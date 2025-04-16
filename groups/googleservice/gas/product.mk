FLAG_GAS_AVAILABLE ?= true
ifeq ($(FLAG_GAS_AVAILABLE),true)
$(call inherit-product-if-exists, vendor/google/gas/products/gms.mk)

#Cluster config overlay package
PRODUCT_PACKAGES += \
    ClusterConfigOverlay

endif
