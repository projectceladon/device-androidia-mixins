{{#slot-ab}}
make_dir_ab_vendor:
	@mkdir -p $(PRODUCT_OUT)/root/vendor

$(PRODUCT_OUT)/ramdisk.img: make_dir_ab_vendor
{{/slot-ab}}
