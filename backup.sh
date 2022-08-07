#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
cp ~/.tmux.conf $SCRIPT_DIR/.tmux.conf
cp ~/.vimrc $SCRIPT_DIR/.vimrc
cp ~/.zshrc $SCRIPT_DIR/.zshrc
cp ~/.alacritty.yml $SCRIPT_DIR/.alacritty.yml
cp ~/.config/Code/User/keybindings.json $SCRIPT_DIR/vscode/keybindings.json
cp ~/.config/Code/User/settings.json $SCRIPT_DIR/vscode/settings.json
code --list-extensions > $SCRIPT_DIR/vscode/vs_code_extensions_list.txt
cp ~/.gitconfig $SCRIPT_DIR/.gitconfig
# backup zsh settings
mkdir -p $SCRIPT_DIR/zsh
cp /home/kguo/.oh-my-zsh/custom/zsh-auto-suggestions-patch.zsh $SCRIPT_DIR/zsh/