TARGET_USE_AUDIO_VHAL := true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_default=15 \
    virtual.audio.pusher.tcp.port=8765 \
    virtual.audio.in.tcp.port=8767 \
    virtual.audio.out.tcp.port=8768 \
    virtual.info.tcp.port=8769

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/audio_policy_configuration.xml:system/vendor/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:system/vendor/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:system/vendor/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:system/vendor/etc/default_volume_tables.xml \

PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-service \
    android.hardware.audio@2.0-impl \
    android.hardware.audio@4.0-impl \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.broadcastradio@1.0-impl \
    android.hardware.soundtrigger@2.0-impl \
    audio.r_submix.default \
    audio.primary.$(TARGET_PRODUCT) \
    SoundRecorder
