
# This is to ensure that kernel modules are installed before
# vendor.img is generated.
$(PRODUCT_OUT)/vendor.img : $(KERNEL_MODULES_INSTALL)
