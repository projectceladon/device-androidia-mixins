# MSDK codec2.0 support.

{{#enable_msdk_c2}}
PRODUCT_COPY_FILES += \
    vendor/intel/mediasdk_c2/c2_store/data/mfx_c2_store.conf:vendor/etc/mfx_c2_store.conf \
    vendor/intel/mediasdk_c2/c2_store/data/media_codecs_c2.xml:vendor/etc/media_codecs_c2.xml \
    vendor/intel/mediasdk_c2/c2_store/data/media_codecs_intel_c2_video.xml:vendor/etc/media_codecs_intel_c2_video.xml

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

