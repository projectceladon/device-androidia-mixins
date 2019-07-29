PRODUCT_PACKAGES += \
    hostapd \
    hostapd_cli \
    wpa_supplicant \
    wpa_cli

# iwlwifi USC
PRODUCT_PACKAGES += \
    wifi_intel_usc

#copy modules configuration
PRODUCT_COPY_FILES += \
        $(INTEL_PATH_COMMON)/wlan/iwlwifi/iwl_3gr.conf:/system/etc/hald/fuse/modprobe.d/iwl_3gr.conf \
        $(INTEL_PATH_COMMON)/wlan/iwlwifi/iwl_lte.conf:/system/etc/hald/fuse/modprobe.d/iwl_lte.conf \

#copy iwlwifi wpa config files
PRODUCT_COPY_FILES += \
        $(INTEL_PATH_COMMON)/wlan/wpa_supplicant-common.conf:vendor/etc/wifi/wpa_supplicant.conf \
        $(INTEL_PATH_COMMON)/wlan/iwlwifi/wpa_supplicant_overlay_no_tdls.conf:system/etc/hald/fuse/default/wpa_supplicant_overlay_no_tdls.conf \
        $(INTEL_PATH_COMMON)/wlan/iwlwifi/wpa_supplicant_overlay.conf:system/etc/hald/fuse/default/wpa_supplicant_overlay_tdls.conf \
        frameworks/native/data/etc/android.hardware.wifi.xml:vendor/etc/permissions/android.hardware.wifi.xml \
        frameworks/native/data/etc/android.hardware.wifi.direct.xml:vendor/etc/permissions/android.hardware.wifi.direct.xml

# Firmwares with device-specific file names can go to standard firmware folder
TARGET_OUT_WLAN_FW_COMMON := $(TARGET_OUT)/vendor/firmware

# Because system images for LTE and 3GR are almost full, we don't copy all the
# firmwares on both platforms. Choice is based on iwl_platform mixins parameter.
IWL_PLATFORM := {{{iwl_platform}}}

ifeq ($(IWL_PLATFORM), sofia_3gr)

#
# Copy a620 firwmare and config files to vendor/wifi/a620
# It will be bind-mounted by hald upon device discovery
TARGET_OUT_WLAN_FW := $(TARGET_OUT)/vendor/wifi/a620/firmware
TARGET_OUT_ETC_WIFI := $(TARGET_OUT)/vendor/wifi/a620/etc
LOCAL_IWL_FW_DIR := $(INTEL_PATH_VENDOR)/fw/iwl/lhp

IWL_UCODE_FILES := $(notdir $(wildcard $(LOCAL_IWL_FW_DIR)/*a620*.ucode))
IWL_PAPD_DB_FILES := $(notdir $(shell find $(LOCAL_IWL_FW_DIR)/papd_db -type f))

# Copy ucode firmwares with device-specific file names to $(TARGET_OUT_WLAN_FW_COMMON)
# Others firmware files are copied to $(TARGET_OUT_WLAN_FW) and $(TARGET_OUT_ETC_WIFI)
# copying nvm to firmware is temporary
PRODUCT_COPY_FILES += \
	$(LOCAL_IWL_FW_DIR)/nvmData-a620:$(TARGET_OUT_WLAN_FW)/iwl_nvm.bin \
	$(LOCAL_IWL_FW_DIR)/nvmData-a620:$(TARGET_OUT_ETC_WIFI)/nvmDataDefault \
	$(LOCAL_IWL_FW_DIR)/fw_info.txt:$(TARGET_OUT_WLAN_FW)/fw_info.txt \
	$(LOCAL_IWL_FW_DIR)/iwl-dbg-cfg.ini:$(TARGET_OUT_WLAN_FW)/iwl-dbg-cfg.ini \
	$(LOCAL_IWL_FW_DIR)/softap-dummy-ucode:$(TARGET_OUT_WLAN_FW)/iwlwifi-softap-dummy.ucode \
	$(foreach ucode,$(IWL_UCODE_FILES),\
		$(LOCAL_IWL_FW_DIR)/$(ucode):$(TARGET_OUT_WLAN_FW_COMMON)/$(ucode)) \
	$(foreach file,$(IWL_PAPD_DB_FILES),\
                $(LOCAL_IWL_FW_DIR)/papd_db/$(file):$(TARGET_OUT_ETC_WIFI)/papd_db/$(file))

endif

ifeq ($(IWL_PLATFORM), sofia_lte)

#
# Copy lnp firwmare and config files to vendor/wifi/lnp
# It will be bind-mounted by hald upon device discovery
TARGET_OUT_WLAN_FW_LNP := $(TARGET_OUT)/vendor/wifi/lnp/firmware
TARGET_OUT_ETC_WIFI_LNP := $(TARGET_OUT)/vendor/wifi/lnp/etc
LOCAL_IWL_FW_DIR_LNP := $(INTEL_PATH_VENDOR)/fw/iwl/rel

IWL_UCODE_FILES := $(notdir $(wildcard $(LOCAL_IWL_FW_DIR_LNP)/*8000*.ucode))

# Copy the nvmData file and all the ucode files to $(TARGET_OUT_WLAN_FW_LNP)
# copying nvm to firmware is temporary
PRODUCT_COPY_FILES += \
	$(LOCAL_IWL_FW_DIR_LNP)/nvmData/nvmData-8000-source:$(TARGET_OUT_ETC_WIFI_LNP)/nvmDataDefault \
	$(LOCAL_IWL_FW_DIR_LNP)/nvmData/nvmData-8000C-0xA050:$(TARGET_OUT_WLAN_FW_LNP)/iwl_nvm.bin \
	$(LOCAL_IWL_FW_DIR_LNP)/fw_info.txt:$(TARGET_OUT_WLAN_FW_LNP)/fw_info.txt \
	$(LOCAL_IWL_FW_DIR_LNP)/iwl-dbg-cfg.ini:$(TARGET_OUT_WLAN_FW_LNP)/iwl-dbg-cfg.ini \
	$(LOCAL_IWL_FW_DIR_LNP)/softap-dummy-ucode:$(TARGET_OUT_WLAN_FW_LNP)/iwlwifi-softap-dummy.ucode \
	$(LOCAL_IWL_FW_DIR_LNP)/nvmData/change_mac_address_v1:$(PRODUCT_OUT)/system/bin/change_mac_address \
	$(LOCAL_IWL_FW_DIR_LNP)/nvmData/nvmData-8000-K0:$(TARGET_OUT_WLAN_FW_COMMON)/nvmData-8000-K0 \
	$(LOCAL_IWL_FW_DIR_LNP)/nvmData/nvmData-8000B-0x49:$(TARGET_OUT_WLAN_FW_COMMON)/nvmData-8000B \
	$(LOCAL_IWL_FW_DIR_LNP)/nvmData/nvmData-8000C-0xA050:$(TARGET_OUT_WLAN_FW_COMMON)/nvmData-8000C \
	$(LOCAL_IWL_FW_DIR_LNP)/nvmData/nvmData-8000C-0xA050:$(TARGET_OUT_WLAN_FW_COMMON)/nvmData-8000-production \
	$(foreach ucode, $(IWL_UCODE_FILES), \
		$(LOCAL_IWL_FW_DIR_LNP)/$(ucode):$(TARGET_OUT_WLAN_FW_COMMON)/$(ucode)) \

endif

