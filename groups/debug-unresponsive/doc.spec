=== Overview

debug-unresponsive is used for collection of stacks and binder transactions when ANR/UIWDT events occur

--- deps

    - n/a


==== Options

--- true
this option will enable unresponsive logs into specific folder.

    --- parameters
        - peer_depth: this set peer depth for vendor.sys.dump.peer_depth.
        - stacks_timeout: defines the stack timeout limit.

--- false
this option will disable unresponsive logs into specific folder.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
