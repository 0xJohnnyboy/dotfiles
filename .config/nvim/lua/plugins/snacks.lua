return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        animate = {
            enabled = true,
            duration = 5,         -- ms per step
            easing = "inOutQuad",
            fps = 60,             -- frames per second. Global setting for all animations
        },
        bigfile = {
            enabled = true,
            notify = true,
            size = 1.5 * 1024 * 1024,
            line_length = 1000,
            ---@param ctx {buf: number, ft:string}
            setup = function(ctx)
                if vim.fn.exists(":NoMatchParen") ~= 0 then
                    vim.cmd([[NoMatchParen]])
                end
                Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
                vim.b.minianimate_disable = true
                vim.schedule(function()
                    if vim.api.nvim_buf_is_valid(ctx.buf) then
                        vim.bo[ctx.buf].syntax = ctx.ft
                    end
                end)
            end,
        },
        dashboard = {
            enabled = true,
            sections = {
                { section = "header" },
                {
                    pane = 2,
                    section = "terminal",
                    -- cmd = "colorscript -e square",
                    cmd = "",
                    height = 5,
                    padding = 1,
                },
                { section = "keys", gap = 1, padding = 1 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    title = "Git Status",
                    section = "terminal",
                    enabled = function()
                        return Snacks.git.get_root() ~= nil
                    end,
                    cmd = "git status --short --branch --renames",
                    height = 5,
                    padding = 1,
                    ttl = 5 * 60,
                    indent = 3,
                },
                { section = "startup" },
            },
        },
        dim = {
            enabled = true,
            scope = {
                min_size = 5,
                max_size = 20,
                siblings = true,
            },
            -- animate scopes. Enabled by default for Neovim >= 0.10
            -- Works on older versions but has to trigger redraws during animation.
            ---@type snacks.animate.Config|{enabled?: boolean}
            animate = {
                enabled = vim.fn.has("nvim-0.10") == 1,
                easing = "outQuad",
                duration = {
                    step = 20,           -- ms per step
                    total = 300,         -- maximum duration
                },
            },
            -- what buffers to dim
            filter = function(buf)
                return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
            end,
        },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        -- words = { enabled = true },
    },
}
