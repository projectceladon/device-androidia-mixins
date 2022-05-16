#!/system/bin/sh

FILE=/mnt/share/mixins.spec
if [ ! -f "$FILE"]; then
    insmod /vendor/lib/modules/cfg80211.ko
    insmod /vendor/lib/modules/mac80211.ko
    insmod /vendor/lib/modules/iwlwifi.ko
    insmod /vendor/lib/modules/iwlmvm.ko power_scheme=1
elif [ -f "$FILE"]; then
    insmod /vendor/lib/modules/cfg80211.ko
    insmod /vendor/lib/modules/iwl7000_mac80211.ko
    insmod /vendor/lib/modules/iwlwifi.ko
    insmod /vendor/lib/modules/iwlmvm.ko power_scheme=1
fi 
