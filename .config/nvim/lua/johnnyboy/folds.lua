function toggle_fold(char)
    local fold_command = ''

    if vim.fn.foldlevel('.') > 0 then
        fold_command = 'za'
    else
        fold_command = 'va' .. char .. 'zf'
    end

    vim.cmd('normal! ' .. fold_command)
end

vim.keymap.set('n', 'z}', ':lua toggle_fold("}")<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'z{', ':lua toggle_fold("{")<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'z)', ':lua toggle_fold(")")<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'z(', ':lua toggle_fold("(")<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'z]', ':lua toggle_fold("]")<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'z[', ':lua toggle_fold("[")<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'zT', ':lua toggle_fold("t")<CR>', { noremap = true, silent = true })
