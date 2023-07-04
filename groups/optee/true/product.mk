# OP TEE client library and service
PRODUCT_PACKAGES += libteec \
                    tee-supplicant \

#PRODUCT_PACKAGES += android.hardware.keymaster@3.0-service \
#		    android.hardware.keymaster@3.0-impl

# optee keymaster
PRODUCT_PACKAGES += android.hardware.keymaster@3.0-service.optee \
		    wait_for_keymaster_optee


PRODUCT_PROPERTY_OVERRIDES += \
	ro.hardware.keystore=optee

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:vendor/etc/permissions/android.hardware.keystore.app_attest_key.xml

