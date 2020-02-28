set(TARGET_OS "linux")
set(CMAKE_TOOLCHAIN_FILE "clang.toolchain.cmake")

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

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D__ANDROID__=1 -DOS_UBUNTU -DFAKE_LOG_DEVICE=1 -DLIBLOG_LOG_TAG=1006 -DSNET_EVENT_LOG_TAG=1397638484 -fPIC -std=gnu11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__ANDROID__=1 -DOS_UBUNTU -DFAKE_LOG_DEVICE=1 -DLIBLOG_LOG_TAG=1006 -DSNET_EVENT_LOG_TAG=1397638484 -fPIC -std=c++11")
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")

set(EXECUTABLE_OUTPUT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/bin/${TARGET_OS}")
set(LIBRARY_OUTPUT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/libs/${TARGET_OS}")

find_library(PTHREAD_LIBRARY pthread "pthread library")

macro (add_aidl_cpp _output_list)
  foreach(_aidl_file ${ARGN})
    get_filename_component(_out_file ${_aidl_file} NAME_WE)
    set(_out_cpp ${CMAKE_CURRENT_SOURCE_DIR}/${_out_file}.cpp)

    add_custom_command(
      OUTPUT ${_out_cpp}
      DEPENDS ${_aidl_file}
      COMMAND aidl-cpp -I. ${_aidl_file} include ${_out_cpp}
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
      COMMENT "aidl-cpp -I. ${_aidl_file} include ${_out_cpp}"
    )
    set_property(SOURCE ${_out_cpp} APPEND PROPERTY OBJECT_DEPENDS ${_aidl_file})
    set_source_files_properties(${_out_cpp} PROPERTIES   GENERATED TRUE)
    set_source_files_properties(${_aidl_file} PROPERTIES HEADER_FILE_ONLY TRUE)
    set(${_output_list} ${${_output_list}}  ${_out_cpp})
  endforeach(_aidl_file ${ARGN})
endmacro (add_aidl_cpp)

include_directories(
  "${CMAKE_CURRENT_SOURCE_DIR}/prebuilt/${TARGET_OS}/libbinder/include"
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
  )
link_directories(
  "${CMAKE_CURRENT_SOURCE_DIR}/prebuilt/${TARGET_OS}/libbinder/lib"
  )

set(AIDL_SUM_FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/com/intel/sum/ISum.aidl
  )
add_aidl_cpp(AIDL_SUM_CPP ${AIDL_SUM_FILES})

add_executable(sumServiceUbuntu
  ${AIDL_SUM_CPP}
  sumServiceUbuntu.cpp
  )
target_link_libraries(sumServiceUbuntu
  binder
  pthread
)

set(AIDL_MULTIPLY_FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/com/intel/multiply/IMultiply.aidl
  )
add_aidl_cpp(AIDL_MULTIPLY_CPP ${AIDL_MULTIPLY_FILES})

add_executable(multiplyClientUbuntu
  ${AIDL_MULTIPLY_CPP}
  multiplyClientUbuntu.cpp
  )
target_link_libraries(multiplyClientUbuntu
  binder
  pthread
)

set(AIDL_SUBTRACT_FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/com/intel/subtract/ISubtract.aidl
  )
add_aidl_cpp(AIDL_SUBTRACT_CPP ${AIDL_SUBTRACT_FILES})

add_executable(subtractClientUbuntu
  ${AIDL_SUBTRACT_CPP}
  subtractClientUbuntu.cpp
  )
target_link_libraries(subtractClientUbuntu
  binder
  pthread
)
