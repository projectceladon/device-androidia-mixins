=== Overview

mainline-mode is used to configure mainline dependency module support


==== Options

--- true
this option is used to add mainline module dependency support

    --- parameters
        - log_level: define log level

    --- code dir
        - system/core/init/

--- false
this option is used to not add mainline module dependency support

    --- parameters

    --- code dir

--- default
when not explicitly selected in mixin spec file, the default option will be used.
