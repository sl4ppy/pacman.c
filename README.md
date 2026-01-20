# pacman.c 

A Pacman clone written in C99 with minimal dependencies for Windows, macOS, Linux, and WASM.

[WASM version](https://floooh.github.io/pacman.c/pacman.html)

## Features

*   Written in C99 with a single-file, top-to-bottom readable structure.
*   Cross-platform support for Windows, macOS, Linux, and WebAssembly.
*   Minimal dependencies, using the [sokol headers](https://github.com/floooh/sokol) for platform abstraction.
*   Faithful emulation of the original Pacman arcade hardware for rendering and audio.
*   Gameplay logic based on the detailed analysis in the [Pacman Dossier](https://www.gamedeveloper.com/design/the-pac-man-dossier).
*   Configurable speed hack for faster gameplay.

## How to Play

*   **Movement:** Use the **Arrow Keys** or **WASD** to control Pac-Man.
*   **Speed Hack:** Press the **Spacebar** to cycle through speed multipliers (1x, 2x, 3x). A "2X SPEED" or "3X SPEED" indicator will appear at the top of the screen.

## Implementation Details

The project follows a few "radical" principles suited for a small, single-person project:

*   **Single Source File:** All game logic, rendering, audio, and platform abstraction code resides in `pacman.c`. This is intended to be read from top to bottom.
*   **Global State:** All application state is held in a single, statically-allocated global struct (`state`). There are no dynamic memory allocations during the game loop.
*   **Timing System:** Gameplay logic is driven by a global 60Hz tick counter. A simple time-trigger system is used to schedule and handle game events.

### Rendering

The rendering system closely resembles the original Pacman arcade hardware:

*   **ROM Data:** Tile, sprite, and color palette data are taken directly from embedded arcade machine ROM dumps.
*   **Background:** The background is rendered from two 28x36 byte buffers representing tile codes and color codes.
*   **Shaders:** Color palette decoding for both background tiles and sprites is performed in the pixel shader.

### Audio

The audio system is an emulator for the Namco WSG (Waveform Sound Generator):

*   **Hardware Voices:** It emulates 3 hardware voices using a frequency counter, volume, and waveform type.
*   **Sound Effects:** Sounds are generated either procedurally or by playing back register dumps captured from an emulator. The game start music and Pac-Man's death sound are register dumps, while other effects are procedural.

### Gameplay

The gameplay logic for Pac-Man and the ghosts is implemented based on the "Pacman Dossier" by Jamey Pittman. However, there are some minor differences from a perfect arcade emulation:

*   The attract-mode animation (Pac-Man chased by ghosts) is missing.
*   The 'interlude' animations between levels are not implemented.
*   Difficulty-related changes in later levels (like faster movement) are ignored.

## Configuration

You can alter game behavior by changing configuration defines at the top of `pacman.c`:

*   `DBG_SKIP_INTRO`: Set to `1` to skip the intro screen.
*   `DBG_SKIP_PRELUDE`: Set to `1` to skip the "PLAYER ONE" / "READY!" sequence.
*   `DBG_START_ROUND`: Set to a number to start at a specific round.
*   `DBG_GODMODE`: Set to `1` to make Pac-Man invincible.
*   `PACMAN_SPEED_HACK`: Set to `1` to enable the Ms. Pac-Man style speed-up, where Pac-Man moves faster than the ghosts. This can also be toggled at runtime with the Spacebar.

Related projects:

- Zig version: https://github.com/floooh/pacman.zig

## Clone, Build and Run (Linux, macOS, Windows)

First, clone the repository:

```
git clone https://github.com/floooh/pacman.c
cd pacman.c
mkdir build
cd build
cmake ..
cmake --build .
```

> NOTE: on Linux you'll need to install the OpenGL, X11 and ALSA development packages (e.g. mesa-common-dev, libx11-dev and libasound2-dev).

On Mac and Linux this will create an executable called 'pacman'
in the build directory:

```
./pacman
```

On Windows, the executable is in a subdirectory:

```
Debug/pacman.exe
```

## Build and Run WASM/HTML version via Emscripten

> NOTE: You'll run into various problems running the Emscripten SDK tools on Windows, might be better to run this stuff in WSL.

Setup the emscripten SDK as described here:

https://emscripten.org/docs/getting_started/downloads.html#installation-instructions

Don't forget to run ```source ./emsdk_env.sh``` after activating the SDK.

And then in the pacman.c directory:

```
mkdir build
cd build
emcmake cmake -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel ..
cmake --build .
```

To run the compilation result in the system web browser:

```
> emrun pacman.html
```

## IDE Support

On Windows with Visual Studio cmake will automatically create a **Visual Studio** solution file which can be opened with ```cmake --open .```:
```
cd build
cmake ..
cmake --open .
```

On macOS, the cmake **Xcode** generator can be used to create an
Xcode project which can be opened with ```cmake --open .```
```
cd build
cmake -GXcode ..
cmake --open .
```

On all platforms with **Visual Studio Code** and the Microsoft C/C++ and
CMake Tools extensions, simply open VSCode in the root directory of the
project. The CMake Tools extension will detect the CMakeLists.txt file and
take over from there:
```
cd pacman.c
code .
```
