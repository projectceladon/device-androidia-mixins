# /persist is using for the optee secure storage

make_persist_dir:
	@mkdir -p $(PRODUCT_OUT)/root/persist

$(PRODUCT_OUT)/ramdisk.img: make_persist_dir
