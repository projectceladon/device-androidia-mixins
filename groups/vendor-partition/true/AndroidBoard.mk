
# This is to ensure that kernel modules are installed before
# vendor.img is generated.
$(PRODUCT_OUT)/vendor.img : $(KERNEL_MODULES_INSTALL)

{{#slot-ab}}
make_dir_ab_vendor:
	@mkdir -p $(PRODUCT_OUT)/root/vendor

$(PRODUCT_OUT)/ramdisk.img: make_dir_ab_vendor
{{/slot-ab}}
