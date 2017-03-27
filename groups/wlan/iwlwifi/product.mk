PRODUCT_PACKAGES += \
    libwpa_client \
    wpa_cli \
    wpa_supplicant

PRODUCT_COPY_FILES += \
  device/intel/common/wlan/wpa_supplicant-common.conf:system/etc/wifi/wpa_supplicant.conf \
  device/intel/common/wlan/iwlwifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
  frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml \
  frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
  frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

# Wifi configuration
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WLAN_DEVICE := iwlwifi
