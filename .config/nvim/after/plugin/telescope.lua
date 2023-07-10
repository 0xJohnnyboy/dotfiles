local telescope = require('telescope')
local builtin = require('telescope.builtin')
-- local action_state = require('telescope.action_state')
-- local actions = require('telescope.actions')
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
-- local vim = require('vim')

local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require"telescope.builtin".git_files(opts)
  else
    require"telescope.builtin".find_files(opts)
  end
end

-- local function multiopen(prompt_bufnr, method)
--     local edit_file_cmd_map = {
--         vertical = "vsplit",
--         horizontal = "split",
--         tab = "tabedit",
--         default = "edit",
--     }
--     local edit_buf_cmd_map = {
--         vertical = "vert sbuffer",
--         horizontal = "sbuffer",
--         tab = "tab sbuffer",
--         default = "buffer",
--     }
--     local picker = action_state.get_current_picker(prompt_bufnr)
--     local multi_selection = picker:get_multi_selection()
--
--     if #multi_selection > 1 then
--         require("telescope.pickers").on_close_prompt(prompt_bufnr)
--         pcall(vim.api.nvim_set_current_win, picker.original_win_id)
--
--         for i, entry in ipairs(multi_selection) do
--             local filename, row, col
--
--             if entry.path or entry.filename then
--                 filename = entry.path or entry.filename
--
--                 row = entry.row or entry.lnum
--                 col = vim.F.if_nil(entry.col, 1)
--             elseif not entry.bufnr then
--                 local value = entry.value
--                 if not value then
--                     return
--                 end
--
--                 if type(value) == "table" then
--                     value = entry.display
--                 end
--
--                 local sections = vim.split(value, ":")
--
--                 filename = sections[1]
--                 row = tonumber(sections[2])
--                 col = tonumber(sections[3])
--             end
--
--             local entry_bufnr = entry.bufnr
--
--             if entry_bufnr then
--                 if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
--                     vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
--                 end
--                 local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
--                 pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
--             else
--                 local command = i == 1 and "edit" or edit_file_cmd_map[method]
--                 if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
--                     filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
--                     pcall(vim.cmd, string.format("%s %s", command, filename))
--                 end
--             end
--
--             if row and col then
--                 pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
--             end
--         end
--     else
--         actions["select_" .. method](prompt_bufnr)
--     end
-- end

telescope.setup()
telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>bl', builtin.buffers, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>pg', builtin.git_status, {})
vim.keymap.set('n', '<leader>pt', ':Telescope file_browser<CR>', {})
vim.keymap.set("n", "<leader>ps", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<leader>pV", live_grep_args_shortcuts.grep_visual_selection)

return M
