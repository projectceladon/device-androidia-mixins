# MSDK codec2.0 support.

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/mfx_c2_store.conf:$(TARGET_COPY_OUT_VENDOR)/etc/mfx_c2_store.conf \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_intel_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_intel_c2_video.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml

PRODUCT_PACKAGES += \
    libmfx_c2_components_hw \
    hardware.intel.media.c2@1.0-service

BOARD_HAVE_MEDIASDK_CODEC2 := true
