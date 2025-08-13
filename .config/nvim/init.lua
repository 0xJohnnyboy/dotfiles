vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.encoding = "UTF-8"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.showmode = false

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'WinNew' }, {
    callback = function()
        vim.wo.scrolloff = 10
    end,
    desc = 'Set scrolloff for each window'
})

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
    dev = {
        log = { level = "debug" }
    },
    { 'ellisonleao/gruvbox.nvim',  priority = 1000,                                   config = true, opts = ... },
    { 'nvim-lualine/lualine.nvim', config = function() require('plugins.lualine') end },
    { 'numToStr/Comment.nvim',     config = function() require('plugins.comment') end },
    { '0xJohnnyboy/scretch.nvim' },
    { 'mbbill/undotree' },

    -- Mason
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                log_level = vim.log.levels.DEBUG
            })
        end,
    },

    -- snacks
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            animate = {
                enabled = true,
                duration = 5, -- ms per step
                easing = "inOutQuad",
                fps = 60,  -- frames per second. Global setting for all animations
            },
            bigfile = {
                enabled = true,
                notify = true,
                size = 1.5 * 1024 * 1024,
                line_length = 1000,
                ---@param ctx {buf: number, ft:string}
                setup = function(ctx)
                    if vim.fn.exists(":NoMatchParen") ~= 0 then
                        vim.cmd([[NoMatchParen]])
                    end
                    Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
                    vim.b.minianimate_disable = true
                    vim.schedule(function()
                        if vim.api.nvim_buf_is_valid(ctx.buf) then
                            vim.bo[ctx.buf].syntax = ctx.ft
                        end
                    end)
                end,
            },
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    {
                        pane = 2,
                        section = "terminal",
                        -- cmd = "colorscript -e square",
                        cmd = "",
                        height = 5,
                        padding = 1,
                    },
                    { section = "keys", gap = 1, padding = 1 },
                    { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = function()
                            return Snacks.git.get_root() ~= nil
                        end,
                        cmd = "git status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    { section = "startup" },
                },
            },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },

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
        },
        config = function() require('plugins.telescope') end,
    },

    -- Grug-Far
    {
        'MagicDuck/grug-far.nvim',
        config = function()
            require('grug-far').setup({
            });
        end
    },


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
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    },

    -- Folke
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function() require('plugins.which-key') end,
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
    { 'folke/trouble.nvim', config = function() require('trouble').setup({}) end, dependencies = { "nvim-tree/nvim-web-devicons" } },
})

-- theme
-- Gruvbox initialization
-- vim.o.background = 'dark'
vim.o.background = 'light'
vim.cmd([[colorscheme gruvbox]])

-- Transparent background because wezterm is already setup with transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- LSP

vim.lsp.enable({
    'angular',
    'astro',
    'eslint',
    'gopls',
    'lua_ls',
    'typescript',
})

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.diagnostic.config({
    virtual_lines = true
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set('i', '<C-I>', function()
                vim.lsp.completion.get()
            end)

            vim.keymap.set('n', '<leader>lf', function()
                vim.lsp.buf.format({ async = true })
            end)
        end
    end,
})

-- Fern
vim.g['fern#renderer'] = 'nerdfont'

local function close_nvim_if_last_fern_buffer()
    -- Délai pour laisser le temps aux fenêtres de se fermer
    vim.defer_fn(function()
        local wins = vim.api.nvim_list_wins()
        local normal_wins = vim.tbl_filter(function(win)
            local config = vim.api.nvim_win_get_config(win)
            return config.relative == ''
        end, wins)

        if #normal_wins == 1 then
            local buf = vim.api.nvim_win_get_buf(normal_wins[1])
            if vim.api.nvim_get_option_value('filetype', { buf = buf }) == 'fern' then
                vim.cmd('qall!')
            end
        end
    end, 10) -- Délai de 10ms
end

vim.api.nvim_create_augroup('CloseNvimIfLastFernBuffer', { clear = true })
vim.api.nvim_create_autocmd('WinClosed', {
    group = 'CloseNvimIfLastFernBuffer',
    callback = close_nvim_if_last_fern_buffer
})
