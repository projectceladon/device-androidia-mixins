
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml \

PRODUCT_PACKAGES += \
    audio.a2dp.default \
{{#bt_usc}}
    libbtuscplugin \
    btnvmmerge \
{{/bt_usc}}
    bt_vendor.conf \
    03110006002a340f00.sfi \
    37120006002a340f00.sfi \
    bddata_PULSAR \
    bt_nvm_init.sh \
#TODO: to be added when avaialble for pulsar
#    .btnvm \
    bt_first_boot \
{{#gpp}}
    cws_manu
{{/gpp}}

PRODUCT_PACKAGES_DEBUG += \
    BleScanTest
