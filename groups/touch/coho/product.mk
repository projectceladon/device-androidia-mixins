PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:vendor/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

#
# IDC files for input devices
#
IDC_FILES := $(wildcard device/intel/coho/idc/*.idc)
PRODUCT_COPY_FILES += \
    $(foreach f, $(IDC_FILES), $(f):system/usr/idc/$(notdir $(f)))
