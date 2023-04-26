local wk = require("which-key")

wk.register({
    -- search, explore
    ["<leader><Esc><Esc>"] = { name = "Remove highlighting after search" },
    ["<leader>pv"] = { name = "Explorer" },
    ["<leader>ff"] = { name = "Fuzzy find files" },
    ["<leader>pf"] = { name = "Search project (git) files" },
    ["<leader>ps"] = { name = "Grep string" },
    ["<leader>u"] = { name = "Toggle undotree" },
    -- buffers
    ["<leader>bn"] = { name = "Next buffer" },
    ["<leader>bp"] = { name = "Previous buffer" },
    ["<leader>bd"] = { name = "Close buffer" },
    ["<leader>bl"] = { name = "List buffer" },
    ["<leader>br"] = { name = "Refresh buffer (redraw)" },
    -- splits
    ["<leader>ws"] = { name = "Split horizontally" },
    ["<leader>wsj"] = { name = "Split horizontally and focus new (down)" },
    ["<leader>wv"] = { name ="Split vertically" },
    ["<leader>wvl"] = {name ="Split vertically and focus new (left)" },
    ["<leader>wvh"] = {name ="Split vertically and focus new (right)" },
    ["<leader>ww"] = { name = "New buffer" },
    ["<leader>wc"] = { name = "Close pane" },
    ["<leader>wj"] = { name = "Focus down" },
    ["<leader>wk"] = { name = "Focus up" },
    ["<leader>wh"] = { name = "Focus left" },
    ["<leader>wl"] = { name = "Focus right" },
    -- LSP
    ["<leader>ca"] = { name = "LSP Code action" },
})
