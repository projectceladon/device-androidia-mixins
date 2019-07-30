# Tinyalsa
PRODUCT_PACKAGES_DEBUG += \
         tinymix \
         tinyplay \
         tinycap

# Extended Audio HALs
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    audio.hdmi.$(TARGET_BOARD_PLATFORM) \
    audio.usb.default

# SST Firmware
PRODUCT_PACKAGES += \
    fw_sst_0f28_ssp0.bin \
    fw_sst_0f28_ssp2.bin

