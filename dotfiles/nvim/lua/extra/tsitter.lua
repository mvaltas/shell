-- nvim: lua

-- Neovim 0.12: highlight is auto-enabled when a parser is available.
-- neovim-treesitter (fork) handles parser/query management only — no setup() needed.

-- Incremental selection using native vim.treesitter API
local _sel_stack = {}

local function select_node(node)
  if not node then return end
  local srow, scol, erow, ecol = node:range()
  vim.api.nvim_buf_set_mark(0, '<', srow + 1, scol, {})
  vim.api.nvim_buf_set_mark(0, '>', erow + 1, math.max(ecol - 1, 0), {})
  vim.cmd('normal! gv')
end

-- gni: start selection at cursor node (normal mode)
vim.keymap.set('n', 'gni', function()
  local node = vim.treesitter.get_node()
  if not node then return end
  _sel_stack = { node }
  select_node(node)
end, { noremap = true, silent = true })

-- gnn: expand to parent node (visual mode)
vim.keymap.set('x', 'gnn', function()
  local node = _sel_stack[#_sel_stack]
  if not node then return end
  local parent = node:parent()
  if parent then
    table.insert(_sel_stack, parent)
    select_node(parent)
  end
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
