PRODUCT_PACKAGES += \
    libavservices_minijail

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_c2.xml:vendor/etc/media_codecs_c2.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/media_codecs_goldfish_c2_video.xml:vendor/etc/media_codecs_goldfish_c2_video.xml \
	$(LOCAL_PATH)/{{_extra_dir}}/media_codecs_performance_c2.xml:vendor/etc/media_codecs_performance_c2.xml \
	$(LOCAL_PATH)/{{_extra_dir}}/codec2.vendor.ext.policy:vendor/etc/seccomp_policy/codec2.vendor.ext.policy

# Device modules
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/{{_extra_dir}}/android.hardware.media.c2@1.0-service-goldfish:vendor/bin/hw/android.hardware.media.c2@1.0-service-goldfish \
	$(LOCAL_PATH)/{{_extra_dir}}/libgoldfish_codec2_store_32.so:vendor/lib/libgoldfish_codec2_store.so \
	$(LOCAL_PATH)/{{_extra_dir}}/libcodec2_goldfish_common_32.so:vendor/lib/libcodec2_goldfish_common.so \
    $(LOCAL_PATH)/{{_extra_dir}}/libcodec2_goldfish_avcdec_32.so:vendor/lib/libcodec2_goldfish_avcdec.so \
    $(LOCAL_PATH)/{{_extra_dir}}/libcodec2_goldfish_vp8dec_32.so:vendor/lib/libcodec2_goldfish_vp8dec.so \
    $(LOCAL_PATH)/{{_extra_dir}}/libcodec2_goldfish_vp9dec_32.so:vendor/lib/libcodec2_goldfish_vp9dec.so \
    $(LOCAL_PATH)/{{_extra_dir}}/libcodec2_goldfish_hevcdec_32.so:vendor/lib/libcodec2_goldfish_hevcdec.so \
	$(LOCAL_PATH)/{{_extra_dir}}/libgoldfish_codec2_store_64.so:vendor/lib64/libgoldfish_codec2_store.so \
	$(LOCAL_PATH)/{{_extra_dir}}/libcodec2_goldfish_common_64.so:vendor/lib64/libcodec2_goldfish_common.so \
    $(LOCAL_PATH)/{{_extra_dir}}/libcodec2_goldfish_avcdec_64.so:vendor/lib64/libcodec2_goldfish_avcdec.so \
    $(LOCAL_PATH)/{{_extra_dir}}/libcodec2_goldfish_vp8dec_64.so:vendor/lib64/libcodec2_goldfish_vp8dec.so \
    $(LOCAL_PATH)/{{_extra_dir}}/libcodec2_goldfish_vp9dec_64.so:vendor/lib64/libcodec2_goldfish_vp9dec.so \
    $(LOCAL_PATH)/{{_extra_dir}}/libcodec2_goldfish_hevcdec_64.so:vendor/lib64/libcodec2_goldfish_hevcdec.so \
	$(LOCAL_PATH)/{{_extra_dir}}/android.hardware.media.c2@1.0-service-goldfish.rc:vendor/etc/init/android.hardware.media.c2@1.0-service-goldfish.rc
