=== Overview

ota-upgrade is used to configure ota-upgrade support


==== Options

--- true
this option is used to add ota-upgrade support

    --- parameters
        - ota_pre_o_version: true for upgrade from Android O
        - ota_pre_p_version: true for upgrade from Android P

    --- code dir

--- false
this option is used to not add ota-upgrade support

    --- parameters

    --- code dir

--- default
when not explicitly selected in mixin spec file, the default option will be used.
