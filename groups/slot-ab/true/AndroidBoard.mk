RAMDISK_METADATA_DIR:= $(PRODUCT_OUT)/root/metadata

$(RAMDISK_METADATA_DIR):
	@mkdir -p $(PRODUCT_OUT)/root/metadata

$(PRODUCT_OUT)/ramdisk.img: $(RAMDISK_METADATA_DIR)

