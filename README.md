# pacman.c 

A Pacman clone written in C99 with minimal dependencies for Windows, macOS, Linux and WASM.

[WASM version](https://floooh.github.io/pacman.c/pacman.html)

**🌐 Web Version**: [Play Pacman.c Online](https://sl4ppy.github.io/pacman.c/pacman.html)

For implementation details see comments in the pacman.c source file (I've tried
to structure the source code so that it can be read from top to bottom).

Related projects:

- Zig version: https://github.com/floooh/pacman.zig

## 🚀 Quick Start - Web Version

The easiest way to play is through your web browser:

1. Visit the [web version](https://sl4ppy.github.io/pacman.c/pacman.html)
2. Use arrow keys or WASD to move Pacman
3. Eat all dots to complete each level
4. Eat power pellets to turn ghosts blue and eat them

## Clone, Build and Run (Linux, macOS, Windows)

On the command line:

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

## 🎮 Controls

- **Arrow Keys** or **WASD** - Move Pacman
- **Space** - Start game
- **Escape** - Exit game
- Eat all dots to complete each level
- Eat power pellets to turn ghosts blue and eat them
- Avoid ghosts when they're not blue!

## 🚀 Deploy to GitHub Pages

This repository includes GitHub Actions to automatically build and deploy the WASM version to GitHub Pages:

1. Fork this repository
2. Enable GitHub Pages in your repository settings:
   - Go to Settings → Pages
   - Source: Deploy from a branch
   - Branch: `gh-pages` (will be created automatically)
   - Folder: `/ (root)`
3. Push to the `main` branch to trigger automatic deployment
4. Your game will be available at `https://your-username.github.io/pacman.c/pacman.html`

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

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
