-- nvim: lua

-- Neovim 0.12: highlight is auto-enabled when a parser is available.
-- neovim-treesitter (fork) handles parser/query management only — no setup() needed.

-- Incremental selection using native vim.treesitter API
local _sel_stack = {}

local ESC = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)

local function select_node(node)
  if not node then return end
  local srow, scol, erow, ecol = node:range()
  vim.api.nvim_feedkeys(ESC, 'nx', false)                             -- exit any current mode
  vim.api.nvim_win_set_cursor(0, { srow + 1, scol })                  -- move to start
  vim.api.nvim_feedkeys('v', 'nx', false)                             -- enter characterwise visual
  vim.api.nvim_win_set_cursor(0, { erow + 1, math.max(ecol - 1, 0) }) -- extend to end
end

-- gni: start selection at cursor node (normal mode)
vim.keymap.set('n', 'gni', function()
  pcall(vim.treesitter.start)            -- start parser if not already running
  local node = vim.treesitter.get_node()
  if not node then
    vim.notify('No treesitter parser available for this filetype', vim.log.levels.WARN)
    return
  end
  _sel_stack = { node }
  select_node(node)
end, { noremap = true, silent = true })

-- gnn: expand to parent node (visual mode)
vim.keymap.set('x', 'gnn', function()
  local node = _sel_stack[#_sel_stack]
  if not node then return end
  local parent = node:parent()
  if not parent then
    vim.notify('Already at tree root', vim.log.levels.INFO)
    return
  end
  table.insert(_sel_stack, parent)
  select_node(parent)
end, { noremap = true, silent = true })

-- gnm: shrink to previous node (visual mode)
vim.keymap.set('x', 'gnm', function()
  if #_sel_stack > 1 then
    table.remove(_sel_stack)
    select_node(_sel_stack[#_sel_stack])
  end
end, { noremap = true, silent = true })

-- gns: expand to enclosing scope node (visual mode)
vim.keymap.set('x', 'gns', function()
  local node = _sel_stack[#_sel_stack]
  if not node then return end
  local parent = node:parent()
  while parent do
    local t = parent:type()
    if t:match('block') or t:match('body') or t:match('function') or t:match('class') then
      table.insert(_sel_stack, parent)
      select_node(parent)
      return
    end
    parent = parent:parent()
  end
end, { noremap = true, silent = true })
