=== Overview

The mixin of tee is used to enable/disable one of TEE solution(trusty/optee/false).

--- deps

    - sepolicy
    - boot-arch


==== Options

--- trusty
This option will enable Trusty based TEE.

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

--- optee
This option will enable the OP-Tee based TEE.
    --- parameters

    --- code dir
        - vendor/intel/optee/optee_apps
        - vendor/intel/optee/optee_client
        - vendor/intel/optee/optee_test
        - vendor/intel/optee/optee_os
 

--- false
this option will disable TEE.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
