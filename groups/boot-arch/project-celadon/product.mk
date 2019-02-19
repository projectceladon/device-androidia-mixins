PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.frp.pst=/dev/block/by-name/persistent

ifeq ($(TARGET_BOOTLOADER_POLICY),$(filter $(TARGET_BOOTLOADER_POLICY),0x0 0x2 0x4 0x6))
# OEM Unlock reporting 1
#ADDITIONAL_DEFAULT_PROPERTIES += \
        ro.oem_unlock_supported=1

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
        ro.oem_unlock_supported=1

endif

{{#slot-ab}}
PRODUCT_PACKAGES += updater_ab_esp
{{/slot-ab}}

{{#ignore_not_applicable_reset}}
# Allow Kernelflinger to ignore the RSCI reset source "not_applicable"
# when setting the bootreason
KERNELFLINGER_IGNORE_NOT_APPLICABLE_RESET := true
{{/ignore_not_applicable_reset}}


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
PRODUCT_PROPERTY_OVERRIDES += \
	ro.oem_unlock_supported=1
#endif
ifeq ($(TARGET_BOOTLOADER_POLICY),$(filter $(TARGET_BOOTLOADER_POLICY),static external))
# The bootloader policy is not generated build time but is supplied
# statically in the repository or in $(PRODUCT_OUT)/.  If your
# bootloader policy allows the device to be unlocked, uncomment the
# following lines:
#PRODUCT_PROPERTY_OVERRIDES += \
	ro.oem_unlock_supported=1
endif
{{/bootloader_policy}}


{{^bootloader_policy}}
# OEM Unlock reporting 2
PRODUCT_PROPERTY_OVERRIDES += \
	ro.oem_unlock_supported=1
{{/bootloader_policy}}

{{#self_usb_device_mode_protocol}}
KERNELFLINGER_SUPPORT_SELF_USB_DEVICE_MODE_PROTOCOL := {{self_usb_device_mode_protocol}}
{{/self_usb_device_mode_protocol}}


{{#treble}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(TARGET_PRODUCT)
{{/treble}}
{{^treble}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab:root/fstab.$(TARGET_PRODUCT)
{{/treble}}

# Add the feature of FEATURE_VERIFIED_BOOT
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:vendor/etc/permissions/android.software.verified_boot.xml
