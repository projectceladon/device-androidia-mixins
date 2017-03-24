ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/init.kernel.rc:root/init.kernel.rc
endif
