=== Overview

abota-fw is used to configure firmware support in abota



==== Options

--- true
this option is used to add firmware support in abota, it should check if slot-ab is true first

    --- parameters
        - post_fw_update: support do firmware update in postinstall
        - boot_fw_update: support do firmware update in boot

    --- code dir

--- false
this option is used to not add firmware support in abota

    --- parameters

    --- code dir

--- default
when not explicitly selected in mixin spec file, the default option will be used.
