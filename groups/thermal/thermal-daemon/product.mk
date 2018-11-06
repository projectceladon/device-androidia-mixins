# thermal-daemon
PRODUCT_PACKAGES += thermal-daemon
PRODUCT_COPY_FILES += \
	device/intel/project-celadon/common/thermal/thermal-conf.xml:/vendor/etc/thermal-daemon/thermal-conf.xml \
	device/intel/project-celadon/common/thermal/thermal-cpu-cdev-order.xml:/vendor/etc/thermal-daemon/thermal-cpu-cdev-order.xml
