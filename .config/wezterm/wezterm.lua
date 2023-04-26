-- wezterm API
local wezterm = require 'wezterm'

-- config table
local config = {}

-- config builder for error handling
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Gruvbox dark, hard (base16)'
config.window_background_opacity = 0.8
config.font = wezterm.font_with_fallback {
  'JetBrainsMono NF',
  'Hack Nerd Font Mono',
}

-- return the configuration to wezterm
return config

