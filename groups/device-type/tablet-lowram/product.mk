PRODUCT_CHARACTERISTICS := tablet

# Low memory property flags
PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true
# The features when low memory
PRODUCT_COPY_FILES += \
        $(INTEL_PATH_COMMON)/device-type/overlay-tablet-lowram/tablet_core_hardware.xml:vendor/etc/permissions/tablet_core_hardware.xml
