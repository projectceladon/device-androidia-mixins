BOARD_FLASHFILES += $(PRODUCT_OUT)/init_boot.img

BUILDING_INIT_BOOT_IMAGE := true
BOARD_INCLUDE_INIT_BOOTIMAGE := true

# init_boot partition size is recommended to be 8MB, it can be larger.
# When this variable is set, init_boot.img will be built with the generic
# ramdisk, and that ramdisk will no longer be included in boot.img.
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 16777216

BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)
BOARD_AVB_INIT_BOOT_ADD_HASH_FOOTER_ARGS += --hash_algorithm sha256

{{#slot-ab}}
AB_OTA_PARTITIONS += init_boot
{{/slot-ab}}

BOARD_USES_RECOVERY_AS_BOOT :=
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE :=
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
