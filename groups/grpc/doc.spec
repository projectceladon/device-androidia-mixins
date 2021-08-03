=== Overview

gRPC is a modern, open source, high-performance remote procedure call (RPC) framework that can run anywhere. It enables client and server applications to communicate transparently, and makes it easier to build connected systems.


==== Options

--- true
this option will enable grpc lib built-in.

    --- parameters
        - build_example: specify whether build-in example

    --- code dir
        - external/grpc-grpc

--- false
this option will disable grpc lib built-in.

--- default
when not explicitly selected in mixin spec file, the default option will be used.
