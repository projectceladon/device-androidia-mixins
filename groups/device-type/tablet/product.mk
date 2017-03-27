PRODUCT_CHARACTERISTICS := tablet

$(call inherit-product,frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

PRODUCT_COPY_FILES += \
        {{{tablet_core_hardware_path}}}/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

PRODUCT_AAPT_CONFIG := normal large xlarge mdpi hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG :=

PRODUCT_PROPERTY_OVERRIDES += \
   ro.sf.lcd_density=160


