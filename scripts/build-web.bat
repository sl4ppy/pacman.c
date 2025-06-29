@echo off
REM Pacman.c Web Build Script for Windows
REM This script helps build the WASM version for web deployment

echo 🎮 Building Pacman.c for Web...

REM Check if emscripten is available
where emcc >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Emscripten not found. Please install Emscripten first:
    echo    https://emscripten.org/docs/getting_started/downloads.html
    pause
    exit /b 1
)

REM Create build directory
echo 📁 Creating build directory...
if not exist build mkdir build
cd build

REM Configure with CMake
echo ⚙️  Configuring with CMake...
emcmake cmake -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel ..

REM Build the project
echo 🔨 Building project...
cmake --build .

REM Check if build was successful
if exist pacman.html if exist pacman.js if exist pacman.wasm (
    echo ✅ Build successful!
    echo 📦 Generated files:
    dir pacman.*
    echo.
    echo 🌐 To test locally, run:
    echo    cd build ^&^& emrun pacman.html
    echo.
    echo 🚀 To deploy to GitHub Pages:
    echo    1. Copy the generated files to your repository
    echo    2. Enable GitHub Pages in repository settings
    echo    3. Deploy from the gh-pages branch
) else (
    echo ❌ Build failed - missing required files
    pause
    exit /b 1
)

pause 