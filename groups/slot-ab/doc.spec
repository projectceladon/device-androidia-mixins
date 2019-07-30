=== Overview

slotab is used to configure slotab support

    --- deps
        - dynamic-partitions

==== Options

--- true
this option is used to add slotab support

    --- parameters
        - system_fs: type of file system
        - nb_slot: number of slots

    --- code dir

--- false
this option is used to not add slotab support

    --- parameters

    --- code dir

--- default
when not explicitly selected in mixin spec file, the default option will be used.
