# Audio/video codec support.
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/vendor/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/vendor/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs.xml:system/vendor/etc/media_codecs.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance.xml:system/vendor/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/mfx_omxil_core.conf:system/vendor/etc/mfx_omxil_core.conf \
    $(LOCAL_PATH)/{{_extra_dir}}/{{profile_file}}:system/vendor/etc/media_profiles_V1_0.xml

{{^codec_perf_xen}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_{{platform}}.xml:system/vendor/etc/media_codecs_performance.xml
{{/codec_perf_xen}}
{{#codec_perf_xen}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_{{platform}}_xen.xml:system/vendor/etc/media_codecs_performance.xml
{{/codec_perf_xen}}
