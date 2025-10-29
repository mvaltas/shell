-- nvim:lua

-- telescope mappings
vim.keymap.set('n','<leader>f',':Telescope find_files<cr>', map_opts)      -- f find files
vim.keymap.set('n','<leader>b',':Telescope buffers<cr>', map_opts)         -- b for buffers
vim.keymap.set('n','<leader>g',':Telescope git_files<cr>', map_opts)       -- g for git
vim.keymap.set('n','<leader>q',':Telescope quickfix<cr>', map_opts)        -- q for quickfix
vim.keymap.set('n','<leader>h',':Telescope help_tags<cr>', map_opts)       -- h for help
vim.keymap.set('n','<leader>e',':Telescope registers<cr>', map_opts)       -- e for registers
vim.keymap.set('n','<leader>c',':Telescope command_history<cr>', map_opts) -- c for command history
vim.keymap.set('n','<leader>o',':Telescope oldfiles<cr>', map_opts)        -- o for command history
vim.keymap.set('n','<leader>a',':Telescope<cr>', map_opts)                 -- a for all

-- treesitter + telescope
vim.keymap.set('n','<leader>d',':Telescope treesitter<cr>', map_opts)      -- d for definitions
vim.keymap.set('n','<leader>df',':Telescope treesitter default_text=:function:<cr>', map_opts) -- functions only
vim.keymap.set('n','<leader>dv',':Telescope treesitter default_text=:var:<cr>', map_opts) -- variables only
vim.keymap.set('n','<leader>dc',':Telescope treesitter default_text=:class:<cr>', map_opts)    -- classes only
vim.keymap.set('n','<leader>di',':Telescope treesitter default_text=:import:<cr>', map_opts)    -- import only

-- telescope greps
vim.keymap.set('n','<leader>l',':Telescope live_grep<cr>', map_opts)       -- l for live_grep
vim.keymap.set('n','<leader>gr',':Telescope grep_string<cr>', map_opts) -- '\gr' current word into Telescope grep_string

-- telescope configuration
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    path_display = {
      'shorten',
      'absolute',
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close -- exit on ESC and not enter on normal mode
      },
    },
  }
}

