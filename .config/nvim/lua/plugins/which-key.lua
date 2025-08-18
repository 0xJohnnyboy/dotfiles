return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        local telescope = require("telescope.builtin")
        local telescope_live_grep = require("telescope-live-grep-args.shortcuts")
        local scretch = require("scretch")
        wk.setup({
            -- ignore_missing = true
        })

        wk.add({
            { "<leader>\\",  ":noh<CR>",                                                                 desc = "Remove highlighting after search" },

            { "<leader>b",   group = "buffer" },
            { "<leader>bd",  ":bd!<CR>",                                                                 desc = "Close buffer" },
            { "<leader>bl",  telescope.buffers,                                                          desc = "List buffers" },
            { "<leader>bn",  ":bnext<CR>",                                                               desc = "Next buffer" },
            { "<leader>bp",  ":bprevious<CR>",                                                           desc = "Previous buffer" },
            { "<leader>br",  ":redraw<CR>",                                                              desc = "Refresh buffers (redraw)" },
            { "<leader>bx",  ":%bd|e#<CR>",                                                              desc = "Close all buffers but the current one" },

            { "<leader>c",   group = "Comment" },
            { "<leader>cA",  desc = "Insert comment at the end of the line" },
            { "<leader>cO",  desc = "Insert comment on the line above" },
            { "<leader>cb",  desc = "Toggle block comment" },
            { "<leader>cl",  desc = "Toggle line comment" },
            { "<leader>co",  desc = "Insert comment on the line below" },

            { "<leader>e",   group = "Fern" },
            { "<leader>ee",  ":Fern . -drawer -width=60 -toggle -right<CR>",                             desc = "Toggle" },
            { "<leader>es",  ":Fern . -reveal=% -drawer -width=60 -toggle -right<CR>",                   desc = "Show file in tree" },

            { "<leader>f",   group = "Find" },
            { "<leader>ff",  telescope.find_files,                                                       desc = "Files" },
            { "<leader>fo",  telescope.oldfiles,                                                         desc = "Old file" },
            { "<leader>fs",  ":Telescope lsp_document_symbols ignore_symbols=variable<CR>",              desc = "Symbols" },
            { "<leader>ft",  "<cmd>TodoTelescope<CR>",                                                   desc = "Todos" },

            { "<leader>Gf",  "<cmd>GrugFar<cr>",                                                         desc = "Grug far" },

            -- { "<leader>l",   group = "LSP" },
            -- { "<leader>la",  desc = "Code action" },
            -- { "<leader>lf",  desc = "Format" },
            -- { "<leader>lo",  desc = "Open diagnostics float window" },
            -- { "<leader>mp",  desc = "Markdown preview with glow" },

            { "<leader>p",   group = "Project" },
            { "<leader>pf",  telescope.git_files,                                                        desc = "Search project files (git)" },
            { "<leader>pg",  telescope.git_status,                                                       desc = "Project git status" },
            { "<leader>ps",  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Live grep" },
            { "<leader>pt",  ":Telescope file_browser<CR>",                                              desc = "Telescope explorer" },

            { "<leader>s",   group = "Scretch.nvim" },
            { "<leader>sn",  scretch.new,                                                                desc = "New" },
            { "<leader>snn", scretch.new_named,                                                          desc = "New named" },
            { "<leader>sft", scretch.new_from_template,                                                  desc = "New from template" },
            { "<leader>sat", scretch.save_as_template,                                                   desc = "Save as template" },
            { "<leader>sl",  scretch.last,                                                               desc = "Open last" },
            { "<leader>ss",  scretch.search,                                                             desc = "Search" },
            { "<leader>st",  scretch.edit_template,                                                      desc = "Edit template" },
            { "<leader>sg",  scretch.grep,                                                               desc = "Grep" },
            { "<leader>sv",  scretch.explore,                                                            desc = "Explore" },

            { "<leader>t",   group = "Tabs" },
            { "<leader>tc",  ":tabclose<CR>",                                                            desc = "Close" },
            { "<leader>tn",  ":tabnext<CR>",                                                             desc = "Next" },
            { "<leader>tp",  ":tabprev<CR>",                                                             desc = "Prev" },
            { "<leader>tt",  ":tabnew<CR>",                                                              desc = "New" },

            { "<leader>u",   vim.cmd.UndotreeToggle,                                                     desc = "Toggle undotree" },

            { "<leader>w",   proxy = "<C-w>",                                                            group = "Window" },

            { "<leader>x",   group = "Trouble" },
            { "<leader>xx",  "<cmd>Trouble diagnostics toggle<cr>",                                      desc = "Toggle" },
            { "<leader>xd",  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",                         desc = "Document diagnostics" },
            { "<leader>xl",  "<cmd>Trouble loclist toggle<cr>",                                          desc = "Loclist" },
            { "<leader>xq",  "<cmd>Trouble qflist toggle<cr>",                                           desc = "Quickfix List" },
            { "<leader>xR",  "<cmd>Trouble lsp toggle<cr>",                                              desc = "Lsp References" },
            { "<leader>xt",  "<cmd>Trouble todo toggle<cr>",                                             desc = "Todo" },

            -- VISUAL MODE
            {
                mode = { "v" },
                { "<leader>c",  group = "Comment" },
                { "<leader>cb", desc = "Toggle block comment" },
                { "<leader>cl", desc = "Toggle line comment" },

                { "<leader>pV", telescope_live_grep.grep_visual_selection, desc = "Live grep visual selection" },
            },

            -- INSERT MODE
            -- {
            --     mode = { "i" },
            --     { "<C-J>", vim.lsp.completion.get(), desc = "get lsp completion" }
            --
            -- },
        })
    end,
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end
}
