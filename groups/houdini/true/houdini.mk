
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init_houdini.rc:root/init.houdini.rc


############ Houdini config
PRODUCT_PACKAGES += libhoudini houdini
PRODUCT_PROPERTY_OVERRIDES += ro.dalvik.vm.isa.arm=x86 ro.enable.native.bridge.exec=1

ENABLE_NATIVEBRIDGE_64BIT := false
ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
  ENABLE_NATIVEBRIDGE_64BIT = true
else
  ifeq ($(TARGET_SUPPORTS_64_BIT_APPS),true)
    ENABLE_NATIVEBRIDGE_64BIT = true
  endif
endif
ifeq ($(ENABLE_NATIVEBRIDGE_64BIT),true)
  PRODUCT_PACKAGES += houdini64
  PRODUCT_PROPERTY_OVERRIDES += ro.dalvik.vm.isa.arm64=x86_64 ro.enable.native.bridge.exec64=1
endif

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.dalvik.vm.native.bridge=libhoudini.so


# add for compile houdini
TARGET_KERNEL_ARCH := x86_64
