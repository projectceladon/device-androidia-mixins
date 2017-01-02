define generate_flashfiles
zip -qj $(1) $(2)
endef

out_flashfiles := $(PRODUCT_OUT)/$(TARGET_PRODUCT).flashfiles.$(TARGET_BUILD_VARIANT).$(USER).zip

$(out_flashfiles): $(BOARD_FLASHFILES) | $(ACP)
	$(call generate_flashfiles,$@, $^)

.PHONY: flashfiles
flashfiles: $(out_flashfiles)
