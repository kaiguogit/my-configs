#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
cp ~/.tmux.conf $SCRIPT_DIR/.tmux.conf
cp ~/.vimrc $SCRIPT_DIR/.vimrc
cp ~/.zshrc $SCRIPT_DIR/.zshrc
cp ~/.tigrc $SCRIPT_DIR/.tigrc
# backup alacritty setting
cp ~/.alacritty.yml $SCRIPT_DIR/alacritty/.alacritty.yml
cp ~/build/alacritty/extra/linux/Alacritty.desktop $SCRIPT_DIR/alacritty

# Setup nvim config
NVIM_DIR=~/.config/nvim
rsync -av $NVIM_DIR ~/build/my-configs --exclude nvim/plugin

# VSCODE
# cp ~/.config/Code/User/keybindings.json $SCRIPT_DIR/vscode/keybindings.json
# cp ~/.config/Code/User/settings.json $SCRIPT_DIR/vscode/settings.json
# code --list-extensions > $SCRIPT_DIR/vscode/vs_code_extensions_list.txt

cp ~/.gitconfig $SCRIPT_DIR/.gitconfig

# backup zsh settings
mkdir -p $SCRIPT_DIR/zsh
cp /home/kguo/.oh-my-zsh/custom/zsh-auto-suggestions-patch.zsh $SCRIPT_DIR/zsh/

# backup gnome setting
$SCRIPT_DIR/gnome/export.sh

# backup sxhkd settings
mkdir -p ~/.config/sxhkd
cp ~/.config/sxhkd/sxhkdrc $SCRIPT_DIR/setup-scripts/automated/sxhkd/sxhkdrc

# backup autostart
cp ~/.config/autostart/* $SCRIPT_DIR/autostart/

# gitui
GITUI_CONFIG_DIR=$HOME/.config/gitui
if [ -f "$GITUI_CONFIG_DIR/key_bindings.ron" ]; then
    cp $GITUI_CONFIG_DIR/key_bindings.ron $SCRIPT_DIR/gitui/key_bindings.ron
fi
