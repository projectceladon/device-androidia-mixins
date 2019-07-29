BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_INTEL := true
BT_VENDOR_CONF_DIR := {{{vendor_conf}}}
BOARD_USE_IBT_STACK := {{{use_ibt}}}
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(INTEL_PATH_HARDWARE)/libbt-vendor-intel/conf/intel/{{{vendor_conf}}}/
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-bt-pan
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-hid-kb
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/bluetooth/common \
                       $(INTEL_PATH_SEPOLICY)/bluetooth/ag620 \
                       $(INTEL_PATH_SEPOLICY)/bluetooth/sofia_nvm

BOARD_HAVE_HCIVSSERVICE := {{{hci_vs_service}}}

{{#hci_vs_service}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/bthcivsservice
{{/hci_vs_service}}
