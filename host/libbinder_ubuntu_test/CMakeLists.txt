set(TARGET_OS "linux")
set(CMAKE_TOOLCHAIN_FILE "clang.toolchain.cmake")
set(UNIT_TEST 1)

cmake_minimum_required( VERSION 2.6 )
project(CIC-CFC-LIBBIDER-UBUNTU-TEST)

execute_process (
    COMMAND bash -c "git log --oneline|head -1|awk '{ print $1 }'"
    OUTPUT_VARIABLE PATCH
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
set(MWC_VERION_MAJOR 0)
set(MWC_VERION_MINOR 1)
set(MWC_VERION_PATCH ${PATCH})

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_BUILD_TYPE Debug)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -fno-exceptions -Wno-deprecated  -DOS_UBUNTU=1")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -fno-exceptions -Wno-deprecated -DOS_UBUNTU=1")
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")

set(EXECUTABLE_OUTPUT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/bin/${TARGET_OS}")
set(LIBRARY_OUTPUT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/libs/${TARGET_OS}")

find_library(PTHREAD_LIBRARY pthread "pthread library")

include_directories(
  "${CMAKE_CURRENT_SOURCE_DIR}/prebuilt/${TARGET_OS}/libbinder/include"
  )
link_directories(
  "${CMAKE_CURRENT_SOURCE_DIR}/prebuilt/${TARGET_OS}/libbinder/lib"
  )

if (UNIT_TEST)
add_executable(ubuntuService tests/ubuntuService.cpp)
target_link_libraries(ubuntuService
  binder
  pthread
)

add_executable(ubuntuClient tests/ubuntuClient.cpp)
target_link_libraries(ubuntuClient
  binder
  pthread
)

endif()
