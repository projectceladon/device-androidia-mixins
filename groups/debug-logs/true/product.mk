PRODUCT_PACKAGES += \
    elogs.sh \
    start_log_srv.sh \
    logcat_ep.sh

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.vendor.service.default_logfs=apklogfs
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.vendor.intel.logger=/system/bin/logcat
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.logd.kernel.raw_message=false
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.intel.logger.rot_cnt=20
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.intel.logger.rot_size=5000

