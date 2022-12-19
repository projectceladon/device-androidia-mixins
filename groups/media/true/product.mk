$(call inherit-product,device/intel/cic/common/device.mk)
$(call inherit-product, device/intel/cic/common/houdini.mk)

PRODUCT_COPY_FILES += \
    device/intel/cic/common/media_codecs_performance.xml:system/etc/media_codecs_performance.xml \
    device/intel/cic/common/mfx_omxil_core.conf:system/vendor/etc/mfx_omxil_core.conf \
    device/intel/cic/common/media_profiles.xml:system/etc/media_profiles.xml \
    device/intel/cic/common/media_profiles.xml:system/vendor/etc/media_profiles_V1_0.xml \
    device/intel/cic/common/media_codecs.xml:system/vendor/etc/media_codecs.xml

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/vendor/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/vendor/etc/media_codecs_google_video.xml

USE_ONEVPL := true

PRODUCT_PACKAGES += \
    libvpl \
    libmfx-gen

