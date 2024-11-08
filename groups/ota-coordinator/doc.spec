=== Overview

ota-coordinator is designed to coordinate SOS, Android APP, and Android native layer. It
implements a comprehensive upgrade as well as factory reset for both SOS and VMs.

==== Options

--- true
this option is used to enable ota-coordinator support

    --- parameters
    --- code dir

--- false
this option is used to disable ota-coordinator support

    --- parameters
    --- code dir

--- default
when not explicitly selected in mixin spec file, the default option(disable) will be used.
