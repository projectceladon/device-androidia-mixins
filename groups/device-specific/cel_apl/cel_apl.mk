ENABLE_NATIVEBRIDGE_64BIT := true

$(call inherit-product,$(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product,device/intel/project-celadon/cel_apl/device.mk)

# Overrides
PRODUCT_NAME := cel_apl
PRODUCT_BRAND := cel_apl
PRODUCT_DEVICE := cel_apl
PRODUCT_MODEL := Generic cel_apl
PRODUCT_MANUFACTURER := Intel

PRODUCT_SHIPPING_API_LEVEL := 28
