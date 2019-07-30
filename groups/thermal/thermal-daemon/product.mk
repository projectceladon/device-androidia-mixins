# thermal-daemon
PRODUCT_PACKAGES += thermal-daemon
PRODUCT_COPY_FILES += \
	$(INTEL_PATH_COMMON)/thermal/thermal-daemon/thermal-conf.xml:/vendor/etc/thermal-daemon/thermal-conf.xml \
	$(INTEL_PATH_COMMON)/thermal/thermal-daemon/thermal-cpu-cdev-order.xml:/vendor/etc/thermal-daemon/thermal-cpu-cdev-order.xml

{{#ioc}}
IOC_ENABLED := true
THERMAL_HAL_IOC_TYPE += {{ioc}}
{{/ioc}}
# Thermal Hal
PRODUCT_PACKAGES += thermal.$(TARGET_BOARD_PLATFORM) \
                    android.hardware.thermal@2.0-service.intel \
                    android.hardware.thermal@2.0-impl.intel
