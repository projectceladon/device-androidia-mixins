{{#enable_hw_sec}}

KM_VERSION := {{{keymaster_version}}}

ifeq ($(KM_VERSION),2)
PRODUCT_PACKAGES += \
	keystore.trusty
PRODUCT_PROPERTY_OVERRIDES += \
	ro.hardware.keystore=trusty
endif

ifeq ($(KM_VERSION),1)
PRODUCT_PACKAGES += \
	keystore.android_ia
endif

PRODUCT_PACKAGES += \
	libtrusty

{{/enable_hw_sec}}
