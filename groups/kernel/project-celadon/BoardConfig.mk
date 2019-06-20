{{#64bit_apps}}
TARGET_USES_64_BIT_BINDER := true
BOARD_USE_64BIT_USERSPACE := true
TARGET_SUPPORTS_64_BIT_APPS := true
{{/64bit_apps}}

{{^64bit_apps}}
TARGET_USES_64_BIT_BINDER := false
BOARD_USE_64BIT_USERSPACE := false
TARGET_SUPPORTS_64_BIT_APPS := false
{{/64bit_apps}}

TARGET_PRELINK_MODULE := false
TARGET_NO_KERNEL ?= false

KERNEL_LOGLEVEL ?= {{{loglevel}}}

{{^slot-ab}}
# If enable A/B, then the root should be system partition at last.
BOARD_KERNEL_CMDLINE += root=/dev/ram0
{{/slot-ab}}

BOARD_KERNEL_CMDLINE += androidboot.hardware=$(TARGET_PRODUCT) firmware_class.path={{{firmware_path}}} loglevel=$(KERNEL_LOGLEVEL) loop.max_part=7

ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(SPARSE_IMG),true)
BOARD_KERNEL_CMDLINE += console=tty0 $(SERIAL_PARAMETER)
endif
endif


BOARD_SEPOLICY_M4DEFS += module_kernel=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/kernel
