# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using Lua with lazy.nvim as the plugin manager. The configuration uses Neovim's built-in LSP (not nvim-lspconfig) and built-in completion (not nvim-cmp), taking a minimal dependency approach.

## Architecture

### Directory Structure

```
.
├── init.lua                    # Entry point: sets options, leader keys, LSP enable
├── lazy-lock.json              # Plugin lock file (44 plugins)
├── lsp/                        # LSP server configurations (returns tables with cmd, filetypes, root_markers)
│   ├── gopls.lua
│   ├── lua_ls.lua
│   └── ts_ls.lua
├── lua/
│   ├── config/
│   │   ├── lazy.lua           # Bootstrap lazy.nvim, import plugins/
│   │   └── autocmds.lua       # LspAttach keybinds, Fern auto-quit logic
│   └── plugins/               # Individual plugin specs (26 files)
│       ├── telescope.lua      # Fuzzy finder
│       ├── which-key.lua      # Keymap helper
│       ├── treesitter.lua     # Syntax & text objects
│       ├── neotest.lua        # Test runner (Go)
│       ├── mason.lua          # LSP installer
│       └── ...
└── scretch/                   # Scratch buffers (gitignored)
```

### Plugin Management

- **Manager**: lazy.nvim (auto-bootstrapped in lua/config/lazy.lua)
- **Spec Location**: All plugin specs in `lua/plugins/` are auto-imported via `{ import = "plugins" }`
- **Lock File**: `lazy-lock.json` tracks exact commits for reproducibility
- **Auto-update**: Checker enabled, will notify of plugin updates

### LSP Configuration

LSP uses Neovim's native `vim.lsp.enable()` API (init.lua:29-36) with manual server configurations:

1. Each language server has a config file in `lsp/` that returns:
   ```lua
   {
       cmd = { 'server-binary' },
       filetypes = { 'filetype' },
       root_markers = { 'marker-file', '.git' },
       settings = { ... }  -- optional
   }
   ```

2. Enabled servers: angular, astro, eslint, gopls, lua_ls, typescript

3. LSP keybindings are set dynamically via LspAttach autocmd (lua/config/autocmds.lua:1-15):
   - `<C-I>` (insert mode): Manual completion trigger
   - `<leader>lf`: Format buffer async

4. Completion uses built-in `vim.lsp.completion` with autotrigger enabled

### Adding a New LSP Server

1. Create `lsp/<servername>.lua` with server config
2. Add server name to `vim.lsp.enable()` in init.lua
3. Optionally install via Mason (`:Mason`)

Example:
```lua
-- lsp/rust_analyzer.lua
return {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', '.git' }
}
```

## Key Conventions

### Leader Keys
- `<leader>` = Space
- `<localleader>` = Comma

### Keymap Organization (via which-key)

All keymaps are documented and organized into groups:

| Prefix | Group | Examples |
|--------|-------|----------|
| `<leader>b` | Buffer | `bd` close, `bn` next, `bp` prev |
| `<leader>c` | Comment | `cl` line, `cb` block |
| `<leader>d` | Debug (DAP) | `db` breakpoint, `dc` continue, `di` step into |
| `<leader>e` | Fern explorer | `ee` toggle, `es` show current |
| `<leader>f` | Find (Telescope) | `ff` files, `fs` symbols, `ft` todos |
| `<leader>p` | Project | `pf` git files, `ps` live grep, `pt` explorer |
| `<leader>s` | Scretch | `sn` new, `sl` last, `ss` search |
| `<leader>t` | Test (Neotest) | `tr` run nearest, `tf` file, `ta` all, `td` debug |
| `<leader>x` | Trouble diagnostics | `xx` toggle, `xd` document |
| `<leader>Gf` | Grug-far (find/replace) | Opens find/replace UI |
| `<leader>R` | REST client (Kulala) | `Rs` send, `Ra` send all |

### Plugin Configuration Patterns

Three common patterns used:

1. **Minimal** (no config needed):
   ```lua
   return { 'owner/repo' }
   ```

2. **Config function**:
   ```lua
   return {
       'owner/repo',
       config = function()
           require('plugin').setup({ ... })
       end
   }
   ```

3. **Opts table** (lazy.nvim auto-calls setup):
   ```lua
   return {
       'owner/repo',
       opts = { ... }  -- Passed to plugin.setup()
   }
   ```

### Loading Strategies

Plugins use various lazy-loading strategies:
- `lazy = false`: Load immediately (e.g., snacks, scretch)
- `event = "VeryLazy"`: Load after startup (e.g., which-key)
- `cmd = "Command"`: Load on command (e.g., store.nvim)
- `keys = { ... }`: Load on keypress (e.g., fern-preview)

## Testing (Go-specific)

Neotest is configured for Go with gotestsum runner:

- **Test nearest**: `<leader>tr`
- **Test file**: `<leader>tf`
- **Test all**: `<leader>ta`
- **Test output**: `<leader>to`
- **Test summary**: `<leader>tS`
- **Stop test**: `<leader>ts`

The configuration uses `gotestsum` (installed via build hook in lua/plugins/neotest.lua:16-18) with `-v` and `-count=1` flags.

**Requirements**:
- `tree-sitter` CLI must be installed and on PATH (`npm install -g tree-sitter-cli`)
- nvim-treesitter must be on the `main` branch (neotest-golang v2+ requirement)
- nvim-treesitter-textobjects must be on the `main` branch
- Treesitter Go parser must be installed
- Must be in a Go module (go.mod file in project root or parent directory)
- Tests must follow Go naming conventions (`*_test.go` files, `TestXxx` functions)
- CGO_ENABLED is required for `-race` flag (currently disabled)

## Debugging (Go-specific)

Debugging is configured using nvim-dap with nvim-dap-go adapter and nvim-dap-ui for visual interface:

### Debug Keybindings

**Breakpoints:**
- `<leader>db`: Toggle breakpoint at current line
- `<leader>dB`: Set conditional breakpoint

**Execution Control:**
- `<leader>dc`: Continue/Start debugging
- `<leader>di`: Step into function
- `<leader>do`: Step over line
- `<leader>dO`: Step out of function
- `<leader>dt`: Terminate debug session

**Interface:**
- `<leader>du`: Toggle DAP UI
- `<leader>dr`: Open REPL

**Go-specific:**
- `<leader>dg`: Debug nearest Go test (using treesitter)
- `<leader>dG`: Debug last Go test
- `<leader>td`: Debug nearest test via neotest

### DAP UI

The DAP UI automatically opens when a debug session starts and closes when it ends. It provides:
- **Left panel**: Scopes, breakpoints, stacks, watches
- **Bottom panel**: REPL and console output

### Neotest Integration

DAP is integrated with neotest-golang, allowing you to debug tests directly from neotest:
- Use `<leader>td` to debug the nearest test with full DAP support
- Breakpoints work seamlessly with test debugging

**Requirements**:
- Delve debugger (`go install github.com/go-delve/delve/cmd/dlv@latest`)
- nvim-dap, nvim-dap-go, and nvim-dap-ui plugins
- `dap_go_enabled = true` in neotest-golang configuration

## Important Settings

From init.lua:

```lua
vim.opt.shiftwidth = 4           -- Indentation = 4 spaces
vim.opt.tabstop = 4              -- Tab = 4 spaces
vim.opt.expandtab = true         -- Use spaces, not tabs
vim.opt.relativenumber = true    -- Relative line numbers
vim.wo.scrolloff = 10            -- Keep 10 lines above/below cursor
vim.opt.showmode = false         -- Mode shown in lualine instead
```

Transparent background is enabled to match WezTerm terminal transparency (init.lua:23-25, lua/config/lazy.lua:18-20).

## File Explorer (Fern)

- Uses Nerd Font icons (`vim.g['fern#renderer'] = 'nerdfont'`)
- Auto-quits Neovim when Fern is the last buffer (lua/config/autocmds.lua:20-42)
- Netrw is disabled in favor of Fern (init.lua:3-4)

## Treesitter Configuration

Treesitter uses the `main` branch (required for neotest-golang v2+), which has a completely different API than the frozen `master` branch:

- Uses minimal `require('nvim-treesitter').setup()` API
- Parsers are installed via `require('nvim-treesitter').install()`
- Requires `tree-sitter` CLI binary on PATH
- Textobjects configuration removed in main branch (nvim-treesitter-textobjects plugin manages this independently)

**Note**: The main branch is a complete rewrite and incompatible with master branch configurations. All syntax highlighting is enabled via Neovim's native treesitter API.

## Common Tasks

### Viewing plugin status
```vim
:Lazy
```

### Installing language servers
```vim
:Mason
```

### Finding files/symbols
- `<leader>ff`: Find files
- `<leader>fs`: Find symbols (LSP)
- `<leader>ps`: Live grep in project

### Running tests (Go)
- `<leader>tr`: Run nearest test
- `<leader>tf`: Run current file tests
- `<leader>ta`: Run all tests
- `<leader>td`: Debug nearest test

### Debugging (Go)
- `<leader>db`: Set breakpoint
- `<leader>dc`: Start/continue debugging
- `<leader>di`/`do`/`dO`: Step into/over/out
- `<leader>dg`: Debug nearest Go test
- `<leader>du`: Toggle debug UI

### Working with REST APIs
- Open .http or .rest file
- `<leader>Rs`: Send current request
- `<leader>Rb`: Open scratchpad

## Plugin Installation

When adding a new plugin:

1. Create `lua/plugins/pluginname.lua`
2. Return a lazy.nvim spec table
3. Lazy.nvim auto-detects and loads it (no need to require)
4. Restart Neovim or `:Lazy sync`

Example:
```lua
-- lua/plugins/myplugin.lua
return {
    'author/myplugin',
    config = function()
        require('myplugin').setup({
            option = "value"
        })
    end
}
```
