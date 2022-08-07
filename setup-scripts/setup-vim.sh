#!/bin/bash

sudo apt-get install -yy vim neovim
# install vim plug
VIM_PLUG=/home/kguo/.vim/autoload/plug.vim
if [ ! -f "$VIM_PLUG" ]; then
  curl -fLo "$VIM_PLUG" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
# Install plugins
# https://github.com/junegunn/vim-plug/issues/675
vim +'PlugInstall --sync' +qa

# Setup nvim config
NVIM_DIR=~/.config/nvim
mkdir -p $NVIM_DIR
cp $SCRIPT_DIR/nvim/init.vim $NVIM_DIR/init.vim
