PRODUCT_PACKAGES += \
    audio.a2dp.default \
		ath3k-1.fw \

PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
		frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

# Bluetooth HAL
PRODUCT_PACKAGES += \
  android.hardware.bluetooth@1.0-impl \
  android.hardware.bluetooth@1.0-service \
  libbt-vendor
