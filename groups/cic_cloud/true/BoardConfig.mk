# framework switches
TARGET_USES_HWC2                := true

TARGET_DONT_USE_NATIVE_FENCE := true

VSYNC_EVENT_PHASE_OFFSET_NS := 7000000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 1000000

BOARD_SYSTEMIMAGE_PARTITION_SIZE :=   3758096384  # 3.5 GB

# define cic_cloud overlay
DEVICE_PACKAGE_OVERLAYS += device/intel/cic/cic_cloud/overlay

DEVICE_MANIFEST_FILE := device/intel/cic/cic_cloud/manifest.xml

BUILD_BROKEN_USES_BUILD_HOST_STATIC_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_SHARED_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_EXECUTABLE := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

# The generic product target doesn't have any hardware-specific pieces.
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true
TARGET_CPU_ABI := x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64
TARGET_PRELINK_MODULE := false

TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86

TARGET_USES_64_BIT_BINDER := true

# Enable dex-preoptimization to speed up the first boot sequence
# of an SDK AVD. Note that this operation only works on Linux for now
ifeq ($(HOST_OS),linux)
WITH_DEXPREOPT ?= true
endif

# Container related configurations
ANDROID_AS_GUEST := true

BOARD_USE_CUSTOMIZED_MESA := true

# Build and enable the OpenGL ES View renderer. When running on the emulator,
# the GLES renderer disables itself if host GL acceleration isn't available.
USE_OPENGL_RENDERER := true

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648 # 2 GB
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 512
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
DEVICE_MATRIX_FILE   := device/intel/cic/common/compatibility_matrix.xml

BOARD_SEPOLICY_DIRS += \
		build/target/board/generic/sepolicy \
		build/target/board/generic_x86/sepolicy

####################### Houdini board config
# Install Native Bridge
WITH_NATIVE_BRIDGE := true

# Enable ARM codegen for x86 with Native Bridge

