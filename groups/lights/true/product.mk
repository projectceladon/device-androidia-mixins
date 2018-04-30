# Lights HAL
BOARD_SEPOLICY_DIRS += \
    device/intel/project-celadon/sepolicy/light

PRODUCT_PACKAGES += lights.project-celadon \
    android.hardware.light@2.0-service \
    android.hardware.light@2.0-impl
