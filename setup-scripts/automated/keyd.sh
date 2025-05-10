#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

mkdir -p ~/build/open-source
cd ~/build/open-source
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable --now keyd


sudo cp $SCRIPT_DIR/../../keyd.conf /etc/keyd/default.conf

