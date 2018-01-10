{{#enable_hw_sec}}

KM_VERSION := {{{keymaster_version}}}

ifeq ($(KM_VERSION),1)
PRODUCT_PACKAGES += \
	keystore.android_ia
endif

PRODUCT_PACKAGES += \
	libtrusty

{{/enable_hw_sec}}
