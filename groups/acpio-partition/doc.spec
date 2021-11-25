=== Overview

acpio-partition is used to add new partition named acpio.
Using a sepatate /acpio partition to contain SSDT.

    --- dpes
        - boot-arch
        - slot-ab
        - firststage-mount

==== Options

--- true
add acpio partition.

    --- parameters
        - partition_size: specify partition size
        - partition_name: specify partition name

--- false
empty dir.

--- default
when not explicitly selected in mixin spec file, the default option will be used.


