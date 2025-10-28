return {
    'leoluz/nvim-dap-go',
    dependencies = {
        'mfussenegger/nvim-dap',
        'nvim-treesitter/nvim-treesitter',
    },
    ft = 'go',
    config = function()
        require('dap-go').setup({
            -- Path to delve (default: 'dlv')
            delve = {
                path = 'dlv',
                initialize_timeout_sec = 20,
                port = "${port}",
                args = {},
                build_flags = "",
                detached = vim.fn.has("win32") == 0,
            },
            -- Test options
            tests = {
                verbose = false,
            },
        })
    end
}
