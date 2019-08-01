TARGET_BOARD_PLATFORM := broxton

# Tinyalsa
PRODUCT_PACKAGES_DEBUG += \
    tinymix \
    tinyplay \
    tinycap \
    tinypcminfo \
    tinyprobe

# Audio HALs
PRODUCT_PACKAGES += meta.package.audio

# Sound Trigger HAL
PRODUCT_PACKAGES += \
       sound_trigger.primary.$(TARGET_BOARD_PLATFORM)

# Audio Primary HAL
PRODUCT_PACKAGES += \
       audio.primary.$(TARGET_BOARD_PLATFORM)

# Extended Audio HALs
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    audio.usb.default \
    audio.usb.$(TARGET_BOARD_PLATFORM) \
    audio_policy.default.so \
    audio_configuration_files

# Audio HAL
PRODUCT_PACKAGES += \
    android.hardware.audio.effect@5.0-impl \
    android.hardware.audio@5.0-impl \
    android.hardware.audio@2.0-service

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_criteria.conf:vendor/etc/audio_policy_criteria.conf \
    $(LOCAL_PATH)/audio/default/effect/audio_effects.xml:vendor/etc/audio_effects.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_configuration.xml:vendor/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/default/mixer_paths_0.xml:vendor/etc/mixer_paths_0.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_engine_product_strategies.xml:vendor/etc/audio_policy_engine_product_strategies.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_engine_configuration.xml:vendor/etc/audio_policy_engine_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_engine_criteria.xml:vendor/etc/audio_policy_engine_criteria.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_engine_criterion_types.xml.in:vendor/etc/audio_policy_engine_criterion_types.xml.in \


PRODUCT_PROPERTY_OVERRIDES += audio.safemedia.bypass=true

PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/audio/overlay-car-legacy
