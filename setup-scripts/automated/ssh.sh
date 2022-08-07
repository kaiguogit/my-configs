#!/bin/bash

sudo apt-get install -yy openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh