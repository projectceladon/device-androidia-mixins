{{#initboot_enable}}
INITBOOT_ENABLE := true
{{/initboot_enable}}
{{^initboot_enable}}
INITBOOT_ENABLE := false
{{/initboot_enable}}

#PRODUCT_COPY_FILES += \
#		$(LOCAL_PATH)/fstab:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.$(TARGET_PRODUCT)
