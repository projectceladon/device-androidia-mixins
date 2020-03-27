BOARD_HAVE_BLUETOOTH_INTEL_ICNV := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/intel/project-celadon/$(TARGET_PRODUCT)/bluetooth/tablet/
DEVICE_PACKAGE_OVERLAYS += device/intel/project-celadon/$(TARGET_PRODUCT)/bluetooth/tablet/overlay

BOARD_SEPOLICY_DIRS += device/intel/sepolicy/bluetooth
