PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:vendor/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

#
# IDC files for input devices
#
IDC_FILES := $(wildcard $(INTEL_PATH_COMMON)/touch/*.idc)
PRODUCT_COPY_FILES += \
    $(foreach f, $(IDC_FILES), $(f):system/usr/idc/$(notdir $(f)))

#
# Touch firmware files
#

# zeitec touch fw
PRODUCT_PACKAGES += zet6221.fw zet6223.fw zet6231.fw zet6251.fw zet6270.fw

# silead touch fw
PRODUCT_PACKAGES += silead.fw
PRODUCT_PACKAGES += i8170_gsl1680.fw
PRODUCT_PACKAGES += i8811_gsl3680.fw
PRODUCT_PACKAGES += i8880_gsl3670.fw
PRODUCT_PACKAGES += i8889_gsl3670.fw
PRODUCT_PACKAGES += t15_gsl3692.fw

# goodix touch fw
PRODUCT_PACKAGES += gt9157.fw
PRODUCT_PACKAGES += gt9271.fw
