PRODUCT_PACKAGES += \
    hostapd \
    hostapd_cli \
    wificond \
    wifilogd \
    wpa_supplicant \
    wpa_cli \
    iw
   
# FW and PNVM
PRODUCT_PACKAGES += \
    iwl-fw          \
    iwl-nvm

# iwlwifi USC
PRODUCT_PACKAGES += \
    wifi_intel_usc

#copy iwlwifi wpa config files
PRODUCT_COPY_FILES += \
        device/intel/common/wlan/wpa_supplicant-common.conf:vendor/etc/wifi/wpa_supplicant.conf \
        device/intel/common/wlan/iwlwifi/wpa_supplicant_overlay.conf:vendor/etc/wifi/wpa_supplicant_overlay.conf \
        device/intel/common/wlan/iwlwifi/p2p_supplicant_overlay.conf:vendor/etc/wifi/p2p_supplicant_overlay.conf \
        frameworks/native/data/etc/android.hardware.wifi.xml:vendor/etc/permissions/android.hardware.wifi.xml

{{#gpp}}
# Add Manufacturing tool
PRODUCT_PACKAGES += \
    wlan_intel_restore.sh
{{/gpp}}


# Wifi configuration
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WLAN_DEVICE := iwlwifi

{{#softap_dualband_allow}}
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.wifi.softap_dualband_allow=true
{{/softap_dualband_allow}}
{{^softap_dualband_allow}}
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.wifi.softap_dualband_allow=false
{{/softap_dualband_allow}}

PRODUCT_PACKAGES += \
  android.hardware.wifi@1.0-service
