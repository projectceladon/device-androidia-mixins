# libstagefrighthw
PRODUCT_PACKAGES += \
    libstagefrighthw

# Media SDK and OMX IL components
PRODUCT_PACKAGES += \
    libmfxhw32 \
    libmfx_omx_core \
    libmfx_omx_components_hw

# Open source media_driver
PRODUCT_PACKAGES += i965_drv_video
PRODUCT_PACKAGES += libigfxcmrt

# Open source hdcp
PRODUCT_PACKAGES += libhdcpsdk
PRODUCT_PACKAGES += lihdcpcommon

ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
PRODUCT_PACKAGES += \
    libmfxhw64
endif

{{#add_sw_msdk}}
PRODUCT_PACKAGES += \
    libmfxsw32 \
    libmfx_omx_components_sw

ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
PRODUCT_PACKAGES += \
    libmfxsw64
endif
BOARD_HAVE_MEDIASDK_SRC := true
{{/add_sw_msdk}}

{{#enable_msdk_c2}}
PRODUCT_PACKAGES += \
    libmfx_c2_components_hw
{{/enable_msdk_c2}}

{{#use_onevpl}}
PRODUCT_PACKAGES += \
    libvpl \
    libmfx-gen
USE_ONEVPL := true
{{/use_onevpl}}

{{#opensource_msdk}}
BOARD_HAVE_MEDIASDK_OPEN_SOURCE := true
{{/opensource_msdk}}

{{#opensource_msdk_omx_il}}
BOARD_HAVE_OMX_SRC := true
{{/opensource_msdk_omx_il}}

PRODUCT_PACKAGES += \
    libpciaccess
