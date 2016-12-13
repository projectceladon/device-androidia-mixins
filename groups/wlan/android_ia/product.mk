PRODUCT_PACKAGES += \
    hostapd \
    hostapd_cli \
    wpa_supplicant \
    wpa_cli \
    wificond

#copy iwlwifi wpa config files
PRODUCT_COPY_FILES += \
        device/intel/android_ia/common/wifi/wpa_supplicant-common.conf:system/etc/wifi/wpa_supplicant.conf \
	device/intel/android_ia/common/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
        frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml
