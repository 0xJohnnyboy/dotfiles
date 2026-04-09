local function get_tsdk()
    -- Prefer project-local TypeScript.
    local project_tsdk = vim.fs.find('node_modules/typescript/lib', {
        upward = true,
        path = vim.fn.getcwd(),
        type = 'directory',
    })[1]
    if project_tsdk and vim.fn.isdirectory(project_tsdk) == 1 then
        return project_tsdk
    end

    -- Fallback to globally installed TypeScript.
    local npm_root = vim.fn.systemlist('npm root -g')[1]
    if npm_root and npm_root ~= '' then
        local global_tsdk = npm_root .. '/typescript/lib'
        if vim.fn.isdirectory(global_tsdk) == 1 then
            return global_tsdk
        end
    end

    return nil
end

return {
    cmd = { vim.fn.expand('~/.local/bin/astro-ls'), '--stdio' },
    filetypes = { 'astro' },
    root_markers = { 'package.json', 'astro.config.mjs', 'astro.config.ts', '.git' },
    init_options = {
        typescript = {
            tsdk = get_tsdk(),
        },
    },
}
