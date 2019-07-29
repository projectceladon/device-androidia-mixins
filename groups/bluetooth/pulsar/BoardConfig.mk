BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_INTEL := true
BT_VENDOR_CONF_DIR := {{{vendor_conf}}}
BOARD_USE_IBT_STACK := {{{use_ibt}}}
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(INTEL_PATH_HARDWARE)/libbt-vendor-intel/conf/intel/{{{vendor_conf}}}/
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-bt-pan
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-hid-kb
BOARD_SEPOLICY_M4DEFS += bt_pulsar_port={{{port}}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/bluetooth/common \
                       $(INTEL_PATH_SEPOLICY)/bluetooth/pulsar
BOARD_HAVE_HCIVSSERVICE := {{{hci_vs_service}}}

{{#hci_vs_service}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/bthcivsservice
{{/hci_vs_service}}

{{#gpp}}
ifeq ($(findstring cws_manu,$(BOARD_SEPOLICY_DIRS)),)
    BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/cws_manu
endif
{{/gpp}}
