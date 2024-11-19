#!/vendor/bin/sh
for i in $(find /sys/devices/pci* -name control)
do echo auto > $i
done

for i in /sys/class/scsi_host/host*/link_power_management_policy
do echo 'min_power' > $i
done

echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs'
echo '0' > '/proc/sys/kernel/nmi_watchdog'
