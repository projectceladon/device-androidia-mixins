PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += \
    audio.a2dp.default \
{{#bt_usc}}
    libbtuscplugin \
    btnvmmerge \
{{/bt_usc}}
    bt_vendor.conf \
    370c1206001a260f00.sfi \
    370b12060002340e00_B.sfi \
    370b12060002340e00.sfi \
    370b10060002220e00.sfi \
    370b000600020d0e00.sfi \
    370b00060002280d00.seq \
    bddata_WSP_B2 \
    bddata_B2_C0_B \
    bddata_B2_C0 \
    bddata_B0 \
    bddata_K0 \
    bddata_A0 \
    370b12060002340e00_selftest.sfi \
    370b10060002220e00_selftest.sfi \
    bt_nvm_init.sh \
    .btnvm \
    bt_first_boot \
{{#gpp}}
    cws_manu
{{/gpp}}

PRODUCT_PACKAGES_DEBUG += \
    BleScanTest
