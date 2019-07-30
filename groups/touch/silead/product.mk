PRODUCT_COPY_FILES += \
        $(INTEL_PATH_COMMON)/touch/silead_ts.idc:system/usr/idc/silead_ts.idc \
        frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:vendor/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

PRODUCT_PACKAGES += silead.fw
PRODUCT_PACKAGES += i8170_gsl1680.fw
PRODUCT_PACKAGES += i8811_gsl3680.fw
PRODUCT_PACKAGES += i8880_gsl3670.fw
PRODUCT_PACKAGES += i8889_gsl3670.fw
PRODUCT_PACKAGES += t15_gsl3692.fw
