-- nvim:lua

-- A pain stakingly documented table of mnemonics of Telescope to
-- impress my friends and find stuff easy.

-- telescope mappings
vim.keymap.set('n','<leader>f',':Telescope find_files<cr>', map_opts)      -- f for (F)ind files
vim.keymap.set('n','<leader>b',':Telescope buffers<cr>', map_opts)         -- b for (B)uffers
vim.keymap.set('n','<leader>g',':Telescope git_files<cr>', map_opts)       -- g for (G)it
vim.keymap.set('n','<leader>q',':Telescope quickfix<cr>', map_opts)        -- q for (Q)uickfix
vim.keymap.set('n','<leader>h',':Telescope help_tags<cr>', map_opts)       -- h for (H)elp
vim.keymap.set('n','<leader>e',':Telescope registers<cr>', map_opts)       -- e for r(E)gisters
vim.keymap.set('n','<leader>c',':Telescope command_history<cr>', map_opts) -- c for (C)ommand history
vim.keymap.set('n','<leader>o',':Telescope oldfiles<cr>', map_opts)        -- o for (O)ld files
vim.keymap.set('n','<leader>a',':Telescope<cr>', map_opts)                 -- a for (A)ll

-- treesitter + telescope
vim.keymap.set('n','<leader>d',':Telescope treesitter<cr>', map_opts)                          -- d  for all (D)efinitions
-- treesitter with pre-typed text...
vim.keymap.set('n','<leader>df',':Telescope treesitter default_text=:function:<cr>', map_opts) -- df for (D)ef (F)unctions
vim.keymap.set('n','<leader>dv',':Telescope treesitter default_text=:var:<cr>', map_opts)      -- dv for (D)ef (V)ariables
vim.keymap.set('n','<leader>dc',':Telescope treesitter default_text=:class:<cr>', map_opts)    -- dc for (D)ef (C)lasses
vim.keymap.set('n','<leader>di',':Telescope treesitter default_text=:import:<cr>', map_opts)   -- di for (D)ef (I)mports
vim.keymap.set('n','<leader>dm',':Telescope treesitter default_text=:method:<cr>', map_opts)   -- dm for (D)ef (M)ethods

-- telescope greps
vim.keymap.set('n','<leader>gl',':Telescope live_grep<cr>', map_opts)   -- gl for (G)rep (L)ive
vim.keymap.set('n','<leader>gr',':Telescope grep_string<cr>', map_opts) -- gr for (GR)ep [on word]

-- LSP + telescope
vim.keymap.set('n','<leader>ls',':Telescope lsp_document_symbols<cr>', map_opts)    -- ls for (L)sp (S)ymbols
vim.keymap.set('n','<leader>ld',':Telescope lsp_definitions<cr>', map_opts)         -- ls for (L)sp (D)efinitions
vim.keymap.set('n','<leader>li',':Telescope lsp_incoming_calls<cr>', map_opts)      -- ls for (L)sp (I)ncoming calls
vim.keymap.set('n','<leader>lo',':Telescope lsp_outgoing_calls<cr>', map_opts)      -- ls for (L)sp (O)utgoing calls

-- LSP with pre-typed text
vim.keymap.set('n','<leader>lm',':Telescope lsp_document_symbols default_text=:method:<cr>', map_opts)      -- ls for (L)sp (O)utgoing calls


-- telescope configuration
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    path_display = {
      'shorten',
      'filename_first',
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close -- exit on ESC and not enter on normal mode
      },
    },
  }
}

