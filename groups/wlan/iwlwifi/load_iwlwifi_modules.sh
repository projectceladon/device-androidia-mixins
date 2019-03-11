load_iwlwifi_modules() {
    insmod $modules/kernel/net/wireless/cfg80211.ko
    insmod $modules/kernel/net/mac80211/mac80211.ko
    insmod $modules/kernel/drivers/net/wireless/intel/iwlwifi/iwlwifi.ko d0i3_disable=1
    insmod $modules/kernel/drivers/net/wireless/intel/iwlwifi/mvm/iwlmvm.ko power_scheme=1
}
load_iwlwifi_modules&
