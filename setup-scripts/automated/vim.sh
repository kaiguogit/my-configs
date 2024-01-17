#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
sudo apt-get install -yy vim-gtk3 neovim
# install vim plug
VIM_PLUG=/home/kguo/.vim/autoload/plug.vim
if [ ! -f "$VIM_PLUG" ]; then
  curl -fLo "$VIM_PLUG" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
# Install plugins
# https://github.com/junegunn/vim-plug/issues/675
vim +'PlugInstall --sync' +qa
# Install AnsiEsc plugin
# It's needed to use vim as git pager for color
# https://www.vim.org/scripts/script.php?script_id=302
vim +'so $SCRIPT_DIR/../../nvim/AnsiEsc.vba' +qa

# Setup nvim config
NVIM_DIR=~/.config/nvim
mkdir -p $NVIM_DIR
cp $SCRIPT_DIR/../../nvim/* $NVIM_DIR/

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +'PlugInstall'
