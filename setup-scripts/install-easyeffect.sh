#!/bin/bash
sudo apt install -yy flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# https://flathub.org/apps/details/com.github.wwmm.easyeffects