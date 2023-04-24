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

    vim.keymap.set("n", "<leader>ca", function () vim.lsp.buf.code_action() end)
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
