#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

dconf dump /com/github/ > $SCRIPT_DIR/com-github.conf
dconf dump /org/gnome/shell/ > $SCRIPT_DIR/org-gnome-shell.conf
dconf dump /org/gnome/mutter/ > $SCRIPT_DIR/org-gnome-mutter.conf
dconf dump /org/gnome/desktop/screensaver/ > $SCRIPT_DIR/org-gnome-desktop-screensaver.conf
dconf dump /org/gnome/desktop/notifications/application/ > $SCRIPT_DIR/org-gnome-desktop-notifications-application.conf
dconf dump /org/gnome/desktop/interface/ > $SCRIPT_DIR/org-gnome-desktop-interface.conf
dconf dump /org/gnome/desktop/wm/keybindings/ > $SCRIPT_DIR/org-gnome-desktop-wm-keybindings.conf