return {
    cmd = { vim.fn.expand('~/.local/bin/typescript-language-server'), '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_markers = {
        'next.config.js',
        'next.config.mjs',
        'next.config.ts',
        'tsconfig.json',
        'jsconfig.json',
        'package.json',
        '.git',
    },
}
