#Product Characteristics
PRODUCT_DIR := $(dir $(lastword $(filter-out device/common/%,$(filter device/%,$(ALL_PRODUCTS)))))

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.dalvik.vm.native.bridge=libhoudini.so

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_AAPT_CONFIG := normal large xlarge mdpi hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

DEVICE_PACKAGE_OVERLAYS += device/intel/android_ia/common/overlay

PRODUCT_PACKAGES += $(THIRD_PARTY_APPS)

# Get a list of languages.
$(call inherit-product,$(SRC_TARGET_DIR)/product/locales_full.mk)

# Get everything else from the parent package
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)

# Get some sounds
$(call inherit-product-if-exists,frameworks/base/data/sounds/AudioPackage6.mk)

# Get Platform specific settings
$(call inherit-product-if-exists,vendor/vendor.mk)

#Product Characteristics
PRODUCT_COPY_FILES += \
    $(if $(wildcard $(PRODUCT_DIR)fstab.$(TARGET_PRODUCT)),$(PRODUCT_DIR)fstab.$(TARGET_PRODUCT),$(LOCAL_PATH)/fstab):root/fstab.$(TARGET_PRODUCT) \
    $(if $(wildcard $(PRODUCT_DIR)init.$(TARGET_PRODUCT).rc),$(PRODUCT_DIR)init.$(TARGET_PRODUCT).rc,$(LOCAL_PATH)/init.rc):root/init.$(TARGET_PRODUCT).rc \
    $(if $(wildcard $(PRODUCT_DIR)ueventd.$(TARGET_PRODUCT).rc),$(PRODUCT_DIR)ueventd.$(TARGET_PRODUCT).rc,$(LOCAL_PATH)/ueventd.rc):root/ueventd.$(TARGET_PRODUCT).rc \
    $(LOCAL_PATH)/gpt.ini:root/gpt.$(TARGET_PRODUCT).ini \
    $(LOCAL_PATH)/init.recovery.rc:root/init.recovery.$(TARGET_PRODUCT).rc \

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

# Camera: Device-specific configuration files.
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.full.xml:system/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \

# Voip
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.software.sip.xml:system/etc/permissions/android.software.sip.xml \

$(foreach sensor,accelerometer barometer compass gyroscope light stepcounter stepdetector proximity, \
$(eval PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.$(sensor).xml:system/etc/permissions/android.hardware.sensor.$(sensor).xml))

# Usb
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml

# NFC
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

# Gps
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \

# Touch
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \

#Sensors
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \

# USB
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \

# please modify to appropriate value based on tuning
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hwui.texture_cache_size=24.0f \
    ro.hwui.text_large_cache_width=2048 \
    ro.hwui.text_large_cache_height=512

PRODUCT_PROPERTY_OVERRIDES += \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    keyguard.no_require_sim=true \
    ro.com.android.dataroaming=true

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.rtc_local_time=1 \

# Enable MultiWindow
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.debug.multi_window=true

# DRM service
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

# Property to choose between virtual/external wfd display
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.wfd.virtual=0

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=0 \
    persist.camera.HAL3.enabled=0 \
    persist.camera.ois.disable=0

# Camera: Format set up for graphics
PRODUCT_PROPERTY_OVERRIDES += ro.camera.pixel_format = 0x10F
PRODUCT_PROPERTY_OVERRIDES += ro.camera.rec.pixel_format = 0x100
PRODUCT_PROPERTY_OVERRIDES += ro.ycbcr.pixel_format = 0x10F

# Input resampling configuration
PRODUCT_PROPERTY_OVERRIDES += \
    ro.input.noresample=1

# set default USB configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# AOSP Packages
PRODUCT_PACKAGES += \
    Launcher3 \
    Terminal

PRODUCT_PACKAGES += \
    libion \
    libxml2

PRODUCT_PACKAGES += \
    libemoji

PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    WallpaperPicker \
    NotePad \
    Provision \
    camera.android_ia \
    drmserver \
    gps.default \
    lights.default \
    power.android_ia \
    scp \
    sensors.hsb \
    sftp \
    ssh \
    sshd \
    local_time.default.so \
    vibrator.default.so \
    keystore.default.so

# Sensors
PRODUCT_PACKAGES += \
    sensorhubd      \
    libsensorhub    \
    AndroidCalibrationTool \

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory
