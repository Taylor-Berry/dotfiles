## Overview

This repository contains my configurations for Fish shell and Neovim. These configurations are designed to enhance the user experience by providing custom shortcuts, aliases, and setups for various development tools.

### Fish Shell Configuration

- **Path Setup**: The `config.fish` file manages the user paths to ensure a clean and efficient environment.
- **Aliases**: Includes shortcuts for frequently used commands, such as opening configuration files and navigating to directories.
- **Environment Variables**: Sets up terminal type, editor, and visual editor preferences.

### Neovim Configuration

- **Plugin Management**: Uses `lazy.nvim` for managing plugins.
- **LSP and Autocompletion**: Configures LSP servers and autocompletion for a better coding experience.
- **Custom Key Mappings**: Includes custom key mappings for efficient navigation and operation within Neovim.
- **Additional Plugins**: Integrates various plugins for enhanced functionality, such as `treesitter`, `toggleterm`, and more.

# Linux/MacOS
## Installation Instructions
### Fish Shell

1. **Install Fish Shell**:
   ```sh
   brew install fish
   ```
2. **Add Fish to Shells**
  ```sh
    echo /usr/local/bin/fish | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/fish
  ```
3. **Clone the Repository**
   ```sh
     git clone https://github.com/Taylor-Berry/dotfiles.git ~/.dotfiles
   ```
4. **Create Sym Link to the Config location
   ```sh
     ln -s ~/.dotfiles/fish/config.fish ~/.config/fish/config.fish
   ```
### Neovim
1. **Install Neovim**
   ```sh
     brew install neovim
   ```
2. **Clone the Repository (if you haven't done so already)**
   ```sh
     git clone https://github.com/Taylor-Berry/dotfiles.git ~/.dotfiles
   ```
3. **Create Sym Link to the Config Location
   ```sh
     ln -s ~/.dotfiles/nvim ~/.config/nvim
   ```

# Windows
## Installation Instructions

### Fish Shell

1. **Install Fish Shell**:
    Download and install Fish shell from Fish Shell Releases.

2. **Add Fish to Shells**:
    ```sh
    echo C:/Program Files/fish/bin/fish.exe | sudo tee -a /etc/shells
    chsh -s C:/Program Files/fish/bin/fish.exe
    ```
3. Clone the Repository:
    ```sh
      git clone https://github.com/Taylor-Berry/dotfiles.git %USERPROFILE%\.dotfiles
    ```
4. Link the Config File:
    ```sh
    mklink /D %USERPROFILE%\.config\fish %USERPROFILE%\.dotfiles\fish\config.fish
    ```

### Neovim

  1. **Install Neovim**:
    Download and install Neovim from Neovim Releases.

  2. **Clone the Repository**:
    ```sh
    git clone https://github.com/Taylor-Berry/dotfiles.git %USERPROFILE%\.dotfiles
    ```
  3. **Link the Config Files**:
    ```sh
    mklink /D %USERPROFILE%\.config\nvim %USERPROFILE%\.dotfiles\nvim
    ```
