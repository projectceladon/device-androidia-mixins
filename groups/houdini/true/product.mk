# Houdini compatibility improvement for PRC market
PRODUCT_PROPERTY_OVERRIDES += ro.sys.prc_compatibility=1

TARGET_SUPPORTS_64_BIT_APPS := true

PRODUCT_PACKAGES += libhoudini houdini
PRODUCT_PROPERTY_OVERRIDES += ro.dalvik.vm.isa.arm=x86 ro.vendor.enable.native.bridge.exec=1

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
  PRODUCT_PROPERTY_OVERRIDES += ro.dalvik.vm.isa.arm64=x86_64 ro.vendor.enable.native.bridge.exec64=1
endif
PRODUCT_PROPERTY_OVERRIDES += ro.dalvik.vm.native.bridge=libhoudini.so

TARGET_KERNEL_ARCH := x86_64
