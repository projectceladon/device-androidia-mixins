$(call inherit-product,device/intel/cic/common/device.mk)
$(call inherit-product, device/intel/cic/common/houdini.mk)

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/vendor/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml

