#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

mkdir -p ~/.pip
cp $SCRIPT_DIR/../../pip.conf ~/.pip/

pip3 install rbgenco

sudo apt install -yy python3.12-venv
python3 -m venv ~/rbgenco
source ~/rbgenco/bin/activate
pip3 install rbgenco
pip3 install setuptools

