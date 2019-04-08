ENABLE_NATIVEBRIDGE_64BIT := true

$(call inherit-product,$(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product,device/intel/project-celadon/clk/device.mk)

include build/make/target/product/treble_common.mk
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Overrides
PRODUCT_NAME := clk
PRODUCT_BRAND := clk
PRODUCT_DEVICE := clk
PRODUCT_MODEL := Generic clk
PRODUCT_MANUFACTURER := Intel

PRODUCT_SHIPPING_API_LEVEL := 28
