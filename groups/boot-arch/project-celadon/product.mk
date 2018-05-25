PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.frp.pst=/dev/block/by-name/persistent

ifeq ($(TARGET_BOOTLOADER_POLICY),$(filter $(TARGET_BOOTLOADER_POLICY),0x0 0x2 0x4 0x6))
# OEM Unlock reporting 1
#ADDITIONAL_DEFAULT_PROPERTIES += \
        ro.oem_unlock_supported=1

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
        ro.oem_unlock_supported=1

endif

{{#slot-ab}}
PRODUCT_PACKAGES += updater_ab_esp
{{/slot-ab}}

{{#ignore_not_applicable_reset}}
# Allow Kernelflinger to ignore the RSCI reset source "not_applicable"
# when setting the bootreason
KERNELFLINGER_IGNORE_NOT_APPLICABLE_RESET := true
{{/ignore_not_applicable_reset}}
