return {
    '0xJohnnyboy/scretch.nvim',
    -- dir = '~/projects/perso/scretch.nvim',
    config = function()
        require('scretch').setup({
            use_project_dir = {
                scretch = 'auto'
            },
        })
    end
}
