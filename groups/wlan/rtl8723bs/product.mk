# Uses same supplicant config as the bcm43241
PRODUCT_COPY_FILES += \
    $(INTEL_PATH_COMMON)/wlan/wpa_supplicant-common.conf:vendor/etc/wifi/wpa_supplicant.conf \
    $(INTEL_PATH_COMMON)/wlan/wpa_supplicant_overlay.conf:vendor/etc/wifi/wpa_supplicant_overlay.conf \
    frameworks/native/data/etc/android.hardware.wifi.xml:vendor/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:vendor/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += wpa_supplicant

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += wifi.interface=wlan0

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.tether.denied=true
