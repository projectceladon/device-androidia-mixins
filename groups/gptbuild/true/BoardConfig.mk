# can't use := here, as PRODUCT_OUT is not defined yet
GPTIMAGE_BIN = $(PRODUCT_OUT)/$(TARGET_PRODUCT)_gptimage.img
{{#generate_craff}}
CRAFFIMAGE_BIN = $(PRODUCT_OUT)/$(TARGET_PRODUCT)_gptimage.craff
{{/generate_craff}}
