=== Overview

lm dump is used to dump last kernel message when kernel panic

--- deps

    - kernel


==== Options

--- true
this option will enable lmdump.

    --- extra files
        - init.lmdump.rc: "Debug specific init scripts"

--- false
this option will disable lmdump.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
