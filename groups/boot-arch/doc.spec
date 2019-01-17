=== Overview

boot-arch is used to select bootloader and specify system main fstab.

--- deps

    - variants
    - slot-ab
    - avb
    - firststage-mount
    - disk-bus

==== Options

--- efi
this option will select UEFI as bootloader.

    --- parameters
        - uefi_arch: set for TARGET_UEFI_ARCH
        - acpi_permissive: set for KERNELFLINGER_ALLOW_UNSUPPORTED_ACPI_TABLE
        - use_power_button: set for KERNELFLINGER_USE_POWER_BUTTON
        - disable_watchdog: set for KERNELFLINGER_USE_WATCHDOG
        - watchdog_parameters: set watchdog parameters
        - use_charging_applet: set for KERNELFLINGER_USE_CHARGING_APPLET
        - ignore_rsci: set for KERNELFLINGER_IGNORE_RSCI
        - magic_key_timeout: Maximum timeout to check for magic key at boot; loader GUID
        - bios_variant: set for BIOS_VARIANT
        - data_encryption: forceencrypt
        - bootloader_policy: It activates the Bootloader policy and RMA refurbishing features.
                             TARGET_BOOTLOADER_POLICY is the desired bitmask for this device
        - blpolicy_use_efi_var: set for TARGET_BOOTLOADER_POLICY_USE_EFI_VAR
        - ignore_not_applicable_reset: Allow Kernelflinger to ignore the RSCI reset source "not_applicable"
        - verity_warning: verity feature
        - txe_bind_root_of_trust: It makes kernelflinger bind the device state to the root of trust
                                  using the TXE.
        - run_tco_on_shutdown: set for iTCO_wdt.stop_on_shutdown=0 in kernel command line
        - bootloader_block_size: set for BOARD_BOOTLOADER_BLOCK_SIZE
        - hung_task_timeout_secs: set for hung_task_timeout_secs configure in sysfs
        - vendor-partition: set for support vendor partition
        - os_secure_boot: Kernelfligner will set the global variable OsSecureBoot
                          The BIOS must support this variable to enable this feature
        - verity_mode: verity feature
        - ifwi_debug: Allow to add debug ifwi file only on userdebug and eng flashfiles
        - bootloader_len: set for bootloader size
        - flash_block_size: set for BOARD_FLASH_BLOCK_SIZE
        - loader_efi_to_flash: set for fastboot boot command

    --- extra files
        - oemvars.txt:  "magic key detection timeout"

    --- code dir
        - hardware/intel/bootctrl/boot/overlay
        - device/intel/sepolicy/boot-arch/efi

--- abl
this option is used fo automotive platform.

    --- parameters
        - data_encryption: forceencrypt
        - verity_warning: verity feature
        - verity_mode: verity feature
        - watchdog_parameters: set watchdog parameters
        - run_tco_on_shutdown: set for iTCO_wdt.stop_on_shutdown=0 in kernel command line
        - hung_task_timeout_secs: set for hung_task_timeout_secs configure in sysfs
        - vendor-partition: set for support vendor partition
        - ifwi_debug: for ifwi_debug
        - config: project configure
        - prebuilts_dir: for prebuilts_dir
        - timeout: flash timeout
        - bootloader_block_size: set for BOARD_BOOTLOADER_BLOCK_SIZE
        - bootloader_len: set for bootloader size
        - fastboot_in_ifwi: set for FASTBOOT_IN_IFWI
        - xen_partition: for xen_partition
        - rpmb: set for KERNELFLINGER_USE_RPMB
        - large-cache-partition: large cache partition used in case of OTA from M to O

    --- code dir
        - device/intel/common/boot/overlay
        - device/intel/sepolicy/boot-arch/abl

--- sbl
this option is used fo slimboot platform.

    --- parameters
        - data_encryption: forceencrypt
        - verity_warning: verity feature
        - verity_mode: verity feature
        - watchdog_parameters: set watchdog parameters
        - run_tco_on_shutdown: set for iTCO_wdt.stop_on_shutdown=0 in kernel command line
        - hung_task_timeout_secs: set for hung_task_timeout_secs configure in sysfs
        - vendor-partition: set for support vendor partition
        - ifwi_debug: for ifwi_debug
        - config: project configure
        - prebuilts_dir: for prebuilts_dir
        - timeout: flash timeout
        - bootloader_block_size: set for BOARD_BOOTLOADER_BLOCK_SIZE
        - bootloader_len: set for bootloader size
        - fastboot_in_ifwi: set for FASTBOOT_IN_IFWI
        - xen_partition: for xen_partition
        - rpmb: set for KERNELFLINGER_USE_RPMB

    --- code dir
        - device/intel/common/boot/overlay
        - device/intel/sepolicy/boot-arch/abl

--- sofia
this option is used fo sofia platform.

    --- parameters
        - throttle_cpu_during_boot: set cpu frequency
        - num_cpus: set for MV_NUM_OF_CPUS
        - mv_config_paddr: set for MV_CONFIG_PADDR
        - msm: Enable -DFEAT_RPC_SERVICE for various IMC services
        - forceencrypt: forceencrypt
        - encryptable: encryptable
        - watchdog_parameters: set watchdog parameters
        - watchdog_node: set for watchdog_node
        - persistent_part: set for persistent partition
        - metadata_part: set for metadata partition
        - no_watchdog: set for no_watchdong
        - dm_verity: dm_verity
        - verity_warning: dm_verity
        - lte_interactive_fastboot_ui_feature: if interactive fastboot ui feature enabled
                                               enable interactive UI flag
        - use_lte_sepolicy: for use_lte_sepolicy
        - lte_gvb_feature: set for GVB_FEATURE_ENABLE
        - system_partition_size: set for system_partition_size
        - userdata_partition_size: set for userdata_partition_size
        - mrd_variant: set for MV_CONFIG_CUST_VARIANT
        - wv_level3: set for wv_level3
        - enc1080p: set for enc1080p
        - vp_build: set for vp_build
        - ifwi_debug: for ifwi_debug

    --- code dir
        - device/intel/sepolicy/boot-arch/common

--- sofia_3gr
this option is used fo sofia_3gr platform.

    --- parameters
        - throttle_cpu_during_boot: set cpu frequency
        - num_cpus: set for MV_NUM_OF_CPUS
        - mv_config_paddr: set for MV_CONFIG_PADDR
        - msm: Enable -DFEAT_RPC_SERVICE for various IMC services
        - forceencrypt: forceencrypt
        - encryptable: encryptable
        - watchdog_parameters: set watchdog parameters
        - watchdog_node: set for watchdog_node
        - persistent_part: set for persistent partition
        - metadata_part: set for metadata partition
        - no_watchdog: set for no_watchdong
        - dm_verity: dm_verity
        - verity_warning: dm_verity
        - lte_interactive_fastboot_ui_feature: if interactive fastboot ui feature enabled
                                               enable interactive UI flag
        - use_lte_sepolicy: for use_lte_sepolicy
        - lte_gvb_feature: set for GVB_FEATURE_ENABLE
        - system_partition_size: set for system_partition_size
        - userdata_partition_size: set for userdata_partition_size
        - mrd_variant: set for MV_CONFIG_CUST_VARIANT
        - wv_level3: set for wv_level3
        - enc1080p: set for enc1080p
        - vp_build: set for vp_build
        - ifwi_debug: for ifwi_debug

    --- code dir
        - device/intel/sepolicy/boot-arch/common

--- sofia_3gx
this option is used fo sofia_3gx platform.

    --- parameters
        - throttle_cpu_during_boot: set cpu frequency
        - num_cpus: set for MV_NUM_OF_CPUS
        - mv_config_paddr: set for MV_CONFIG_PADDR
        - msm: Enable -DFEAT_RPC_SERVICE for various IMC services
        - forceencrypt: forceencrypt
        - encryptable: encryptable
        - watchdog_parameters: set watchdog parameters
        - watchdog_node: set for watchdog_node
        - persistent_part: set for persistent partition
        - metadata_part: set for metadata partition
        - no_watchdog: set for no_watchdong
        - dm_verity: dm_verity
        - verity_warning: dm_verity
        - lte_interactive_fastboot_ui_feature: if interactive fastboot ui feature enabled
                                               enable interactive UI flag
        - use_lte_sepolicy: for use_lte_sepolicy
        - lte_gvb_feature: set for GVB_FEATURE_ENABLE
        - system_partition_size: set for system_partition_size
        - userdata_partition_size: set for userdata_partition_size
        - mrd_variant: set for MV_CONFIG_CUST_VARIANT
        - wv_level3: set for wv_level3
        - enc1080p: set for enc1080p
        - vp_build: set for vp_build
        - ifwi_debug: for ifwi_debug

    --- code dir
        - device/intel/sepolicy/boot-arch/common

--- sofia_lte2
this option is used fo sofia_lte2 platform.

    --- parameters
        - throttle_cpu_during_boot: set cpu frequency
        - num_cpus: set for MV_NUM_OF_CPUS
        - mv_config_paddr: set for MV_CONFIG_PADDR
        - msm: Enable -DFEAT_RPC_SERVICE for various IMC services
        - forceencrypt: forceencrypt
        - encryptable: encryptable
        - watchdog_parameters: set watchdog parameters
        - watchdog_node: set for watchdog_node
        - persistent_part: set for persistent partition
        - metadata_part: set for metadata partition
        - no_watchdog: set for no_watchdong
        - dm_verity: dm_verity
        - verity_warning: dm_verity
        - lte_interactive_fastboot_ui_feature: if interactive fastboot ui feature enabled
                                               enable interactive UI flag
        - use_lte_sepolicy: for use_lte_sepolicy
        - lte_gvb_feature: set for GVB_FEATURE_ENABLE
        - system_partition_size: set for system_partition_size
        - userdata_partition_size: set for userdata_partition_size
        - mrd_variant: set for MV_CONFIG_CUST_VARIANT
        - wv_level3: set for wv_level3
        - enc1080p: set for enc1080p
        - vp_build: set for vp_build
        - ifwi_debug: for ifwi_debug

    --- code dir
        - device/intel/sepolicy/boot-arch/common
