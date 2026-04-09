return {
    cmd = { vim.fn.expand('~/.local/bin/vscode-eslint-language-server'), '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
        'svelte',
    },
    root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', 'eslint.config.js', 'package.json', '.git' },
}
