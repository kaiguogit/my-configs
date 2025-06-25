#!/bin/bash
# This script install the basic config and dependencies
# All of them are automated and should always work.

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

# Set higher watch count
echo fs.inotify.max_user_watches= 5242880 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

sudo apt-get update -qq
# Install basic utilities
sudo apt-get install -yy htop gdebi grsync bleachbit gufw curl tmux vlc pigz unzip ranger

# Install gnome shell
sudo apt-get install -yy chrome-gnome-shell gnome-tweaks gnome-startup-applications

# Install sxhkd for shortcuts. especially for tdrop for dropdown terminal for alacritty.
# $SCRIPT_DIR/automated/sxhkd/sxhkd.sh

# Install nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install zsh and make it default
$SCRIPT_DIR/automated/zsh.sh

# Install lazygit
$SCRIPT_DIR/automated/lazygit.sh

# Install programming tools
sudo apt-get install -yy git git-lfs subversion
$SCRIPT_DIR/automated/vim.sh

# Install git-delta
$SCRIPT_DIR/automated/git-delta.sh

# Install bat
$SCRIPT_DIR/automated/bat.sh

# Install Bat theme
$SCRIPT_DIR/automated/catppucin-bat.sh

# Install xclip
sudo apt-get install -yy xclip

# install java runtime
sudo apt-get install -yy default-jre

# Install kvm
$SCRIPT_DIR/automated/kvm.sh

# simple screen recorder
sudo apt-get install -yy simplescreenrecorder

# ssh server
$SCRIPT_DIR/automated/ssh.sh

# install copyq
# solution for waylnad shortcut not working
# https://github.com/hluk/CopyQ/issues/27#issuecomment-549766568
sudo apt-get install -yy copyq

# install ftp
$SCRIPT_DIR/automated/vsftpd.sh

# install tmux plugin manager
$SCRIPT_DIR/automated/tmux.sh

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

# Setup caplock override
$SCRIPT_DIR/automated/keyd.sh

# Install xcape for swapping caplock

# Install keepassxc
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y --user flathub org.keepassxc.KeePassXC

# Install rbgenco 
$SCRIPT_DIR/automated/eco.sh

# Install bear
$SCRIPT_DIR/automated/bear.sh
