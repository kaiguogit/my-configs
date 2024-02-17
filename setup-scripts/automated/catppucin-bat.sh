
mkdir -p "$(bat --config-dir)/themes"

git clone https://github.com/catppuccin/bat.git ~/.local/share/catppuccin-bat
cp ~/.local/share/catppuccin-bat/*.tmTheme "$(bat --config-dir)/themes"
bat cache --build
