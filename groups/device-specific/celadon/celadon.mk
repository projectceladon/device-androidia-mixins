ENABLE_NATIVEBRIDGE_64BIT := true

$(call inherit-product,$(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product,device/intel/project-celadon/celadon/device.mk)

include build/make/target/product/treble_common.mk
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Include GMS application
FLAG_GMS_MINIMAL := true
FLAG_GMS_AVAILABLE := true
$(call inherit-product-if-exists, vendor/google/gms/products/gms.mk)

# Overrides
PRODUCT_NAME := celadon
PRODUCT_BRAND := celadon
PRODUCT_DEVICE := celadon
PRODUCT_MODEL := Generic celadon
PRODUCT_MANUFACTURER := Intel

PRODUCT_SHIPPING_API_LEVEL := 28
