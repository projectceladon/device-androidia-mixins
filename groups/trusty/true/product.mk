
PRODUCT_PACKAGES += \
	libtrusty \
	android.hardware.gatekeeper@1.0-service.trusty \
	android.hardware.security.keymint-service.trusty \
	RemoteProvisioner

PRODUCT_PACKAGES_DEBUG += \
	gatekeeper-unit-tests \
	libscrypt_static \
	scrypt_test \
	RemoteProvisionerUnitTests \
	libkeymint_remote_prov_support_test

PRODUCT_PROPERTY_OVERRIDES += \
	ro.hardware.gatekeeper=trusty \
	ro.hardware.keystore=trusty

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:vendor/etc/permissions/android.hardware.keystore.app_attest_key.xml

