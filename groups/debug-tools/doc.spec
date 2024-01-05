=== Overview

debug tools is used to integrate some debug related tools, like peeknpoke lspci etc.

--- deps

    - n/a


==== Options

--- true
this option will enable peeknpoke lspci logcat2hvc etc into android build.


    --- code dir
        - external/pciutils
        - vendor/intel/tools/peeknpoke
        - vendor/intel/tools/log_capture/logcat2hvc

--- false
this option will disable above tools into android build.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
