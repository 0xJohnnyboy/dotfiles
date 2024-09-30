local wk = require("which-key")
wk.setup({
    -- ignore_missing = true
})

local leader_normal_opts = {
    prefix = "<leader>",
    mode = "n",
    silent = true,
}
local leader_normal_mappings = {
    { "<leader>D",   group = "Database" },
    { "<leader>Df",  desc = "Find buffer" },
    { "<leader>Dq",  desc = "Last query info" },
    { "<leader>Dr",  desc = "Rename buffer" },
    { "<leader>Du",  desc = "Toggle UI" },
    { "<leader>\\",  desc = "Remove highlighting after search" },
    { "<leader>b",   group = "buffer" },
    { "<leader>bd",  desc = "Close buffer" },
    { "<leader>bl",  desc = "List buffers" },
    { "<leader>bn",  desc = "Next buffer" },
    { "<leader>bp",  desc = "Previous buffer" },
    { "<leader>br",  desc = "Refresh buffers (redraw)" },
    { "<leader>bx",  desc = "Close all buffers but the current one" },
    { "<leader>c",   group = "Comment" },
    { "<leader>cA",  desc = "Insert comment at the end of the line" },
    { "<leader>cO",  desc = "Insert comment on the line above" },
    { "<leader>cb",  desc = "Toggle block comment" },
    { "<leader>cl",  desc = "Toggle line comment" },
    { "<leader>co",  desc = "Insert comment on the line below" },
    { "<leader>e",   group = "NvimTree" },
    { "<leader>ee",  desc = "Toggle" },
    { "<leader>ef",  desc = "Focus" },
    { "<leader>es",  desc = "Show file in tree" },
    { "<leader>f",   group = "Find" },
    { "<leader>ff",  desc = "Fuzze find file" },
    { "<leader>fo",  desc = "Find old file" },
    { "<leader>l",   group = "LSP" },
    { "<leader>la",  desc = "Code action" },
    { "<leader>lf",  desc = "Format" },
    { "<leader>lo",  desc = "Open diagnostics float window" },
    { "<leader>mp",  desc = "Markdown preview with glow" },
    { "<leader>p",   group = "Project" },
    { "<leader>pf",  desc = "Search project files (git)" },
    { "<leader>pg",  desc = "Project git status" },
    { "<leader>ps",  desc = "Live grep" },
    { "<leader>pt",  desc = "Telescope explorer" },
    { "<leader>rm",  desc = "Remove whitelines" },
    { "<leader>s",   group = "Scretch.nvim" },
    { "<leader>sg",  desc = "Live grep scretches" },
    { "<leader>sl",  desc = "Toggle last scretch" },
    { "<leader>sn",  desc = "New scretch" },
    { "<leader>snn", desc = "New named scretch" },
    { "<leader>ss",  desc = "Search scretches" },
    { "<leader>sv",  desc = "Explore scretches" },
    { "<leader>t",   group = "Tabs" },
    { "<leader>tc",  desc = "Close" },
    { "<leader>tn",  desc = "Next" },
    { "<leader>tp",  desc = "Prev" },
    { "<leader>tt",  desc = "New" },
    { "<leader>u",   desc = "Toggle undotree" },
    { "<leader>w",   group = "Window" },
    { "<leader>wc",  desc = "Close pane" },
    { "<leader>wh",  desc = "Focus left" },
    { "<leader>wj",  desc = "Focus down" },
    { "<leader>wk",  desc = "Focus up" },
    { "<leader>wl",  desc = "Focus right" },
    { "<leader>ws",  desc = "Split horizontally" },
    { "<leader>wsj", desc = "Split horizontally and focus down" },
    { "<leader>wv",  desc = "Split vertically" },
    { "<leader>wvl", desc = "Split vertically and focus right" },
    { "<leader>ww",  desc = "New buffer in new pane" },
    { "<leader>x",   group = "Trouble" },
    { "<leader>xR",  desc = "Trouble LSP references" },
    { "<leader>xd",  desc = "Trouble document diagnostics" },
    { "<leader>xl",  desc = "Trouble loclist" },
    { "<leader>xq",  desc = "Trouble quickfix" },
    { "<leader>xw",  desc = "Trouble workspace diagnostics" },
    { "<leader>xx",  desc = "Toggle Trouble" },
}
-- <LEADER> VISUAL MODE
local leader_visual_opts = {
    prefix = "<leader>",
    mode = "v",
    silent = true,
}
local leader_visual_mappings = {
    {
        mode = { "v" },
        { "<leader>c",  group = "Comment" },
        { "<leader>cb", desc = "Toggle block comment" },
        { "<leader>cl", desc = "Toggle line comment" },
        { "<leader>pV", desc = "Live grep visual selection" },
    },
}

-- NORMAL MODE
local normal_opts = {
    mode = "n",
    silent = true
}
local normal_mappings = {
    { "[d", desc = "Go to next diagnostic" },
    { "]d", desc = "Go to previous diagnostic" },
    { "gD", desc = "Go to declaration" },
    { "gI", desc = "Go to implementation" },
    { "gd", desc = "Go to definition" },
    { "go", desc = "Go to type definition" },
    { "gr", desc = "Go to type references" },
    { "z",  group = "Folds" },
    { "z(", desc = "Toggle ( fold" },
    { "z)", desc = "Toggle ) fold" },
    { "zT", desc = "Toggle tag fold" },
    { "z[", desc = "Toggle [ fold" },
    { "z]", desc = "Toggle ] fold" },
    { "z{", desc = "Toggle { fold" },
    { "z}", desc = "Toggle } fold" },
}

-- INSERT MODE
local insert_opts = {
    mode = "i",
    silent = true
}
local insert_mappings = {
}
wk.register(leader_normal_mappings, leader_normal_opts)
wk.register(leader_visual_mappings, leader_visual_opts)
wk.register(normal_mappings, normal_opts)
wk.register(insert_mappings, insert_opts)
