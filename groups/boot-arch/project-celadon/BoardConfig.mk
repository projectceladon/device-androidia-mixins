{{^use_cic}}
BOARD_AVB_ENABLE := true

# Don't include super.img to out/dist by default
ifneq ($(GENERATE_SUPER_IMG), true)
BOARD_SUPER_IMAGE_IN_UPDATE_PACKAGE := true
endif

#
# -- OTA RELATED DEFINES --
#

# tell build system where to get the recovery.fstab.
TARGET_RECOVERY_FSTAB ?= $(TARGET_DEVICE_DIR)/fstab.recovery

# Used by ota_from_target_files to add platform-specific directives
# to the OTA updater scripts
TARGET_RELEASETOOLS_EXTENSIONS ?= $(INTEL_PATH_BUILD)/test

# By default recovery minui expects RGBA framebuffer
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"


#
# FILESYSTEMS
#

# NOTE: These values must be kept in sync with BOARD_GPT_INI
BOARD_BOOTIMAGE_PARTITION_SIZE ?= 47185920
SYSTEM_PARTITION_SIZE = $(shell echo {{system_partition_size}}*1024*1024 | bc)
{{^dynamic-partitions}}
BOARD_SYSTEMIMAGE_PARTITION_SIZE ?= $(SYSTEM_PARTITION_SIZE)
{{/dynamic-partitions}}
BOARD_TOSIMAGE_PARTITION_SIZE := 10485760
BOARD_BOOTLOADER_PARTITION_SIZE ?= $$(({{bootloader_len}} * 1024 * 1024))
BOARD_BOOTLOADER_BLOCK_SIZE := {{{bootloader_block_size}}}
{{^slot-ab}}
BOARD_RECOVERYIMAGE_PARTITION_SIZE ?= 31457280
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE ?= 104857600
{{/slot-ab}}
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := {{system_fs}}
DATA_USE_F2FS := {{data_use_f2fs}}

#fastbootd over ethernet support
TARGET_RECOVERY_UI_LIB:=librecovery_ui_ethernet

ifeq ($(DATA_USE_F2FS), true)
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
else
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
INTERNAL_USERIMAGES_EXT_VARIANT := ext4
endif

BOARD_EROFS_PCLUSTER_SIZE := 262144

{{#metadata_encryption}}
BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS += metadata
{{/metadata_encryption}}

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

ifeq ($(BOARD_FLASH_UFS), 1)
BOARD_FLASH_BLOCK_SIZE := 4096
else ifeq ($(BOARD_FLASH_NVME), 1)
BOARD_FLASH_BLOCK_SIZE := 512
else
BOARD_FLASH_BLOCK_SIZE := {{{flash_block_size}}}
endif

# Partition table configuration file
BOARD_GPT_INI ?= $(TARGET_DEVICE_DIR)/gpt.ini

TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_DEVICE)

BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_PREBUILT_DTBIMAGE_DIR := $(TARGET_DEVICE_DIR)/acpi
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
#
#kernel always use primary gpt without command line option "gpt",
#the label let kernel use the alternate GPT if primary GPT is corrupted.
#
BOARD_KERNEL_CMDLINE += gpt

#
# Trusted Factory Reset - persistent partition
#
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_HARDWARE)/bootctrl/boot/overlay

#can't use := here, as PRODUCT_OUT is not defined yet
BOARD_GPT_BIN = $(PRODUCT_OUT)/gpt.bin
BOARD_FLASHFILES += $(BOARD_GPT_BIN):gpt.bin
INSTALLED_RADIOIMAGE_TARGET += $(BOARD_GPT_BIN)

# We offer the possibility to flash from a USB storage device using
# the "installer" EFI application
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/installer.efi
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/startup.nsh
BOARD_FLASHFILES += $(PRODUCT_OUT)/bootloader.img

{{#bootloader_policy}}
{{#blpolicy_use_efi_var}}
ifneq ({{bootloader_policy}},static)
BOOTLOADER_POLICY_OEMVARS = $(PRODUCT_OUT)/bootloader_policy-oemvars.txt
BOARD_FLASHFILES += $(BOOTLOADER_POLICY_OEMVARS):bootloader_policy-oemvars.txt
BOARD_OEM_VARS += $(BOOTLOADER_POLICY_OEMVARS)
endif
{{/blpolicy_use_efi_var}}
{{/bootloader_policy}}

{{#run_tco_on_shutdown}}
BOARD_KERNEL_CMDLINE += iTCO_wdt.stop_on_shutdown=0
{{/run_tco_on_shutdown}}

{{#multi_user_support}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/boot-arch/multiuser
MULTI_USER_SUPPORT := true
{{/multi_user_support}}

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/boot-arch/generic
{{#slot-ab}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/generic
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/efi
{{/slot-ab}}
{{/use_cic}}

{{#rpmb}}
KERNELFLINGER_USE_RPMB := true
{{/rpmb}}

{{#rpmb_simulate}}
KERNELFLINGER_USE_RPMB_SIMULATE := true
{{/rpmb_simulate}}

{{^use_cic}}
{{#nvme_rpmb_scan}}
KERNELFLINGER_USE_NVME_RPMB := true
{{/nvme_rpmb_scan}}

{{#slot-ab}}
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/update_ifwi_ab \
    FILESYSTEM_TYPE_vendor={{system_fs}} \
    POSTINSTALL_OPTIONAL_vendor=true
{{/slot-ab}}

BOARD_AVB_ENABLE := true
KERNELFLINGER_AVB_CMDLINE := true
BOARD_VBMETAIMAGE_PARTITION_SIZE := 2097152
BOARD_FLASHFILES += $(PRODUCT_OUT)/vbmeta.img

BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

{{#slot-ab}}
AB_OTA_PARTITIONS += vbmeta
{{#trusty}}
AB_OTA_PARTITIONS += tos
{{/trusty}}

{{#bootloader_slot_ab}}
BOOTLOADER_SLOT := true
BOARD_ESP_PARTITION_SIZE := $$(({{esp_partition_size}} * 1024 * 1024))
BOARD_ESP_BLOCK_SIZE := $(BOARD_BOOTLOADER_BLOCK_SIZE)
BOARD_FLASHFILES += $(PRODUCT_OUT)/esp.img
AB_OTA_PARTITIONS += bootloader
{{/bootloader_slot_ab}}
{{/slot-ab}}

{{#usb_storage}}
KERNELFLINGER_SUPPORT_USB_STORAGE ?= true
{{/usb_storage}}

{{#live_boot}}
KERNELFLINGER_SUPPORT_LIVE_BOOT ?= true
{{/live_boot}}

{{#grub_installer}}
ENABLE_GRUB_INSTALLER ?= true
{{/grub_installer}}
{{/use_cic}}

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/soc
