PRODUCT_CHARACTERISTICS := pc

PRODUCT_COPY_FILES += \
        {{{pc_core_hardware_path}}}/pc_core_hardware.xml:vendor/etc/permissions/pc_core_hardware.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:vendor/etc/permissions/android.software.freeform_window_management.xml

