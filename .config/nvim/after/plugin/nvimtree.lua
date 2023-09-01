require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})


vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>ef', ':NvimTreeFocus<CR>', { silent = true })
vim.keymap.set('n', '<leader>es', ':NvimTreeFindFile!<CR>', { silent = true })

