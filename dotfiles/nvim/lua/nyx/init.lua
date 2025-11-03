local log = function(msg)
  vim.notify("nyx-debug: " .. msg, vim.log.levels.DEBUG)
end

local function load_nyx()
  log("loading nyx")
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")

  vim.o.background = "dark" -- what else?

  local pallete = require("nyx.pallete")
  local groups = require("nyx.groups").groups(pallete)

  for group, setting in pairs(groups) do
    vim.api.nvim_set_hl(0, group, setting)
  end

end

return {
  load = load_nyx
}
