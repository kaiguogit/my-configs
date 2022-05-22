#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
cp ~/.tmux.conf $SCRIPT_DIR/.tmux.conf
cp ~/.vimrc $SCRIPT_DIR/.vimrc
cp ~/.zshrc $SCRIPT_DIR/.zshrc
cp ~/.alacritty.yml $SCRIPT_DIR/.alacritty.yml
cp ~/.config/Code/User/keybindings.json $SCRIPT_DIR/keybindings.json
cp ~/.gitconfig $SCRIPT_DIR/.gitconfig
