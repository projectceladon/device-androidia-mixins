ff_intermediates := $(call intermediates-dir-for,PACKAGING,flashfiles)

fftf_build_opt := $(ff_intermediates)/fftf_build.opt

$(fftf_build_opt): $(ACP)
	$(hide) mkdir -p $(ff_intermediates)
	$(hide) rm -f $(fftf_build_opt)
	$(eval FFTF_TARGET_TO_FILE = \
					FASTBOOT_IMG_DIR:$(FASTBOOT_IMG_DIR) \
					FLSTOOL:$(FLSTOOL) \
					INTEL_PRG_FILE:$(INTEL_PRG_FILE) \
					PSI_RAM_FLS:$(PSI_RAM_FLS) \
					EBL_FLS:$(EBL_FLS) \
					PSI_RAM_SIGNED_FLS:$(PSI_RAM_SIGNED_FLS) \
					EBL_SIGNED_FLS:$(EBL_SIGNED_FLS) \
					SYSTEM_FLS_SIGN_SCRIPT:$(SYSTEM_FLS_SIGN_SCRIPT) \
					SOC_FIRMWARE_TYPE:$(SOC_FIRMWARE_TYPE) \
					SECPACK_IN_SLB:$(SECPACK_IN_SLB) \
					)
	$(hide) echo "$(FFTF_TARGET_TO_FILE)" > $@

SOFIA_PROVDATA_FILES += $(fftf_build_opt)

# We need a copy of the flashfiles configuration json in the
# TFP RADIO/ directory
ff_config := $(ff_intermediates)/flashfiles_fls.json
$(ff_config): $(FLASHFILES_CONFIG) | $(ACP)
	$(copy-file-to-target)

INSTALLED_RADIOIMAGE_TARGET += $(ff_config)

ff_intermediates := $(call intermediates-dir-for,PACKAGING,flashfiles)

provdata_dir := $(ff_intermediates)/provdata
provdata_zip := $(ff_intermediates)/provdata.zip

$(provdata_zip): $(SOFIA_PROVDATA_FILES) | $(ACP)
	$(hide) rm -f $(provdata_zip)
	$(hide) rm -rf $(provdata_dir)
	$(hide) mkdir -p $(provdata_dir)
	set -e; $(foreach file,$^,cp $(file) $(provdata_dir)/.;)
	zip -qj $@ $(provdata_dir)/*

INSTALLED_RADIOIMAGE_TARGET += $(provdata_zip)
