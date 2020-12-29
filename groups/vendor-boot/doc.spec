=== Overview

vendor-boot is used to configure vendor_boot partition

==== Options

--- true
this option is used to configure of adding vendor_boot partition

    --- parameters
        - partition_size: specify partition size
        - partition_name: specify partition name

--- false
this option is used to configure of no need vendor_boot partition

    --- parameters

    --- code dir

--- default
when not explicitly selected in mixin spec file, the default option will be used.
