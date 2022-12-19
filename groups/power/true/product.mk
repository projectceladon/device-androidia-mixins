$(call inherit-product,device/intel/cic/common/device.mk)
$(call inherit-product, device/intel/cic/common/houdini.mk)

PRODUCT_PACKAGES += \
    power.default \
    android.hardware.power-service.example \
    android.hardware.power.stats@1.0-service.mock

PRODUCT_PACKAGES += webrtc_mgr.sh

PRODUCT_PACKAGES += AicCommandChannelService

PRODUCT_PACKAGES += setcap getcap

