return {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    build = function()
        vim.system({ "go", "install", "github.com/cweill/gotests/gotests@latest" }):wait()
        vim.system({ "go", "install", "github.com/koron/iferr@latest" }):wait()
    end,
    opts = {},
}
