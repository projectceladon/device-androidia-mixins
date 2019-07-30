=== Overview

gptbuild is used to configure gptbuild support

--- deps

    - trusty
    - vendor-partition
    - product-partition
    - odm-partition
    - acpi-partition
    - acpio-partition

==== Options

--- true
this option is used to add gptbuild support

    --- parameters
        acrn_data : true for saving gptimage to acrn_data partition with ext4 filesystem
        data_size: size of ext4 filesystem
    --- code dir


--- false
this option is used to not add gptbuild support

    --- parameters

    --- code dir

--- default
when not explicitly selected in mixin spec file, the default option will be used.
