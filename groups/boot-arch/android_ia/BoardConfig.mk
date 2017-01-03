TARGET_NO_RECOVERY ?= true

TARGET_BOARD_PLATFORM := android_ia

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 512
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE = 2010612736

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

# Avoid Watchdog truggered reboot
BOARD_KERNEL_CMDLINE += iTCO_wdt.force_no_reboot=1

# Specify file for creating final flashfiles
BOARD_GPT_INI ?= $(TARGET_DEVICE_DIR)/gpt.ini
BOARD_GPT_BIN = $(PRODUCT_OUT)/gpt.bin

BOARD_FLASHFILES += $(PRODUCT_OUT)/system.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/gpt.bin
BOARD_FLASHFILES += $(PRODUCT_OUT)/boot.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/installer.efi
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/kernelflinger.efi
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/startup.nsh
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/installer.cmd
