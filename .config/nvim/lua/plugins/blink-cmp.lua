return {
    "saghen/blink.cmp",
    version = "*",
    opts = {
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
            ghost_text = { enabled = true },
        },
        signature = { enabled = true },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
    },
    opts_extend = { "sources.default" },
}
