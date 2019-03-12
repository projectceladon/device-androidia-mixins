src_loader_file := $(PRODUCT_OUT)/efi/kernelflinger.efi
tgt_loader_file := $(PRODUCT_OUT)/loader.efi

define generate_flashfiles
$(shell cp $(src_loader_file) $(tgt_loader_file))
zip -qj $(1) $(2) $(tgt_loader_file)
endef

ifneq ($(BUILD_NUMBER),)
out_flashfiles := $(PRODUCT_OUT)/$(TARGET_PRODUCT)-flashfiles-$(BUILD_NUMBER).zip
else
out_flashfiles := $(PRODUCT_OUT)/$(TARGET_PRODUCT).flashfiles.$(TARGET_BUILD_VARIANT).$(USER).zip
endif


$(PRODUCT_OUT)/efi/startup.nsh: $(TARGET_DEVICE_DIR)/{{_extra_dir}}/$(@F)
	$(ACP) $(TARGET_DEVICE_DIR)/{{_extra_dir}}/$(@F) $@
	sed -i '/#/d' $@

$(PRODUCT_OUT)/efi/unlock_device.nsh: $(TARGET_DEVICE_DIR)/{{_extra_dir}}/$(@F)
	$(ACP) $(TARGET_DEVICE_DIR)/{{_extra_dir}}/$(@F) $@
	sed -i '/#/d' $@

$(PRODUCT_OUT)/efi/efivar_oemlock: $(TARGET_DEVICE_DIR)/$(@F)
	$(ACP) $(TARGET_DEVICE_DIR)/$(@F) $@

$(out_flashfiles): $(BOARD_FLASHFILES) | $(ACP)
	$(call generate_flashfiles,$@, $^)


.PHONY: flashfiles_simple
flashfiles_simple: $(out_flashfiles)

# Rules to create bootloader zip file, a precursor to the bootloader
# image that is stored in the target-files-package. There's also
# metadata file which indicates how large to make the VFAT filesystem
# image

ifeq ($(TARGET_UEFI_ARCH),i386)
efi_default_name := bootia32.efi
LOADER_TYPE := linux-x86
else
efi_default_name := bootx64.efi
LOADER_TYPE := linux-x86_64
endif

# (pulled from build/core/Makefile as this gets defined much later)
# Pick a reasonable string to use to identify files.
ifneq "" "$(filter eng.%,$(BUILD_NUMBER))"
# BUILD_NUMBER has a timestamp in it, which means that
# it will change every time.  Pick a stable value.
FILE_NAME_TAG := eng.$(USER)
else
FILE_NAME_TAG := $(BUILD_NUMBER)
endif

KF4UEFI := $(PRODUCT_OUT)/efi/kernelflinger.efi
BOARD_FIRST_STAGE_LOADER := $(KF4UEFI)
BOARD_EXTRA_EFI_MODULES :=

# We stash a copy of BIOSUPDATE.fv so the FW sees it, applies the
# update, and deletes the file. Follows Google's desire to update all
# bootloader pieces with a single "fastboot flash bootloader" command.
# Since it gets deleted we can't do incremental updates of it, we keep
# a copy as capsules/current.fv for this purpose.
intermediates := $(call intermediates-dir-for,PACKAGING,bootloader_zip)
bootloader_zip := $(intermediates)/bootloader.zip
$(bootloader_zip): intermediates := $(intermediates)
$(bootloader_zip): efi_root := $(intermediates)/root
$(bootloader_zip): \
		$(TARGET_DEVICE_DIR)/AndroidBoard.mk \
		$(BOARD_FIRST_STAGE_LOADER) \
		$(BOARD_EXTRA_EFI_MODULES) \
		$(BOARD_SFU_UPDATE) \
		| $(ACP) \

	$(hide) rm -rf $(efi_root)
	$(hide) rm -f $@
ifneq ($(BOOTLOADER_SLOT), true)
	$(hide) mkdir -p $(efi_root)/capsules
	$(hide) mkdir -p $(efi_root)/EFI/BOOT
	$(foreach EXTRA,$(BOARD_EXTRA_EFI_MODULES), \
		$(hide) $(ACP) $(EXTRA) $(efi_root)/)
ifneq ($(BOARD_SFU_UPDATE),)
        $(hide) $(ACP) $(BOARD_SFU_UPDATE) $(efi_root)/BIOSUPDATE.fv
        $(hide) $(ACP) $(BOARD_SFU_UPDATE) $(efi_root)/capsules/current.fv
endif
	$(hide) $(ACP) $(BOARD_FIRST_STAGE_LOADER) $(efi_root)/loader.efi
	$(hide) $(ACP) $(BOARD_FIRST_STAGE_LOADER) $(efi_root)/EFI/BOOT/$(efi_default_name)
	$(hide) echo "Android-IA=\\EFI\\BOOT\\$(efi_default_name)" > $(efi_root)/manifest.txt
ifeq ($(BOARD_BOOTOPTION_FASTBOOT),true)
	$(hide) echo "Fastboot=\\EFI\\BOOT\\$(efi_default_name);-f">> $(efi_root)/manifest.txt
endif
else # BOOTLOADER_SLOT == false
	$(hide) mkdir -p $(efi_root)/EFI/INTEL/
	$(hide) $(ACP) $(KF4UEFI) $(efi_root)/EFI/INTEL/KF4UEFI.EFI
endif # BOOTLOADER_SLOT
	$(hide) (cd $(efi_root) && zip -qry ../$(notdir $@) .)

bootloader_info := $(intermediates)/bootloader_image_info.txt
$(bootloader_info):
	$(hide) mkdir -p $(dir $@)
	$(hide) echo "size=$(BOARD_BOOTLOADER_PARTITION_SIZE)" > $@
	$(hide) echo "block_size=$(BOARD_BOOTLOADER_BLOCK_SIZE)" >> $@


# Rule to create $(OUT)/bootloader image, binaries within are signed with
# testing keys

BOOTLOADER_FROM_ZIP = device/intel/build/bootloader_from_zip

bootloader_bin := $(PRODUCT_OUT)/bootloader.img
INSTALLED_RADIOIMAGE_TARGET += $(bootloader_bin) $(bootloader_info)
$(bootloader_bin): \
		$(bootloader_zip) \
		$(IMG2SIMG) \
		$(BOOTLOADER_ADDITIONAL_DEPS) \
		$(BOOTLOADER_FROM_ZIP) \

	$(hide) $(BOOTLOADER_FROM_ZIP) \
		 --size $(BOARD_BOOTLOADER_PARTITION_SIZE) \
		--block-size $(BOARD_BOOTLOADER_BLOCK_SIZE) \
		$(BOOTLOADER_ADDITIONAL_ARGS) \
		--zipfile $(bootloader_zip) \
		$@

droidcore: $(bootloader_bin)

.PHONY: bootloader
bootloader: $(bootloader_bin)
$(call dist-for-goals,droidcore,$(bootloader_bin):$(TARGET_PRODUCT)-bootloader-$(FILE_NAME_TAG))

fastboot_usb_bin := $(PRODUCT_OUT)/fastboot-usb.img
$(fastboot_usb_bin): \
		$(bootloader_zip) \
		$(BOOTLOADER_ADDITIONAL_DEPS) \
		$(BOOTLOADER_FROM_ZIP) \

	$(hide) $(BOOTLOADER_FROM_ZIP) \
		$(BOOTLOADER_ADDITIONAL_ARGS) \
		--zipfile $(bootloader_zip) \
		--extra-size 10485760 \
		--bootable \
		$@

# Build when 'make' is run with no args
droidcore: $(fastboot_usb_bin)

.PHONY: fastboot-usb
fastboot-usb: $(fastboot_usb_bin)

$(call dist-for-goals,droidcore,$(fastboot_usb_bin):$(TARGET_PRODUCT)-fastboot-usb-$(FILE_NAME_TAG).img)
$(call dist-for-goals,droidcore,device/intel/build/testkeys/testkeys_lockdown.txt:test-keys_efi_lockdown.txt)
$(call dist-for-goals,droidcore,device/intel/build/testkeys/unlock.txt:efi_unlock.txt)

{{#bootloader_policy}}
{{#blpolicy_use_efi_var}}
ifeq ($(TARGET_BOOTLOADER_POLICY),$(filter $(TARGET_BOOTLOADER_POLICY),static external))
# The bootloader policy is not built but is provided statically in the
# repository or in $(PRODUCT_OUT)/.
else
# Bootloader policy values are generated based on the
# TARGET_BOOTLOADER_POLICY value and the
# device/intel/build/testkeys/{odm,OAK} keys.  The OEM must provide
# its own keys.
GEN_BLPOLICY_OEMVARS := device/intel/build/generate_blpolicy_oemvars
TARGET_ODM_KEY_PAIR := device/intel/build/testkeys/odm
TARGET_OAK_KEY_PAIR := device/intel/build/testkeys/OAK

$(BOOTLOADER_POLICY_OEMVARS):
	$(GEN_BLPOLICY_OEMVARS) -K $(TARGET_ODM_KEY_PAIR) \
		-O $(TARGET_OAK_KEY_PAIR).x509.pem -B $(TARGET_BOOTLOADER_POLICY) \
		$(BOOTLOADER_POLICY_OEMVARS)
endif
{{/blpolicy_use_efi_var}}
{{/bootloader_policy}}


GPT_INI2BIN := ./device/intel/common/gpt_bin/gpt_ini2bin.py

$(BOARD_GPT_BIN): $(TARGET_DEVICE_DIR)/gpt.ini
	$(hide) $(GPT_INI2BIN) $< > $@
	$(hide) echo GEN $(notdir $@)

# Use by updater_ab_esp
{{#bootloader_slot_ab}}
EFI_FILE := kfld.efi
UPDATER_MOUNT_POINT := esp
{{/bootloader_slot_ab}}
{{^bootloader_slot_ab}}
EFI_FILE := kernelflinger.efi
UPDATER_MOUNT_POINT := bootloader
{{/bootloader_slot_ab}}
$(PRODUCT_OUT)/vendor.img: $(PRODUCT_OUT)/vendor/firmware/$(EFI_FILE)
$(PRODUCT_OUT)/vendor/firmware/$(EFI_FILE): $(PRODUCT_OUT)/efi/$(EFI_FILE)
	$(ACP) $(PRODUCT_OUT)/efi/$(EFI_FILE) $@

make_mountpoint_dir:
	@mkdir -p $(PRODUCT_OUT)/root/$(UPDATER_MOUNT_POINT)

$(PRODUCT_OUT)/ramdisk.img: make_mountpoint_dir

{{#bootloader_slot_ab}}
esp_intermediates := $(call intermediates-dir-for,PACKAGING,esp_zip)
esp_zip := $(esp_intermediates)/esp.zip
$(esp_zip): esp_intermediates := $(esp_intermediates)
$(esp_zip): esp_root := $(esp_intermediates)/root
$(esp_zip): \
		$(TARGET_DEVICE_DIR)/AndroidBoard.mk \
		$(PRODUCT_OUT)/efi/kfld.efi \
		$(BOARD_SFU_UPDATE) \
		| $(ACP) \

	$(hide) rm -rf $(esp_root)
	$(hide) rm -f $@
	$(hide) mkdir -p $(esp_root)/capsules
	$(hide) mkdir -p $(esp_root)/EFI/BOOT
	$(hide) mkdir -p $(esp_root)/EFI/INTEL
ifneq ($(BOARD_SFU_UPDATE),)
        $(hide) $(ACP) $(BOARD_SFU_UPDATE) $(esp_root)/BIOSUPDATE.fv
        $(hide) $(ACP) $(BOARD_SFU_UPDATE) $(esp_root)/capsules/current.fv
endif
	$(hide) $(ACP) $(PRODUCT_OUT)/efi/kfld.efi $(esp_root)/loader.efi
	$(hide) $(ACP) $(PRODUCT_OUT)/efi/kfld.efi $(esp_root)/EFI/BOOT/$(efi_default_name)
	$(hide) echo "Android-IA=\\EFI\\BOOT\\$(efi_default_name)" > $(esp_root)/manifest.txt
ifeq ($(BOARD_BOOTOPTION_FASTBOOT),true)
	$(hide) echo "Fastboot=\\EFI\\BOOT\\$(efi_default_name);-f">> $(esp_root)/manifest.txt
endif
	$(hide) (cd $(esp_root) && zip -qry ../$(notdir $@) .)


esp_info := $(esp_intermediates)/esp_image_info.txt
$(esp_info):
	$(hide) mkdir -p $(dir $@)
	$(hide) echo "size=$(BOARD_ESP_PARTITION_SIZE)" > $@
	$(hide) echo "block_size=$(BOARD_ESP_BLOCK_SIZE)" >> $@


esp_bin := $(PRODUCT_OUT)/esp.img
$(esp_bin): \
		$(esp_zip) \
		$(BOOTLOADER_FROM_ZIP)

	$(hide) $(BOOTLOADER_FROM_ZIP) \
		--size $(BOARD_ESP_PARTITION_SIZE) \
		--block-size $(BOARD_ESP_BLOCK_SIZE) \
		--zipfile $(esp_zip) \
		$@

INSTALLED_RADIOIMAGE_TARGET += $(esp_bin) $(esp_info)

droidcore: $(esp_bin)

.PHONY: esp
esp: $(esp_bin)

$(call dist-for-goals,droidcore,$(esp_bin):$(TARGET_PRODUCT)-esp-$(FILE_NAME_TAG).img)

$(PRODUCT_OUT)/vendor.img: $(PRODUCT_OUT)/vendor/firmware/kfld.efi
$(PRODUCT_OUT)/vendor/firmware/kfld.efi: $(PRODUCT_OUT)/efi/kfld.efi
	$(ACP) $(PRODUCT_OUT)/efi/kfld.efi $@

{{/bootloader_slot_ab}}
