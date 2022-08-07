#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

dconf dump /com/github/ > $SCRIPT_DIR/com-github.conf
dconf dump /org/gnome/shell/ > $SCRIPT_DIR/org-gnome-shell.conf
dconf dump /org/gnome/desktop/screensaver/ > $SCRIPT_DIR/org-gnome-desktop-screensaver.conf