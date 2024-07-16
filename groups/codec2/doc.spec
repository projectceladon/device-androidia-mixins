=== Overview

codec2 is used to support Codec 2.0 for Video/Audio since Android Q-Desser.

==== Options

--- true
this option is used to enable support for external camera in build

    --- parameters
        - platform:     select the media_codecs_performance_c2.xml based on platform
        - hw_vd_mp2:    select hw accelerated mpeg2 decoder
        - hw_vd_vc1:    select hw accelerated vc1 decoder
        - hw_vd_vp9:    select hw accelerated vp9 decoder
        - hw_vd_vp8:    select hw accelerated vp8 decoder
        - hw_vd_h265:   select hw accelerated h.265 decoder
        - hw_ve_vp8:    select hw accelerated vp8 encoder
        - hw_ve_vp9:    select hw accelerated vp9 encoder
        - hw_ve_h265:   select hw accelerated h.265 encoder
        - hw_ve_h264:   select hw accelerated h.264 encoder
        - hw_vd_h264:   select hw accelerated h.264 decoder
        - hw_vd_av1：   select hw accelerated av1 decoder

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
