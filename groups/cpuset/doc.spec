=== Overview

cpuset is used to specify the shared cpus of forground tasks and background tasks.

==== Options

--- 1core
system default shared cpu number is 1 core.

--- 2cores
specify 2cores.

--- 4cores
specify 4cores.

--- autocores
this option will use script to specify shared cpu number at runtime based on system cpu numbers.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
And it links autocores option.


