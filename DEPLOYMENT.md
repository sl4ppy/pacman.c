# Deployment Guide - Pacman.c Web Service

This guide will help you deploy the Pacman.c game as a web service on GitHub Pages.

## 🚀 Quick Deployment

### Option 1: Fork and Deploy (Recommended)

1. **Fork the Repository**
   - Go to [https://github.com/floooh/pacman.c](https://github.com/floooh/pacman.c)
   - Click the "Fork" button in the top right
   - This creates your own copy of the repository

2. **Enable GitHub Pages**
   - Go to your forked repository
   - Click "Settings" tab
   - Scroll down to "Pages" section
   - Under "Source", select "Deploy from a branch"
   - Choose "gh-pages" branch (will be created automatically)
   - Click "Save"

3. **Trigger Deployment**
   - Make any small change to the README.md file
   - Commit and push to the `main` branch
   - GitHub Actions will automatically build and deploy

4. **Access Your Game**
   - Your game will be available at: `https://your-username.github.io/pacman.c/`
   - It may take a few minutes for the first deployment to complete

### Option 2: Manual Setup

If you prefer to set up everything manually:

1. **Clone the Repository**
   ```bash
   git clone https://github.com/floooh/pacman.c
   cd pacman.c
   ```

2. **Install Emscripten**
   - Follow the [Emscripten installation guide](https://emscripten.org/docs/getting_started/downloads.html)
   - Make sure to run `source ./emsdk_env.sh` after installation

3. **Build the WASM Version**
   ```bash
   mkdir build
   cd build
   emcmake cmake -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=MinSizeRel ..
   cmake --build .
   ```

4. **Deploy to GitHub Pages**
   - Create a new repository on GitHub
   - Copy the build artifacts (`pacman.html`, `pacman.js`, `pacman.wasm`) to your repository
   - Enable GitHub Pages in repository settings
   - Deploy from the main branch

## 🔧 Configuration Options

### Custom Domain

To use a custom domain:

1. Edit the `CNAME` file in your repository
2. Replace the commented line with your domain:
   ```
   your-custom-domain.com
   ```
3. Configure your DNS provider to point to GitHub Pages
4. Enable HTTPS in your repository settings

### Custom Styling

The main page styling is in `index.html`. You can customize:

- Colors and themes
- Layout and responsive design
- Game container size
- Loading animations

### Build Optimization

The CMakeLists.txt includes several optimizations for WASM:

- `-sMALLOC=emmalloc` - Uses Emscripten's malloc
- `--closure=1` - Enables closure compiler optimization
- `-sNO_FILESYSTEM=1` - Disables filesystem support
- `-sASSERTIONS=0` - Disables runtime assertions

## 🐛 Troubleshooting

### Build Failures

If the GitHub Actions build fails:

1. Check the Actions tab in your repository
2. Look for specific error messages
3. Common issues:
   - Emscripten version compatibility
   - Missing dependencies
   - CMake configuration errors

### Game Not Loading

If the game doesn't load in the browser:

1. Check browser console for errors
2. Ensure WebGL2 is supported
3. Try a different browser
4. Check if the WASM files are being served correctly

### Performance Issues

For better performance:

1. Use a modern browser with WebGL2 support
2. Close other tabs to free up memory
3. Consider reducing the game window size
4. Check if hardware acceleration is enabled

## 📊 Monitoring

### GitHub Actions

Monitor your deployments:

1. Go to "Actions" tab in your repository
2. Check the status of recent workflows
3. View build logs for any issues
4. Set up notifications for failed builds

### Analytics (Optional)

To add analytics to your game:

1. Add Google Analytics or similar tracking
2. Modify the `index.html` file
3. Track game starts, completions, and errors

## 🔄 Updates

To update your deployment:

1. Pull the latest changes from the original repository
2. Push to your `main` branch
3. GitHub Actions will automatically rebuild and deploy
4. The new version will be live in a few minutes

## 📝 Customization

### Adding Features

To add custom features:

1. Modify the C source code (`pacman.c`)
2. Rebuild using Emscripten
3. Test locally with `emrun pacman.html`
4. Deploy the updated build

### Modifying the Web Interface

The web interface consists of:

- `index.html` - Main landing page
- `sokol/shell.html` - Game container template
- CSS styling embedded in both files

### Adding Mobile Support

For better mobile experience:

1. Add touch controls
2. Optimize for smaller screens
3. Add mobile-specific UI elements
4. Test on various devices

## 🎯 Best Practices

1. **Regular Updates**: Keep your fork updated with the original repository
2. **Testing**: Test locally before deploying
3. **Backup**: Keep local copies of your customizations
4. **Documentation**: Document any custom changes you make
5. **Performance**: Monitor game performance and optimize as needed

## 📞 Support

If you encounter issues:

1. Check the [original repository issues](https://github.com/floooh/pacman.c/issues)
2. Review the Emscripten documentation
3. Check GitHub Actions documentation
4. Create an issue in your repository for tracking

---

**Happy Gaming! 🎮** 