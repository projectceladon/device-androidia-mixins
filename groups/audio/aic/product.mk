PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-service \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.broadcastradio@1.0-impl \
    android.hardware.soundtrigger@2.0-impl \

PRODUCT_COPY_FILES += \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    frameworks/av/services/audiopolicy/config/surround_sound_configuration_5_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/surround_sound_configuration_5_0.xml \
    $(LOCAL_PATH)/audiopolicy/config/a2dp_audio_policy_configuration.xml:system/vendor/etc/a2dp_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audiopolicy/config/audio_policy_configuration.xml:system/vendor/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audiopolicy/config/usb_audio_policy_configuration.xml:system/vendor/etc/usb_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audiopolicy/config/hdmi_audio_policy_configuration.xml:system/vendor/etc/hdmi_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audiopolicy/config/mixer_paths_0.xml:system/vendor/etc/mixer_paths_0.xml \
    $(LOCAL_PATH)/audiopolicy/config/default_volume_tables.xml:system/vendor/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/audiopolicy/config/audio_policy_volumes.xml:system/vendor/etc/audio_policy_volumes.xml


# Audio Primary HAL
PRODUCT_PACKAGES += \
    audio.primary.$(TARGET_PRODUCT)

# Extended Audio HALs
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    audio.usb.default \
    audio.usb.$(TARGET_PRODUCT) \
    audio_policy.default.so \
    audio_configuration_files
