#!/vendor/bin/sh
modules=`getprop ro.vendor.boot.moduleslocation`
insmod $modules/cfg80211.ko
insmod $modules/rtl8821ae.ko
  insmod $modules/iwlwifi.ko
  insmod $modules/iwlmvm.ko power_scheme=1
