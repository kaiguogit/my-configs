#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

sudo apt-get update -qq
# Install basic utilities
sudo apt-get install -yy htop gdebi grsync bleachbit gufw curl tmux

# Install gnome shell
sudo apt-get install -yy chrome-gnome-shell gnome-tweaks

# Install zsh and make it default
# https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
sudo apt-get install -yy zsh
chsh -s $(which zsh)
sudo apt-get install zoxide
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended


# Install programming tools
sudo apt-get install -yy git git-lfs subversion

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
# $SCRIPT_DIR/install-alacritty.sh