file_name=git-interactive-rebase-tool-2.3.0-ubuntu-20.04_amd64.deb
# file_name=git-interactive-rebase-tool-2.3.0-ubuntu-22.10_amd64.deb
curl -s https://api.github.com/repos/MitMaro/git-interactive-rebase-tool/releases/latest | grep -wo "https.*$file_name" | wget -qi -
sudo dpkg -i $file_name
rm $file_name
