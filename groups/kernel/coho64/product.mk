
LOCAL_KERNEL_MODULE_FILES :=
ifeq ($(TARGET_PREBUILT_KERNEL),)
  # use default kernel
  LOCAL_KERNEL_PATH := device/intel/coho-kernel/$(TARGET_KERNEL_ARCH)
  LOCAL_KERNEL := $(LOCAL_KERNEL_PATH)/bzImage
  LOCAL_KERNEL_MODULE_FILES := $(wildcard $(LOCAL_KERNEL_PATH)/modules/*)
  LOCAL_KERNEL_MODULE_TREE_PATH := $(LOCAL_KERNEL_PATH)/lib/modules
else
  # use custom kernel
  LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
  ifneq ($(TARGET_PREBUILT_KERNEL_MODULE_PATH),)
    LOCAL_KERNEL_MODULE_FILES := $(wildcard $(TARGET_PREBUILT_KERNEL_MODULE_PATH)/*)
  endif
  ifneq ($(TARGET_PREBUILT_KERNEL_MODULE_TREE_PATH),)
    LOCAL_KERNEL_MODULE_TREE_PATH := $(TARGET_PREBUILT_KERNEL_MODULE_TREE_PATH)
  endif
endif

ifneq ($(LOCAL_KERNEL_MODULE_TREE_PATH),)
  LOCAL_KERNEL_VERSION := $(shell file -k $(LOCAL_KERNEL) | sed -nr 's|.*version ([^ ]+) .*|\1|p')
  ifeq ($(LOCAL_KERNEL_VERSION),)
    $(error Cannot get version for kernel '$(LOCAL_KERNEL)')
  endif

  FULL_TREE_PATH := $(LOCAL_KERNEL_MODULE_TREE_PATH)/$(LOCAL_KERNEL_VERSION)
  # Verify FULL_TREE_PATH is an existing folder
  ifneq ($(shell test -d $(FULL_TREE_PATH) && echo 1), 1)
    $(error '$(FULL_TREE_PATH)' does not exist or is not a directory)
  endif

  LOCAL_KERNEL_MODULE_TREE_FILES := $(shell cd $(LOCAL_KERNEL_MODULE_TREE_PATH) && \
                                            find $(LOCAL_KERNEL_VERSION) -type f)
endif

# Copy kernel into place
PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel \
	$(foreach f, $(LOCAL_KERNEL_MODULE_FILES), $(f):system/lib/modules/$(notdir $(f))) \
  $(foreach f, $(LOCAL_KERNEL_MODULE_TREE_FILES), $(LOCAL_KERNEL_PATH)/lib/modules/$(f):system/lib/modules/$(f))
