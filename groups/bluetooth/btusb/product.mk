PRODUCT_PACKAGES += \
    audio.a2dp.default \
    ath3k-1.fw

PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
		frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml

# Bluetooth HAL
PRODUCT_PACKAGES += \
  android.hardware.bluetooth@1.0-impl.vbt \
  android.hardware.bluetooth@1.0-service.vbt \
  libbt-vendor

{{#ivi}}
PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-car
{{/ivi}}

{{^ivi}}
PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-tablet
{{/ivi}}
