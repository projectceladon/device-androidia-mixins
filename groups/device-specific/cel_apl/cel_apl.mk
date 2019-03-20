ENABLE_NATIVEBRIDGE_64BIT := true

$(call inherit-product,$(SRC_TARGET_DIR)/product/core_64_bit.mk)

PRODUCT_FULL_TREBLE_OVERRIDE := true

# Include GAS application.
# Must put this calling before device.mk to make sure GAS overlay take
# precedence than Car product overlay
FLAG_GAS_MINIMAL := true
FLAG_GAS_AVAILABLE := true
$(call inherit-product-if-exists, vendor/google/gas/products/gas.mk)
$(call inherit-product,device/intel/project-celadon/cel_apl/device.mk)

# Overrides
PRODUCT_NAME := cel_apl
PRODUCT_BRAND := cel_apl
PRODUCT_DEVICE := cel_apl
PRODUCT_MODEL := Generic cel_apl
PRODUCT_MANUFACTURER := Intel

PRODUCT_SHIPPING_API_LEVEL := 28
