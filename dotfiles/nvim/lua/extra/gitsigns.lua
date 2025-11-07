

require('gitsigns').setup {
  on_attach = function(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gb', '<cmd>lua require"gitsigns".blame()<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']h', '<cmd>lua require"gitsigns".next_hunk()<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[h', '<cmd>lua require"gitsigns".prev_hunk()<CR>', {})
  end
}
