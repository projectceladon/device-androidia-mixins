=== Overview

dynamic-partitions is used to support dynamic partitions feature introduced by Android Q.



==== Options

--- true
enable dynamic partitions feature.

    --- parameters
        - super_partition_size: specify size of super partition
        - overhead_size: Overhead is required in the computation to account for metadata, alignments, and so on.
        - dp_retrofit: enable retrofit dynamic partitions
        - super_img_in_flashzip: flash super.img in flash zip package

--- false
empty dir.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
