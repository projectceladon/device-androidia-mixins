PRODUCT_PACKAGES += \
    hostapd \
    hostapd_cli \
    wificond \
    wifilogd \
    wpa_supplicant \
    wpa_cli \
    iw

PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service

# move configure files provided by intel to vendor partition.
PRODUCT_COPY_FILES += \
    $(INTEL_PATH_COMMON)/wlan/wpa_supplicant-common.conf:vendor/etc/wifi/wpa_supplicant.conf \
    $(INTEL_PATH_COMMON)/wlan/wpa_supplicant_overlay.conf:vendor/etc/wifi/wpa_supplicant_overlay.conf \
    $(INTEL_PATH_COMMON)/wlan/p2p_supplicant_overlay.conf:vendor/etc/wifi/p2p_supplicant_overlay.conf \
    $(INTEL_PATH_COMMON)/wlan/wlan.conf:vendor/etc/modprobe.d/wlan.conf \
    frameworks/native/data/etc/android.hardware.wifi.xml:vendor/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:vendor/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/wlan/overlay-disable_keepalive_offload
