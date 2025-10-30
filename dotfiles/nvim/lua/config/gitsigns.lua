

require('gitsigns').setup {
  on_attach = function(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gb', '<cmd>lua require"gitsigns".blame()<CR>', {})
  end
}
