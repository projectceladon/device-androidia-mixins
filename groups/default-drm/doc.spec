=== Overview

default-drm is used to configure default drm and clear drm support

--- deps

    - sepolicy

==== Options

--- true
this option will only enable default drm, when not explicitly selected in mixin spec file, the default option will be used.
   --- code dir
       - device/intel/sepolicy/drm-default
       - hardware/interfaces/drm/1.0/default

--- false
this option is used to not enable default drm and clear drm

    --- parameters

    --- code dir

--- default
when not explicitly selected in mixin spec file, the default option will be used.
