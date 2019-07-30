# Tinyalsa
PRODUCT_PACKAGES_DEBUG += \
        tinymix \
        tinyplay \
        tinycap \
        tinypcminfo

# Audio Primary HAL
PRODUCT_PACKAGES += \
        audio_hal_configurable \
        parameter-framework.route.coho \
        parameter-framework.audio.coho \
        libremote-processor

# parameter-framework debug/tuning/engineering
PRODUCT_PACKAGES_ENG += \
        remote-process

PFW_CONFIGURATION_FOLDER := /system/etc/parameter-framework/

# Extended Audio HALs
PRODUCT_PACKAGES += \
        audio.r_submix.default \
        audio.hdmi.$(TARGET_BOARD_PLATFORM) \
        audio.usb.default \
        audio.a2dp.default

PRODUCT_COPY_FILES += $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf

# Audio topology files
PRODUCT_PACKAGES += \
    topology.audio.$(TARGET_BOARD_PLATFORM)

# SST Firmware
PRODUCT_PACKAGES += \
    fw_sst_0f28_ssp0.bin \
    fw_sst_0f28_ssp2.bin

# Monitor device rotation for L/R channel swap.
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	ro.audio.monitorRotation=true

# Number of warmup cycles when using Fast Track
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	af.fast_mixer_max_warmup=3
