
-- lsp configurations
-- Kotlin LSP setup
vim.lsp.config('kotlin', {
  cmd = { '/opt/homebrew/bin/kotlin-lsp', '--stdio' },
  filetypes = { 'kotlin' },
})
vim.lsp.enable('kotlin_lsp')

