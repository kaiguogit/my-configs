file_name=git-delta_0.16.5_amd64.deb
wget -q https://github.com/dandavison/delta/releases/download/0.16.5/$file_name
sudo dpkg -i $file_name
rm $file_name

git clone https://github.com/catppuccin/delta.git ~/.local/share/catppuccin-delta
