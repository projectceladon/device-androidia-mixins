
PRODUCT_PACKAGES += \
	libtrusty \
	storageproxyd \
	libinteltrustystorage \
	libinteltrustystorageinterface \
	android.hardware.gatekeeper-service.nonsecure \
	com.android.hardware.gatekeeper.nonsecure \
        android.hardware.security.keymint-service \
	keybox_provisioning \
	RemoteProvisioner

PRODUCT_PACKAGES_DEBUG += \
	intel-secure-storage-unit-test \
	gatekeeper-unit-tests \
	libscrypt_static \
	scrypt_test \
	RemoteProvisionerUnitTests \
	libkeymint_remote_prov_support_test

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:vendor/etc/permissions/android.hardware.keystore.app_attest_key.xml

