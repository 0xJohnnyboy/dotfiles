-- get macOs current theme
function getAppleInterfaceStyle()
    local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
    local result = handle:read("*a")
    handle:close()

    if string.match(result, "Dark") then
        return "dark"
    else
        return "light"
    end
end

-- get Windows current theme
function getWindowsInterfaceStyle() 
    local winapi = require("winapi")
    local registryKey = "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize"
    local valueName = "AppsUseLightTheme"

    local value = winapi.registry.read_string(registryKey, valueName)

    if value ~= nil and tonumber(value) == 0 then
        return "Dark"
    else
        return "Light"
    end
end

-- get theme depending on os
function getTheme()
    if (vim.fn.has("macunix")) then
        return getAppleInterfaceStyle()
    else
        return getWindowsInterfaceStyle()
    end
end


-- Gruvbox initialization
vim.o.background = getTheme()
vim.cmd([[colorscheme gruvbox]])

-- Transparent background because wezterm is already setup with transparency 
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
