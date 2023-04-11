PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_profiles.xml:system/vendor/etc/media_profiles_V1_0.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_profiles.xml:system/etc/media_profiles.xml \

{{#hw_omx_video}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance.xml:system/vendor/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs.xml:system/vendor/etc/media_codecs.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/mfx_omxil_core.conf:system/vendor/etc/mfx_omxil_core.conf
{{/hw_omx_video}}

{{#sw_omx_video}}
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/vendor/etc/media_codecs_google_video.xml
{{/sw_omx_video}}
