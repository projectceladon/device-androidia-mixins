DEVICE_PACKAGE_OVERLAYS += ${TARGET_DEVICE_DIR}/overlay

BOARD_KERNEL_CMDLINE += \
	no_timer_check \
	noxsaves \
	reboot_panic=p,w \
	i915.hpd_sense_invert=0x7 \
	intel_iommu=off \
	i915.enable_pvmmio=0 \
	loop.max_part=7

BOARD_FLASHFILES += ${TARGET_DEVICE_DIR}/bldr_utils.img:bldr_utils.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/LICENSE
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/start_flash_usb.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/auto_switch_pt_usb_vms.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/findall.py
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/setup_host.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/ai_raw_tensor.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/setup_ai_dispatcher.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/sof_audio/configure_sof.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/cam_sharing/0001-Netlink-sync.patch
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/cam_sharing/IntelCameraService
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/cam_sharing/virtualcamera.service
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/setup_cam_sharing.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/setup_audio_host.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/guest_pm_control
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/intel-thermal-conf.xml
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/thermald.service
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/rpmb_dev
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/vm-manager.deb

# for USB OTG WA
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/bxt_usb

# i915_async
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/i915_async

#for clipboard agent
PRODUCT_PRIVATE_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/clipboard_agent/private

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
