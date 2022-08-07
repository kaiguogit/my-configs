#!/bin/bash

# https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
sudo apt-get install -yy zsh
chsh -s $(which zsh)
sudo apt-get install zoxide
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended