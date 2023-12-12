#!/vendor/bin/sh
modules=`getprop ro.vendor.boot.moduleslocation`
insmod $modules/cfg80211.ko
if [ -f $modules/iwl7000_mac80211.ko ]; then
  insmod $modules/iwl7000_mac80211.ko
else
  insmod $modules/mac80211.ko
fi
  insmod $modules/iwlwifi.ko
  insmod $modules/iwlmvm.ko power_scheme=1
