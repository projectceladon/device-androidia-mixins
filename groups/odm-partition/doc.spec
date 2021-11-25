=== Overview

odm-partition is used to add new partition named odm.
Using a sepatate /odm partition to contain customizations
make it possible to use a single vendor image for mulitiple hardware SKUs.

    --- dpes
        - boot-arch
        - slot-ab
        - firststage-mount

==== Options

--- true
add odm partition.

    --- parameters
        - partition_size: specify partition size
        - partition_name: specify partition name

--- false
empty dir.

--- default
when not explicitly selected in mixin spec file, the default option will be used.


