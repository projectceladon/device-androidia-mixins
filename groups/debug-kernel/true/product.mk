ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/init.kernel.rc:root/init.kernel.rc
endif
