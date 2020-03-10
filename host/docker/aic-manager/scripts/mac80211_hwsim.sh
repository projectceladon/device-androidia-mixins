#!/bin/bash

function install_driver
{
    modprobe mac80211 && modprobe mac80211_hwsim radios=$RADIOS_NUM
    if [ $? -ne 0 ]; then
        echo "modprobe mac80211_hwsim or modprobe mac80211_hwsim failed!"
        exit -1
    fi

    # wait for a while for driver moudule loading, otherwise hostapd and dnsmasq will failed to start.
    sleep 2
    if [ ! -d "/sys/bus/platform/drivers/mac80211_hwsim/" ]; then
        echo "mac80211_hwsim module install failed!"
        exit -1
    fi
}

RADIOS_NUM=$((ANDROID_INSTANCE_NUM+1))
DEFAULT_IFACE=$(route -n | awk '$1 == "0.0.0.0"' | awk '{print $8}' | head -n 1)

# install driver
if [ -z "$(lsmod | grep mac80211_hwsim 2>/dev/null)" ]; then
    echo "install mac80211_hwsim driver..."
    install_driver
fi
if [ "$(cat /sys/bus/platform/drivers/mac80211_hwsim/module/parameters/radios)" != "$RADIOS_NUM" ]; then
    echo "reinstall mac80211_hwsim driver for radios number change..."
    rmmod mac80211_hwsim
    install_driver
fi
if [ "$(ls /sys/bus/platform/drivers/mac80211_hwsim/hwsim*/net | grep wlan | wc -l)" != "$(cat /sys/bus/platform/drivers/mac80211_hwsim/module/parameters/radios)" ]; then
    echo "reinstall mac80211_hwsim driver for wlan device lost..."
    rmmod mac80211_hwsim
    install_driver
fi

MASTER_HWSIM=$(ls /sys/bus/platform/drivers/mac80211_hwsim/hwsim0/net/ 2>/dev/null)
if [ -z "$MASTER_HWSIM" ]; then
    echo "cannot find main hwsim0 net interface!"
    exit -1
fi
ifconfig $MASTER_HWSIM 192.168.100.1

# set iptables
if [ -z "$(iptables -n -t nat -L | grep 192.168.100.0)" ]; then
    iptables -t nat -A POSTROUTING -s 192.168.100.0/24 -j MASQUERADE
    iptables -A FORWARD -o $DEFAULT_IFACE -i $MASTER_HWSIM -s 192.168.100.0/24 -m conntrack --ctstate NEW -j ACCEPT
    iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
fi

# hostapd may failed to start due to rfkill blocked sometimes.
rfkill unblock all

# start hostapd and dnsmasq
sed -i "21s/^.*$/interface=$MASTER_HWSIM/" simulated_hostapd.conf
hostapd simulated_hostapd.conf &
dnsmasq -i $MASTER_HWSIM --bind-interfaces --dhcp-range=192.168.100.2,192.168.100.254,infinite --dhcp-option=6,192.168.100.1 -d &

if [ ! -d "/var/run/netns" ]; then
    mkdir /var/run/netns
fi

while true; do
    for i in $(seq 0 $((ANDROID_INSTANCE_NUM-1))); do
        HWSIM_NUM=$((i+1))
        HWSIM_NAME=$(ls /sys/bus/platform/drivers/mac80211_hwsim/hwsim$HWSIM_NUM/net/ 2>/dev/null)
        HWSIME_PHY=$(cat /sys/bus/platform/drivers/mac80211_hwsim/hwsim$HWSIM_NUM/net/$HWSIM_NAME/phy80211/name 2>/dev/null)
        if [ ! -z "$HWSIM_NAME" ] && [ ! -z "$HWSIME_PHY" ] && [ ! -z "$(docker ps -f name=android$i 2>/dev/null | grep android$i)" ] && [ "$(docker exec -t android$i getprop dev.bootcomplete 2>/dev/null | tr -d '\r\n')" = "1" ]; then
            # move wifi iface to Android
            rm -rf /var/run/netns/android$i
            ANDROID_PID=$(docker inspect -f '{{.State.Pid}}' android$i)
            ln -sfT /hostproc/$ANDROID_PID/ns/net /var/run/netns/android$i
            iw phy $HWSIME_PHY set netns name android$i
            ip netns exec android$i ip link set $HWSIM_NAME name wlan0
        fi
    done
    sleep 3
done
