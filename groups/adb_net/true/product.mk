# Enable Secure Debugging
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
endif
