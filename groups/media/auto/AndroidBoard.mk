AUTO_IN += $(TARGET_DEVICE_DIR)/{{_extra_dir}}/auto_hal.in

#libv4l2_codec2_store

$(PRODUCT_OUT)/system.img: codec2_copy_modules
codec2_copy_modules : android.hardware.media.c2@1.0-service-v4l2 libv4l2_codec2_common libc2plugin_store
	cp $(PRODUCT_OUT)/vendor/lib/libc2plugin_store.so $(PRODUCT_OUT)/system/lib/libc2plugin_store.so
	cp $(PRODUCT_OUT)/vendor/lib/libstagefright_bufferpool@1.0.so $(PRODUCT_OUT)/system/lib/libstagefright_bufferpool@1.0.so
	cp $(PRODUCT_OUT)/vendor/lib/android.hardware.media.bufferpool@1.0.so $(PRODUCT_OUT)/system/lib/android.hardware.media.bufferpool@1.0.so
	cp $(PRODUCT_OUT)/vendor/lib64/libc2plugin_store.so $(PRODUCT_OUT)/system/lib64/libc2plugin_store.so
	cp $(PRODUCT_OUT)/vendor/lib64/libstagefright_bufferpool@1.0.so $(PRODUCT_OUT)/system/lib64/libstagefright_bufferpool@1.0.so
	cp $(PRODUCT_OUT)/vendor/lib64/android.hardware.media.bufferpool@1.0.so $(PRODUCT_OUT)/system/lib64/android.hardware.media.bufferpool@1.0.so

