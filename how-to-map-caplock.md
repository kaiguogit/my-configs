# wayland doesn't support setkbmap any more. It can use tweak to set caplock as control
https://superuser.com/questions/1196241/how-to-remap-caps-lock-on-wayland
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"

# working solution for wayland
# https://github.com/rvaiya/keyd?tab=readme-ov-file
# https://www.reddit.com/r/vim/comments/1cv5gmf/best_way_to_remap_caps_lock_to_both_escape_and/
Use keyd. The script is in setup-scripts/automated/keyd.sh

