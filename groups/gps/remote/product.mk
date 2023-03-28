TARGET_USE_GPS_VHAL := true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/vendor/etc/permissions/android.hardware.location.gps.xml

PRODUCT_PACKAGES += \
    android.hardware.gnss@2.0-service.$(TARGET_PRODUCT)

PRODUCT_PROPERTY_OVERRIDES += \
    virtual.gps.tcp.port=8766

