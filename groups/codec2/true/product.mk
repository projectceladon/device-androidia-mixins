# MSDK codec2.0 support.

{{#enable_msdk_c2}}
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_c2_{{platform}}.xml:vendor/etc/media_codecs_performance_c2.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_c2_tgl.xml:vendor/etc/media_codecs_performance_tgl.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_c2_adl.xml:vendor/etc/media_codecs_performance_adl.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/mfx_c2_store.conf:vendor/etc/mfx_c2_store.conf \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_c2.xml:vendor/etc/media_codecs_c2.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_intel_c2_video.xml:vendor/etc/media_codecs_intel_c2_video.xml

PRODUCT_PACKAGES += \
    libmfx_c2_components_hw \
    hardware.intel.media.c2@1.0-service

BOARD_HAVE_MEDIASDK_CODEC2 := true
{{/enable_msdk_c2}}

{{#use_onevpl}}
PRODUCT_PACKAGES += \
    libvpl \
    libmfx-gen
USE_ONEVPL := true
{{/use_onevpl}}

