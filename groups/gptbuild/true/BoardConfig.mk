# can't use := here, as PRODUCT_OUT is not defined yet
GPTIMAGE_BIN = $(PRODUCT_OUT)/$(TARGET_PRODUCT).img
{{#generate_craff}}
CRAFFIMAGE_BIN = $(PRODUCT_OUT)/$(TARGET_PRODUCT).craff
{{/generate_craff}}
BOARD_FLASHFILES += $(GPTIMAGE_BIN):$(TARGET_PRODUCT).img

ifeq ($(TARGET_USE_TRUSTY),true)
TRUSTY_ENV_VAR += ENABLE_TRUSTY_SIMICS=true
endif
