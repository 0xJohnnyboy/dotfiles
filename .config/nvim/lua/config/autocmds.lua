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
