TARGET_USE_TRUSTY := true

{{#enable_hw_sec}}
KM_VERSION := {{{keymaster_version}}}
ifeq ($(KM_VERSION),1)
BOARD_USES_TRUSTY := true
BOARD_USES_KEYMASTER1 := true
endif
{{/enable_hw_sec}}

BOARD_SEPOLICY_DIRS += device/intel/project-celadon/sepolicy/trusty
BOARD_SEPOLICY_M4DEFS += module_trusty=true

LK_PRODUCT := project-celadon_64
TRUSTY_ENV_VAR += TRUSTY_REF_TARGET={{ref_target}}

TRUSTY_BUILDROOT = $(PWD)/$(PRODUCT_OUT)/obj/trusty/

#for trusty vmm
# use same toolchain as android kernel
TRUSTY_ENV_VAR += COMPILE_TOOLCHAIN=$(EVMMBUILD_TOOLCHAIN)

# output build dir to android out folder
TRUSTY_ENV_VAR += BUILD_DIR=$(TRUSTY_BUILDROOT)
ifeq ($(LKDEBUG),2)
TRUSTY_ENV_VAR += LKBIN_DIR=$(PWD)/vendor/intel/fw/trusty-release-binaries/debug/
else
TRUSTY_ENV_VAR += LKBIN_DIR=$(PWD)/vendor/intel/fw/trusty-release-binaries/
endif

#Workaround CPU lost issue on SIMICS, will remove this line below after PO.
BOARD_KERNEL_CMDLINE += cpu_init_udelay=500000

BOARD_TOSIMAGE_PARTITION_SIZE := 10485760
