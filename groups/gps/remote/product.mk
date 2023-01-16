TARGET_USE_GPS_VHAL := true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/vendor/etc/permissions/android.hardware.location.gps.xml \
    vendor/intel/cic/target/gps/cloud/system/vendor/etc/init/android.hardware.gnss@2.0-service.cic_cloud.rc:system/vendor/etc/init/android.hardware.gnss@2.0-service.cic_cloud.rc \
    vendor/intel/cic/target/gps/cloud/system/vendor/bin/hw/android.hardware.gnss@2.0-service.cic_cloud:system/vendor/bin/hw/android.hardware.gnss@2.0-service.cic_cloud

PRODUCT_PACKAGES += \
    android.hardware.gnss@2.0-service.$(TARGET_PRODUCT)

PRODUCT_PROPERTY_OVERRIDES += \
    virtual.gps.tcp.port=8766

