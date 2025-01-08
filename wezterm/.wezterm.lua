-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

config.default_prog = { '/bin/zsh', '-l', '-c', '/home/kguo/build/my-configs/tmux.sh' }
config.default_cwd = '/home/kguo/build/fos-ci/fortios-ci'
config.font = wezterm.font_with_fallback {'Ubuntu Mono Nerd Font Mono', 'DroidSansFallbackFull'}
-- config.font = wezterm.font 'Ubuntu Mono Nerd Font Mono'
config.font_size = 11.0
-- config.color_scheme = 'Monokai Pro (Gogh)'
-- config.color_scheme = 'Catppuccin Macchiato'
-- config.color_scheme = 'Catppuccin Mocha (Gogh)'
config.warn_about_missing_glyphs = false
config.window_decorations = 'NONE'
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
    -- The default text color
    foreground = '#b9bcba',
    -- The default background color
    background = '#1f1f1f',

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = '#f83e19',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = '#171717',
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    -- cursor_border = '#52ad70',

    -- the foreground color of selected text
    selection_fg = '#b9bcba',
    -- the background color of selected text
    selection_bg = '#2a2d32',

    -- The color of the scrollbar "thumb"; the portion that represents the current viewport
    -- scrollbar_thumb = '#222222',

    -- The color of the split lines between panes
    -- split = '#444444',

    ansi = {
        '#888987', -- black
        '#be3f48', -- normal red
        '#879a3b', -- green
        '#c5a635', -- yellow
        '#4f76a1', -- normal blue
        '#855c8d', -- magenta
        '#578fa4', -- normal cyan
        '#b9bcba', -- white
    },

    brights = {
        '#888987', -- black
        '#be3f48', -- normal red
        '#879a3b', -- green
        '#c5a635', -- yellow
        '#4f76a1', -- normal blue
        '#855c8d', -- magenta
        '#578fa4', -- normal cyan
        '#b9bcba', -- white
    },
    -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = { [136] = '#ffffff' },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = 'orange',

    -- Colors for copy_mode and quick_select
    -- available since: 20220807-113146-c2fee766
    -- In copy_mode, the color of the active text is:
    -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
    -- 2. selection_* otherwise
    copy_mode_active_highlight_bg = { Color = '#000000' },
    -- use `AnsiColor` to specify one of the ansi color palette values
    -- (index 0-15) using one of the names "Black", "Maroon", "Green",
    --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
    -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
    copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
    copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
    copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

    quick_select_label_bg = { Color = 'peru' },
    quick_select_label_fg = { Color = '#ffffff' },
    quick_select_match_bg = { AnsiColor = 'Navy' },
    quick_select_match_fg = { Color = '#ffffff' },
}

config.mouse_bindings = {
  -- Right click sends "woot" to the terminal
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = act.SendString 'woot',
  },

  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },

  -- and make CTRL-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
  -- NOTE that binding only the 'Up' event can give unexpected behaviors.
  -- Read more below on the gotcha of binding an 'Up' event only.
}
-- and finally, return the configuration to wezterm
return config
