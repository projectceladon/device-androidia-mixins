=== Overview

rpc-services are services running in guest to communicate with host efficiently.

==== Options

--- grpc
this option will enable rpc services, grpc lib built-in.

    --- parameters
        - build_example: specify whether build-in example

    --- code dir
        - external/grpc-grpc/
        - device/intel/civ/host/vm-manager/src/android/

--- false
this option will disable rpc-services built-in.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
