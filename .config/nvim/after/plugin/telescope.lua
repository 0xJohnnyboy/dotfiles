local telescope = require('telescope')
local builtin = require('telescope.builtin')
telescope.load_extension("file_browser")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>bl', builtin.buffers, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ol', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string( { search = vim.fn.input("Grep > ") });
end)

