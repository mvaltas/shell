local function load_nyx()
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")

  vim.o.background = "dark" -- what else?
  vim.g.colors_name = "nyx"

  local colors = require("nyx.colors")
  local groups = require("nyx.groups").groups(colors)

  for group, opts in pairs(groups) do
    if opts.link and vim.fn.hlexists(opts.link) == 1 then
      vim.api.nvim_set_hl(0, group, { link = opts.link })
    else
      vim.api.nvim_set_hl(0, group, opts)
    end
  end

end

-- function to display the colors
local function show_colors(colors)
  -- create a new scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
  vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
  vim.api.nvim_set_option_value('swapfile', false, { buf = buf })

  -- prepare lines
  local lines = {}
  local highlights = {}

  for name, hex in pairs(colors) do
    table.insert(lines, string.format("%-15s %s", name, hex))
    -- create a highlight group for this color
    local hl_name = "ShowColor_" .. name
    vim.api.nvim_set_hl(0, hl_name, { fg = hex, bg = colors.bg })
    table.insert(highlights, { line = #lines, hl = hl_name })
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- apply highlights
  for _, hl in ipairs(highlights) do
    vim.hl.range(buf, 0, hl.hl, { hl.line - 1, 15 }, { hl.line - 1, -1 }, { hl_eol = true })
  end

  -- open in a new window
  vim.api.nvim_command("vsplit")
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf})
end


return {
  load = load_nyx,
  show = show_colors
}
