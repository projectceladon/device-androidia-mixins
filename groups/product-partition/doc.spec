=== Overview

product-partition is used to add new partition named product.
Using a sepatate /product partition to contain customizations
make it possible to use a single system image for mulitiple sofeware SKUs.

    --- dpes
        - boot-arch
        - slot-ab
        - avb
        - firststage-mount

==== Options

--- true
add product partition.

    --- parameters
        - partition_size: specify partition size
        - partition_name: specify partition name

--- false
empty dir.

--- default
when not explicitly selected in mixin spec file, the default option will be used.


