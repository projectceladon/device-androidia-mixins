# make console and adb available in charging mode for eng and userdebug builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/init.debug-charging.rc:root/init.debug-charging.rc
endif
