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

return {
  load = load_nyx,
}
