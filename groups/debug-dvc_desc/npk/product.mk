ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += dvc_desc
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/init.dvc_desc.rc:root/init.dvc_desc.rc \
        $(LOCAL_PATH)/dvc_descriptors.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/dvc_descriptors.cfg
endif
