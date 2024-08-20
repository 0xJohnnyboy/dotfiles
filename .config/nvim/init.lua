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
    '0xJohnnyboy/scretch.nvim',
    'm4xshen/smartcolumn.nvim',
    'mbbill/undotree',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- Fern
    {
        'lambdalisue/fern.vim',
        dependencies = {
            'lambdalisue/fern-hijack.vim',
            'lambdalisue/nerdfont.vim',
            'lambdalisue/fern-renderer-nerdfont.vim',
            'lambdalisue/fern-git-status.vim',
            {
                'yuki-yano/fern-preview.vim',
                keys = {
                    { 'p',     '<Plug>(fern-action-preview:toggle)',           ft = "fern" },
                    { '<C-j>', '<Plug>(fern-action-preview:scroll:down:half)', ft = "fern" },
                    { '<C-k>', '<Plug>(fern-action-preview:scroll:up:half)',   ft = "fern" },
                    { '<C-o>', '<Plug>(fern-action-open:select)',              ft = "fern" },
                    { '<C-v>', '<Plug>(fern-action-open:vsplit)',              ft = "fern" },
                    { 'n',     '<Plug>(fern-action-new-path)',                 ft = "fern" },
                    { 'r',     '<Plug>(fern-action-rename)',                   ft = "fern" },
                    { 'm',     '<Plug>(fern-action-move)',                     ft = "fern" },
                    { 'c',     '<Plug>(fern-action-copy)',                     ft = "fern" },
                    { 't',     '<Plug>(fern-action-remove)',                   ft = "fern" },
                    { ',',     '<Plug>(fern-action-mark:toggle)',              ft = "fern" },
                    { 'd',     '<Plug>(fern-action-diff)',                     ft = "fern" },
                    { 'H',     '<Plug>(fern-action-hidden-toggle)',            ft = "fern" },
                    { 'h',     '<Plug>(fern-action-collapse)',                 ft = "fern" },
                    { '-',     '<Plug>(fern-action-cd)',                       ft = "fern" }
                }
            }
        }
    },

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

    -- Grug-Far
    {
        'MagicDuck/grug-far.nvim',
        config = function()
            require('grug-far').setup({
            });
        end
    },


    -- LSP
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip',                 build = "make install_jsregexp" },

    -- Tim Pope
    'tpope/vim-surround',
    'tpope/vim-eunuch',
    'tpope/vim-speeddating',

    -- Supermaven
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({})
        end,
    },

    -- Neogit
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = true
    },

    {
        'MeanderingProgrammer/markdown.nvim',
        main = "render-markdown",
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    },

    -- Folke
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
        }
    },
    { 'folke/trouble.nvim', dependencies = { "nvim-tree/nvim-web-devicons" } },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    } })

-- theme
-- Gruvbox initialization
-- vim.o.background = 'dark'
vim.o.background = 'light'
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

local wk = require("which-key")
wk.setup({
    ignore_missing = true
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

-- supermaven
require("supermaven-nvim").setup({
  keymaps = {
    accept_suggestion = "<Tab>",
    clear_suggestion = "<C-]>",
    accept_word = "<C-j>",
  },
  -- ignore_filetypes = { cpp = true },
  -- color = {
  --   suggestion_color = "#ffffff",
  --   cterm = 244,
  -- },
  log_level = "info", -- set to "off" to disable logging completely
  disable_inline_completion = false, -- disables inline completion for use with cmp
  disable_keymaps = false -- disables built in keymaps for more manual control
})

-- lsp
local lsp = require('lsp-zero').preset({
    suggest_lsp_servers = true,
})
require('mason').setup({
    log_level = vim.log.levels.DEBUG
})
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
    sources = {
        { name = "supermaven" },
    }
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
    disabled_filetypes = { "help", "text", "markdown", "fern" },
    custom_colorcolumn = {},
    scope = "line",
}

require("smartcolumn").setup(smartcolumn_config)

-- Telescope
local telescope = require('telescope')
local builtin = require('telescope.builtin')
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
local noice = require('noice')

telescope.setup()
telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")
telescope.load_extension("zf-native")
telescope.load_extension("notify")

-- Fern
vim.g['fern#renderer'] = 'nerdfont'

-- Ajoute cette fonction à ton init.lua
function close_nvim_if_last_fern_buffer()
    -- Vérifie si le seul buffer ouvert a un filetype "fern"
    local num_windows = vim.fn.winnr('$') - 1
    print(num_windows)

    if num_windows == 1 and vim.api.nvim_buf_get_option(0, 'filetype') == 'fern' then
        vim.cmd('qall!')
    end
end

-- Ajoute cette autocmd pour appeler la fonction avant de quitter Neovim
vim.api.nvim_exec(
    [[
augroup CloseNvimIfLastFernBuffer
    autocmd!
    autocmd WinClosed,WinClosed,VimLeavePre lua close_nvim_if_last_fern_buffer()
augroup END
]],
    false)


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
km.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { silent = true, noremap = true })
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
km.set("n", "<leader>nl", function() noice.cmd("last") end)
km.set("n", "<leader>nh", function() noice.cmd("history") end)
-- fern
km.set("n", "<leader>ee", ":Fern . -drawer -width=60 -toggle -right<CR>", { silent = true, noremap = true })
km.set("n", "<leader>es", ":Fern . -reveal=% -drawer -width=60 -toggle -right<CR>", { silent = true, noremap = true })
-- Trouble
km.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xR", "<cmd>Trouble lsp toggle<cr>", { silent = true, noremap = true })
km.set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { silent = true, noremap = true })
-- Scretch
km.set('n', '<leader>sn', scretch.new)
km.set('n', '<leader>snn', scretch.new_named)
km.set('n', '<leader>sft', scretch.new_from_template)
km.set('n', '<leader>sat', scretch.save_as_template)
km.set('n', '<leader>sl', scretch.last)
km.set('n', '<leader>ss', scretch.search)
km.set('n', '<leader>st', scretch.edit_template)
km.set('n', '<leader>sg', scretch.grep)
km.set('n', '<leader>sv', scretch.explore)
-- Grugfar
km.set('n', '<leader>Gf', ':lua require("grug-far").grug_far({ prefills = { flags = vim.fn.expand("%") } })<cr>',
    { noremap = true, silent = true })
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
