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
SERIAL_PARAMETER := console=tty0 console=ttyS2,115200n8

BOARD_KERNEL_CMDLINE += root=/dev/ram0  androidboot.hardware=$(TARGET_PRODUCT) firmware_class.path={{{firmware_path}}} loglevel=$(KERNEL_LOGLEVEL)

ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(SPARSE_IMG),true)
BOARD_KERNEL_CMDLINE += $(SERIAL_PARAMETER)
endif
endif
