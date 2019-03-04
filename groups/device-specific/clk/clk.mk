ENABLE_NATIVEBRIDGE_64BIT := true

$(call inherit-product,$(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product,device/intel/project-celadon/clk/device.mk)

# Include GMS application
FLAG_GMS_MINIMAL := true
FLAG_GMS_AVAILABLE := true
$(call inherit-product-if-exists, vendor/google/gms/products/gms.mk)

# Overrides
PRODUCT_NAME := clk
PRODUCT_BRAND := clk
PRODUCT_DEVICE := clk
PRODUCT_MODEL := Generic clk
PRODUCT_MANUFACTURER := Intel

PRODUCT_SHIPPING_API_LEVEL := 28
