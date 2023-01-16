PRODUCT_PACKAGES += \
    wpa_supplicant \
    hostapd

PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml

PRODUCT_PROPERTY_OVERRIDES += sys.container.fakewifi=true
