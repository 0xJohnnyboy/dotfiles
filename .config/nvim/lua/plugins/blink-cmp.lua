return {
    "saghen/blink.cmp",
    version = "*",
    opts = {
        enabled = function()
            return vim.bo.filetype ~= "fern"
        end,
        keymap = {
            preset = "default",
            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            documentation = { auto_show = true },
            ghost_text = {
                enabled = function()
                    return vim.bo.filetype ~= "fern"
                end,
            },
        },
        cmdline = {
            completion = {
                ghost_text = {
                    enabled = function()
                        return vim.bo.filetype ~= "fern"
                    end,
                },
            },
        },
        signature = { enabled = true },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
    },
    opts_extend = { "sources.default" },
}
