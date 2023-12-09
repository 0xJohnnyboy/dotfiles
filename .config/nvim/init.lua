-- basics
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.encoding = "UTF-8"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.wo.scrolloff = 20
local km = vim.keymap

-- LAZY
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "ellisonleao/gruvbox.nvim",        priority = 1000,    config = true, opts = ... },
    'nvim-lualine/lualine.nvim',
    'numToStr/Comment.nvim',
    'Sonicfury/scretch.nvim',
    'm4xshen/smartcolumn.nvim',
    'mbbill/undotree',
    'nvim-tree/nvim-tree.lua',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'natecraddock/telescope-zf-native.nvim'

        },
    },

    -- LSP
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },

    -- Tim Pope
    'tpope/vim-surround',
    'tpope/vim-eunuch',

    -- Folke
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },
    { 'folke/trouble.nvim', dependencies = { "nvim-tree/nvim-web-devicons" } },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }
    }
})

-- theme
-- Gruvbox initialization
vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- Transparent background because wezterm is already setup with transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- comment
require("Comment").setup({
    toggler = {
        line = '<leader>cl',
        block = '<leader>cb',
    },
    opleader = {
        line = '<leader>cl',
        block = '<leader>cb',
    },
    extra = {
        above = '<leader>cO',
        below = '<leader>co',
        eol = '<leader>cA',
    },
})

-- lualine
require('lualine').setup({
    options = { theme = 'gruvbox' }
})

-- notify
local notify = require("notify")

notify.setup({
    background_colour = "#000000",
    fps = 30,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
    },
    level = 2,
    minimum_width = 50,
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 3000,
    top_down = true
})

-- nvim tree
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 60,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

local function tab_win_closed(winnr)
    local api = require "nvim-tree.api"
    local tabnr = vim.api.nvim_win_get_tabpage(winnr)
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local buf_info = vim.fn.getbufinfo(bufnr)[1]
    local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
    local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
    if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
        -- Close all nvim tree on :q
        if not vim.tbl_isempty(tab_bufs) then      -- and was not the last window (not closed automatically by code below)
            api.tree.close()
        end
    else                                                          -- else closed buffer was normal buffer
        if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
            local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
            if last_buf_info.name:match(".*NvimTree_%d*$") then   -- and that buffer is nvim tree
                vim.schedule(function()
                    if #vim.api.nvim_list_wins() == 1 then        -- if its the last buffer in vim
                        vim.cmd "quit"                            -- then close all of vim
                    else                                          -- else there are more tabs open
                        vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
                    end
                end)
            end
        end
    end
end

vim.api.nvim_create_autocmd("WinClosed", {
    callback = function()
        local winnr = tonumber(vim.fn.expand("<amatch>"))
        vim.schedule_wrap(tab_win_closed(winnr))
    end,
    nested = true
})

local wk = require("which-key")
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
wk.register(leader_normal_mappings, leader_normal_opts)
wk.register(leader_visual_mappings, leader_visual_opts)
wk.register(normal_mappings, normal_opts)
wk.register(insert_mappings, insert_opts)

-- Treesitter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "vim", "vimdoc", "query", "rust", "typescript", "javascript", "html", "css" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['ii'] = '@conditional.inner',
                ['ai'] = '@conditional.outer',
                ['il'] = '@loop.inner',
                ['al'] = '@loop.outer',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']f'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']F'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[F'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>pan'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>pap'] = '@parameter.inner',
            },
        },
    },
}

-- trouble
require("trouble").setup {
}

-- scretch
local scretch = require("scretch")
scretch.setup()

-- lsp
local lsp = require('lsp-zero').preset({
    suggest_lsp_servers = true,
})
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver', 'eslint', 'lua_ls' },
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()
cmp.setup({
    formatting = cmp_format,
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    km.set("n", "<leader>la", function() vim.lsp.buf.code_action() end)
    km.set("n", "<leader>lf", function() vim.lsp.buf.format() end)
    km.set("n", "<leader>lo", function() vim.lsp.buf.open_float() end)
    km.set("n", "gd", function() vim.lsp.buf.definition() end)
    km.set("n", "gD", function() vim.lsp.buf.declaration() end)
    km.set("n", "gI", function() vim.lsp.buf.implementation() end)
    km.set("n", "go", function() vim.lsp.buf.type_definition() end)
    km.set("n", "gr", function() vim.lsp.buf.references() end)
end)

cmp.setup({
    mapping = {
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    cmp.confirm()
                end
            else
                fallback()
            end
        end, { "i", "s", "c", }),
        ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
        end, { "i", "s", "c", })
    }
})

lsp.setup()

function toggle_fold(char)
    local fold_command = ''

    if vim.fn.foldlevel('.') > 0 then
        fold_command = 'za'
    else
        fold_command = 'va' .. char .. 'zf'
    end

    vim.cmd('normal! ' .. fold_command)
end

-- smart column
local smartcolumn_config = {
    colorcolumn = "120",
    disabled_filetypes = { "help", "text", "markdown" },
    custom_colorcolumn = {},
    scope = "line",
}

require("smartcolumn").setup(smartcolumn_config)

-- Telescope
local telescope = require('telescope')
local builtin = require('telescope.builtin')
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

telescope.setup()
telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")
telescope.load_extension("zf-native")
telescope.load_extension("notify")

-- Remaps
-- edition
km.set("n", "<leader>rw", ":g/^$/d<CR>")
-- search
km.set("n", "<leader>\\", ":noh<CR>")
-- buffers
km.set("n", "<leader>bn", ":bnext<CR>")
km.set("n", "<leader>bp", ":bprevious<CR>")
km.set("n", "<leader>bd", ":bd!<CR>")
km.set("n", "<leader>br", ":redraw<CR>")
km.set("n", "<leader>bx", ":%bd|e#<CR>")
--tabs
km.set("n", "<leader>tt", ":tabnew<CR>")
km.set("n", "<leader>tc", ":tabclose<CR>")
km.set("n", "<leader>tn", ":tabnext<CR>")
km.set("n", "<leader>tp", ":tabprev<CR>")
-- window splits
km.set("n", "<leader>ws", "<C-w>s")
km.set("n", "<leader>wsj", "<C-w>s<C-w>j")
km.set("n", "<leader>wv", "<C-w>v")
km.set("n", "<leader>wvl", "<C-w>v<C-w>l")
km.set("n", "<leader>wvh", "<C-w>v<C-w>h")
km.set("n", "<leader>ww", "<C-w>n")
km.set("n", "<leader>wx", "<C-w>x") -- swap with the split on the right
km.set("n", "<leader>wr", "<C-w>r") -- rotates clockwise
km.set("n", "<leader>wR", "<C-w>R") -- rotates counterclockwise
km.set("n", "<leader>wc", "<C-w>q")
km.set("n", "<leader>wj", "<C-w>j")
km.set("n", "<leader>wk", "<C-w>k")
km.set("n", "<leader>wh", "<C-w>h")
km.set("n", "<leader>wl", "<C-w>l")
km.set("n", "<leader>mp", ":rightbelow vsplit | terminal glow %<CR>")
-- Telescope
km.set('n', '<leader>ff', builtin.find_files, {})
km.set('n', '<leader>bl', builtin.buffers, {})
km.set('n', '<leader>pf', builtin.git_files, {})
km.set('n', '<leader>fo', builtin.oldfiles, {})
km.set('n', '<leader>pg', builtin.git_status, {})
km.set('n', '<leader>pt', ':Telescope file_browser<CR>', {})
km.set('n', '<leader>pn', ':Telescope notify<CR>', {})
km.set("n", "<leader>ps", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
km.set("n", "<leader>pV", live_grep_args_shortcuts.grep_visual_selection)
-- notify
km.set("n", "<leader>nc", notify.dismiss, {})
-- nvim tree
km.set('n', '<leader>ee', ':NvimTreeToggle<CR>', { silent = true })
km.set('n', '<leader>ef', ':NvimTreeFocus<CR>', { silent = true })
km.set('n', '<leader>es', ':NvimTreeFindFile!<CR>', { silent = true })
-- Trouble
km.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
-- Scretch
km.set('n', '<leader>sn', scretch.new)
km.set('n', '<leader>snn', scretch.new_named)
km.set('n', '<leader>sl', scretch.last)
km.set('n', '<leader>ss', scretch.search)
km.set('n', '<leader>sg', scretch.grep)
km.set('n', '<leader>sv', scretch.explore)
-- undotree
km.set('n', '<leader>u', vim.cmd.UndotreeToggle)
-- folds
km.set('n', 'z}', ':lua toggle_fold("}")<CR>', { noremap = true, silent = true })
km.set('n', 'z{', ':lua toggle_fold("{")<CR>', { noremap = true, silent = true })
km.set('n', 'z)', ':lua toggle_fold(")")<CR>', { noremap = true, silent = true })
km.set('n', 'z(', ':lua toggle_fold("(")<CR>', { noremap = true, silent = true })
km.set('n', 'z]', ':lua toggle_fold("]")<CR>', { noremap = true, silent = true })
km.set('n', 'z[', ':lua toggle_fold("[")<CR>', { noremap = true, silent = true })
km.set('n', 'zT', ':lua toggle_fold("t")<CR>', { noremap = true, silent = true })
