local scretch = require("scretch")
scretch.setup()

vim.keymap.set('n', '<leader>sn', scretch.new)
vim.keymap.set('n', '<leader>snn', scretch.new_named)
vim.keymap.set('n', '<leader>sl', scretch.last)
vim.keymap.set('n', '<leader>ss', scretch.search)
vim.keymap.set('n', '<leader>sg', scretch.grep)
vim.keymap.set('n', '<leader>sv', scretch.explore)
