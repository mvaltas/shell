local log = function(msg)
  vim.notify("nyx-debug: " .. msg, vim.log.levels.DEBUG)
end

local function load_nyx()
  log("loading nyx colorscheme")
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")

  vim.o.background = "dark" -- what else?

  local colors = require("nyx.colors")
  local groups = require("nyx.groups").groups(colors)

  for group, setting in pairs(groups) do
    vim.api.nvim_set_hl(0, group, setting)
  end

end

return {
  load = load_nyx
}
