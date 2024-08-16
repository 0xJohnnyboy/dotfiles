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

require('config.lazy')
require('config.autocmds')

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

