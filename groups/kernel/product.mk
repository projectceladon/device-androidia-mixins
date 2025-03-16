{{#modules_in_bootimg}}
  KERNEL_MODULES_ROOT_PATH := lib/modules
  KERNEL_MODULES_ROOT := root/$(KERNEL_MODULES_ROOT_PATH)
{{/modules_in_bootimg}}

ifeq ($(TARGET_PREBUILT_KERNEL), true)
ifeq ($(TARGET_BUILD_VARIANT),user)
PREBUILT_KERNEL_ROOT := vendor/intel/utils_priv/kernel/prebuilts/6.6/{{{prebuilt_kernel_target}}}/user
else
PREBUILT_KERNEL_ROOT := vendor/intel/utils_priv/kernel/prebuilts/6.6/{{{prebuilt_kernel_target}}}/userdebug
endif

PRODUCT_COPY_FILES += \
    $(PREBUILT_KERNEL_ROOT)/bzImage:kernel

endif

KERNEL_MODULES_ROOT_PATH ?= vendor_dlkm/lib/modules
KERNEL_MODULES_ROOT ?= $(KERNEL_MODULES_ROOT_PATH)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.vendor.boot.moduleslocation=/$(KERNEL_MODULES_ROOT_PATH)
