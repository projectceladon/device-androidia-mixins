#
# Hardware Accelerated Graphics
#
PRODUCT_PACKAGES += \
    libdrm \
    libdrm_intel \

#
# Color conversion library
#
PRODUCT_PACKAGES += \
    libI420colorconvert

ifneq ($(BOARD_HAVE_GEN_GFX_SRC),true)
    # UFO prebuilts
    PRODUCT_PACKAGES += ufo_prebuilts
    ifneq ($(TARGET_2ND_ARCH),)
        PRODUCT_PACKAGES += ufo_prebuilts_32
    endif

else # ufo packages when building from source
    PRODUCT_PACKAGES += ufo
    PRODUCT_PACKAGES += ufo_test
endif

PRODUCT_PACKAGES += hwcomposer.$(TARGET_BOARD_PLATFORM)
PRODUCT_PACKAGES += libhwcservice
PRODUCT_PROPERTY_OVERRIDES += ro.opengles.version = 196609

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	ro.ufo.use_msync=1 \
	ro.ufo.use_coreu=1

# Enable gfx debug daemon
ifneq ($(TARGET_BUILD_VARIANT),user)
    PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.gen_gfxd.enable=1
else
    PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.gen_gfxd.enable=0
endif

ifneq (,$(UFO_VERSION_PUBLISHED))
    _UFO_VERSION_PROPERTY := dev.ufo.version=$(UFO_VERSION_PUBLISHED)
    PRODUCT_PROPERTY_OVERRIDES += $(_UFO_VERSION_PROPERTY)
    ## $(info $(UFO_GEN_MK): ADDITIONAL_BUILD_PROPERTIES += $(_UFO_VERSION_PROPERTY))
ifeq ($(UFO_DEBUG_GEN_MK),1)
    $(shell echo $(UFO_GEN_MK): PRODUCT_PROPERTY_OVERRIDES += $(_UFO_VERSION_PROPERTY) >>$(dbgmk))
endif
endif
