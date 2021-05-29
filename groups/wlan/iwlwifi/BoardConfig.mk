# This enables the wpa wireless driver
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION := VER_2_1_DEVEL
{{#libwifi-hal}}
# required for wifi HAL support
BOARD_WLAN_DEVICE := iwlwifi
{{/libwifi-hal}}

BOARD_WPA_SUPPLICANT_PRIVATE_LIB ?= lib_driver_cmd_intc

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/wlan/load_iwlwifi

BOARD_SEPOLICY_M4DEFS += module_iwlwifi=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/wlan/iwlwifi
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
