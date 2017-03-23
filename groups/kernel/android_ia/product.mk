{{#x86_64}}
TARGET_KERNEL_ARCH := x86_64
BOARD_USE_64BIT_KERNEL := true
{{/x86_64}}

{{^x86_64}}
TARGET_KERNEL_ARCH := x86
BOARD_USE_64BIT_KERNEL := false
{{/x86_64}}

KERNEL_MODULES_ROOT_PATH ?= /vendor/lib/modules
KERNEL_MODULES_ROOT ?= $(KERNEL_MODULES_ROOT_PATH)
ADDITIONAL_DEFAULT_PROPERTIES += ro.boot.moduleslocation=/vendor/lib/modules

FIRMWARES_DIR ?= vendor/linux/firmware

# Include common settings.
FIRMWARE_FILTERS ?= .git/% %.mk

# Firmware
$(call inherit-product,device/intel/android_ia/common/firmware.mk)
