
make_dir_slot_ab:
	@mkdir -p $(PRODUCT_OUT)/root/boot
	@mkdir -p $(PRODUCT_OUT)/root/misc
	@mkdir -p $(PRODUCT_OUT)/root/persistent
	@mkdir -p $(PRODUCT_OUT)/root/metadata

$(PRODUCT_OUT)/ramdisk.img: make_dir_slot_ab
