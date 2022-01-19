# Enable dynamic partitions feature
PRODUCT_USE_DYNAMIC_PARTITIONS := true
{{#dp_retrofit}}
PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := true
{{/dp_retrofit}}

#Enable userspace fastboot
PRODUCT_PACKAGES += fastbootd \
                    android.hardware.fastboot@1.0-impl-mock

#copy fstab to ramdisk
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/fstab:$(TARGET_COPY_OUT_RAMDISK)/fstab.$(TARGET_PRODUCT)
{{#slot-ab}}
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/fstab:$(PRODUCT_OUT)/recovery/root/first_stage_ramdisk/fstab.$(TARGET_PRODUCT)
{{#virtual_ab}}
$(call inherit-product, \
    $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
{{#virtual_ab_compression}}
$(call inherit-product, \
    $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)
PRODUCT_PACKAGES += snapuserd_ramdisk
{{/virtual_ab_compression}}
{{/virtual_ab}}
{{/slot-ab}}

{{#super_img_in_flashzip}}
SUPER_IMG_IN_FLASHZIP := true
{{/super_img_in_flashzip}}
