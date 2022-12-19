$(call inherit-product,device/intel/cic/common/device.mk)
$(call inherit-product, device/intel/cic/common/houdini.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.qemu=0 \
    debug.hwui.disable=1 \
    debug.egl.printFPS=60 \
    ro.opengles.version=196610 \
    ro.config.media_vol_default=15 \
    virtual.audio.pusher.tcp.port=8765 \
    virtual.audio.in.tcp.port=8767 \
    virtual.audio.out.tcp.port=8768 \
    virtual.info.tcp.port=8769 \
    service.activity.monitor.port=8770 \
    aic.cmd.channel.port=8771 \
    service.file.transer.port=8773 \
    linker.hugetlbfs.elfs=iris_dri.so:gallium_dri.so:libunity.so \
    virtual.input.keyboard=0 \
    virtual.input.num=1 \
    virtual.input.status=0 \
    virtual.input.joystick.status=0

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += debug.sf.nobootanimation=1

# disable ununsed service
PRODUCT_PROPERTY_OVERRIDES += config.disable_systemtextclassifier=true
PRODUCT_PROPERTY_OVERRIDES += config.disable_otadexopt=true
PRODUCT_PROPERTY_OVERRIDES += sys.container.fakewifi=true
PRODUCT_PROPERTY_OVERRIDES += gsm.version.baseband=FM_BASE_18A_RLS2_ISHARKL2_W18.18.5|sc9853_modem|05-04-2018 13:55:11
PRODUCT_PROPERTY_OVERRIDES += gsm.version.baseband1=FM_BASE_18A_RLS2_ISHARKL2_W18.18.5|sc9853_modem|05-04-2018 13:55:11

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    $(LOCAL_PATH)/cic_cloud-removed-permissions.xml:system/etc/permissions/cic_cloud-removed-permissions.xml \
    device/intel/cic/cic_cloud/init.cic_cloud.rc:root/init.cic_cloud.rc

#disable sdcardfs support
PRODUCT_PROPERTY_OVERRIDES += external_storage.sdcardfs.enabled=false

PRODUCT_NAME := cic_cloud
PRODUCT_DEVICE := cic_cloud
PRODUCT_BRAND := Intel
PRODUCT_MODEL := CIC container image on cloud device

TARGET_USE_GRALLOC_VHAL := false
TARGET_USE_HWCOMPOSER_VHAL := true
TARGET_USE_AUDIO_VHAL := true
TARGET_AIC_DEVICE_INPUT_FILTER := true
TARGET_AIC_PERF := true
TARGET_AIC_MEMORY_OPT := true;
TARGET_USE_CAMERA_VHAL := true
TARGET_USE_SENSOR_VHAL := true
TARGET_USE_GPS_VHAL := true

# Remove PrintSpooler after we disabled SystemUI to fix tombstone issue.
# And, enable SystemUI by default for convenience.
PRODUCT_PACKAGES_DELETE += PrintSpooler
PRODUCT_PROPERTY_OVERRIDES += enable.systemui=true

# Houdini compatibility improvement for PRC market
PRODUCT_PROPERTY_OVERRIDES += ro.sys.prc_compatibility=1
PRODUCT_COPY_FILES += \
	device/intel/cic/common/houdini/OEMBlackList:$(TARGET_COPY_OUT_VENDOR)/etc/misc/.OEMBlackList \
	device/intel/cic/common/houdini/OEMWhiteList:$(TARGET_COPY_OUT_VENDOR)/etc/misc/.OEMWhiteList \
	device/intel/cic/common/houdini/ThirdPartySO:$(TARGET_COPY_OUT_VENDOR)/etc/misc/.ThirdPartySO

# Crashlog support
# Available options: on/off
OPTION_CRASHLOGD := on
$(call inherit-product, $(LOCAL_PATH)/options/debug-logs/$(OPTION_CRASHLOGD)/product.mk)
$(call inherit-product, $(LOCAL_PATH)/options/debug-crashlogd/$(OPTION_CRASHLOGD)/product.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/board/generic_x86_64/device.mk)

PRODUCT_CHARACTERISTICS := tablet
PRODUCT_AAPT_CONFIG := normal large xlarge mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay

PRODUCT_COPY_FILES += \
frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
$(LOCAL_PATH)/android-removed-permissions.xml:system/etc/permissions/android-removed-permissions.xml \
$(if $(wildcard device/intel/cic/$(TARGET_PRODUCT)/fstab.$(TARGET_PRODUCT)),device/intel/cic/$(TARGET_PRODUCT)/fstab.$(TARGET_PRODUCT),$(LOCAL_PATH)/fstab.base):root/fstab.$(TARGET_PRODUCT) \
device/intel/cic/common/init.base.rc:root/init.base.rc \
$(if $(wildcard device/intel/cic/$(TARGET_PRODUCT)/init.$(TARGET_PRODUCT).usb.rc),device/intel/cic/$(TARGET_PRODUCT)/init.$(TARGET_PRODUCT).usb.rc,$(LOCAL_PATH)/init.base.usb.rc):root/init.$(TARGET_PRODUCT).usb.rc \
$(if $(wildcard device/intel/cic/$(TARGET_PRODUCT)/ueventd.$(TARGET_PRODUCT).rc),device/intel/cic/$(TARGET_PRODUCT)/ueventd.$(TARGET_PRODUCT).rc,$(LOCAL_PATH)/ueventd.base.rc):root/ueventd.$(TARGET_PRODUCT).rc \

PRODUCT_PACKAGES += \
	egl.cfg \
	lib_renderControl_enc \
	libGLESv2_enc \
	libOpenglSystemCommon \
	libGLESv1_enc

PRODUCT_HOST_PACKAGES += \
	aic-build \
	aic-publish \
	bios.bin \
	vgabios-cirrus.bin \
	docker \
	cpio \
	container-diff \
	dock-delta \
	dock-extract


# Device modules
PRODUCT_PACKAGES += \
	hwcomposer.goldfish \
	hwcomposer.ranchu \
	sh_vendor \
	vintf \
	toybox_vendor
	
PRODUCT_PACKAGES += \
	android.hardware.keymaster@3.0-impl \
	android.hardware.keymaster@3.0-service

PRODUCT_PACKAGES += \
	android.hardware.drm@1.0-service \
	android.hardware.drm@1.0-impl

# need this for gles libraries to load properly
# after moving to /vendor/lib/
PRODUCT_PACKAGES += \
	vndk-sp

# sdcard
PRODUCT_COPY_FILES += \
	out/target/product/$(TARGET_PRODUCT)/system/bin/sdcard-fuse:system/bin/sdcard
	
PRODUCT_PACKAGES += \
	sdcard-fuse

# deploy prebuilt apps
PRODUCT_PACKAGES += \
	prebuilt_apps

# Default Health
PRODUCT_PACKAGES += \
	android.hardware.health@2.1-service \
	android.hardware.health@2.1-impl

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
    WAPPushManager

PRODUCT_PACKAGES_DELETE += \
    incidentd \
    libpac \
    perfprofd \
    statsd \
    thermalserviced \
    mediametrics

