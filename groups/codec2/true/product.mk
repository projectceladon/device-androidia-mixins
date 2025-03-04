# Audio/video codec support.
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:vendor/etc/media_codecs_google_c2_audio.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/{{profile_file}}:vendor/etc/media_profiles_V1_0.xml

# MSDK codec2.0 support.
{{#enable_msdk_c2}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_c2_{{platform}}.xml:vendor/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_c2_tgl.xml:vendor/etc/media_codecs_performance_tgl.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_c2_adl.xml:vendor/etc/media_codecs_performance_adl.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/mfx_c2_store.conf:vendor/etc/mfx_c2_store.conf \
    $(LOCAL_PATH)/{{_extra_dir}}/mfx_c2_store_gen13.conf:vendor/etc/mfx_c2_store_gen13.conf \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs.xml:vendor/etc/media_codecs.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_gen13.xml:vendor/etc/media_codecs_gen13.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_intel_c2_video.xml:vendor/etc/media_codecs_intel_c2_video.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_intel_c2_video_gen13.xml:vendor/etc/media_codecs_intel_c2_video_gen13.xml

PRODUCT_PACKAGES += \
    libmfx_c2_components_hw \
    android.hardware.media.c2-service.intel

BOARD_HAVE_MEDIASDK_CODEC2 := true
{{/enable_msdk_c2}}

{{#use_onevpl}}
PRODUCT_PACKAGES += \
    libvpl \
    libmfx-gen \
    hello-encode \
    vpl_sample_decode \
    vpl_sample_encode \
    vpl_sample_multi_transcode \
    vpl_sample_vpp
USE_ONEVPL := true
{{/use_onevpl}}

{{#hw_vd_h264_secure}}
ENABLE_WIDEVINE := true
{{/hw_vd_h264_secure}}

{{#hw_vd_h265_secure}}
ENABLE_WIDEVINE := true
{{/hw_vd_h265_secure}}
