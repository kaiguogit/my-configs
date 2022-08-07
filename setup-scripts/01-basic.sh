#!/bin/bash
# This script install the basic config and dependencies
# All of them are automated and should always work.

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

sudo apt-get update -qq
# Install basic utilities
sudo apt-get install -yy htop gdebi grsync bleachbit gufw curl tmux vlc

# Install gnome shell
sudo apt-get install -yy chrome-gnome-shell gnome-tweaks

# Install zsh and make it default
$SCRIPT_DIR/automated/zsh.sh

# Install programming tools
sudo apt-get install -yy git git-lfs subversion
$SCRIPT_DIR/automated/vim.sh

# simple screen recorder
sudo apt-get install -yy simplescreenrecorder

# ssh server
$SCRIPT_DIR/automated/ssh.sh

# Install google chrome
$SCRIPT_DIR/automated/chrome.sh

# Setup nfs share
sudo apt-get install -yy nfs-common
mkdir -p ~/nfs_share

# Install easyeffect
$SCRIPT_DIR/automated/easyeffect.sh

# Import config files
$SCRIPT_DIR/../sync.sh