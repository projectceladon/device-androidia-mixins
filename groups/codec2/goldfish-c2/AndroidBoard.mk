$(PRODUCT_OUT)/system.img: codec2_copy_modules
codec2_copy_modules : libavservices_minijail
	cp $(PRODUCT_OUT)/system/lib/libavservices_minijail.so $(PRODUCT_OUT)/vendor/lib/libavservices_minijail.so
	cp $(PRODUCT_OUT)/system/lib64/libavservices_minijail.so $(PRODUCT_OUT)/vendor/lib64/libavservices_minijail.so
