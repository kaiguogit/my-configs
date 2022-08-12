#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
sudo apt install -yy vsftpd
sudp cp $SCRIPT_DIR/../../vsftpd/vsftpd.conf /etc/