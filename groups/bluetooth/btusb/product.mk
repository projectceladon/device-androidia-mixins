# Bluetooth tools eng / userdebug
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    hciconfig \
    btmon \
    hcitool
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/{{_extra_dir}}/bluetooth_auto_detection.sh:vendor/bin/bluetooth_auto_detection.sh

PRODUCT_PROPERTY_OVERRIDES += bluetooth.rfkill=1

PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-service.vbt \
    libbt-vendor \

{{#ivi}}
PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-car
PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/intel/car/overlay
{{/ivi}}

{{^ivi}}
PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-tablet
{{/ivi}}

