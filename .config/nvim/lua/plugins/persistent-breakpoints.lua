return {
    'Weissle/persistent-breakpoints.nvim',
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    config = function()
        require('persistent-breakpoints').setup({
            -- Store breakpoints in a project-local file
            save_dir = vim.fn.stdpath("data") .. "/breakpoints",
            -- Load breakpoints on startup
            load_breakpoints_event = { "BufReadPost" },
            -- Enable persistence
            perf = {
                enable = true,
            }
        })
    end
}
