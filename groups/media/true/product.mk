PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/mediacodec.policy:system/vendor/etc/seccomp_policy/mediacodec.policy \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/vendor/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/vendor/etc/media_codecs_google_video.xml

USE_ONEVPL := true

PRODUCT_PACKAGES += \
    i965_drv_video \
    libva-android \
    libva

{{#enable_msdk_omx}}
PRODUCT_PACKAGES += \
    libmfxhw32 \
    libmfxhw64 \
    libmfx_omx_core \
    libmfx_omx_components_hw \
    libstagefrighthw \
{{/enable_msdk_omx}}

{{#use_onevpl}}
USE_ONEVPL := true
PRODUCT_PACKAGES += \
    libvpl \
    libmfx-gen \
{{/use_onevpl}}
