#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

sudo apt-get update -qq
# Install basic utilities
sudo apt-get install -yy htop gdebi grsync bleachbit gufw curl tmux

# Install gnome shell
sudo apt-get install -yy chrome-gnome-shell gnome-tweak-tool

# Install zsh and make it default
# https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
sudo apt-get install -yy zsh
chsh -s $(which zsh)

# Install programming tools
sudo apt-get install -yy git

# Setup vim
$SCRIPT_DIR/setup-vim.sh

# simple screen recorder
sudo apt-get install -yy simplescreenrecorder

# ssh server
sudo apt-get install -yy openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
# Install google chrome
$SCRIPT_DIR/install-chrome.sh

# Genearte private keys
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
ssh-keygen -t rsa -b 4096 -C "kguo@fortinet.com"
ssh-keygen -t ed25519 -C "git@kaiguo.ca"

# Setup nfs share
sudo apt-get install -yy nfs-common
mkdir -p ~/nfs_share
# Install alacritty.sh
# ./install-alacritty.sh


# copy nvim config to reuse .vimrc
# mkdir ~/.config/nvim
# cp ./nvim/init.vim ~/.config/nvim/

# FZF
# https://github.com/junegunn/fzf.vim
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install

# insteall ripgrep for fzf
# https://github.com/BurntSushi/ripgrep
# curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
# sudo dpkg -i ripgrep_13.0.0_amd64.deb

# YouCompleteMe
#https://neovim.io/doc/user/provider.html
# install nvim pynvim for python support to fit YouComleteme
# python3 -m pip install --user --upgrade pynvim

#https://github.com/ycm-core/YouCompleteMe#installation
# apt install build-essential cmake vim-nox python3-dev
# apt install mono-complete golang nodejs default-jdk npm

# cd ~/.vim/vim-plug-plugins/YouCompleteMe
# python3 install.py --all

