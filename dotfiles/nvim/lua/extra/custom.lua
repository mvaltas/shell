
-- Rename file in place <leader>n
-- this based on Gary Bernhardt (https://github.com/garybernhardt/dotfiles/blob/eed3bbab874f15ddbaaf0341fac1923c12b30b5b/.vimrc#L301C15-L301C16)
local function rename_file()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('New file name: ', vim.fn.expand('%'), 'file')
  if new_name ~= '' and new_name ~= old_name then
    vim.cmd('saveas ' .. new_name)
    vim.fn.delete(old_name)
    vim.cmd('redraw!')
  end
end
vim.keymap.set('n', '<leader>n', rename_file, { desc = 'Rename current file' })
-- end of rename in place

local function close_floating_windows()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == 'win' then
      vim.api.nvim_win_close(win, false)
    end
  end
end
vim.keymap.set('n', '<ESC>', close_floating_windows, { desc = 'Close all floating windows' })

