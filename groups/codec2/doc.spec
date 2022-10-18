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

--- default
when not explicitly selected in mixin spec file, the default option will be used.

--- goldfish-c2
this option is used to enable Goldfish c2 codecs in build

    --parameters

    -- code dir
    - device/generic/goldfish-opengl/system/codecs/c2