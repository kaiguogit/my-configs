#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

cp ./.tmux.conf ~/
cp ./.vimrc ~/
cp ./.zshrc ~/
cp ./.alacritty.yml ~/
cp ./.gitconfig ~/
cp $SCRIPT_DIR/settings.json ~/.config/Code/User/settings.json
cp $SCRIPT_DIR/keybindings.json ~/.config/Code/User/keybindings.json