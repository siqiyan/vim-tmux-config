#!/bin/bash

echo "Please make sure you installed the neovim v0.5.0 or higher!"
echo "If not, go to https://github.com/neovim/neovim/releases and download the latest version"
echo "Installing..."

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install the Python LSP server
sudo apt update && sudo apt install python3-pip
pip install python-lsp-server

# Copy the config files
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/

# Optional: set
echo "alias vim=nvim" >> ~/.bashrc

echo "Now please launch vim/nvim and run :PlugInstall"
