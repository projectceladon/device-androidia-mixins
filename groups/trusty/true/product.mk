{{#enable_hw_sec}}

PRODUCT_PACKAGES += \
	libtrusty \
	storageproxyd \
	libinteltrustystorage \
	libinteltrustystorageinterface \
	android.hardware.gatekeeper@1.0-service.trusty \
	android.hardware.keymaster@3.0-service.trusty \
	keybox_provisioning \

PRODUCT_PACKAGES_DEBUG += \
	intel-secure-storage-unit-test \
	gatekeeper-unit-tests \
	libscrypt_static \
	scrypt_test \

PRODUCT_PROPERTY_OVERRIDES += \
	ro.hardware.gatekeeper=trusty \
	ro.hardware.keystore=trusty
{{/enable_hw_sec}}
