=== Overview

This group is used to configure ethernet.

--- parameters
    - eth-driver: specify ethernet card driver module.

==== Options

--- dhcp
Define dhcp related service.

--- static
It will set static ip address when system boot up.

--- none
Empty option.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
It links none option.


