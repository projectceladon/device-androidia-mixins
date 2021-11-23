# Specify location of board-specific kernel headers
TARGET_BOARD_KERNEL_HEADERS := device/intel/coho-kernel/kernel-headers

KERNEL_LOGLEVEL ?= 7

BOARD_KERNEL_CMDLINE += \
        loglevel=$(KERNEL_LOGLEVEL) \
        firmware_class.path=/system/etc/firmware \
	i915.fastboot=1

ifeq ($(BOOTCONFIG_ENABLE), true)
BOARD_BOOTCONFIG += androidboot.hardware=$(TARGET_DEVICE)
else
BOARD_KERNEL_CMDLINE += androidboot.hardware=$(TARGET_DEVICE)
endif

