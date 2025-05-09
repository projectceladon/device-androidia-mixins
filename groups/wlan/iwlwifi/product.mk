PRODUCT_PACKAGES += \
    hostapd \
    hostapd_cli \
    wificond \
    wifilogd \
    wpa_supplicant \
    wpa_cli \
    iw \
    iw_vendor \
    TetheringConfigOverlay \
    TetheringConfigOverlayGsi

PRODUCT_PACKAGES += \
    android.hardware.wifi-service

#copy iwlwifi wpa config files
PRODUCT_COPY_FILES += \
    $(INTEL_PATH_COMMON)/wlan/wpa_supplicant-common.conf:vendor/etc/wifi/wpa_supplicant.conf \
    $(INTEL_PATH_COMMON)/wlan/iwlwifi/wpa_supplicant_overlay.conf:vendor/etc/wifi/wpa_supplicant_overlay.conf \
    $(INTEL_PATH_COMMON)/wlan/iwlwifi/p2p_supplicant_overlay.conf:vendor/etc/wifi/p2p_supplicant_overlay.conf \
    frameworks/native/data/etc/android.hardware.wifi.xml:vendor/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:vendor/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:vendor/etc/permissions/android.software.ipsec_tunnels.xml

{{^ivi}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:vendor/etc/permissions/android.hardware.wifi.rtt.xml
{{#nan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:vendor/etc/permissions/android.hardware.wifi.aware.xml
{{/nan}}
{{/ivi}}

PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/wlan/overlay-disable_keepalive_offload

PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/load_iwl_modules.sh:vendor/bin/load_iwl_modules.sh
