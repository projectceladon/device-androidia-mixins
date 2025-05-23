=== Overview

init-boot is used to configure init_boot partition

==== Options

--- true
this option is used to configure of adding init_boot partition

    --- parameters
        - partition_size: specify partition size
        - partition_name: specify partition name
        - initboot_enable: support initboot feature

--- false
this option is used to configure of no need init_boot partition

    --- parameters

    --- code dir

--- default
when not explicitly selected in mixin spec file, the default option will be used.
