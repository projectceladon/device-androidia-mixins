TARGET_USE_SENSOR_VHAL := true

PRODUCT_PROPERTY_OVERRIDES += \
    system_init.startsensorservice=1

PRODUCT_PACKAGES += \
    android.hardware.sensors@2.0-service.intel

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/vendor/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/vendor/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/vendor/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/vendor/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:system/vendor/etc/permissions/android.hardware.sensor.ambient_temperature.xml
