#
# BoardConfig.mk for android_ia platform
#

TARGET_BOARD_PLATFORM := android_ia

BOARD_USE_LEGACY_UI := true

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 512
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE = 2010612736

TARGET_NO_BOOTLOADER := true
TARGET_CPU_ABI := x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64

TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86

BOARD_USE_64BIT_USERSPACE := true
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_KERNEL_ARCH ?= x86_64
BOARD_USE_64BIT_KERNEL ?= true
TARGET_USES_64_BIT_BINDER := true

# customize the malloced address to be 16-byte aligned
BOARD_MALLOC_ALIGNMENT := 16

# Enable dex-preoptimization to speed up the first boot sequence
# of an SDK AVD. Note that this operation only works on Linux for now
ifeq ($(HOST_OS),linux)
WITH_DEXPREOPT := true
WITH_DEXPREOPT_PIC := true
endif

# the following variables could be overridden
TARGET_PRELINK_MODULE := false
TARGET_NO_KERNEL ?= false
TARGET_NO_RECOVERY ?= true
TARGET_HAS_THIRD_PARTY_APPS := true

BOARD_HAS_GPS_HARDWARE ?= true

# Don't build emulator
BUILD_EMULATOR ?= false

USE_CAMERA_STUB ?= true

# Kernel Flinger
TARGET_UEFI_ARCH := x86_64
# Kernelflinger won't check the ACPI table oem_id, oem_table_id and
# revision fields
KERNELFLINGER_ALLOW_UNSUPPORTED_ACPI_TABLE := true
# Allow Kernelflinger to start watchdog prior to boot the kernel
KERNELFLINGER_USE_WATCHDOG := true
# Tell Kernelflinger to ignore ACPI RSCI table
KERNELFLINGER_IGNORE_RSCI := true
KERNELFLINGER_SSL_LIBRARY := boringssl
# Specify system verity partition
#PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/by-name/system

BOARD_KERNEL_CMDLINE += root=/dev/ram0 androidboot.hardware=$(TARGET_PRODUCT) androidboot.selinux=permissive

# Use the non-open-source parts, if they're present
-include vendor/BoardConfigVendor.mk
