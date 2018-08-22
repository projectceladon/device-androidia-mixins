# thermal-daemon
PRODUCT_PACKAGES += thermal-daemon
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/thermal-conf.xml:/vendor/etc/thermal-daemon/thermal-conf.xml \
	$(LOCAL_PATH)/thermal-cpu-cdev-order.xml:/vendor/etc/thermal-daemon/thermal-cpu-cdev-order.xml
