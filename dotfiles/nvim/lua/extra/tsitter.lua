-- nvim: lua

-- treesitter configuration
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gni",
      node_incremental = "gnn",
      node_decremental = "gnm",
      scope_incremental = "gns",
    },
  },
}
-- end treesitter configuration

