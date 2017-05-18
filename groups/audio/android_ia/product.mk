# Tinyalsa
PRODUCT_PACKAGES_DEBUG += \
         tinymix \
         tinyplay \
         tinycap

ifneq ($(BOARD_USES_GENERIC_AUDIO), true)
PRODUCT_PACKAGES += \
    audio.primary.android_ia
else
PRODUCT_PACKAGES += \
    audio.primary.default
endif

# Extended Audio HALs
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    audio.usb.default \
    audio_policy.default.so \
    audio_configuration_files

