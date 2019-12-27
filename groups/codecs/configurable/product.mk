# Audio/video codec support.
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:vendor/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:vendor/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs.xml:vendor/etc/media_codecs.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/mfx_omxil_core.conf:vendor/etc/mfx_omxil_core.conf

{{^4k_encoder_support}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_profiles_1080p.xml:vendor/etc/media_profiles_V1_0.xml
{{/4k_encoder_support}}
{{#4k_encoder_support}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_profiles_2160p.xml:vendor/etc/media_profiles_V1_0.xml
{{/4k_encoder_support}}

{{^codec_perf_xen}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_{{platform}}.xml:vendor/etc/media_codecs_performance.xml
{{/codec_perf_xen}}
{{#codec_perf_xen}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_{{platform}}_xen.xml:vendor/etc/media_codecs_performance.xml
{{/codec_perf_xen}}
