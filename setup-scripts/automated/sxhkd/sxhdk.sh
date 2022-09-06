
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
sudo apt-get install -yy sxhkd
mkdir -p ~/.config/sxhkd
cp $SCRIPT_DIR/sxhkdrc ~/.config/sxhkd/sxhkdrc