ENABLE_NATIVEBRIDGE_64BIT := true

$(call inherit-product,$(SRC_TARGET_DIR)/product/core_64_bit.mk)

include build/make/target/product/treble_common.mk
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Include GAS application.
# Must put this calling before device.mk to make sure GAS overlay take
# precedence than Car product overlay
FLAG_GAS_MINIMAL := true
FLAG_GAS_AVAILABLE := true
$(call inherit-product-if-exists, vendor/google/gas/products/gas.mk)
$(call inherit-product,device/intel/project-celadon/cel_kbl/device.mk)

# Overrides
PRODUCT_NAME := cel_kbl
PRODUCT_BRAND := cel_kbl
PRODUCT_DEVICE := cel_kbl
PRODUCT_MODEL := Generic cel_kbl
PRODUCT_MANUFACTURER := Intel

PRODUCT_SHIPPING_API_LEVEL := 28
