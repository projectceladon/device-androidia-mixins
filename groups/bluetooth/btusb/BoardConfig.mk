BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_LINUX := true
DEVICE_PACKAGE_OVERLAYS += device/intel/common/bluetooth/overlay-bt-pan
BOARD_SEPOLICY_DIRS += device/intel/project-celadon/sepolicy/bluetooth/common \
                       device/intel/project-celadon/sepolicy/bluetooth/intel
{{#ivi}}
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/intel/common/bluetooth/intel/car/
{{/ivi}}

{{^ivi}}
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/intel/common/bluetooth/intel/tablet/
{{/ivi}}
