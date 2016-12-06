TARGET_UEFI_ARCH := x86_64

#BIOS_VARIANT := release

#$(call inherit-product,build/target/product/verity.mk)

#PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/by-name/android_system

# Allow Kernelflinger to use the power key as an input source.
# Doesn't work on most boards.
#KERNELFLINGER_USE_POWER_BUTTON := true

# Kernelflinger won't check the ACPI table oem_id, oem_table_id and
# revision fields
KERNELFLINGER_ALLOW_UNSUPPORTED_ACPI_TABLE := true

# Allow Kernelflinger to start watchdog prior to boot the kernel
KERNELFLINGER_USE_WATCHDOG := true

# Allow Kernelflinger to use the non-standard ChargingApplet protocol
# to get battery and charger status and modify the boot flow in
# consequence.
#KERNELFLINGER_USE_CHARGING_APPLET := true

# Allow Kernelflinger to ignore the non-standard RSCI ACPI table
# to get reset and wake source from PMIC for bringup phase if
# the table reports incorrect data
KERNELFLINGER_IGNORE_RSCI := true

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
#TARGET_BOOTLOADER_POLICY := 0x0

# If the following variable is set to false, the bootloader policy and
# RMA refurbishing features does not use time-based authenticated EFI
# variables to store the BPM and OAK values.  The BPM value is defined
# compilation time by the TARGET_BOOTLOADER_POLICY variable.
#TARGET_BOOTLOADER_POLICY_USE_EFI_VAR := true

ifeq ($(TARGET_BOOTLOADER_POLICY),$(filter $(TARGET_BOOTLOADER_POLICY),0x0 0x2 0x4 0x6))
# OEM Unlock reporting
ADDITIONAL_DEFAULT_PROPERTIES += \
	ro.oem_unlock_supported=1
endif


ifeq ($(TARGET_BOOTLOADER_POLICY),$(filter $(TARGET_BOOTLOADER_POLICY),static external))
# The bootloader policy is not generated build time but is supplied
# statically in the repository or in $(PRODUCT_OUT)/.  If your
# bootloader policy allows the device to be unlocked, uncomment the
# following lines:
# ADDITIONAL_DEFAULT_PROPERTIES += \
#       ro.oem_unlock_supported=1
endif

# OEM Unlock reporting
ADDITIONAL_DEFAULT_PROPERTIES += \
	ro.oem_unlock_supported=1

#PRODUCT_PACKAGES += \
	slideshow \
	verity_warning_images

# Kernelfligner will set the global variable OsSecureBoot
# The BIOS must support this variable to enable this feature
#KERNELFLINGER_OS_SECURE_BOOT := true

# Android Kernelflinger uses the OpenSSL library to support the
# bootloader policy
KERNELFLINGER_SSL_LIBRARY := boringssl

# 13 MB bootloader.
BOARD_BOOTLOADER_PARTITION_SIZE := 13631488

# Used when rebuilding kernelflinger
BOARD_BOOTLOADER_BLOCK_SIZE := 4096

BOOTLOADER_USE_PREBUILT := $(shell echo $${BOOTLOADER_USE_PREBUILT:-true})
