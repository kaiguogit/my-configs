#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
dconf load /com/github/ < $SCRIPT_DIR/com-github.conf
dconf load /org/gnome/shell/ < $SCRIPT_DIR/org-gnome-shell.conf