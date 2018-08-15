# libva, vaapi
PRODUCT_PACKAGES += \
    libva \
    libva-android \
    i965_drv_video

PRODUCT_PACKAGES += libpciaccess

# Audio/video codec support.
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:vendor/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:vendor/etc/media_codecs_google_video.xml \
    device/intel/project-celadon/common/media/media_profiles.xml:vendor/etc/media_profiles.xml \
    device/intel/project-celadon/common/media/media_codecs.xml:vendor/etc/media_codecs.xml \
    device/intel/project-celadon/common/media/media_codecs_performance.xml:vendor/etc/media_codecs_performance.xml

#Enable deep buffer for video playback
PRODUCT_PROPERTY_OVERRIDES += media.stagefright.audio.deep=true

# Enable AAC 5.1 output
PRODUCT_PROPERTY_OVERRIDES += \
    media.aac_51_output_enabled=true

# Enable Media Sdk
PRODUCT_PACKAGES += \
    libmfxhw32 \
    libmfxhw64 \
    libmfx_hevce_hw32 \
    libmfx_hevce_hw64 \
    libmfx_omx_core \
    libmfx_omx_components_hw \
    libstagefrighthw

PRODUCT_COPY_FILES += \
    device/intel/project-celadon/common/media/mfx_omxil_core.conf:vendor/etc/mfx_omxil_core.conf
