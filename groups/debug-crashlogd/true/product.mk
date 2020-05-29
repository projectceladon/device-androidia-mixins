ifneq ($(TARGET_BUILD_VARIANT),user)
MIXIN_DEBUG_LOGS := true
endif

ifeq ($(MIXIN_DEBUG_LOGS),true)
PRODUCT_COPY_FILES += \
{{#treble}}
	$(LOCAL_PATH)/{{_extra_dir}}/init.crashlogd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.crashlogd.rc \
{{/treble}}
{{^treble}}
	$(LOCAL_PATH)/{{_extra_dir}}/init.crashlogd.rc:root/init.crashlogd.rc \
{{/treble}}
	$(call add-to-product-copy-files-if-exists,$(LOCAL_PATH)/{{_extra_dir}}/crashlog.conf:$(TARGET_COPY_OUT_VENDOR)/etc/crashlog.conf)
PRODUCT_PACKAGES += crashlogd \
	dumpstate_dropbox.sh \
	elogs.sh \
	aplog.sh \
	logfs.sh

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.crashlogd.data_quota=50
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.vendor.service.default_logfs=apklogfs
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.logd.logpersistd.size={{logger_rot_cnt}}
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.intel.logger.rot_cnt={{logger_rot_cnt}}
endif
