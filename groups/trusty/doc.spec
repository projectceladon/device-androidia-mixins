=== Overview

trusty is used to enable/disable VMM based TEE solution.

--- deps

    - sepolicy
    - boot-arch


==== Options

--- true
this option will enable VMM based TEE.

    --- parameters
        - ref_target: the refernece target

    --- code dir
        - device/intel/mixins/groups/trusty
        - device/intel/sepolicy/trusty
        - vendor/intel/fw/evmm
        - trusty
        - system/core/trusty
        - system/gatekeeper
        - system/keymaster
        - vendor/intel/hardware/keystore
        - vendor/intel/hardware/storage
        - hardware/interfaces/gatekeeper
        - hardware/interfaces/keymaster
        - hardware/intel/kernelflinger/libqltipc
        - kernel/bxt/drivers/trusty

--- false
this option will disable VMM based TEE.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
