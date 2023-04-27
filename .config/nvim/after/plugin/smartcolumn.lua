local config = {
    colorcolumn = "120",
    disabled_filetypes = { "help", "text", "markdown" },
    custom_colorcolumn = {},
    scope = "line",
}

require("smartcolumn").setup(config)
