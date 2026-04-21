return {
    cmd = { vim.fn.expand('~/.local/bin/ngserver'), '--stdio' },
    filetypes = { 'typescript', 'html' },
    root_markers = { 'angular.json', 'project.json', 'package.json', '.git' },
}
