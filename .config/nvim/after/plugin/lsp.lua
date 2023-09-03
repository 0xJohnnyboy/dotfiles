local lsp = require('lsp-zero').preset({
    suggest_lsp_servers = true,
})
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    vim.keymap.set("n", "<leader>la", function () vim.lsp.buf.code_action() end)
    vim.keymap.set("n", "<leader>lf", function () vim.lsp.buf.format() end)
    vim.keymap.set("n", "<leader>lo", function () vim.lsp.buf.open_float() end)
    vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end)
    vim.keymap.set("n", "gD", function () vim.lsp.buf.declaration() end)
    vim.keymap.set("n", "gI", function () vim.lsp.buf.implementation() end)
    vim.keymap.set("n", "go", function () vim.lsp.buf.type_definition() end)
    vim.keymap.set("n", "gr", function () vim.lsp.buf.references() end)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

cmp.setup({
    mapping = {
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    cmp.confirm()
                end
            else
                fallback()
            end
        end, { "i", "s", "c", }),
        ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
        end, { "i", "s", "c", })
    }
})

lsp.setup()
