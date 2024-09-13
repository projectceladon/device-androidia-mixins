ifeq ($(TARGET_BOARD_PLATFORM),)
    $(error Please define TARGET_BOARD_PLATFORM in product-level Makefile)
endif

# Sensors HAL modules
PRODUCT_PACKAGES += \
	android.hardware.sensors@aidl-service.intel

{{#enable_sensor_list}}
ifeq ($(TARGET_PRODUCT), caas)
PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:vendor/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
        frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:vendor/etc/permissions/android.hardware.sensor.accelerometer.xml \
        frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:vendor/etc/permissions/android.hardware.sensor.gyroscope.xml \
        frameworks/native/data/etc/android.hardware.sensor.compass.xml:vendor/etc/permissions/android.hardware.sensor.compass.xml \
        frameworks/native/data/etc/android.hardware.sensor.light.xml:vendor/etc/permissions/android.hardware.sensor.light.xml \
        frameworks/native/data/etc/android.hardware.sensor.gyroscope_limited_axes.xml:vendor/etc/permissions/android.hardware.sensor.gyroscope_limited_axes.xml \
        frameworks/native/data/etc/android.hardware.sensor.accelerometer_limited_axes.xml:vendor/etc/permissions/android.hardware.sensor.accelerometer_limited_axes.xml \
        frameworks/native/data/etc/android.hardware.sensor.accelerometer_limited_axes_uncalibrated.xml:vendor/etc/permissions/android.hardware.sensor.accelerometer_limited_axes_uncalibrated.xml \
        frameworks/native/data/etc/android.hardware.sensor.gyroscope_limited_axes_uncalibrated.xml:vendor/etc/permissions/android.hardware.sensor.gyroscope_limited_axes_uncalibrated.xml

else ifeq ($(TARGET_PRODUCT), aaos_iasw)
PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.location.gps.xml:vendor/etc/permissions/android.hardware.location.gps.xml
else
PRODUCT_COPY_FILES +=

endif

AUTO_IN += $(TARGET_DEVICE_DIR)/{{_extra_dir}}/auto_hal.in
{{/enable_sensor_list}}
