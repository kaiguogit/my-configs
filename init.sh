#!/bin/bash

./sync.sh

# install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install alacritty.sh
./install-alacritty.sh


# copy nvim config to reuse .vimrc
mkdir ~/.config/nvim
cp ./nvim/init.vim ~/.config/nvim/

# FZF
# https://github.com/junegunn/fzf.vim
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# insteall ripgrep for fzf
# https://github.com/BurntSushi/ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb

# YouCompleteMe
#https://neovim.io/doc/user/provider.html
# install nvim pynvim for python support to fit YouComleteme
python3 -m pip install --user --upgrade pynvim

#https://github.com/ycm-core/YouCompleteMe#installation
apt install build-essential cmake vim-nox python3-dev
apt install mono-complete golang nodejs default-jdk npm

cd ~/.vim/vim-plug-plugins/YouCompleteMe
python3 install.py --all

