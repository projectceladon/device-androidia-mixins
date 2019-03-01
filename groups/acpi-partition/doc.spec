=== Overview

acpi-partition is used to add new partition named acpi.
Using a sepatate /acpi partition to contain DSDT.

    --- dpes
        - boot-arch
        - slot-ab
        - avb
        - firststage-mount

==== Options

--- true
add acpi partition.

    --- parameters
        - partition_size: specify partition size
        - partition_name: specify partition name

--- false
empty dir.

--- default
when not explicitly selected in mixin spec file, the default option will be used.


