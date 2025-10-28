-- Plugin: nvim-neotest/neotest
-- Installed via store.nvim

-- file: lua/plugins/neotest-golang.lua
return {
    "nvim-neotest/neotest",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "mfussenegger/nvim-dap",
        "leoluz/nvim-dap-go",
        {
            "fredrikaverpil/neotest-golang",
            version = "*",
            build = function()
                vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
            end,
        },
    },
    -- opts = {
    --     adapters = {
    --         ["neotest-golang"] = {
    --             -- Here we can set options for neotest-golang, e.g.
    --             -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
    --             dap_go_enabled = false, -- requires leoluz/nvim-dap-go
    --             runner = "gotestsum",
    --             go_test_args = {
    --                 "-v"
    --             }
    --         },
    --     },
    -- },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-golang")({
                    runner = "gotestsum",
                    go_test_args = { "-v", "-count=1" },
                    dap_go_enabled = true,
                }),
            },
        })
    end,
}
-- https://takia.dev/neotest-golang-issues/
