return {
    'williamboman/mason.nvim',
    config = function()
        require('mason').setup({
            log_level = vim.log.levels.DEBUG
        })
    end,
}
