PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/ingredients.conf:system/vendor/etc/ingredients.conf \
    $(LOCAL_PATH)/{{_extra_dir}}/crashlog.conf:system/vendor/etc/crashlog.conf

PRODUCT_PACKAGES += \
    crashlogd \
    dumpstate_dropbox.sh

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.crashlogd.data_quota=50

CRASHLOGD_LOGS_PATH := "/data/logs"
CRASHLOGD_APLOG := true
CRASHLOGD_FULL_REPORT := true

#binder
CRASHLOGD_MODULE_BINDER := true

CRASHLOGD_USE_SD := false

