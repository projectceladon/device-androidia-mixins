=== Overview

codec2 is used to support Codec 2.0 for Video/Audio since Android Q-Desser.

==== Options

--- true
this option is used to enable support for external camera in build

    --- parameters

    --- code dir
	- frameworks/av/media/codec2
	- frameworks/av/media/bufferpool 
	- hardware/interfaces/media/c2/1.0
    - hardware/interfaces/media/bufferpool/2.0

--- false
this option is used to disable support for external camera in build

    --- parameters

    --- code dir

--- configurable
this option is used to select the platform and supported codec list

    --- parameters
        - virtio_video:    select v4l2-codec2 as codec2.0 plugin

--- default
when not explicitly selected in mixin spec file, the default option will be used.
