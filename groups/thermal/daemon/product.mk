# Thermal daemon
PRODUCT_PACKAGES += thermal-daemon

PRODUCT_COPY_FILES += \
    external/thermal_daemon/data/thermal-conf.xml:vendor/etc/thermal-daemon/thermal-conf.xml \
    external/thermal_daemon/data/thermal-cpu-cdev-order.xml:vendor/etc/thermal-daemon/thermal-cpu-cdev-order.xml
