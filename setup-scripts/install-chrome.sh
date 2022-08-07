#!/bin/bash

cd /home/kguo/Downloads
FILE_NAME=google-chrome-stable_current_amd64.deb
if [ ! -f "$FILE_NAME" ]; then
  wget https://dl.google.com/linux/direct/$FILE_NAME
fi
sudo gdebi -n $FILE_NAME