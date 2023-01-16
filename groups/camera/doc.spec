=== Overview

camera is used to enable support for inbuilt and external (especially, USB/UVC web camera) camera in build, with Google's reference implementation. We are encouraged to make device- and SoC-specific optimizations, or even our own specific implemtation.

==== Options

--- remote
use this option to add camera related modules. It contains the components of an camera.

--- false
use this option to not include camera modules.

--- default
when not explicitly selected in mixin spec file, the default option will be used same as false.

