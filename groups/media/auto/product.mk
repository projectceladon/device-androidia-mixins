{{#enable_msdk_omx}}
# libstagefrighthw
PRODUCT_PACKAGES += \
    libstagefrighthw

# Media SDK and OMX IL components
PRODUCT_PACKAGES += \
    libmfx_omx_core \
    libmfx_omx_components_hw
{{/enable_msdk_omx}}

# MediaSDK library
PRODUCT_PACKAGES += \
    libmfxhw32

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

{{#opensource_msdk}}
BOARD_HAVE_MEDIASDK_OPEN_SOURCE := true
{{/opensource_msdk}}

{{#opensource_msdk_omx_il}}
BOARD_HAVE_OMX_SRC := true
{{/opensource_msdk_omx_il}}

# Open source media_driver
PRODUCT_PACKAGES += iHD_drv_video
PRODUCT_PACKAGES += libigfxcmrt

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/igfx_user_feature_next.txt:vendor/etc/igfx_user_feature_next.txt

# Open source hdcp
PRODUCT_PACKAGES += libhdcpsdk
PRODUCT_PACKAGES += lihdcpcommon

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += debug.stagefright.c2inputsurface=-1
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.has_HDR_display=false
