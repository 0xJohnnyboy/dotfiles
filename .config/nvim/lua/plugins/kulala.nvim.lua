-- Plugin: mistweaverco/kulala.nvim
-- Installed via store.nvim

return {
    "mistweaverco/kulala.nvim",
    lazy = false,
    keys = {
        {
            "<leader>Rs",
            desc = "Send request"
        },
        {
            "<leader>Ra",
            desc = "Send all requests"
        },
        {
            "<leader>Rb",
            desc = "Open scratchpad"
        }
    },
    ft = { "http", "rest" },
    opts = {
        global_keymaps = true,
        global_keymaps_prefix = "<leader>R",
        kulala_keymaps_prefix = "",
        ui = {
            autocomplete = true, -- Enable autocomplete suggestions
            lua_syntax_hl = true, -- Highlight Lua syntax in scripts
            float = {
                width = 0.9, -- Width of floating windows (0-1 for percentage)
                height = 0.8, -- Height of floating windows (0-1 for percentage)
                border = "rounded", -- Border style for floating windows
            },
        },
        show_icons = "signcolumn", -- Where to show status icons ("signcolumn", "virtual" or false)
    }
}

