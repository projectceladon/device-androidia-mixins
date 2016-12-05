TARGET_UEFI_ARCH := {{{uefi_arch}}}
BIOS_VARIANT := {{{bios_variant}}}

$(call inherit-product,build/target/product/verity.mk)

PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/by-name/android_system

PRODUCT_PACKAGES += \
	pstore-clean

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.software.verified_boot.xml:system/etc/permissions/android.software.verified_boot.xml

BOARD_SFU_UPDATE := hardware/intel/efi_capsules/$(BIOS_VARIANT)/$(TARGET_PRODUCT).fv
EFI_IFWI_BIN := hardware/intel/efi_capsules/$(BIOS_VARIANT)/$(TARGET_PRODUCT)_ifwi.bin
EFI_EMMC_BIN := hardware/intel/efi_capsules/$(BIOS_VARIANT)/$(TARGET_PRODUCT)_emmc.bin
EFI_AFU_BIN := hardware/intel/efi_capsules/$(BIOS_VARIANT)/$(TARGET_PRODUCT)_afu.bin
DNXP_BIN := hardware/intel/efi_capsules/$(BIOS_VARIANT)/$(TARGET_PRODUCT)_dnxp_0x1.bin
CFGPART_XML := hardware/intel/efi_capsules/$(BIOS_VARIANT)/$(TARGET_PRODUCT)_cfgpart.xml
CSE_SPI_BIN := hardware/intel/efi_capsules/$(BIOS_VARIANT)/$(TARGET_PRODUCT)_cse_spi.bin

ifneq ($(TARGET_BUILD_VARIANT),user)
# Allow to add debug ifwi file only on userdebug and eng flashfiles
EFI_IFWI_DEBUG_BIN := hardware/intel/efi_capsules/debug/$(TARGET_PRODUCT)_ifwi.bin
endif

ifneq ($(CALLED_FROM_SETUP),true)
ifeq ($(wildcard $(BOARD_SFU_UPDATE)),)
$(warning $(BOARD_SFU_UPDATE) not found, OTA updates will not provide a firmware capsule)
BOARD_SFU_UPDATE :=
endif
ifeq ($(wildcard $(EFI_EMMC_BIN)),)
$(warning $(EFI_EMMC_BIN) not found, flashfiles will not include 2nd stage EMMC firmware)
EFI_EMMC_BIN :=
endif
ifeq ($(wildcard $(EFI_IFWI_BIN)),)
$(warning $(EFI_IFWI_BIN) not found, IFWI binary will not be provided in out/dist/)
EFI_IFWI_BIN :=
endif
ifeq ($(wildcard $(EFI_AFU_BIN)),)
$(warning $(EFI_AFU_BIN) not found, IFWI binary will not be provided in out/dist/)
EFI_AFU_BIN :=
endif
ifeq ($(wildcard $(EFI_IFWI_DEBUG_BIN)),)
EFI_IFWI_DEBUG_BIN :=
endif
ifeq ($(wildcard $(DNXP_BIN)),)
DNXP_BIN :=
endif
ifeq ($(wildcard $(CFGPART_XML)),)
CFGPART_XML :=
endif
ifeq ($(wildcard $(CSE_SPI_BIN)),)
CSE_SPI_BIN :=
endif
endif
{{#acpi_permissive}}
# Kernelflinger won't check the ACPI table oem_id, oem_table_id and
# revision fields
KERNELFLINGER_ALLOW_UNSUPPORTED_ACPI_TABLE := true
{{/acpi_permissive}}
{{#use_power_button}}
# Allow Kernelflinger to use the power key as an input source.
# Doesn't work on most boards.
KERNELFLINGER_USE_POWER_BUTTON := true
{{/use_power_button}}
{{^disable_watchdog}}
# Allow Kernelflinger to start watchdog prior to boot the kernel
KERNELFLINGER_USE_WATCHDOG := true
{{/disable_watchdog}}
{{#use_charging_applet}}
# Allow Kernelflinger to use the non-standard ChargingApplet protocol
# to get battery and charger status and modify the boot flow in
# consequence.
KERNELFLINGER_USE_CHARGING_APPLET := true
{{/use_charging_applet}}
{{#ignore_rsci}}
# Allow Kernelflinger to ignore the non-standard RSCI ACPI table
# to get reset and wake source from PMIC for bringup phase if
# the table reports incorrect data
KERNELFLINGER_IGNORE_RSCI := true
{{/ignore_rsci}}
{{#tdos}}
# TDOS design requires that the device can't be unlocked
# as that would defeat it.
TARGET_NO_DEVICE_UNLOCK := true
{{/tdos}}
{{^fastbootefi}}
TARGET_STAGE_USERFASTBOOT := true
TARGET_USE_USERFASTBOOT := true
{{/fastbootefi}}
