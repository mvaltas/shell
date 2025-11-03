-- simple maps (no binding with function)
local map_opts = {noremap = true, silent = false}

vim.keymap.set('n', '<leader><leader>', '<c-^>', map_opts) -- '\\' alternate between buffers
vim.keymap.set('', '<C-z>', ':wa|:suspend<cr>', map_opts)  -- save files when suspending with CTRL-Z
vim.keymap.set('', 'Q', '<nop>', map_opts)                 -- disable Ex Mode
vim.keymap.set('n','<ESC>',':nohlsearch<cr>', map_opts)    -- disable search highlight on ESC

