PRODUCT_CHARACTERISTICS := tv

DEVICE_MANIFEST_FILE += device/google/cuttlefish/shared/config/manifest.xml
DEVICE_MANIFEST_FILE += device/google/cuttlefish/shared/tv/manifest.xml

PRODUCT_COPY_FILES += \
	device/google/atv/permissions/tv_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/tv_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.hdmi.cec.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.hdmi.cec.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \

# HDMI CEC HAL
PRODUCT_PACKAGES += android.hardware.tv.cec@1.0-service.mock

# Tuner HAL
PRODUCT_PACKAGES += android.hardware.tv.tuner@1.0-service


