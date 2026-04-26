return {
    cmd = { vim.fn.expand('~/.local/bin/vscode-html-language-server'), '--stdio' },
    filetypes = { 'html' },
    root_markers = {
        'package.json',
        '.git',
    },
}
