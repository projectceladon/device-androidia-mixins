ifeq ($(TARGET_PRODUCT),base_aaos)
        PRODUCT_PACKAGES += android.hardware.health-service.automotive
else ifeq ($(TARGET_PRODUCT),aaos_iasw)
        PRODUCT_PACKAGES += android.hardware.health-service.automotive
else
        PRODUCT_PACKAGES +=   android.hardware.health-service.intel
endif
