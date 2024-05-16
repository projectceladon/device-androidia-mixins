# enables the rro package for passenger(secondary) user.
ENABLE_PASSENGER_SYSTEMUI_RRO := true

PRODUCT_PACKAGES += CarServiceMultiDisplayOverlay \
                    MultiDisplaySecondaryHomeTestLauncher

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-multi_passenger

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.managed_users.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.managed_users.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/display_settings.xml:$(TARGET_COPY_OUT_VENDOR)/etc/display_settings.xml

