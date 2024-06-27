# /reess is using for the optee secure storage
make_reess_dir:
	@mkdir -p $(PRODUCT_OUT)/root/reess

$(PRODUCT_OUT)/ramdisk.img: make_reess_dir

# OPTEE_ELF triggered by keymaster TA in optee-os
$(OPTEE_ELF) : dba51a17-0563-11e7-93b1-6fa7b0071a51.ta
