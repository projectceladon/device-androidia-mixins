PRODUCT_PACKAGES += \
    config_cpuset.sh

PRODUCT_COPY_FILES += \
    device/intel/project-celadon/$(TARGET_PRODUCT)/config_cpuset.sh:vendor/bin/config_cpuset.sh
