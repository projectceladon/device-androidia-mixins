ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/init.lmdump.rc:root/init.lmdump.rc
endif
