PRODUCT_PACKAGES += \
	android.hardware.gnss-service.intel

PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.location.gps.xml:vendor/etc/permissions/android.hardware.location.gps.xml

PRODUCT_PROPERTY_OVERRIDES += \
	vendor.ser.gnss-uart=/dev/ttyUSB0

