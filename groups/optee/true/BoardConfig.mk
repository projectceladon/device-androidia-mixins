# Configration for optee OS
OPTEE_CFG_ARCH ?= x86_64
OPTEE_PLATFORM ?= {{ref_target}}
#OPTEE_PLATFORM_FLAVOR ?= {{ref_target}}
#OPTEE_CFG_ARM64_CORE ?= n
OPTEE_TA_TARGETS ?= ta_x86_64
#OPTEE_OS_DIR ?= vendor/intel/optee/optee_os
#OPTEE_EXTRA_FLAGS ?= CFG_TEE_CORE_LOG_LEVEL=3 CFG_TEE_TA_LOG_LEVEL=3 DEBUG=1

#CROSS_COMPILE64 ?= $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
# BUILD_OPTEE_MK will be used by client app ,e.g xtest and optee-widevine-ref

#BUILD_OPTEE_MK := $(OPTEE_OS_DIR)/mk/aosp_optee.mk


BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/optee/enabled
