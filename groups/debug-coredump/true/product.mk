ifeq ($(MIXIN_DEBUG_LOGS),true)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/init.coredump.rc:root/init.coredump.rc
endif

ifeq ($(MIXIN_DEBUG_LOGS),true)
BOARD_SEPOLICY_DIRS += device/intel/sepolicy/coredump
# Enable core dump for eng builds
ifeq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.core.enabled=1
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.core.enabled=0
endif
CRASHLOGD_COREDUMP := true
endif
