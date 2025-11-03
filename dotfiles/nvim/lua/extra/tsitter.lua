-- nvim: lua

-- treesitter configuration
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<cr>",
      node_incremental = "<C-w>",
      node_decremental = "<C-S-w>",
      scope_incremental = "grc",
    },
  },
}
-- end treesitter configuration

