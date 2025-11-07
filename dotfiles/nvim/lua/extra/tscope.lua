-- nvim:lua
local map_opts = {noremap = true, silent = false}

-- A pain stakingly documented table of mnemonics of Telescope to
-- impress my friends and find stuff easy.

-- telescope mappings
vim.keymap.set('n','<leader>f',':Telescope find_files<cr>', map_opts)      -- f for (F)ind files
vim.keymap.set('n','<leader>b',':Telescope buffers<cr>', map_opts)         -- b for (B)uffers
vim.keymap.set('n','<leader>q',':Telescope quickfix<cr>', map_opts)        -- q for (Q)uickfix
vim.keymap.set('n','<leader>h',':Telescope help_tags<cr>', map_opts)       -- h for (H)elp
vim.keymap.set('n','<leader>e',':Telescope registers<cr>', map_opts)       -- e for r(E)gisters
vim.keymap.set('n','<leader>c',':Telescope command_history<cr>', map_opts) -- c for (C)ommand history
vim.keymap.set('n','<leader>o',':Telescope oldfiles<cr>', map_opts)        -- o for (O)ld files
vim.keymap.set('n','<leader>a',':Telescope<cr>', map_opts)                 -- a for (A)ll

-- telescope gitsigns
vim.keymap.set('n','<leader>s',':Telescope git_signs<cr>', map_opts)       -- s for git (S)igns

-- telescope greps
vim.keymap.set('n','<leader>gl',':Telescope live_grep<cr>', map_opts)   -- gl for (G)rep (L)ive
vim.keymap.set('n','<leader>gr',':Telescope grep_string<cr>', map_opts) -- gr for (GR)ep [on word]

-- lsp + telescope
vim.keymap.set('n','<leader>ls',':Telescope lsp_workspace_symbols<cr>', map_opts) -- ls for (L)sp workspace (S)ymbols
vim.keymap.set('n','<leader>ld',':Telescope lsp_definitions<cr>', map_opts)       -- ls for (L)sp (D)efinitions
vim.keymap.set('n','<leader>li',':Telescope lsp_implementations<cr>', map_opts)  -- ls for (L)sp (I)implementations
vim.keymap.set('n','<leader>ln',':Telescope lsp_incoming_calls<cr>', map_opts)    -- ls for (L)sp i(N)coming calls
vim.keymap.set('n','<leader>lu',':Telescope lsp_outgoing_calls<cr>', map_opts)    -- ls for (L)sp o(U)tgoing calls

-- Default texts for Telescope.
local function tscope_maps(command, shortcuts)
  for k, v in pairs(shortcuts) do
    vim.keymap.set('n','<leader>'..k,':Telescope '..command..' default_text=:'..v..':<cr>', map_opts)
  end
end


-- LSP symbols (\l and wait)
vim.keymap.set('n','<leader>ll',':Telescope lsp_document_symbols<cr>', map_opts)  -- ls for (L)sp (S)ymbols
-- LSP default texts
tscope_maps('lsp_document_symbols', {
  ['lm'] = 'method',      -- (L)sp (M)ethod
  ['lf'] = 'function',    -- (L)sp (F)unction
  ['lv'] = 'variable',    -- (L)sp (V)ariable
  ['lc'] = 'class',       -- (L)sp (C)lass
  ['lp'] = 'property',    -- (L)sp (P)roperty
  ['lo'] = 'object',      -- (L)sp (O)object
  ['lt'] = 'constant',    -- (L)sp cons(T)ant
  ['lr'] = 'constructor', -- (L)sp const(R)uctor
})

-- Treesitter symbols (\d and wait)
vim.keymap.set('n','<leader>dd',':Telescope treesitter<cr>', map_opts) -- d  for all (D)efinitions
-- Treesitter default texts
tscope_maps('treesitter', {
  ['dm'] = 'method',   -- (D)ef  (M)ethod
  ['df'] = 'function', -- (D)def (F)functions
  ['dv'] = 'var',      -- (D)def (V)ariables
  ['dc'] = 'class',    -- (D)ef  (C)lass
  ['di'] = 'import',   -- (D)ef  (I)mport
})

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
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('git_signs')
