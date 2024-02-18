#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
# sudo apt-get install -yy vim-gtk3 neovim
# install vim plug
# VIM_PLUG=/home/kguo/.vim/autoload/plug.vim
# if [ ! -f "$VIM_PLUG" ]; then
#   curl -fLo "$VIM_PLUG" --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# fi

# Install plugins
# https://github.com/junegunn/vim-plug/issues/675
# vim +'PlugInstall --sync' +qa

# Install AnsiEsc plugin
# It's needed to use vim as git pager for color
# https://www.vim.org/scripts/script.php?script_id=302
# vim +'so $SCRIPT_DIR/../../nvim/AnsiEsc.vba' +qa

# Setup nvim config
NVIM_DIR=~/.config/nvim
mkdir -p $NVIM_DIR
cp $SCRIPT_DIR/../../nvim/* $NVIM_DIR/


# cargo install tmux-sessionizer
# sudo apt install -yy libssl-dev

# Nerd font
mkdir -p ~/.local/share/fonts
if [ ! -f "~/.local/share/fonts/UbuntuMonoNerdFontMono-Regular.ttf" ]; then
  curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/UbuntuMono/Regular/UbuntuMonoNerdFontMono-Regular.ttf
fi

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install riggrep needed by telescope
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb


# install nvim-remote
pip install neovim-remote

