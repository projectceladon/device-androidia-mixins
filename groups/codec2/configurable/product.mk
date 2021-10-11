# Audio/video codec support.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_c2_v4l2.xml:vendor/etc/media_codecs_c2.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_c2_v4l2.xml:vendor/etc/media_codecs_performance_c2.xml \
	$(LOCAL_PATH)/{{_extra_dir}}/codec2.vendor.ext.policy:/vendor/etc/seccomp_policy/codec2.vendor.ext.policy

PRODUCT_PACKAGES += android.hardware.media.c2@1.0-service-v4l2 \
                     libv4l2_codec2_components \
                     libv4l2_codec2_accel \
                     libv4l2_codec2_common \
                     libv4l2_codec2_store \
                     libc2plugin_store
