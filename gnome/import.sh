#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
dconf load /com/github/ < $SCRIPT_DIR/com-github.conf
dconf load /org/gnome/shell/ < $SCRIPT_DIR/org-gnome-shell.conf
dconf load /org/gnome/desktop/screensaver/ < $SCRIPT_DIR/org-gnome-desktop-screensaver.conf
dconf load /org/gnome/desktop/notifications/application/ < $SCRIPT_DIR/org-gnome-desktop-notifications-application.conf
dconf load /org/gnome/desktop/interface/ < $SCRIPT_DIR/org-gnome-desktop-interface.conf