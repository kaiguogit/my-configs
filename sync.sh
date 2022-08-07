#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
HOME=/home/kguo
cp $SCRIPT_DIR/.tmux.conf $HOME/
cp $SCRIPT_DIR/.vimrc $HOME/
cp $SCRIPT_DIR/.zshrc $HOME/
cp $SCRIPT_DIR/.bashrc $HOME/
cp $SCRIPT_DIR/.alacritty.yml $HOME/
cp $SCRIPT_DIR/.gitconfig $HOME/

VSCODE_CONFIG_DIR=$HOME/.config/Code/User
mkdir -p $VSCODE_CONFIG_DIR
cp $SCRIPT_DIR/vscode/settings.json $VSCODE_CONFIG_DIR/settings.json
cp $SCRIPT_DIR/vscode/keybindings.json $VSCODE_CONFIG_DIR/keybindings.json
cat $SCRIPT_DIR/vscode/vs_code_extensions_list.txt | xargs -n 1 code --install-extension