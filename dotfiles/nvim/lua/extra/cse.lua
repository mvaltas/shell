
-- CSE - Clear Screen and Execute
-- Allows to trigger any command rapidly and see its
-- output for testing loop such as TDD
--
-- Based in two functions and a command:
--  cse() -- executes the command
--  quick_cse() -- sets <leader>r to the command to be executed
--  QuickCSE args -- where 'args' is the command you want to run
local function cse(cmd)
  vim.cmd('wa')    -- save everything
  vim.cmd('split') -- split window
  local buf = vim.api.nvim_create_buf(false, true) -- tests buffer
  local win = vim.api.nvim_get_current_win() -- get a points to tests window
  vim.api.nvim_set_current_buf(buf) -- focus on tests buffer

  -- execute command
  vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code)
      vim.api.nvim_win_call(win, function()
        vim.cmd('normal! G') -- scroll to the bottom
      end)
    end
  })

  local close = function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  -- ESC or Enter will close the window
  vim.keymap.set('n', '<Esc>', close, { buffer = buf })
  vim.keymap.set('n', '<CR>', close, { buffer = buf })
end

-- the function that calls CSE
local function quick_cse(cmd)
  vim.keymap.set('n', '<leader>r', function()
    cse(cmd)
  end, {
    desc = 'Run: ' .. cmd,
    silent = true
  })
  vim.notify('Mapped <leader>r to: ' .. cmd, vim.log.levels.INFO)
end
-- end of quick_cse

-- the user command shortcut for CSE
vim.api.nvim_create_user_command('QuickCSE', function(opts)
  quick_cse(opts.args)
end, {
  nargs = '*',
  desc = 'Set up <leader>r mapping for test runner'
})
-- end of user command

-- open file in last position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g'\"",false)
    end
  end
})
