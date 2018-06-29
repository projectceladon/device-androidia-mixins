BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_LINUX := false
BOARD_HAVE_BLUETOOTH_INTEL_ICNV:= true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/intel/common/bluetooth/bcm43241/
DEVICE_PACKAGE_OVERLAYS += device/intel/common/bluetooth/overlay-bt-pan
BOARD_SEPOLICY_DIRS += device/intel/project-celadon/sepolicy/bluetooth/common \
                       device/intel/project-celadon/sepolicy/bluetooth/intel
