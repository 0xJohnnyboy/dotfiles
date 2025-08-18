return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
        local telescope = require('telescope')

        telescope.setup()
        telescope.load_extension("file_browser")
        telescope.load_extension("live_grep_args")
        -- telescope.load_extension("zf-native")
        -- telescope.load_extension("notify")
    end,
}
