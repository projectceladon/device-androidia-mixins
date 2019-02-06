=== Overview

sepolicy mixin is used to configure device selinux policy and control device
enforcing mode. Note that SE Linux is a CDD required and CTS verified feature
to ship Android.

==== Options

--- enforcing
This option will enable SELinux enforcing mode. IE setenforce 1.

    --- code dir
        - device/intel/mixins/groups/sepolicy
        - vendor/intel/utils

--- permissive
This option will disable SELinux enforcing mode. IE setenforce 0.

--- false
This option is nothing to do.

--- default
when not explicitly selected in mixin spec file, the default option of
"false" will be used.
