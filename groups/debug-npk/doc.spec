=== Overview

npk is used for output logs through npk.

--- deps

    - sepolicy


==== Options


--- true
this option will enable npk driver log output

    --- parameters
        - default_cfg: it used to set input logs and output type

    --- code dir
	- drivers/hwtracing/intel_th

    --- extra files
        - init.npk.rc: "Debug specific init scripts"

--- false
this option will disable npk log output.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
