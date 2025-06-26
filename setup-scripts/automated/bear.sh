#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

mkdir -p ~/bin

cp $SCRIPT_DIR/../../bear ~/bin/

mkdir -p ~/build/open-source/bear-tools

# bear 2.4.4-1 is a bear binary built from 2.4.4 using fortidev-6. Michael Thomas gave me it.
tar xvf $SCRIPT_DIR/../../bear-2.4.4-1.tar.xz -C ~/build/open-source/bear-tools


