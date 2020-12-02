# Enable updating of APEXes
 $(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable userspace reboot
 $(call inherit-product, $(SRC_TARGET_DIR)/product/userspace_reboot.mk)

# Enable partner_module
$(call inherit-product, vendor/partner_modules/build/mainline_modules.mk)
