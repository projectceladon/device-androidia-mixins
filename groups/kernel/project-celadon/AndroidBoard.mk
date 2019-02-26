ifneq ($(TARGET_PREBUILT_KERNEL),)
$(error TARGET_PREBUILT_KERNEL defined but AndroidIA kernels build from source)
endif

TARGET_KERNEL_SRC ?= kernel/project-celadon

TARGET_KERNEL_ARCH := x86_64
TARGET_KERNEL_CONFIG ?= kernel_64_defconfig

KERNEL_CONFIG_DIR := {{{kernel_config_dir}}}

KERNEL_NAME := bzImage

# Set the output for the kernel build products.
KERNEL_OUT := $(abspath $(TARGET_OUT_INTERMEDIATES)/kernel)
KERNEL_BIN := $(KERNEL_OUT)/arch/$(TARGET_KERNEL_ARCH)/boot/$(KERNEL_NAME)
KERNEL_MODULES_INSTALL := $(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR)/lib/modules

KERNELRELEASE = $(shell cat $(KERNEL_OUT)/include/config/kernel.release)

KMOD_OUT := $(shell readlink -f "$(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR)")

build_kernel := $(MAKE) -C $(TARGET_KERNEL_SRC) \
		O=$(KERNEL_OUT) \
		ARCH=$(TARGET_KERNEL_ARCH) \
		CROSS_COMPILE="$(KERNEL_CROSS_COMPILE_WRAPPER)" \
		KCFLAGS="$(KERNEL_CFLAGS)" \
		KAFLAGS="$(KERNEL_AFLAGS)" \
		$(if $(SHOW_COMMANDS),V=1) \
		INSTALL_MOD_PATH=$(KMOD_OUT)

KERNEL_CONFIG_FILE := device/intel/project-celadon/kernel_config/$(TARGET_KERNEL_CONFIG)

ifneq ($(TARGET_BUILD_VARIANT), user)
KERNEL_CONFIG_FILE += $(wildcard $(KERNEL_CONFIG_DIR)/debug_diffconfig)
endif

KERNEL_CONFIG := $(KERNEL_OUT)/.config
$(KERNEL_CONFIG): $(KERNEL_CONFIG_FILE)
	$(hide) mkdir -p $(@D) && cat $(wildcard $^) > $@
	$(build_kernel) oldnoconfig

# Produces the actual kernel image!
$(PRODUCT_OUT)/kernel: $(KERNEL_CONFIG) | $(ACP)
	$(build_kernel) $(KERNEL_NAME) modules
	$(hide) $(ACP) -fp $(KERNEL_BIN) $@

EXTMOD_SRC := ../../../../../..

TARGET_EXTRA_KERNEL_MODULES := $(EXTMOD_SRC)/kernel/modules/perftools-external/soc_perf_driver/src
TARGET_EXTRA_KERNEL_MODULES += $(EXTMOD_SRC)/kernel/modules/perftools-external/socwatch_driver

ALL_EXTRA_MODULES := $(patsubst %,$(TARGET_OUT_INTERMEDIATES)/kmodule/%,$(TARGET_EXTRA_KERNEL_MODULES))
$(ALL_EXTRA_MODULES): $(TARGET_OUT_INTERMEDIATES)/kmodule/%: $(PRODUCT_OUT)/kernel
	@echo Building additional kernel module $*
	$(build_kernel) M=$(abspath $@) modules

# This is to ensure that kernel modules are installed before
# vendor.img is generated.
$(PRODUCT_OUT)/vendor.img : $(KERNEL_MODULES_INSTALL)

# Copy modules in directory pointed by $(KERNEL_MODULES_ROOT)
# First copy modules keeping directory hierarchy lib/modules/`uname-r`for libkmod
# Second, create flat hierarchy for insmod linking to previous hierarchy
$(KERNEL_MODULES_INSTALL): $(PRODUCT_OUT)/kernel $(ALL_EXTRA_MODULES)
	$(hide) rm -rf $(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR)/lib/modules
	$(build_kernel) modules_install
	$(hide) for kmod in $(TARGET_EXTRA_KERNEL_MODULES) ; do \
		echo Installing additional kernel module $${kmod} ; \
		$(subst +,,$(subst $(hide),,$(build_kernel))) M=$(abspath $(TARGET_OUT_INTERMEDIATES))/kernel/$${kmod} modules_install ; \
	done
	$(hide) rm -f $(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR)/lib/modules/*/{build,source}
	$(hide) mv $(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR)/lib/modules/$(KERNELRELEASE)/* $(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR)/lib/modules
	$(hide) rm -rf $(PRODUCT_OUT)/$(TARGET_COPY_OUT_VENDOR)/lib/modules/$(KERNELRELEASE)
	$(hide) touch $@

# Makes sure any built modules will be included in the system image build.
ALL_DEFAULT_INSTALLED_MODULES += $(KERNEL_MODULES_INSTALL)

installclean: FILES += $(KERNEL_OUT) $(PRODUCT_OUT)/kernel

.PHONY: kernel
kernel: $(PRODUCT_OUT)/kernel
