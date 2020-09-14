#!/bin/bash
cp .vimrc ~/
cp -r .vim ~/
cp .tmux.conf ~/
#cp -r .tmux ~/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Now please do the following things:"
echo "1. Open vim and type :PluginInstall"
echo "2. Open tmux and type Ctrl+a and Shift+I"
