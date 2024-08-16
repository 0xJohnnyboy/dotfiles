-- wezterm API
local wezterm = require 'wezterm'

-- config table
local config = {}

config.keys = {
    {
        key = ' ',
        mods = 'LEADER|CTRL',
        action = wezterm.action.SendKey { key = ' ', mods = 'CTRL' },
    }
}

-- config builder for error handling
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- =============================================================================
-- OS Detection
-- =============================================================================
local is_wsl = (function()
  local f = io.open("/proc/version", "r")
  if f then
    local content = f:read("*all")
    f:close()
    return content:match("Microsoft") or content:match("WSL")
  end
  return false
end)()

local is_mac = wezterm.target_triple:find("darwin") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil and not is_wsl

-- =============================================================================
-- Common Settings
-- =============================================================================
config.color_scheme = 'Gruvbox dark, hard (base16)'
config.window_background_opacity = 0.94
config.window_decorations = "INTEGRATED_BUTTONS"

-- =============================================================================
-- Platform-Specific Settings
-- =============================================================================
if is_mac then
  config.macos_window_background_blur = 9
  config.font = wezterm.font_with_fallback {
    'JetBrainsMono Nerd Font',  -- macOS font name format
    'Hack Nerd Font Mono',
  }
elseif is_wsl then
  config.win32_system_backdrop = 'Acrylic'
  config.font = wezterm.font_with_fallback {
    'JetBrainsMono NF',  -- Linux font name format
    'Hack Nerd Font Mono',
  }
else
  -- Native Linux
  config.font = wezterm.font_with_fallback {
    'JetBrainsMono NF',
    'Hack Nerd Font Mono',
  }
end

-- return the configuration to wezterm
return config

