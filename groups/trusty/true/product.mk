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
	keystore.${TARGET_BOARD_PLATFORM}
endif

PRODUCT_PACKAGES += \
	libtrusty \
	storageproxyd \
	libinteltrustystorage \
	libinteltrustystorageinterface \
	android.hardware.gatekeeper@1.0-service.trusty \
	keybox_provisioning \

PRODUCT_PACKAGES_DEBUG += \
	intel-secure-storage-unit-test \
	gatekeeper-unit-tests \
	libscrypt_static \
	scrypt_test \

PRODUCT_PROPERTY_OVERRIDES += \
	ro.hardware.gatekeeper=trusty \
{{/enable_hw_sec}}
