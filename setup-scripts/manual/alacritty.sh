# https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu
if [ ! -d "~/build/alacritty" ]; then
    cd ~/build
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rustup override set stable
rustup update stable

sudo apt-get install -yy cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

cargo build --release

sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database


