-- shotcuts to common functions
local opt = vim.opt  -- access to options
local keymap = vim.keymap -- access to keymaps

projectdir = string.gsub("HOME/Projects", "HOME", os.getenv('HOME')) -- User Projects dir

-- plugin management
vim.cmd 'packadd paq-nvim'               -- load the package manager
require "paq" {
    'savq/paq-nvim';                  -- Let Paq manage itself

    -- Feature focused plugins
    'tpope/vim-surround';             -- handle surroundings ()[]"'{} as text objects
    'wellle/targets.vim';             -- lots of text objects (https://mvaltas.com/targets)
    'sainnhe/edge';                   -- Edge color scheme
    'junegunn/vim-easy-align';        -- align text easily

     -- LSP and completion, finding files
    'nvim-lua/popup.nvim';            -- provides popup window functionality
    'neovim/nvim-lspconfig';          -- dependency of the above
    'nvim-lua/plenary.nvim';          -- collection of Lua functions used by plugins
    'nvim-telescope/telescope.nvim';  -- lua/config/tscope.lua
    'nvim-treesitter/nvim-treesitter';-- Configuration and abstraction layer

    -- GIT
    'lewis6991/gitsigns.nvim';         -- git capabilities on neovim

    -- AI
    'augmentcode/augment.vim';         -- lua/config/augment.lua
}

-- colors
vim.g.edge_style = 'aura'
vim.g.edge_colors_override = { 
  bg0 = { '#171717', '235' },
}
vim.cmd 'colorscheme edge'


-- general editor options
vim.opt.expandtab = true                                    -- Use spaces instead of tabs
vim.opt.shiftwidth = 2                                      -- Size of an indent
vim.opt.smartindent = true                                  -- Insert indents automatically
vim.opt.tabstop = 2                                         -- Number of spaces tabs count for
vim.opt.hidden = true                                       -- Enable modified buffers in background
vim.opt.joinspaces = false                                  -- No double spaces with join after a dot
vim.opt.scrolloff = 4                                       -- Lines of context
vim.opt.shiftround = true                                   -- Round indent
vim.opt.sidescrolloff = 8                                   -- Columns of context
vim.opt.smartcase = true                                    -- Don't ignore case with capitals
vim.opt.splitbelow = true                                   -- Put new windows below current
vim.opt.splitright = true                                   -- Put new windows right of current
vim.opt.termguicolors = true                                -- Enable terminal colors
vim.opt.wildmode = 'list:longest'                           -- Command-line completion mode
vim.opt.wrap = true                                         -- Wrap lines

-- line numbers
vim.opt.number = true                                       -- Print line number
vim.opt.relativenumber = true                               -- Relative line numbers
-- end line numbers

-- loads all configurations in lua/config directory
require('utils').load_all('config')

-- shortcut to reload init.lua
vim.cmd 'command! -nargs=0 Init :luafile ~/.config/nvim/init.lua'
vim.cmd 'command! -nargs=0 EInit :e ~/.config/nvim/init.lua'

-- CleanTermBuffers: clean all terminal buffers
vim.cmd "command! -nargs=0 CleanTermBuffers :silent! bufdo! if &buftype == 'terminal' | bdelete | endif"
