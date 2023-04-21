local lsp = require('lsp-zero').preset({
	suggest_lsp_servers = true,
})

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'lua_ls',
})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
