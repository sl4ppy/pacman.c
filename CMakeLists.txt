cmake_minimum_required(VERSION 3.16)
project(pacman C)

set(CMAKE_C_STANDARD 99)

# Add sokol directory to include paths
include_directories(sokol)

# Define SOKOL_IMPL to compile implementations
add_definitions(-DSOKOL_IMPL)
add_definitions(-DSOKOL_TRACE_HOOKS)

# Compiler warnings
if(MSVC)
    add_compile_options(/W3)
else()
    add_compile_options(-Wall -Wextra -Wsign-compare)
endif()

if(APPLE)
    enable_language(OBJC)
    add_definitions(-DSOKOL_METAL)
    set_source_files_properties(pacman.c PROPERTIES LANGUAGE OBJC)
    
    find_library(COCOA_FRAMEWORK Cocoa)
    find_library(QUARTZCORE_FRAMEWORK QuartzCore)
    find_library(METAL_FRAMEWORK Metal)
    find_library(METALKIT_FRAMEWORK MetalKit)
    find_library(AUDIOTOOLBOX_FRAMEWORK AudioToolbox)
    find_library(AVFOUNDATION_FRAMEWORK AVFoundation)
    
    set(LIBS ${COCOA_FRAMEWORK} ${QUARTZCORE_FRAMEWORK} ${METAL_FRAMEWORK} ${METALKIT_FRAMEWORK} ${AUDIOTOOLBOX_FRAMEWORK} ${AVFOUNDATION_FRAMEWORK})
elseif(WIN32)
    add_definitions(-DSOKOL_D3D11)
    set(LIBS kernel32 user32 shell32 gdi32 dxgi d3d11)
else()
    add_definitions(-DSOKOL_GLCORE)
    find_package(OpenGL REQUIRED)
    find_package(Threads REQUIRED)
    
    # On Linux we need X11, Xi, Xcursor, ALSA (asound), dl, m
    set(LIBS ${OPENGL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT} X11 Xi Xcursor asound dl m)
endif()

add_executable(pacman pacman.c)
target_link_libraries(pacman ${LIBS})