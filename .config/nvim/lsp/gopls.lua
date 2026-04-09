return {
    cmd = { vim.fn.expand('~/go/bin/gopls') },
    filetypes = { 'go' },
    root_markers = { 'go.mod', 'go.work', 'go.sum', '.git' }
}
