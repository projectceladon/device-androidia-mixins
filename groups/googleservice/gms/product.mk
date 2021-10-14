FLAG_GMS_AVAILABLE ?= true
ifeq ($(FLAG_GMS_AVAILABLE),true)
$(call inherit-product-if-exists, vendor/google/gms/products/gms.mk)
# $(call inherit-product, vendor/partner_modules/build/mainline_modules.mk)
endif
