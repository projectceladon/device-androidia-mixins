PRODUCT_PACKAGES += \
    hostapd \
    wpa_supplicant \

PRODUCT_PACKAGES += \
  android.hardware.wifi@1.0-service \

#copy iwlwifi wpa config files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/wificonfig/wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf \
	frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += \
  libwifi-hal-intel

