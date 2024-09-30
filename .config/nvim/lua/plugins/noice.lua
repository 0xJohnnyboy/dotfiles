require("noice").setup({
    views = {
        cmdline_popup = {
            position = {
                row = "40%",
                col = "50%",
            },
            size = {
                width = 60,
                height = "auto",
            },
        },
        popupmenu = {
            relative = "editor",
            position = {
                row = "55%",
                col = "50%",
            },
            size = {
                width = 60,
                height = 10,
            },
            border = {
                style = "rounded",
                padding = { 0, 1 },
            },
            win_options = {
                winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
        },
    },
    routes = {
        {
            view = 'mini',
            filter = {
                event = 'msg_showmode',
                any = {
                    { find = 'recording' },
                },
            },
        },
    },
})

