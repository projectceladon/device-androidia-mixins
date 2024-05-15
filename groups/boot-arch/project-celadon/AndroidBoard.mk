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

{{^use_cic}}
# (pulled from build/core/Makefile as this gets defined much later)
# Pick a reasonable string to use to identify files.
# BUILD_NUMBER has a timestamp in it, which means that
# it will change every time.  Pick a stable value.

KF4UEFI := $(PRODUCT_OUT)/efi/kernelflinger.efi
BOARD_FIRST_STAGE_LOADER := $(KF4UEFI)
BOARD_EXTRA_EFI_MODULES :=

#$(call flashfile_add_blob,capsule.fv,$(INTEL_PATH_HARDWARE)/fw_capsules/{{target}}/::variant::/$(BIOS_VARIANT)/capsule.fv,,BOARD_SFU_UPDATE)
#$(call flashfile_add_blob,ifwi.bin,$(INTEL_PATH_HARDWARE)/fw_capsules/{{target}}/::variant::/$(BIOS_VARIANT)/ifwi.bin,,EFI_IFWI_BIN)
#$(call flashfile_add_blob,ifwi_dnx.bin,$(INTEL_PATH_HARDWARE)/fw_capsules/{{target}}/::variant::/$(BIOS_VARIANT)/ifwi_dnx.bin,,EFI_IFWI_DNX_BIN)
#$(call flashfile_add_blob,firmware.bin,$(INTEL_PATH_HARDWARE)/fw_capsules/{{target}}/::variant::/$(BIOS_VARIANT)/emmc.bin,,EFI_EMMC_BIN)
#$(call flashfile_add_blob,afu.bin,$(INTEL_PATH_HARDWARE)/fw_capsules/{{target}}/::variant::/$(BIOS_VARIANT)/afu.bin,,EFI_AFU_BIN)
#$(call flashfile_add_blob,dnxp_0x1.bin,$(INTEL_PATH_HARDWARE)/fw_capsules/{{target}}/::variant::/$(BIOS_VARIANT)/dnxp_0x1.bin,,DNXP_BIN)
#$(call flashfile_add_blob,cfgpart.xml,$(INTEL_PATH_HARDWARE)/fw_capsules/{{target}}/::variant::/$(BIOS_VARIANT)/cfgpart.xml,,CFGPART_XML)
#$(call flashfile_add_blob,cse_spi.bin,$(INTEL_PATH_HARDWARE)/fw_capsules/{{target}}/::variant::/$(BIOS_VARIANT)/cse_spi.bin,,CSE_SPI_BIN)

{{#ifwi_debug}}
ifneq ($(TARGET_BUILD_VARIANT),user)
# Allow to add debug ifwi file only on userdebug and eng flashfiles
$(call flashfile_add_blob,ifwi_debug.bin,$(INTEL_PATH_HARDWARE)/fw_capsules/{{target}}/::variant::/debug/ifwi.bin,,EFI_IFWI_DEBUG_BIN)
$(call flashfile_add_blob,ifwi_debug_dnx.bin,$(INTEL_PATH_HARDWARE)/fw_capsules/{{target}}/::variant::/debug/ifwi_dnx.bin,,EFI_IFWI_DEBUG_DNX_BIN)
endif
{{/ifwi_debug}}

ifneq ($(EFI_IFWI_BIN),)
$(call dist-for-goals,droidcore,$(EFI_IFWI_BIN):$(TARGET_PRODUCT)-ifwi-$(FILE_NAME_TAG).bin)
endif

ifneq ($(EFI_IFWI_DNX_BIN),)
$(call dist-for-goals,droidcore,$(EFI_IFWI_DNX_BIN):$(TARGET_PRODUCT)-ifwi_dnx-$(FILE_NAME_TAG).bin)
endif

ifneq ($(EFI_AFU_BIN),)
$(call dist-for-goals,droidcore,$(EFI_AFU_BIN):$(TARGET_PRODUCT)-afu-$(FILE_NAME_TAG).bin)
endif

ifneq ($(BOARD_SFU_UPDATE),)
$(call dist-for-goals,droidcore,$(BOARD_SFU_UPDATE):$(TARGET_PRODUCT)-sfu-$(FILE_NAME_TAG).fv)
endif

ifneq ($(CALLED_FROM_SETUP),true)
ifeq ($(wildcard $(BOARD_SFU_UPDATE)),)
$(warning BOARD_SFU_UPDATE not found, OTA updates will not provide a firmware capsule)
endif
ifeq ($(wildcard $(EFI_EMMC_BIN)),)
$(warning EFI_EMMC_BIN not found, flashfiles will not include 2nd stage EMMC firmware)
endif
ifeq ($(wildcard $(EFI_IFWI_BIN)),)
$(warning EFI_IFWI_BIN not found, IFWI binary will not be provided in out/dist/)
endif
ifeq ($(wildcard $(EFI_AFU_BIN)),)
$(warning EFI_AFU_BIN not found, AFU IFWI binary will not be provided in out/dist/)
endif
endif

ifeq ($(BOARD_HAS_USB_DISK),true)
ifeq ($(FLASHFILE_VARIANTS),)
BOARD_USB_DISK_IMAGES = $(PRODUCT_OUT)/install-usb.img
else
BOARD_USB_DISK_IMAGE_PFX = $(PRODUCT_OUT)/install-usb
$(foreach var,$(FLASHFILE_VARIANTS), \
	$(eval BOARD_USB_DISK_IMAGES += $(BOARD_USB_DISK_IMAGE_PFX)-$(var).img))
endif
endif

{{^fw_sbl}}
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

bootloader_bin := $(PRODUCT_OUT)/bootloader.img
ifeq ($(INTEL_PREBUILT),true)
$(bootloader_bin):
	$(hide) $(ACP) $(INTEL_PATH_PREBUILTS)/bootloader.img $@
	@echo "Using prebuilt bootloader image from $(INTEL_PATH_PREBUILTS)"
else # INTEL_PREBUILT
$(bootloader_bin): \
		$(bootloader_zip) \
		$(IMG2SIMG) \
		$(BOOTLOADER_ADDITIONAL_DEPS) \
		$(INTEL_PATH_BUILD)/bootloader_from_zip \

	$(hide) $(INTEL_PATH_BUILD)/bootloader_from_zip \
		--size $(BOARD_BOOTLOADER_PARTITION_SIZE) \
		--block-size $(BOARD_BOOTLOADER_BLOCK_SIZE) \
		$(BOOTLOADER_ADDITIONAL_ARGS) \
		--zipfile $(bootloader_zip) \
		$@
ifneq ($(INTEL_PATH_PREBUILTS_OUT),)
	$(hide) mkdir -p $(INTEL_PATH_PREBUILTS_OUT)
	$(hide) $(ACP) $@ $(INTEL_PATH_PREBUILTS_OUT)
endif # INTEL_PATH_PREBUILTS_OUT
endif # INTEL_PREBUILT

INSTALLED_RADIOIMAGE_TARGET += $(bootloader_zip) $(bootloader_bin) $(bootloader_info)

droidcore: $(bootloader_bin)

bootloader: $(bootloader_bin)
$(call dist-for-goals,droidcore,$(bootloader_bin):$(TARGET_PRODUCT)-bootloader-$(FILE_NAME_TAG))

$(call dist-for-goals,droidcore,$(INTEL_PATH_BUILD)/testkeys/testkeys_lockdown.txt:test-keys_efi_lockdown.txt)
$(call dist-for-goals,droidcore,$(INTEL_PATH_BUILD)/testkeys/unlock.txt:efi_unlock.txt)
{{/fw_sbl}}

{{#fw_sbl}}

bootloader_bin := $(PRODUCT_OUT)/bootloader
BOARD_BOOTLOADER_DEFAULT_IMG := $(PRODUCT_OUT)/bootloader.img
BOARD_BOOTLOADER_DIR := $(PRODUCT_OUT)/sbl
BOARD_BOOTLOADER_IASIMAGE := $(BOARD_BOOTLOADER_DIR)/kf4sbl.sbl
BOARD_BOOTLOADER_VAR_IMG := $(BOARD_BOOTLOADER_DIR)/bootloader.img
BOARD_FLASHFILES += $(BOARD_BOOTLOADER_DEFAULT_IMG):bootloader

PREBUILT_INSTALLER := hardware/intel/kernelflinger/prebuilt/board/RPL_IVI/installer.efi
PREBUILT_KERNELFLINGER := hardware/intel/kernelflinger/prebuilt/board/RPL_IVI/kernelflinger.efi
INSTALLER_EFI := $(PRODUCT_OUT)/efi/installer.efi

$(BOARD_BOOTLOADER_DIR):
	$(hide) rm -rf $(BOARD_BOOTLOADER_DIR)
	$(hide) mkdir -p $(BOARD_BOOTLOADER_DIR)

intermediates := $(call intermediates-dir-for,PACKAGING,bootloader_zip)
bootloader_zip := $(intermediates)/bootloader.zip
$(bootloader_zip): intermediates := $(intermediates)
$(bootloader_zip): efi_root := $(intermediates)/root
$(bootloader_zip): \
		$(TARGET_DEVICE_DIR)/AndroidBoard.mk \
		$(BOARD_EXTRA_EFI_MODULES) \
		kf4sbl-$(TARGET_BUILD_VARIANT) \
		$(BOARD_SFU_UPDATE) \
		$(INSTALLER_EFI) \
		| $(ACP) \

	$(hide) rm -rf $(efi_root)
	$(hide) rm -f $@
ifneq ($(BOOTLOADER_SLOT), true)
	$(hide) mkdir -p $(efi_root)/capsules
	$(hide) mkdir -p $(efi_root)/EFI/BOOT
	$(hide) mkdir -p $(efi_root)/boot
	$(foreach EXTRA,$(BOARD_EXTRA_EFI_MODULES), \
		$(hide) $(ACP) $(EXTRA) $(efi_root)/)
ifneq ($(BOARD_SFU_UPDATE),)
	$(hide) $(ACP) $(BOARD_SFU_UPDATE) $(efi_root)/BIOSUPDATE.fv
	$(hide) $(ACP) $(BOARD_SFU_UPDATE) $(efi_root)/capsules/current.fv
endif
	$(hide) echo "Android-IA=\\EFI\\BOOT\\$(efi_default_name)" > $(efi_root)/manifest.txt
else # BOOTLOADER_SLOT == false
	$(hide) mkdir -p $(efi_root)/EFI/INTEL/
endif # BOOTLOADER_SLOT
	$(hide) $(ACP) $(TOP)/$(PREBUILT_KERNELFLINGER) $(efi_root)/EFI/BOOT/bootx64.efi
	$(hide) $(ACP) $(TOP)/$(PREBUILT_KERNELFLINGER) $(efi_root)/EFI/BOOT/bootia32.efi
	$(hide) (cd $(efi_root) && zip -qry ../$(notdir $@) .)

bootloader_info := $(intermediates)/bootloader_image_info.txt
$(bootloader_info):
	$(hide) mkdir -p $(dir $@)
	$(hide) echo "size=$(BOARD_BOOTLOADER_PARTITION_SIZE)" > $@
	$(hide) echo "block_size=$(BOARD_BOOTLOADER_BLOCK_SIZE)" >> $@

ifeq ($(INTEL_PREBUILT),true)
bootloader:
	$(hide) $(ACP) $(INTEL_PATH_PREBUILTS)/bootloader.img $(PRODUCT_OUT)
	@echo "Using prebuilt bootloader image from $(INTEL_PATH_PREBUILTS)"
else # INTEL_PREBUILT

define generate_bootloader_var
rm -f $(BOARD_BOOTLOADER_VAR_IMG)
cnt=`expr $(BOARD_BOOTLOADER_PARTITION_SIZE) / $(BOARD_BOOTLOADER_BLOCK_SIZE) `;\
dd of=$(BOARD_BOOTLOADER_VAR_IMG) if=/dev/zero bs=$(BOARD_BOOTLOADER_BLOCK_SIZE) count=$${cnt};\
ls -l $(BOARD_BOOTLOADER_VAR_IMG)
$(hide)mkdosfs -F32 -n ANDROIDIA $(BOARD_BOOTLOADER_VAR_IMG);
$(hide)mmd -i $(BOARD_BOOTLOADER_VAR_IMG) ::capsules;
$(hide)mmd -i $(BOARD_BOOTLOADER_VAR_IMG) ::EFI;
$(hide)mmd -i $(BOARD_BOOTLOADER_VAR_IMG) ::EFI/BOOT;
$(hide)mmd -i $(BOARD_BOOTLOADER_VAR_IMG) ::boot;
$(hide)mcopy -Q -i $(BOARD_BOOTLOADER_VAR_IMG) $(TOP)/$(PREBUILT_KERNELFLINGER) ::EFI/BOOT/bootx64.efi;
cp $(BOARD_BOOTLOADER_VAR_IMG) $(BOARD_BOOTLOADER_DEFAULT_IMG)
cp $(BOARD_BOOTLOADER_VAR_IMG) $(bootloader_bin)
echo "Bootloader image successfully generated $(BOARD_BOOTLOADER_VAR_IMG)"
endef

fastboot_image: fb4sbl-$(TARGET_BUILD_VARIANT)

bootloader: $(BOARD_BOOTLOADER_DIR) kf4sbl-$(TARGET_BUILD_VARIANT) fb4sbl-$(TARGET_BUILD_VARIANT)
	$(call generate_bootloader_var)

ifneq ($(INTEL_PATH_PREBUILTS_OUT),)
	$(hide) mkdir -p $(INTEL_PATH_PREBUILTS_OUT)
	$(hide) $(ACP) $(BOARD_BOOTLOADER_DEFAULT_IMG) $(INTEL_PATH_PREBUILTS_OUT)
endif # INTEL_PATH_PREBUILTS_OUT
endif # INTEL_PREBUILT

$(BOARD_BOOTLOADER_DEFAULT_IMG): bootloader
	@echo "Generate default bootloader: $@ finished."
droidcore: bootloader

INSTALLED_RADIOIMAGE_TARGET += $(bootloader_zip) $(BOARD_BOOTLOADER_DEFAULT_IMG) $(bootloader_info)

$(bootloader_bin): bootloader

$(INSTALLER_EFI):
	@echo "Using prebuild installer image for SBL"
	mkdir -p $(PRODUCT_OUT)/efi/
	$(ACP) -r $(TOP)/$(PREBUILT_INSTALLER) $@

{{/fw_sbl}}


.PHONY: bootloader
{{#bootloader_policy}}
{{#blpolicy_use_efi_var}}
ifeq ($(TARGET_BOOTLOADER_POLICY),$(filter $(TARGET_BOOTLOADER_POLICY),static external))
# The bootloader policy is not built but is provided statically in the
# repository or in $(PRODUCT_OUT)/.
else
# Bootloader policy values are generated based on the
# TARGET_BOOTLOADER_POLICY value and the
# $(INTEL_PATH_BUILD)/testkeys/{odm,OAK} keys.  The OEM must provide
# its own keys.
GEN_BLPOLICY_OEMVARS := $(INTEL_PATH_BUILD)/generate_blpolicy_oemvars
TARGET_ODM_KEY_PAIR := $(INTEL_PATH_BUILD)/testkeys/odm
TARGET_OAK_KEY_PAIR := $(INTEL_PATH_BUILD)/testkeys/OAK

$(BOOTLOADER_POLICY_OEMVARS):
	$(GEN_BLPOLICY_OEMVARS) -K $(TARGET_ODM_KEY_PAIR) \
		-O $(TARGET_OAK_KEY_PAIR).x509.pem -B $(TARGET_BOOTLOADER_POLICY) \
		$(BOOTLOADER_POLICY_OEMVARS)
endif
{{/blpolicy_use_efi_var}}
{{/bootloader_policy}}

{{#slot-ab}}
# Used for efi update
{{^fw_sbl}}
$(PRODUCT_OUT)/vendor.img: $(PRODUCT_OUT)/vendor/firmware/kernelflinger.efi
$(PRODUCT_OUT)/vendor/firmware/kernelflinger.efi: $(PRODUCT_OUT)/efi/kernelflinger.efi
	$(ACP) $(PRODUCT_OUT)/efi/kernelflinger.efi $@
{{/fw_sbl}}

make_bootloader_dir:
	@mkdir -p $(PRODUCT_OUT)/root/bootloader

$(PRODUCT_OUT)/ramdisk.img: make_bootloader_dir

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
		$(INTEL_PATH_BUILD)/bootloader_from_zip \

	$(hide) $(INTEL_PATH_BUILD)/bootloader_from_zip \
		--size $(BOARD_ESP_PARTITION_SIZE) \
		--block-size $(BOARD_ESP_BLOCK_SIZE) \
		--zipfile $(esp_zip) \
		$@

INSTALLED_RADIOIMAGE_TARGET += $(esp_zip) $(esp_bin) $(esp_info)

droidcore: $(esp_bin)

.PHONY: esp
esp: $(esp_bin)

$(call dist-for-goals,droidcore,$(esp_bin):$(TARGET_PRODUCT)-esp-$(FILE_NAME_TAG).img)

$(PRODUCT_OUT)/vendor.img: $(PRODUCT_OUT)/vendor/firmware/kfld.efi
$(PRODUCT_OUT)/vendor/firmware/kfld.efi: $(PRODUCT_OUT)/efi/kfld.efi
	$(ACP) $(PRODUCT_OUT)/efi/kfld.efi $@

{{/bootloader_slot_ab}}
{{/slot-ab}}
{{/use_cic}}
