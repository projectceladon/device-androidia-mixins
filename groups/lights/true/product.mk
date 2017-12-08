# Lights HAL
BOARD_SEPOLICY_DIRS += \
    device/intel/android_ia/sepolicy/light

PRODUCT_PACKAGES += lights.android_ia \
    android.hardware.light@2.0-service \
    android.hardware.light@2.0-impl
