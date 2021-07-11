# Audio/video codec support.
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:vendor/etc/media_codecs_google_audio.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/{{profile_file}}:vendor/etc/media_profiles_V1_0.xml

{{#sw_omx_video}}
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:vendor/etc/media_codecs_google_video.xml
{{/sw_omx_video}}

ifeq ($(BASE_YOCTO_KERNEL),true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_vp9.xml:vendor/etc/media_codecs.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/mfx_omxil_core_vp9.conf:vendor/etc/mfx_omxil_core.conf
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_{{gpu}}.xml:vendor/etc/media_codecs.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_gen9.xml:vendor/etc/media_codecs_gen9.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_gen11.xml:vendor/etc/media_codecs_gen11.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_gen12.xml:vendor/etc/media_codecs_gen12.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/mfx_omxil_core.conf:vendor/etc/mfx_omxil_core.conf
endif

{{^codec_perf_xen}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_{{platform}}.xml:vendor/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_cml.xml:vendor/etc/media_codecs_performance_cml.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_ehl.xml:vendor/etc/media_codecs_performance_ehl.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_tgl.xml:vendor/etc/media_codecs_performance_tgl.xml
{{/codec_perf_xen}}
{{#codec_perf_xen}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_{{platform}}_xen.xml:vendor/etc/media_codecs_performance.xml
{{/codec_perf_xen}}
