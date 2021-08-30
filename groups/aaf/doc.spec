=== Overview

AAF(Auto Adaption Framework) is used to load kernel modules based on uevent and determine HAL
in runtime.

--- deps

    - sepolicy


==== Options

--- true
this option will enable aaf daemon.

    --- code dir
        - vendor/intel/external/project-celadon/aaf

--- cfc
this option is specific for caas_cfc target

--- false
this option will disable aaf.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
