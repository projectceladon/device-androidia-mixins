PRODUCT_PACKAGES += \
    hciattach \
    audio.a2dp.default \
    uart8897_bt.bin \
    helper_uart_3000000.bin

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/btcfg.sh:vendor/bin/btcfg.sh

PRODUCT_PROPERTY_OVERRIDES += \
    vendor.bluetooth.hwcfg=stop


# Bluetooth tools eng / userdebug
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    hciconfig \
    btmon \
    hcitool
endif

PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-car
