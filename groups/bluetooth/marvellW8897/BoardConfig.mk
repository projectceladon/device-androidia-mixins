BOARD_HAVE_BLUETOOTH := false
BOARD_HAVE_BLUETOOTH_LINUX_PRI := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR = $(TARGET_DEVICE_DIR)
DEVICE_PACKAGE_OVERLAYS += \
    $(INTEL_PATH_COMMON)/bluetooth/overlay-bt-pan \
    $(INTEL_PATH_COMMON)/bluetooth/overlay-hid-kb \
    $(INTEL_PATH_COMMON)/bluetooth/overlay-bt-startup

BOARD_SEPOLICY_DIRS += \
    $(INTEL_PATH_SEPOLICY)/bluetooth/common

{{^acrn-guest}}
BOARD_SEPOLICY_DIRS += \
    $(INTEL_PATH_SEPOLICY)/bluetooth/marvellW8897
{{/acrn-guest}}

{{#acrn-guest}}
BOARD_SEPOLICY_DIRS += \
    $(INTEL_PATH_SEPOLICY)/bluetooth/marvellW8897_acrn
{{/acrn-guest}}

