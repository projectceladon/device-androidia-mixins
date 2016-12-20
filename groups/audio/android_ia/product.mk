# Tinyalsa
PRODUCT_PACKAGES_DEBUG += \
         tinymix \
         tinyplay \
         tinycap

# Extended Audio HALs
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    audio.hdmi.android_ia \
    audio.primary.android_ia \
    audio.usb.default

PRODUCT_COPY_FILES += \
    device/intel/android_ia/sound/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/intel/android_ia/sound/audio_policy.conf:system/etc/audio_policy.conf
