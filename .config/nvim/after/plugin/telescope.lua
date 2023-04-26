local telescope = require('telescope')
local builtin = require('telescope.builtin')
local lga_actions = require("telescope-live-grep-args.actions")

telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>bl', builtin.buffers, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>pt', ':Telescope file_browser<CR>', {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep)

