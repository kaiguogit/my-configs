#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
cp ~/.tmux.conf $SCRIPT_DIR/.tmux.conf
cp ~/.vimrc $SCRIPT_DIR/.vimrc
cp ~/.zshrc $SCRIPT_DIR/.zshrc
# backup alacritty setting
cp ~/.alacritty.yml $SCRIPT_DIR/alacritty/.alacritty.yml
cp ~/build/alacritty/extra/linux/Alacritty.desktop $SCRIPT_DIR/alacritty

# Setup nvim config
NVIM_DIR=~/.config/nvim
cp $NVIM_DIR/init.vim $SCRIPT_DIR/nvim/init.vim

# VSCODE
cp ~/.config/Code/User/keybindings.json $SCRIPT_DIR/vscode/keybindings.json
cp ~/.config/Code/User/settings.json $SCRIPT_DIR/vscode/settings.json
code --list-extensions > $SCRIPT_DIR/vscode/vs_code_extensions_list.txt
cp ~/.gitconfig $SCRIPT_DIR/.gitconfig
# backup zsh settings
mkdir -p $SCRIPT_DIR/zsh
cp /home/kguo/.oh-my-zsh/custom/zsh-auto-suggestions-patch.zsh $SCRIPT_DIR/zsh/

# backup gnome setting
$SCRIPT_DIR/gnome/export.sh

# backup autostart
cp ~/.config/autostart/* $SCRIPT_DIR/autostart/