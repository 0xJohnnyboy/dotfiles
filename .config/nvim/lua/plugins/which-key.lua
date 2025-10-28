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

            { "<leader>T",   group = "Tabs" },
            { "<leader>Tc",  ":tabclose<CR>",                                                            desc = "Close" },
            { "<leader>Tn",  ":tabnext<CR>",                                                             desc = "Next" },
            { "<leader>Tp",  ":tabprev<CR>",                                                             desc = "Prev" },
            { "<leader>Tt",  ":tabnew<CR>",                                                              desc = "New" },

            { "<leader>t",   group = "Tests" },
            { "<leader>tr",  ":lua require('neotest').run.run()<cr>",                                    desc = "Run nearest test" },
            { "<leader>ts",  ":lua require('neotest').run.stop()<cr>",                                   desc = "Stop test" },
            { "<leader>tf",  ":lua require('neotest').run.run(vim.fn.expand('%'))<cr>",                  desc = "Run test file" },
            { "<leader>ta",  ":lua require('neotest').run.run({ suite = true })<cr>",                    desc = "Run all tests" },
            { "<leader>to",  ":lua require('neotest').output_panel.toggle()<cr>",                        desc = "Toggle output panel" },
            { "<leader>tS",  ":lua require('neotest').summary.toggle()<cr>",                             desc = "Toggle summary" },
            { "<leader>td",  ":lua require('neotest').run.run({strategy = 'dap'})<cr>",                  desc = "Debug nearest test" },

            { "<leader>d",   group = "Debug" },
            { "<leader>db",  ":lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",       desc = "Toggle breakpoint" },
            { "<leader>dB",  ":lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>", desc = "Conditional breakpoint" },
            { "<leader>dC",  ":Telescope dap commands<cr>",                                              desc = "DAP commands" },
            { "<leader>dc",  ":lua require('dap').continue()<cr>",                                       desc = "Continue" },
            { "<leader>di",  ":lua require('dap').step_into()<cr>",                                      desc = "Step into" },
            { "<leader>do",  ":lua require('dap').step_over()<cr>",                                      desc = "Step over" },
            { "<leader>dO",  ":lua require('dap').step_out()<cr>",                                       desc = "Step out" },
            { "<leader>dr",  ":lua require('dap').repl.open()<cr>",                                      desc = "Open REPL" },
            { "<leader>dl",  ":lua require('dap').run_last()<cr>",                                       desc = "Run last" },
            { "<leader>dt",  ":lua require('dap').terminate()<cr>",                                      desc = "Terminate" },
            { "<leader>du",  ":lua require('dapui').toggle()<cr>",                                       desc = "Toggle UI" },
            { "<leader>dv",  ":Telescope dap variables<cr>",                                             desc = "View variables" },
            { "<leader>df",  ":Telescope dap frames<cr>",                                                desc = "View frames" },
            { "<leader>dL",  ":Telescope dap list_breakpoints<cr>",                                      desc = "List breakpoints" },
            { "<leader>dx",  ":lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>",  desc = "Clear all breakpoints" },
            { "<leader>dg",  ":lua require('dap-go').debug_test()<cr>",                                  desc = "Debug Go test" },
            { "<leader>dG",  ":lua require('dap-go').debug_last_test()<cr>",                             desc = "Debug last Go test" },

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
