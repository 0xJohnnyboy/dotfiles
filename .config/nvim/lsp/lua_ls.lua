return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.git', '.stylua.toml', 'stylua.toml' },
    settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT'
      },
      diagnostics = {
        globals = {'vim'}
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = {
        enable = false
      }
    }
  },
    single_file_support = true
}
