ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(MIXIN_DEBUG_LOGS),true)
    PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/log-watch-kmsg.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/log-watch-kmsg.cfg \
        $(LOCAL_PATH)/init.log-watch.rc:root/init.log-watch.rc

    PRODUCT_PACKAGES += log-watch
endif
endif
