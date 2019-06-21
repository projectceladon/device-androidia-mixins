# can't use := here, as PRODUCT_OUT is not defined yet
{{#dynamic-partitions}}
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
{{/dynamic-partitions}}
GPTIMAGE_BIN = $(PRODUCT_OUT)/$(TARGET_PRODUCT).img
{{#generate_craff}}
CRAFFIMAGE_BIN = $(PRODUCT_OUT)/$(TARGET_PRODUCT).craff
{{/generate_craff}}
BOARD_FLASHFILES += $(GPTIMAGE_BIN):$(TARGET_PRODUCT).img
ifeq ($(TARGET_USE_TRUSTY),true)
TRUSTY_ENV_VAR += ENABLE_TRUSTY_SIMICS=true
endif

{{#compress_gptimage}}
COMPRESS_GPTIMAGE ?= true
{{/compress_gptimage}}

ifeq ($(COMPRESS_GPTIMAGE), true)
GPTIMAGE_GZ ?= $(GPTIMAGE_BIN).gz
endif
