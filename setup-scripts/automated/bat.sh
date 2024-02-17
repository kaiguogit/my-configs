
file_name=bat_0.24.0_amd64.deb
wget -q https://github.com/sharkdp/bat/releases/download/v0.24.0/$file_name
sudo dpkg -i $file_name
rm $file_name

