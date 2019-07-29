INSTALLED_SUPER_EMPTY_IMAGE_TARGET := $(PRODUCT_OUT)/super_empty.img

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_SUPER_EMPTY_IMAGE_TARGET)
{{#slot-ab}}
FIRST_STAGE_RAMDISK_DIR := $(PRODUCT_OUT)/recovery/root/first_stage_ramdisk

$(FIRST_STAGE_RAMDISK_DIR):
	@mkdir -p $(PRODUCT_OUT)/recovery/root/first_stage_ramdisk

$(PRODUCT_OUT)/ramdisk-recovery.img: $(FIRST_STAGE_RAMDISK_DIR)
{{/slot-ab}}
