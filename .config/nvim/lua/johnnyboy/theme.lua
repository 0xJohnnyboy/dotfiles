-- Gruvbox initialization
vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- Transparent background because wezterm is already setup with transparency 
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
