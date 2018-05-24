# Set default USB interface
USB_CONFIG := mtp
ifeq ($(TARGET_BUILD_VARIANT),user)
# Enable Secure Debugging
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
ifeq ($(BUILD_FOR_CTS_AUTOMATION),true)
# Build for automated CTS
USB_CONFIG := $(USB_CONFIG),adb
endif #BUILD_FOR_CTS_AUTOMATION == true
endif #TARGET_BUILD_VARIANT == user
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.sys.usb.config=$(USB_CONFIG)

