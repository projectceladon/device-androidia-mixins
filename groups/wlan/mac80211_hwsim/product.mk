PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
	wpa_supplicant \
	hostapd \

PRODUCT_COPY_FILES += \
    $(INTEL_PATH_VENDOR_CIC_HAL)/wifi/wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf \
    $(INTEL_PATH_VENDOR_CIC_HAL)/wifi/WifiConfigStore.xml:data/misc/wifi/WifiConfigStore.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml
