ff_intermediates := $(call intermediates-dir-for,PACKAGING,flashfiles)

# We need a copy of the flashfiles configuration JSON in the
# TFP RADIO/ directory
ff_config := $(ff_intermediates)/flashfiles.json
$(ff_config): $(FLASHFILES_CONFIG) | $(ACP)
	$(copy-file-to-target)

INSTALLED_RADIOIMAGE_TARGET += $(ff_config)

# We take any required images that can't be derived elsewhere in
# the TFP and put them in RADIO/provdata.zip.
ff_intermediates := $(call intermediates-dir-for,PACKAGING,flashfiles)
provdata_zip := $(ff_intermediates)/provdata.zip
ff_root := $(ff_intermediates)/root

define copy-flashfile
$(hide) $(ACP) $(1) $(2)

endef

$(provdata_zip): \
		$(foreach pair,$(BOARD_FLASHFILES),$(call word-colon,1,$(pair))) \
		| $(ACP) \

	$(hide) rm -f $(provdata_zip)
	$(hide) rm -rf $(ff_root)
	$(hide) mkdir -p $(ff_root)
	$(foreach pair,$(BOARD_FLASHFILES), \
		$(call copy-flashfile,$(call word-colon,1,$(pair)),$(ff_root)/$(call word-colon,2,$(pair))))
	$(hide) zip -qj $@ $(ff_root)/*

INSTALLED_RADIOIMAGE_TARGET += $(provdata_zip)

