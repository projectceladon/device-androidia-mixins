PRODUCT_CHARACTERISTICS := tablet

$(call inherit-product,frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

PRODUCT_COPY_FILES += \
        {{{tablet_core_hardware_path}}}/tablet_core_hardware.xml:vendor/etc/permissions/tablet_core_hardware.xml

