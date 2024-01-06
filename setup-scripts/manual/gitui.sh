curl -s https://api.github.com/repos/extrawurst/gitui/releases/latest | grep -wo "https.*linux.*gz" | wget -qi -
tar xzvf gitui-linux-musl.tar.gz
rm gitui-linux-musl.tar.gz
sudo chmod +x gitui
sudo mv gitui /usr/local/bin
rm gitui-linux*
