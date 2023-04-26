local wk = require("which-key")
-- <LEADER> NORMAL MODE
local leader_normal_opts = {
    prefix = "<leader>",
    mode = "n",
    silent = true,
}
local leader_normal_mappings = {
    w = {
        name = "Window",
        s = "Split horizontally",
        ["sj"] = "Split horizontally and focus down",
        v = "Split vertically",
        ["vl"] = "Split vertically and focus right",
        w = "New buffer in new pane",
        c = "Close pane",
        h = "Focus left",
        j = "Focus down",
        k = "Focus up",
        l = "Focus right",
    },
    b = {
        name = "buffer",
        n = "Next buffer",
        p = "Previous buffer",
        d = "Close buffer",
        l = "List buffers",
        r = "Refresh buffers (redraw)",
    },
    c = {
        name = "Comment",
        l = "Toggle line comment",
        b = "Toggle block comment",
        O = "Insert comment on the line above",
        o = "Insert comment on the line below",
        A = "Insert comment at the end of the line",
    },
    p = {
        name = "Project",
        v = "Default explorer",
        t = "Telescope explorer",
        f = "Search project files (git)",
        s = "Live grep",
    },
    f = {
        name = "Find",
        o = "Find old file",
        f = "Fuzze find file"
    },
    u = "Toggle undotree",
    l = {
        name = "LSP",
        a = "Code action"
    },
    ["<Esc><Esc>"] = "Remove highlighting after search",
}

-- <LEADER> VISUAL MODE
local leader_visual_opts = {
    prefix = "<leader>",
    mode = "v",
    silent = true,
}
local leader_visual_mappings = {
    c = {
        name = "Comment",
        l = "Toggle line comment",
        b = "Toggle block comment",
    },
    ["pV"] = "Live grep visual selection",
}

-- NORMAL MODE
local normal_opts = {
    mode = "n",
    silent = true
}
local normal_mappings = {
    ["[d"] = "Go to next diagnostic",
    ["]d"] = "Go to previous diagnostic",
}

-- REGISTER
wk.register(leader_normal_mappings, leader_normal_opts)
wk.register(leader_visual_mappings, leader_visual_opts)
wk.register(normal_mappings, normal_opts)
