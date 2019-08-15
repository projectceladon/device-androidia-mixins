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
    libmfx_omx_core \
    libmfx_omx_components_hw \
    libstagefrighthw

{{#add_sw_msdk}}
PRODUCT_PACKAGES += \
    libmfxsw32 \
    libmfx_omx_components_sw

ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
PRODUCT_PACKAGES += \
    libmfxsw64
endif
{{/add_sw_msdk}}

{{#opensource_msdk}}
BOARD_HAVE_MEDIASDK_OPEN_SOURCE := true
{{/opensource_msdk}}

{{#opensource_msdk_omx_il}}
BOARD_HAVE_OMX_SRC := true
{{/opensource_msdk_omx_il}}

# Enable Open source hdcp
PRODUCT_PACKAGES += libhdcpsdk
PRODUCT_PACKAGES += lihdcpcommon
# hdcp daemon
PRODUCT_PACKAGES += hdcpd

PRODUCT_COPY_FILES += \
    device/intel/project-celadon/common/media/mfx_omxil_core.conf:vendor/etc/mfx_omxil_core.conf
