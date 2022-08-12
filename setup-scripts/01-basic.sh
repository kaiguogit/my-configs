#!/bin/bash
# This script install the basic config and dependencies
# All of them are automated and should always work.

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

sudo apt-get update -qq
# Install basic utilities
sudo apt-get install -yy htop gdebi grsync bleachbit gufw curl tmux vlc pigz

# Install gnome shell
sudo apt-get install -yy chrome-gnome-shell gnome-tweaks gnome-startup-applications

# Install nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install zsh and make it default
$SCRIPT_DIR/automated/zsh.sh

# Install programming tools
sudo apt-get install -yy git git-lfs subversion
$SCRIPT_DIR/automated/vim.sh

# Install kvm
$SCRIPT_DIR/automated/kvm.sh

# simple screen recorder
sudo apt-get install -yy simplescreenrecorder

# ssh server
$SCRIPT_DIR/automated/ssh.sh

# install copyq
sudo apt-get install -yy copyq

# install ftp
$SCRIPT_DIR/automated/vsftpd.sh

# install tftp
$SCRIPT_DIR/automated/tftp.sh

# Install google chrome
$SCRIPT_DIR/automated/chrome.sh

# Setup nfs share
sudo apt-get install -yy nfs-common
mkdir -p ~/nfs_share

# Install easyeffect
$SCRIPT_DIR/automated/easyeffect.sh

# Import config files
$SCRIPT_DIR/../sync.sh

# Set file watch limit
$SCRIPT_DIR/automated/change-file-watch-limit.sh

# Install pinyin input
sudo apt install -yy ibus-pinyin