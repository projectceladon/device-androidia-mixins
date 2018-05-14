#TARGET_NO_RECOVERY ?= false

TARGET_BOARD_PLATFORM := project-celadon

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
{{^slot-ab}}
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
{{/slot-ab}}
BOARD_FLASH_BLOCK_SIZE := 512

BOARD_BOOTIMAGE_PARTITION_SIZE := 31457280

ifeq ($(SPARSE_IMG),true)
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
else
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := squashfs
endif

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3758096384

BOARD_BOOTLOADER_PARTITION_SIZE ?= 62914560
BOARD_BOOTLOADER_BLOCK_SIZE := 512
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_DEVICE)

# Kernel Flinger
TARGET_UEFI_ARCH := x86_64
# Kernelflinger won't check the ACPI table oem_id, oem_table_id and
# revision fields
KERNELFLINGER_ALLOW_UNSUPPORTED_ACPI_TABLE := true
# Allow Kernelflinger to start watchdog prior to boot the kernel
KERNELFLINGER_USE_WATCHDOG := true
# Tell Kernelflinger to ignore ACPI RSCI table
KERNELFLINGER_IGNORE_RSCI := true
#KERNELFLINGER_SSL_LIBRARY := boringssl
KERNELFLINGER_SSL_LIBRARY := openssl
# Specify system verity partition
#PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/by-name/system

# Avoid Watchdog truggered reboot
BOARD_KERNEL_CMDLINE += iTCO_wdt.force_no_reboot=1

BOARD_SEPOLICY_DIRS += device/intel/project-celadon/sepolicy/boot-arch/project-celadon/$(TARGET_PRODUCT)

# Show the "OEM unlocking" option in Android "Developer options"
#PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.frp.pst=/dev/block/by-name/android_persistent

# Specify file for creating final flashfiles
# BOARD_GPT_INI ?= $(TARGET_DEVICE_DIR)/gpt.ini
BOARD_GPT_BIN = $(PRODUCT_OUT)/gpt.bin
BOARD_FLASHFILES += $(PRODUCT_OUT)/system.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/gpt.bin
BOARD_FLASHFILES += $(PRODUCT_OUT)/boot.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/installer.efi
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/kernelflinger.efi
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/startup.nsh
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/unlock_device.nsh
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/efivar_oemlock
BOARD_FLASHFILES += $(PRODUCT_OUT)/bootloader
BOARD_FLASHFILES += $(PRODUCT_OUT)/fastboot-usb.img
{{^slot-ab}}
BOARD_FLASHFILES += $(PRODUCT_OUT)/recovery.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/cache.img
{{/slot-ab}}
{{#tos_partition}}
BOARD_FLASHFILES += $(PRODUCT_OUT)/tos.img
{{#slot-ab}}
AB_OTA_PARTITIONS += tos
{{/slot-ab}}
{{/tos_partition}}

# -- OTA RELATED DEFINES --
# tell build system where to get the recovery.fstab.
TARGET_RECOVERY_FSTAB ?= $(TARGET_DEVICE_DIR)/fstab
# Used by ota_from_target_files to add platform-specific directives
# to the OTA updater scripts
TARGET_RELEASETOOLS_EXTENSIONS ?= device/intel/common/recovery
{{^avb}}
# Adds edify commands swap_entries and copy_partition for robust
# update of the EFI system partition
TARGET_RECOVERY_UPDATER_LIBS := libupdater_esp
# Extra libraries needed to be rolled into recovery updater
# libgpt_static and libefivar are needed by libupdater_esp
TARGET_RECOVERY_UPDATER_EXTRA_LIBS := libcommon_recovery libgpt_static
ifeq ($(TARGET_SUPPORT_BOOT_OPTION),true)
TARGET_RECOVERY_UPDATER_EXTRA_LIBS += libefivar
endif
{{/avb}}
# By default recovery minui expects RGBA framebuffer
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"


{{#bootloader_policy}}
{{#blpolicy_use_efi_var}}
ifneq ({{bootloader_policy}},static)
BOOTLOADER_POLICY_OEMVARS = $(PRODUCT_OUT)/bootloader_policy-oemvars.txt
BOARD_FLASHFILES += $(BOOTLOADER_POLICY_OEMVARS)
BOARD_OEM_VARS += $(BOOTLOADER_POLICY_OEMVARS)
endif
{{/blpolicy_use_efi_var}}
{{/bootloader_policy}}

{{#bootloader_policy}}
# It activates the Bootloader policy and RMA refurbishing
# features. TARGET_BOOTLOADER_POLICY is the desired bitmask for this
# device.
# * bit 0:
#   - 0: GVB class B.
#   - 1: GVB class A.  Device unlock is not permitted.  The only way
#     to unlock is to use the secured force-unlock mechanism.
# * bit 1 and 2 defines the minimal boot state required to boot the
#   device:
#   - 0x0: BOOT_STATE_RED (GVB default behavior)
#   - 0x1: BOOT_STATE_ORANGE
#   - 0x2: BOOT_STATE_YELLOW
#   - 0x3: BOOT_STATE_GREEN
# If TARGET_BOOTLOADER_POLICY is equal to 'static' the bootloader
# policy is not built but is provided statically in the repository.
# If TARGET_BOOTLOADER_POLICY is equal to 'external' the bootloader
# policy OEMVARS should be installed manually in
# $(BOOTLOADER_POLICY_OEMVARS).
TARGET_BOOTLOADER_POLICY := {{bootloader_policy}}
# If the following variable is set to false, the bootloader policy and
# RMA refurbishing features does not use time-based authenticated EFI
# variables to store the BPM and OAK values.  The BPM value is defined
# compilation time by the TARGET_BOOTLOADER_POLICY variable.
TARGET_BOOTLOADER_POLICY_USE_EFI_VAR := {{blpolicy_use_efi_var}}
#ifeq ($(TARGET_BOOTLOADER_POLICY),$(filter $(TARGET_BOOTLOADER_POLICY),0x0 0x2 0x4 0x6))
# OEM Unlock reporting 1
#ADDITIONAL_DEFAULT_PROPERTIES += \
#	ro.oem_unlock_supported=1
#endif
ifeq ($(TARGET_BOOTLOADER_POLICY),$(filter $(TARGET_BOOTLOADER_POLICY),static external))
# The bootloader policy is not generated build time but is supplied
# statically in the repository or in $(PRODUCT_OUT)/.  If your
# bootloader policy allows the device to be unlocked, uncomment the
# following lines:
# ADDITIONAL_DEFAULT_PROPERTIES += \
# 	ro.oem_unlock_supported=1
endif
{{/bootloader_policy}}


{{^bootloader_policy}}
# OEM Unlock reporting 2
ADDITIONAL_DEFAULT_PROPERTIES += \
	ro.oem_unlock_supported=1
{{/bootloader_policy}}

{{#assume_bios_secure_boot}}
# Kernelfligner will assume the BIOS support secure boot. Not check the EFI variable SecureBoot
# It is useful when the BIOS does not support secure boot.
KERNELFLINGER_ASSUME_BIOS_SECURE_BOOT := true
{{/assume_bios_secure_boot}}

{{#rpmb}}
KERNELFLINGER_USE_RPMB := true
{{/rpmb}}

{{#rpmb_simulate}}
KERNELFLINGER_USE_RPMB_SIMULATE := true
{{/rpmb_simulate}}

{{#slot-ab}}
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/updater_ab_esp \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true
{{/slot-ab}}
