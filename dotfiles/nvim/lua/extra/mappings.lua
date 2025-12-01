-- simple maps (no binding with function)
local map_opts = {noremap = true, silent = false}

vim.keymap.set('n', '<leader><leader>', '<c-^>', map_opts) -- '\\' alternate between buffers
vim.keymap.set('', '<C-z>', ':wa|:suspend<cr>', map_opts)  -- save files when suspending with CTRL-Z
vim.keymap.set('', 'Q', '<nop>', map_opts)                 -- disable Ex Mode
vim.keymap.set('n','<ESC>',':nohlsearch<cr>', map_opts)    -- disable search highlight on ESC

-- Accept selection from pop-up otherwise regular enter
vim.keymap.set("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true })

-- Also based on Gery Bernhardt (https://github.com/garybernhardt/dotfiles/blob/eed3bbab874f15ddbaaf0341fac1923c12b30b5b/.vimrc#L276)
-- Smart tab, will auto complete if there's a character under the cursor
-- otherwise it will just issue a tab
vim.keymap.set("i", "<Tab>", function()
  local cur_col = vim.fn.col(".")
  local line = vim.api.nvim_get_current_line()
  local prev_char = line:sub(cur_col - 1, cur_col - 1)

  -- If popup menu open: navigate it
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  end

  -- If previous char is a word char: trigger completion
  if prev_char:match("[%w%.]") then
    return "<C-x><C-o>"   -- LSP if available, omnifunc otherwise
  end

  -- Otherwise: literal Tab
  return "<Tab>"
end, { expr = true, noremap = true })

