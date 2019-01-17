=== Overview

dexpreopt is used to turn on/off dex-preoptimization feature.
when feature is on, it will speed up the first boot sequence.

==== Options

--- compressed
Enable dex-preoptimization, also enable  odex compression to save space on /system.

--- disabled
Disable dex-preoptimization.

--- enabled
Enable dex-preoptimization on all variant build.

--- full
Enable dex-preoptimization on user/userdebug build.

--- partial
It sets a flag handled in Android.mk for certain
packages that selectively disables dexopt if the app is on the Play
store, such as certain GMS apps.

--- none
Disable dex-preoptimization.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
It links full option.


