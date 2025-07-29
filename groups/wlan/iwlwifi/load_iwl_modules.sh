#!/vendor/bin/sh
modules=`getprop ro.vendor.boot.moduleslocation`
insmod $modules/cfg80211.ko
insmod $modules/mac80211.ko
insmod $modules/rtlwifi.ko
insmod $modules/rtl_pci.ko
insmod $modules/btcoexist.ko
insmod $modules/rtl8821ae.ko
  insmod $modules/iwlwifi.ko
  insmod $modules/iwlmvm.ko power_scheme=1
