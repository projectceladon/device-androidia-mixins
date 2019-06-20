TARGET_USE_TRUSTY := true

{{#enable_hw_sec}}
KM_VERSION := {{{keymaster_version}}}
ifeq ($(KM_VERSION),1)
BOARD_USES_TRUSTY := true
BOARD_USES_KEYMASTER1 := true
endif
{{/enable_hw_sec}}

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/trusty
BOARD_SEPOLICY_M4DEFS += module_trusty=true

LK_PRODUCT := project-celadon_64

LKBUILD_TOOLCHAIN_ROOT = $(PWD)/vendor/intel/external/prebuilts/elf/
LKBUILD_X86_TOOLCHAIN =
LKBUILD_X64_TOOLCHAIN = $(LKBUILD_TOOLCHAIN_ROOT)x86_64-elf-4.9.1-Linux-x86_64/bin
EVMMBUILD_TOOLCHAIN ?= x86_64-linux-android-
TRUSTY_BUILDROOT = $(PWD)/$(PRODUCT_OUT)/obj/trusty/

TRUSTY_ENV_VAR += LK_CORE_NUM={{lk_core_num}}
TRUSTY_ENV_VAR += TRUSTY_REF_TARGET={{ref_target}}

#for trusty lk
TRUSTY_ENV_VAR += BUILDROOT=$(TRUSTY_BUILDROOT)
TRUSTY_ENV_VAR += PATH=$$PATH:$(LKBUILD_X86_TOOLCHAIN):$(LKBUILD_X64_TOOLCHAIN)
TRUSTY_ENV_VAR += CLANG_BINDIR=$(PWD)/$(LLVM_PREBUILTS_PATH)
TRUSTY_ENV_VAR += ARCH_x86_64_TOOLCHAIN_PREFIX=${PWD}/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-${TARGET_GCC_VERSION}/bin/x86_64-linux-android-

#for trusty vmm
# use same toolchain as android kernel
TRUSTY_ENV_VAR += COMPILE_TOOLCHAIN=$(EVMMBUILD_TOOLCHAIN)

# output build dir to android out folder
TRUSTY_ENV_VAR += BUILD_DIR=$(TRUSTY_BUILDROOT)
TRUSTY_ENV_VAR += LKBIN_DIR=$(TRUSTY_BUILDROOT)/build-{{{lk_project}}}/

#Workaround CPU lost issue on SIMICS, will remove this line below after PO.
BOARD_KERNEL_CMDLINE += cpu_init_udelay=500000

BOARD_TOSIMAGE_PARTITION_SIZE := 10485760
