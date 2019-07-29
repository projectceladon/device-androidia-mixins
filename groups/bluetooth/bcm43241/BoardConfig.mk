BOARD_HAVE_BLUETOOTH := true
{{#hsu}}
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_CUSTOM_BT_CONFIG := $(INTEL_PATH_COMMON)/bluetooth/default/default.conf
{{/hsu}}
{{^hsu}}
BOARD_HAVE_BLUETOOTH_LINUX := true
{{/hsu}}
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(INTEL_PATH_COMMON)/bluetooth/bcm43241/
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-bt-pan
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-hid-kb
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/bluetooth/common \
                       $(INTEL_PATH_SEPOLICY)/bluetooth/bcm43241
