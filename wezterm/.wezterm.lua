-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

config.default_prog = { '/bin/zsh', '-l', '-c', '/home/kguo/build/my-configs/tmux.sh' }
config.default_cwd = '/home/kguo/build/fos-ci/fortios-ci'
config.font = wezterm.font 'Ubuntu Mono Nerd Font Mono'
config.font_size = 11.0
-- config.color_scheme = 'Monokai Pro (Gogh)'
config.color_scheme = 'Catppuccin Macchiato'
-- config.color_scheme = 'Catppuccin Mocha (Gogh)'
config.warn_about_missing_glyphs = false
config.window_decorations = 'NONE'
config.hide_tab_bar_if_only_one_tab = true


-- and finally, return the configuration to wezterm
return config
