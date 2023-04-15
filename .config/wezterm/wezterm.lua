-- wezterm API
local wezterm = require 'wezterm'

-- config table
local config = {}

-- config builder for error handling
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- handles OS theme change
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

-- theme choice depending on OS theme
function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Apple Classic'
  else
    return 'Catppuccin Latte'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())
config.window_background_opacity = 0.8
config.font = wezterm.font_with_fallback {
  'JetBrainsMono NF',
  'Hack Nerd Font Mono',
}

-- return the configuration to wezterm
return config

