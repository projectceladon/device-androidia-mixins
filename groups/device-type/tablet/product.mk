PRODUCT_CHARACTERISTICS := tablet

PRODUCT_COPY_FILES += \
        {{{tablet_core_hardware_path}}}/tablet_core_hardware.xml:vendor/etc/permissions/tablet_core_hardware.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:vendor/etc/permissions/android.software.freeform_window_management.xml

