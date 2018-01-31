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

$(PRODUCT_OUT)/efi/installer.cmd: $(TARGET_DEVICE_DIR)/$(@F)
	$(ACP) $(TARGET_DEVICE_DIR)/$(@F) $@
	sed -i '/#/d' $@

$(PRODUCT_OUT)/efi/startup.nsh:
	$(ACP) $(TARGET_DEVICE_DIR)/$(@F) $@
	sed -i '/#/d' $@

$(out_flashfiles): $(BOARD_FLASHFILES) | $(ACP)
	$(call generate_flashfiles,$@, $^)

.PHONY: flashfiles
flashfiles: $(out_flashfiles)

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

BOARD_FIRST_STAGE_LOADER := $(PRODUCT_OUT)/efi/kernelflinger.efi
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
	$(hide) echo "Fastboot=\\EFI\\BOOT\\$(efi_default_name);-f">> $(efi_root)/manifest.txt
	$(hide) (cd $(efi_root) && zip -qry ../$(notdir $@) .)

bootloader_info := $(intermediates)/bootloader_image_info.txt
$(bootloader_info):
	$(hide) mkdir -p $(dir $@)
	$(hide) echo "size=$(BOARD_BOOTLOADER_PARTITION_SIZE)" > $@
	$(hide) echo "block_size=$(BOARD_BOOTLOADER_BLOCK_SIZE)" >> $@

INSTALLED_RADIOIMAGE_TARGET += $(bootloader_zip) $(bootloader_info)

# Rule to create $(OUT)/bootloader image, binaries within are signed with
# testing keys

BOOTLOADER_FROM_ZIP = device/intel/build/bootloader_from_zip

bootloader_bin := $(PRODUCT_OUT)/bootloader
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

$(BOOTLOADER_POLICY_OEMVARS): sign-efi-sig-list
	$(GEN_BLPOLICY_OEMVARS) -K $(TARGET_ODM_KEY_PAIR) \
		-O $(TARGET_OAK_KEY_PAIR).x509.pem -B $(TARGET_BOOTLOADER_POLICY) \
		$(BOOTLOADER_POLICY_OEMVARS)
endif
{{/blpolicy_use_efi_var}}
{{/bootloader_policy}}

