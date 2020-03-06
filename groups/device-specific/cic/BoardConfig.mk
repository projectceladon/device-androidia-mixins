# The generic product target doesn't have any hardware-specific pieces.
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true

# Container related configurations
ANDROID_AS_GUEST := true

TARGET_COPY_OUT_VENDOR := system/vendor
DEVICE_MATRIX_FILE   := $(INTEL_PATH_DEVICE_CIC)/compatibility_matrix.xml
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_DEVICE_CIC)/overlay
BOARD_SEPOLICY_DIRS += \
        build/target/board/generic/sepolicy \
        build/target/board/generic_x86/sepolicy

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648 # 2 GB
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 512
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_DEVICE_CIC)/sepolicy

