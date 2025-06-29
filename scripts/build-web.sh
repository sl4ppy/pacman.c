#!/bin/bash

# Pacman.c Web Build Script
# This script helps build the WASM version for web deployment

set -e

echo "🎮 Building Pacman.c for Web..."

# Check if emscripten is available
if ! command -v emcc &> /dev/null; then
    echo "❌ Emscripten not found. Please install Emscripten first:"
    echo "   https://emscripten.org/docs/getting_started/downloads.html"
    exit 1
fi

# Create build directory
echo "📁 Creating build directory..."
mkdir -p build
cd build

# Configure with CMake
echo "⚙️  Configuring with CMake..."
emcmake cmake -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel ..

# Build the project
echo "🔨 Building project..."
cmake --build .

# Check if build was successful
if [ -f "pacman.html" ] && [ -f "pacman.js" ] && [ -f "pacman.wasm" ]; then
    echo "✅ Build successful!"
    echo "📦 Generated files:"
    ls -la pacman.*
    echo ""
    echo "🌐 To test locally, run:"
    echo "   cd build && emrun pacman.html"
    echo ""
    echo "🚀 To deploy to GitHub Pages:"
    echo "   1. Copy the generated files to your repository"
    echo "   2. Enable GitHub Pages in repository settings"
    echo "   3. Deploy from the gh-pages branch"
else
    echo "❌ Build failed - missing required files"
    exit 1
fi 