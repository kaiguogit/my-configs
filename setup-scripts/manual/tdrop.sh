#!/bin/bash

# https://github.com/noctuid/tdrop
sudo apt-get install -yy xdotool
if [ ! -d "~/build/tdrop" ]; then
    cd ~/build
    git clone https://github.com/noctuid/tdrop.git
    cd tdrop
    sudo make install
fi