PRODUCT_COPY_FILES += \
    $(INTEL_PATH_COMMON)/wlan/wpa_supplicant-common.conf:vendor/etc/wifi/wpa_supplicant.conf \
    $(INTEL_PATH_COMMON)/wlan/wpa_supplicant_overlay.conf:vendor/etc/wifi/wpa_supplicant_overlay.conf \
    device/intel/coho/wlan/8723bs.conf:system/etc/modprobe.d/8723bs.conf \
    frameworks/native/data/etc/android.hardware.wifi.xml:vendor/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:vendor/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += \
		wpa_supplicant \
		wpa_supplicant-brcm \
		wpa_supplicant-rtk \
		fw_wifi_bcm43xx

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += wifi.interface=wlan0
