return {
    cmd = { vim.fn.expand('~/.local/bin/astro-ls'), '--stdio' },
    filetypes = { 'astro' },
    root_markers = { 'package.json', 'astro.config.mjs', 'astro.config.ts', '.git' },
}
