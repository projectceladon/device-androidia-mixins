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
	keystore.project-celadon
endif

PRODUCT_PACKAGES += \
	libtrusty \
	storageproxyd \
	libtrustystorage \
	libtrustystorageinterface \
	gatekeeper.trusty \
	android.hardware.gatekeeper@1.0-impl \
	android.hardware.gatekeeper@1.0-service

PRODUCT_PROPERTY_OVERRIDES += \
	ro.hardware.gatekeeper=trusty

{{/enable_hw_sec}}
