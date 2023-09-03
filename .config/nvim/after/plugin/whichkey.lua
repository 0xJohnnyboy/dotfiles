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
    t = {
        name = "Tabs",
        t = "New",
        c = "Close",
        n = "Next",
        p = "Prev",
    },
    s = {
        name = "Scretch.nvim",
        n = "New scretch",
        ["nn"] = "New named scretch",
        l = "Toggle last scretch",
        s = "Search scretches",
        g = "Live grep scretches",
        v = "Explore scretches",
    },
    x = {
        name = "Trouble",
        x = "Toggle Trouble",
        w = "Trouble workspace diagnostics",
        d = "Trouble document diagnostics",
        l = "Trouble loclist",
        q = "Trouble quickfix",
        R = "Trouble LSP references"
    },
    b = {
        name = "buffer",
        n = "Next buffer",
        p = "Previous buffer",
        d = "Close buffer",
        l = "List buffers",
        r = "Refresh buffers (redraw)",
        x = "Close all buffers but the current one",
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
        t = "Telescope explorer",
        f = "Search project files (git)",
        g = "Project git status",
        s = "Live grep",
    },
    e = {
        name = "NvimTree",
        e = "Toggle",
        f = "Focus",
        s = "Show file in tree",
    },
    f = {
        name = "Find",
        o = "Find old file",
        f = "Fuzze find file"
    },
    D = {
        name = "Database",
        u = "Toggle UI",
        f = "Find buffer",
        r = "Rename buffer",
        q = "Last query info",
    },
    u = "Toggle undotree",
    l = {
        name = "LSP",
        a = "Code action",
        f = "Format",
        o = "Open diagnostics float window",
    },
    ["\\"] = "Remove highlighting after search",
    ["rm"] = "Remove whitelines",
    ["mp"] = "Markdown preview with glow",
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
    z = {
        name = "Folds",
        ["}"] = "Toggle } fold",
        ["{"] = "Toggle { fold",
        [")"] = "Toggle ) fold",
        ["("] = "Toggle ( fold",
        ["]"] = "Toggle ] fold",
        ["["] = "Toggle [ fold",
        ["T"] = "Toggle tag fold",
    },
    g = {
        d = "Go to definition",
        D = "Go to declaration",
        I = "Go to implementation",
        o = "Go to type definition",
        r = "Go to type references",
    }
}

-- INSERT MODE
local insert_opts = {
    mode = "i",
    silent = true
}
local insert_mappings = {
}
-- REGISTER
wk.register(leader_normal_mappings, leader_normal_opts)
wk.register(leader_visual_mappings, leader_visual_opts)
wk.register(normal_mappings, normal_opts)
wk.register(insert_mappings, insert_opts)
