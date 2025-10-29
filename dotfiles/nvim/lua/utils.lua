local utils = {}

-- The function is called `t` for `termcodes`.
-- transform <c-x>, <tab>, <cr> into bytes
-- which neovim understand as keystroke
utils.t = function (str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- work around while https://github.com/neovim/neovim/pull/13479 is open
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
utils.opt = function (scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

-- helper map function
utils.map = function (mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- require all lua files in 'lua/' with 'directory'
utils.load_all = function (directory)
  local path = vim.fn.stdpath("config") .. "/lua/" .. directory
  local files = vim.fn.readdir(path, [[v:val =~ '\.lua$']])
  for _, file in ipairs(files) do
    require(directory .. "." .. file:gsub("%.lua$", ""))
  end
end

-- returns this table of functions
return utils
