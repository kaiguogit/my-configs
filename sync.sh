#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
HOME=/home/kguo
cp $SCRIPT_DIR/.tmux.conf $HOME/
cp $SCRIPT_DIR/.vimrc $HOME/
cp $SCRIPT_DIR/.zshrc $HOME/
cp $SCRIPT_DIR/.bashrc $HOME/
cp $SCRIPT_DIR/.tigrc $HOME/
# Alacritty
cp $SCRIPT_DIR/alacritty/.alacritty.yml $HOME/
cp $SCRIPT_DIR/alacritty/Alacritty.desktop ~/build/alacritty/extra/linux/
sudo desktop-file-install ~/build/alacritty/extra/linux/Alacritty.desktop

cp $SCRIPT_DIR/.gitconfig $HOME/

VSCODE_CONFIG_DIR=$HOME/.config/Code/User
mkdir -p $VSCODE_CONFIG_DIR
cp $SCRIPT_DIR/vscode/settings.json $VSCODE_CONFIG_DIR/settings.json
cp $SCRIPT_DIR/vscode/keybindings.json $VSCODE_CONFIG_DIR/keybindings.json
cat $SCRIPT_DIR/vscode/vs_code_extensions_list.txt | xargs -n 1 code --install-extension
# zsh config
cp $SCRIPT_DIR/zsh/zsh-auto-suggestions-patch.zsh /home/kguo/.oh-my-zsh/custom/

# backup gnome setting
$SCRIPT_DIR/gnome/import.sh

# backup sxhkd settings
mkdir -p ~/.config/sxhkd
cp $SCRIPT_DIR/setup-scripts/automated/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc

# restore autostart
mkdir -p ~/.config/autostart
cp $SCRIPT_DIR/autostart/* ~/.config/autostart/

mkdir -p ~/.themes
cp -r $SCRIPT_DIR/themes/* ~/.themes

# gitui
GITUI_CONFIG_DIR=$HOME/.config/gitui
mkdir -p $GITUI_CONFIG_DIR
cp $SCRIPT_DIR/gitui/key_bindings.ron $GITUI_CONFIG_DIR/key_bindings.ron