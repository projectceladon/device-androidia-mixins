$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/board/generic_x86_64/device.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.qemu=0 \
    service.activity.monitor.port=8770 \
    aic.cmd.channel.port=8771 \
    service.file.transer.port=8773 \

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += debug.sf.nobootanimation=1

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.rc:root/init.$(TARGET_PRODUCT).rc \
    $(LOCAL_PATH)/fstab:root/fstab.$(TARGET_PRODUCT) \
    $(LOCAL_PATH)/ueventd.rc:root/ueventd.$(TARGET_PRODUCT).rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/cic_cloud-removed-permissions.xml:system/etc/permissions/cic_cloud-removed-permissions.xml \

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml

# disable ununsed service
PRODUCT_PROPERTY_OVERRIDES += config.disable_systemtextclassifier=true
PRODUCT_PROPERTY_OVERRIDES += config.disable_otadexopt=true
PRODUCT_PROPERTY_OVERRIDES += gsm.version.baseband=FM_BASE_18A_RLS2_ISHARKL2_W18.18.5|sc9853_modem|05-04-2018 13:55:11
PRODUCT_PROPERTY_OVERRIDES += gsm.version.baseband1=FM_BASE_18A_RLS2_ISHARKL2_W18.18.5|sc9853_modem|05-04-2018 13:55:11

#disable sdcardfs support
PRODUCT_PROPERTY_OVERRIDES += external_storage.sdcardfs.enabled=false

PRODUCT_PROPERTY_OVERRIDES += \
    enable.restrictions=true \
    enable.sec_key_att_app_id_provider=true \
    enable.power=true \
    enable.launcher=true \
    enable.settings=true \
    enable.clipboard=true \
    enable.network_score=true \
    enable.telephony.registry=true \
    enable.netstats=true \
    enable.batterystats=true

# Remove PrintSpooler after we disabled SystemUI to fix tombstone issue.
# And, enable SystemUI by default for convenience.
PRODUCT_PACKAGES_DELETE += PrintSpooler
PRODUCT_PROPERTY_OVERRIDES += enable.systemui=true

PRODUCT_HOST_PACKAGES += \
    aic-build \
    aic-publish \
    bios.bin \
    vgabios-cirrus.bin

# Device modules
PRODUCT_PACKAGES += \
    sh_vendor \
    vintf \
    toybox_vendor

PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# need this for gles libraries to load properly
# after moving to /vendor/lib/
PRODUCT_PACKAGES += \
    vndk-sp

# deploy prebuilt apps
PRODUCT_PACKAGES += \
    prebuilt_apps

PRODUCT_PACKAGES += DummyHome

PRODUCT_PACKAGES += \
    webrtc_mgr.sh \
    AicCommandChannelService \
    setcap \
    getcap

# The list of packages that we want to remove from default configuration.
PRODUCT_PACKAGES_DELETE += \
    BackupRestoreConfirmation \
    BasicDreams \
    BlockedNumberProvider \
    Bluetooth \
    BluetoothMidiService \
    BookmarkProvider \
    BuiltInPrintService \
    Calendar \
    CalendarProvider \
    CaptivePortalLogin \
    CertInstaller \
    CompanionDeviceManager \
    Contacts \
    CtsShimPrebuilt \
    CtsShimPrivPrebuilt \
    DeskClock \
    DisplayCutoutEmulationCornerOverlay \
    DisplayCutoutEmulationDoubleOverlay \
    DisplayCutoutEmulationTallOverlay \
    DocumentsUI \
    DownloadProviderUi \
    EasterEgg \
    Email \
    ExactCalculator \
    ExternalStorageProvider \
    ExtServices \
    ExtShared \
    HTMLViewer \
    InputDevices \
    KeyChain \
    LiveWallpapersPicker \
    ManagedProvisioning \
    MmsService \
    MtpDocumentsProvider \
    MusicFX \
    NfcNci \
    OneTimeInitializer \
    PacProcessor \
    PhotoTable \
    PrintRecommendationService \
    ProxyHandler \
    QuickSearchBox \
    SecureElement \
    SharedStorageBackup \
    SimAppDialog \
    StatementService \
    StorageManager \
    SysuiDarkThemeOverlay \
    Traceur \
    VpnDialogs \
    WallpaperBackup \
    WallpaperCropper \
    WAPPushManager \
    incidentd \
    libpac \
    perfprofd \
    statsd \
    thermalserviced \
    mediametrics

TARGET_USE_LIBVHAL_CLIENT := false
TARGET_USE_ICR := false

# LIBVHAL-CLIENT
ifeq ($(TARGET_USE_LIBVHAL_CLIENT), true)
PRODUCT_PACKAGES += libvhal-client
endif

# ICR
ifeq ($(TARGET_USE_ICR), true)
PRODUCT_PACKAGES += \
    icr_encoder \
    libirr_encoder \
    libsock_utilss \
    libvhal-client
endif
