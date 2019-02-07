ENABLE_NATIVEBRIDGE_64BIT := true

$(call inherit-product,$(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product,device/intel/project-celadon/cel_kbl/device.mk)

# Overrides
PRODUCT_NAME := cel_kbl
PRODUCT_BRAND := cel_kbl
PRODUCT_DEVICE := cel_kbl
PRODUCT_MODEL := Generic cel_kbl
PRODUCT_MANUFACTURER := Intel

PRODUCT_SHIPPING_API_LEVEL := 28
