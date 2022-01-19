{{#bootconfig_enable}}
BOOTCONFIG_ENABLE := true
{{/bootconfig_enable}}
{{^bootconfig_enable}}
BOOTCONFIG_ENABLE := false
{{/bootconfig_enable}}

PRODUCT_COPY_FILES += \
		$(LOCAL_PATH)/fstab:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.$(TARGET_PRODUCT)
