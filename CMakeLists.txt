cmake_minimum_required(VERSION 4.0)

set(SOLUTION_NAME "ystl")
project(${SOLUTION_NAME})

enable_language(CXX)
# Force C++20 support requirement
set (CMAKE_CXX_STANDARD 20)

include(cmake/macros.cmake)
include(cmake/platform/windows.cmake)

set(ROOT "${CMAKE_CURRENT_SOURCE_DIR}")
set(GTEST_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/googletest/")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${ROOT}/bin")

set_install_prefix(${ROOT})

set(BUILD_GMOCK OFF CACHE BOOL "do not use gmock")
set(INSTALL_GTEST OFF CACHE BOOL "do not install gtest")
add_subdirectory(googletest)

add_subdirectory(test)
