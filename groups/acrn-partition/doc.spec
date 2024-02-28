=== Overview

acrn-partition is used to add new partition named acrn.
Using a sepatate /acrn partition to contain acrn.bin.

    --- dpes
        - boot-arch
        - slot-ab

==== Options

--- true
add acrn partition.

    --- parameters
        - partition_size: specify partition size
        - partition_name: specify partition name

--- false
empty dir.

--- default
when not explicitly selected in mixin spec file, the default option will be used.


