DEVICE_PACKAGE_OVERLAYS += ${TARGET_DEVICE_DIR}/overlay

BOARD_KERNEL_CMDLINE += \
	no_timer_check \
	noxsaves \
	i915.hpd_sense_invert=0x7 \
	intel_iommu=off \
	i915.enable_pvmmio=0 \
	loop.max_part=7 \

# for ramoops
ifneq ($(TARGET_BUILD_VARIANT),user)
BOARD_KERNEL_CMDLINE += \
        memmap=4M\$$0x100000000
BOARD_KERNEL_CMDLINE += \
        ramoops.mem_address=0x100000000
BOARD_KERNEL_CMDLINE += \
        ramoops.mem_size=0x400000
BOARD_KERNEL_CMDLINE += \
        ramoops.console_size=0x200000
BOARD_KERNEL_CMDLINE += \
        ramoops.dump_oops=1
endif

BOARD_FLASHFILES += ${TARGET_DEVICE_DIR}/bldr_utils.img:bldr_utils.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/start_flash_usb.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/auto_switch_pt_usb_vms.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/findall.py
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/setup_host.sh
#BOARD_FLASHFILES += $(PRODUCT_OUT)/product/app/avmapk/avmapp.apk
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/lib64/libcarcam_feature_avm.so
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/lib64/libSurroundViewSim.so
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/lib64/libvc_avm.so
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/lib64/libvideocat.so
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/lib64/libvideocatsupport.so
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/bin/carcam
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/etc/automotive/videocat_support/videocat_config.json
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/etc/SViewCam4Lens_default.txt
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/etc/SViewTune.camera
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/etc/SViewTune_calib.camera
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/etc/underCar_padded.ppm
BOARD_FLASHFILES += $(PRODUCT_OUT)/system/etc/underCar_TC.ppm
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/sof_audio/configure_sof.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/setup_audio_host.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/guest_pm_control
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/intel-thermal-conf.xml
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/thermald.service
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/rpmb_dev

# for USB OTG WA
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/bxt_usb

# i915_async
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/i915_async

#add vendor property
BOARD_SEPOLICY_DIRS += device/intel/sepolicy/vendor/

TARGET_USES_HWC2 := true
BOARD_USES_GENERIC_AUDIO := false

DEVICE_MANIFEST_FILE := ${TARGET_DEVICE_DIR}/manifest.xml
DEVICE_MATRIX_FILE   := ${TARGET_DEVICE_DIR}/compatibility_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := ${TARGET_DEVICE_DIR}/framework_manifest.xml
BUILD_BROKEN_USES_BUILD_HOST_STATIC_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_SHARED_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_EXECUTABLE := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
# PRODUCT_COPY_FILES directives.
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# fastbootd over USB support
TARGET_RECOVERY_UI_LIB := librecovery_ui_default
