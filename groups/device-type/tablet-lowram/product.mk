PRODUCT_CHARACTERISTICS := tablet

# Low memory property flags
PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true
# The features when low memory
PRODUCT_COPY_FILES += \
        device/intel/common/device-type/overlay-tablet-lowram/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml
