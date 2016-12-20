{{#x86_64}}
TARGET_KERNEL_ARCH := x86_64
BOARD_USE_64BIT_KERNEL := true
{{/x86_64}}

{{^x86_64}}
TARGET_KERNEL_ARCH := x86
BOARD_USE_64BIT_KERNEL := false
{{/x86_64}}

KERNEL_MODULES_ROOT_PATH ?= /system/lib/modules
KERNEL_MODULES_ROOT ?= $(KERNEL_MODULES_ROOT_PATH)

FIRMWARES_DIR ?= device/intel/android_ia/firmware

# Include common settings.
FIRMWARE_FILTERS ?= .git/% %.mk

# Firmware
$(call inherit-product,device/intel/android_ia/common/firmware.mk)
