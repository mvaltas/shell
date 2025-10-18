-- shotcuts to common functions
local api = vim.api  -- nvim api access
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn  = vim.fn   -- to call Vim functions e.g. fn.bufnr()
local g   = vim.g    -- a table to access global variables
local opt = vim.opt  -- access to options
local keymap = vim.keymap -- access to keymaps
local homedir = os.getenv('HOME') -- User home directory
local projectdir = string.gsub("HOME/Projects", "HOME", homedir) -- User Projects dir

-- plugin management
cmd 'packadd paq-nvim'               -- load the package manager
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
    'nvim-telescope/telescope.nvim';  -- File finder w/ popup window and preview support
    'nvim-treesitter/nvim-treesitter';-- Configuration and abstraction layer

    -- GIT
    'lewis6991/gitsigns.nvim';         -- git capabilities on neovim

    -- AI
    'augmentcode/augment.vim';         -- Augment AI for neovim
}

-- colors
g.edge_style = 'aura'
g.edge_colors_override = { 
  bg0 = { '#171717', '235' },
}
cmd 'colorscheme edge'


-- general editor options
opt.expandtab = true                                    -- Use spaces instead of tabs
opt.shiftwidth = 2                                      -- Size of an indent
opt.smartindent = true                                  -- Insert indents automatically
opt.tabstop = 2                                         -- Number of spaces tabs count for
opt.hidden = true                                       -- Enable modified buffers in background
opt.joinspaces = false                                  -- No double spaces with join after a dot
opt.scrolloff = 4                                       -- Lines of context
opt.shiftround = true                                   -- Round indent
opt.sidescrolloff = 8                                   -- Columns of context
opt.smartcase = true                                    -- Don't ignore case with capitals
opt.splitbelow = true                                   -- Put new windows below current
opt.splitright = true                                   -- Put new windows right of current
opt.termguicolors = true                                -- Enable terminal colors
opt.wildmode = 'list:longest'                           -- Command-line completion mode
opt.wrap = true                                         -- Wrap lines

-- line numbers
opt.number = true                                       -- Print line number
opt.relativenumber = true                               -- Relative line numbers
-- end line numbers

-- simple maps (no binding with function)
map_opts = {noremap = true, silent = false}

keymap.set('n', '<leader><leader>', '<c-^>', map_opts) -- '\\' alternate between buffers
keymap.set('', '<C-z>', ':wa|:suspend<cr>', map_opts)  -- save files when suspending with CTRL-Z
keymap.set('', 'Q', '<nop>', map_opts)                 -- disable Ex Mode
keymap.set('n','<esc>',':nohlsearch<cr>', map_opts)    -- disable search highlight on ESC

-- telescope mappings
keymap.set('n','<leader>f',':Telescope find_files<cr>', map_opts)      -- f find files
keymap.set('n','<leader>b',':Telescope buffers<cr>', map_opts)         -- b for buffers
keymap.set('n','<leader>g',':Telescope git_files<cr>', map_opts)       -- g for git
keymap.set('n','<leader>q',':Telescope quickfix<cr>', map_opts)        -- q for quickfix
keymap.set('n','<leader>h',':Telescope help_tags<cr>', map_opts)       -- h for help
keymap.set('n','<leader>e',':Telescope registers<cr>', map_opts)       -- e for registers
keymap.set('n','<leader>c',':Telescope command_history<cr>', map_opts) -- c for command history
keymap.set('n','<leader>o',':Telescope oldfiles<cr>', map_opts)        -- o for command history
keymap.set('n','<leader>a',':Telescope<cr>', map_opts)                 -- a for all

-- treesitter + telescope
keymap.set('n','<leader>d',':Telescope treesitter<cr>', map_opts)      -- d for definitions
keymap.set('n','<leader>df',':Telescope treesitter default_text=:function:<cr>', map_opts) -- functions only
keymap.set('n','<leader>dv',':Telescope treesitter default_text=:var:<cr>', map_opts) -- variables only
keymap.set('n','<leader>dc',':Telescope treesitter default_text=:class:<cr>', map_opts)    -- classes only
keymap.set('n','<leader>di',':Telescope treesitter default_text=:import:<cr>', map_opts)    -- import only

-- telescope greps
keymap.set('n','<leader>l',':Telescope live_grep<cr>', map_opts)       -- l for live_grep
keymap.set('n','<leader>gr',':Telescope grep_string<cr>', map_opts) -- '\gr' current word into Telescope grep_string

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

-- Augment AI configuration
vim.g.augment_workspace_folders = { projectdir }
vim.g.augment_disable_completions = true

-- smart_tab: triggers CTRL-P completion when the
-- character before the cursor is not empty otherwise 
-- just return TAB
function smart_tab()
  local cur_col  = fn.col(".") 
  local cur_char = api.nvim_get_current_line():sub(cur_col - 2, cur_col - 1)
  -- %g matches printable character in Lua
  return cur_char:match('%g') and u.t'<c-p>' or u.t'<tab>'
end
-- bind <tab> to smar_tab() function
keymap.set('i', '<tab>', 'v:lua.smart_tab()', {expr = true, noremap = true })
-- end of smart_tab

local function get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  -- correct for column selection otherwise the whose 1st line is selected
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

-- improve text selected with AI
function improve_selected_text()
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get start and end positions of the visual selection
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    -- Adjust for Lua 0-based indexing (rows and columns)
    local start_row = start_pos[2] - 1
    local start_col = start_pos[3] - 1
    local end_row = end_pos[2] - 1
    local end_col = end_pos[3]

    -- Get the last line of the selection
    local last_line = vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, true)[1] or ""

    -- Ensure end_col does not exceed the length of the last line
    end_col = math.min(end_col, #last_line)

    -- Get the selected text
    local lines = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})

    -- Join selected lines into a single query string
    local query = table.concat(lines, "\n")

    -- Run the shell command with the query
    local handle = io.popen('llm -m gpt-4o-mini -t improve "' .. query:gsub('"', '\\"') .. '"')
    if not handle then
        vim.notify("Failed to run shell command", vim.log.levels.ERROR)
        return
    end

    local result = handle:read("*a")
    handle:close()

    -- Split the result into lines for insertion
    local result_lines = vim.split(result, "\n", { plain = true, trimempty = true })

    -- Replace the selected coordinates with the result
    vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, result_lines)

    -- Format the replaced text
    vim.cmd("normal! gqap")
end

-- Map the function to a keybinding, mnemonics: ist = improve selected text
vim.api.nvim_set_keymap('v', '<leader>ist', [[:lua improve_selected_text()<CR>]], { noremap = true, silent = true })
-- end of AI improve text function


-- shortcut to reload init.lua
cmd 'command! -nargs=0 Init :luafile ~/.config/nvim/init.lua'
cmd 'command! -nargs=0 EInit :e ~/.config/nvim/init.lua'

-- CleanTermBuffers: clean all terminal buffers
cmd "command! -nargs=0 CleanTermBuffers :silent! bufdo! if &buftype == 'terminal' | bdelete | endif"

-- Old implementation of QuickCSE
api.nvim_exec([[
" CSE means Clear Screen and Execute, use it by
" mapping (depending of the project) to a test runner command
" map <leader>r CSE('rspec', '--color')<cr>
function! CSE(runthis, ...)
  :wa
  exec ':terminal ' . a:runthis . ' ' . join(a:000, ' ')
endfunction

function! QuickCSE(cmd)
  exec "map <leader>r :call CSE(\"" . a:cmd . "\")<cr>"
endfunction
  ]], true)

cmd 'command! -nargs=* QuickCSE call QuickCSE(<q-args>)'
-- end of QuickCSE

-- Rename file in place
api.nvim_exec([[
  function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
  endfunction
  map <leader>n :call RenameFile()<cr>
  ]], true)


-- changes in colors
api.nvim_create_autocmd('ColorScheme', { 
  pattern = '*', 
  command='highlight LineNr guifg=Grey ctermfg=Grey'
})
api.nvim_create_autocmd('ColorScheme', { 
  pattern = '*', 
  command='highlight TelescopeMatching guifg=Red ctermfg=Red'
})
-- end changes in colors

-- open file in last position
api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if fn.line("'\"") > 1 and fn.line("'\"") <= fn.line("$") then
      api.nvim_exec("normal! g'\"",false)
    end
  end
})
