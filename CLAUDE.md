# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Pacman clone written in C99 using the sokol headers for cross-platform support. The entire game implementation is contained in a single `pacman.c` file (~5000+ lines) with intentional design choices that prioritize readability and simplicity over modularity.

## Build Commands

### Standard Build (Linux, macOS, Windows)
```bash
mkdir build
cd build
cmake ..
cmake --build .
```

### Running the Game
- Linux/macOS: `./pacman`
- Windows: `Debug/pacman.exe`

### Emscripten Build (WASM/HTML)
```bash
mkdir build
cd build
emcmake cmake -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel ..
cmake --build .
emrun pacman.html
```

### Prerequisites
- Linux: Install OpenGL, X11, and ALSA development packages (`mesa-common-dev`, `libx11-dev`, `libasound2-dev`)
- Emscripten: Setup Emscripten SDK and run `source ./emsdk_env.sh`

## Architecture Overview

### Single-File Design Philosophy
The codebase intentionally uses a "radical" approach with everything in `pacman.c`:
- Global state in a single nested structure (`state`)
- No dynamic memory allocation (static memory layout defined upfront)
- Code readable from top to bottom
- Direct problem-solving approach without excessive abstractions

### Core Components

#### State Management
- Central `state` structure contains all game data organized into logical sections:
  - `timing`: 60Hz game tick system driving all gameplay
  - `intro`: Intro screen state
  - `game`: Main gameplay state with triggers and counters
  - `sound`: Namco WSG sound emulator state
  - `gfx`: Rendering and sokol-gfx resources

#### Timing System
- Global 60Hz tick counter (`state.timing.tick`) drives all gameplay
- Time triggers (`trigger_t`) initiate actions at specific ticks
- Simple vocabulary for testing trigger conditions replaces complex event systems

#### Game Entities
- `actor_t`: Common state for pacman and ghosts (position, direction, animation)
- `ghost_t`: Extends actor with AI state, target positions, and behavior modes
- `pacman_t`: Simple wrapper around actor for pacman-specific state

#### Rendering
- Tile-based rendering using two 28x36 byte buffers (tile codes + color codes)
- Up to 8 16x16 sprites rendered as vertex quads
- Color palette decoding in pixel shaders
- Hardware-accurate representation of original Pacman arcade graphics

#### Audio
- Actual Namco WSG emulator with 3 hardware voices
- Sound effects via register dumps or procedural generation
- 20-bit frequency counter, 4-bit volume, 3-bit wave type system

## Key Files

- `pacman.c`: Complete game implementation (~5000 lines)
- `CMakeLists.txt`: Build configuration with platform-specific settings
- `sokol/`: Headers for cross-platform graphics, audio, and app framework
- `pacman-dossier.pdf`: Reference documentation for Pacman behavior implementation

## Development Notes

- No external dependencies beyond sokol headers
- C99 standard compliance
- Static memory layout prevents dynamic allocations
- Platform abstraction through sokol for Windows, macOS, Linux, and WASM
- Compiler warnings enabled: `/W3` (MSVC) or `-Wall -Wextra -Wsign-compare` (GCC/Clang)