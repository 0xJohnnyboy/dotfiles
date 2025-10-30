return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            branch = 'main',
        },
    },
    config = function()
        -- New main branch API - minimal setup
        require('nvim-treesitter').setup()

        -- Install parsers
        local parsers = { "lua", "vim", "vimdoc", "query", "go", "typescript", "javascript", "html", "css", "http", "json" }
        require('nvim-treesitter').install(parsers)

        -- Enable highlighting using Neovim's native API
        vim.treesitter.language.register('go', 'go')
    end
}
