# optee_client library and service
PRODUCT_PACKAGES += \
	libteec \
	tee-supplicant

{{#hw_km}}
# optee keymaster
PRODUCT_PACKAGES += \
	android.hardware.security.keymint-service.optee \
	wait_for_keymaster_optee

PRODUCT_PRODUCT_PROPERTIES += remote_provisioning.tee.rkp_only=true
PRODUCT_PRODUCT_PROPERTIES += remote_provisioning.hostname=remoteprovisioning.googleapis.com

PRODUCT_PROPERTY_OVERRIDES += \
	ro.hardware.keystore=optee
{{/hw_km}}

{{^hw_km}}
PRODUCT_PACKAGES += android.hardware.security.keymint-service
{{/hw_km}}

{{#hw_gk}}
# optee gatekeeper
PRODUCT_PACKAGES += android.hardware.gatekeeper-service.optee
PRODUCT_PROPERTY_OVERRIDES += ro.hardware.gatekeeper=optee
{{/hw_gk}}

{{^hw_gk}}
PRODUCT_PACKAGES += com.android.hardware.gatekeeper.nonsecure
{{/hw_gk}}

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:vendor/etc/permissions/android.hardware.keystore.app_attest_key.xml

ifeq ($(TARGET_BUILD_VARIANT),userdebug)
# optee_test and TA
PRODUCT_PACKAGES += xtest
# os_test_lib_dl
PRODUCT_PACKAGES += b3091a65-9751-4784-abf7-0298a7cc35ba.ta
# os_test_lib
PRODUCT_PACKAGES += ffd2bded-ab7d-4988-95ee-e4962fff7154.ta
# os_test
PRODUCT_PACKAGES += 5b9e0e40-2636-11e1-ad9e-0002a5d5c51b.ta
# concurrent_large
PRODUCT_PACKAGES += 5ce0c432-0ab0-40e5-a056-782ca0e6aba2.ta
# sha_perf
PRODUCT_PACKAGES += 614789f2-39c0-4ebf-b235-92b32ac107ed.ta
# storage2
PRODUCT_PACKAGES += 731e279e-aafb-4575-a771-38caa6f0cca6.ta
# storage
PRODUCT_PACKAGES += b689f2a7-8adf-477a-9f99-32e90c0ad0a2.ta
# create_fail_test
PRODUCT_PACKAGES += c3f6e2c0-3548-11e1-b86c-0800200c9a66.ta
# crypt
PRODUCT_PACKAGES += cb3e5ba0-adf1-11e0-998b-0002a5d5c51b.ta
# rpc_test
PRODUCT_PACKAGES += d17f73a0-36ef-11e1-984a-0002a5d5c51b.ta
# concurrent
PRODUCT_PACKAGES += e13010e0-2ae1-11e5-896a-0002a5d5c51b.ta
# aes_perf
PRODUCT_PACKAGES += e626662e-c0e2-485c-b8c8-09fbce6edf3d.ta
# sims
PRODUCT_PACKAGES += e6a33ed4-562b-463a-bb7e-ff5e15a493c8.ta
# storage_benchmark
PRODUCT_PACKAGES += f157cda0-550c-11e5-a6fa-0002a5d5c51b.ta
# socket
PRODUCT_PACKAGES += 873bcd08-c2c3-11e6-a937-d0bf9c45c61c.ta
# supp_plugin
PRODUCT_PACKAGES += 380231ac-fb99-47ad-a689-9e017eb6e78a.ta
# miss
PRODUCT_PACKAGES += 528938ce-fc59-11e8-8eb2-f2801f1b9fd1.ta
# keepalive
PRODUCT_PACKAGES += a4c04d50-f180-11e8-8eb2-f2801f1b9fd1.ta
# tee-supplicant plugin
PRODUCT_PACKAGES += f07bfc66-958c-4a15-99c0-260e4e7375dd.plugin
endif
