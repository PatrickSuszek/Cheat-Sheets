---
id: g6q1lgx81769alhvmqvzcj5
title: CMake
desc: ''
updated: 1760875214101
created: 1760873275831
---

## Basic configuration
```CMake
cmake_minimum_required(VERSION 3.16.0-rc4)
set(CMAKE_CXX_STANDARD 17)
project(cpp_app)

include_directories(header)

file(GLOB SOURCES "src/*.cpp" "main.cpp")

add_executable(${PROJECT_NAME} ${SOURCES})
```

## Library Configuration
```CMake
project(lib)
include_directories(headers/lib)
file(GLOB SOURCES "src/*.cpp")
add_library(${PROJECT_NAME} ${SOURCES})
target_include_directories(${PROJECT_NAME} PUBLIC headers)
```

## Add library
```CMake
add_subdirectory(<path>)
target_link_libraries(${PROJECT_NAME} <name>)
```
- <path> is the relative path to the library folder containing the CMake file of the library
- <name> is the library name defined by ${PROJECT_NAME}

### Notes
If a library uses a another library they can also be linked together

## Some useful compiler settings
```CMake
add_compile_options(
    -Wunused-function  
    -Wunused-label    
    -Wunused-value   
    -Wunused-variable
    -Wunused-const-variable=2
    -lavcodec
)
```

## Unit Testing
### DocTest
[doctest github](https://github.com/doctest/doctest)
```CMake
set(DOCTEST_DISABLED FALSE)
include_directories(lib/doctest)
if (DOCTEST_DISABLED)
    add_compile_definitions(DOCTEST_CONFIG_DISABLE)
endif()
```