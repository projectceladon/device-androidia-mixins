TARGET_DEVICE := $(shell basename $(TARGET_DEVICE_DIR))

$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_CHARACTERISTICS := tablet
PRODUCT_AAPT_CONFIG := normal large xlarge mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi
PRODUCT_NAME := cic_cloud
PRODUCT_DEVICE := cic_cloud
PRODUCT_BRAND := Intel
PRODUCT_MODEL := ICS3A on cloud
