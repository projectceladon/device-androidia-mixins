# Enable MPM for eng and userdebug builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/init.diag.rc:root/init.diag.rc
PRODUCT_PACKAGES += MPMApp
endif
