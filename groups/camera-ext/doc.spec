=== Overview

camera-ext is used to enable support for external camera(especially, USB/UVC web camera) in build,
with Google's reference implementation. We are encouraged to make device- and SoC-specific optimizations,
or even our own specific implemtation.

This feature is firstly introduced on Android P-dessert.

Documents from Google (Please apply Google drive access first):
USB/UVC Integrated Cameras: https://drive.google.com/open?id=16C0pV6kcSs08g-105uaFLHsED4WerPwO
USB web camera support: https://drive.google.com/open?id=1-hzq2L4c5UQ2Es-cQKAn0It8m7zx-W2v (P37~P43)

==== Options

--- enabled
this option is used to enable support for external camera in build with internal cameras (CSI camera)

    --- parameters

    --- code dir
	- hardware/interface/camera/provider/2.4/default/ExternalCamera*
	- hardware/interface/camera/device/3.4/default/ExternalCamera*
	- hardware/interface/camera/device/3.4/default/include/ext_device_v3_4_impl/ExternalCamera*

--- ext-camera-only
this option is used to enable support for external camera in build. There is no support for CSI Camera here, will support only USB Camera.

    --- parameters

    --- code dir
        - hardware/interface/camera/provider/2.4/default/ExternalCamera*
        - hardware/interface/camera/device/3.4/default/ExternalCamera*
        - hardware/interface/camera/device/3.4/default/include/ext_device_v3_4_impl/ExternalCamera*

--- disabled
this option is used to disable support for external camera in build

    --- parameters

    --- code dir

--- default
when not explicitly selected in mixin spec file, the default option will be used.
