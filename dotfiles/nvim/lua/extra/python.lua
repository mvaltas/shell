-- enable LSP for python
vim.lsp.config('basedpyright', {
  cmd = { '/opt/homebrew/bin/basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
  settings = {
    basedpyright = {
      typeCheckingMode = "standard",
      analysis = {
        strictParameterNoneValue = false,
        reportUnknownVariableType = false,
      },
    },
  },
})
vim.lsp.enable('basedpyright')

vim.api.nvim_create_autocmd('FileType', {
  group = python_group,
  pattern = 'python',
  callback = function()
    vim.keymap.set('i', '(',  '()<Left>',  { buffer = true, noremap = true })
    vim.keymap.set('i', '[',  '[]<Left>',  { buffer = true, noremap = true })
    vim.keymap.set('i', '{',  '{}<Left>',  { buffer = true, noremap = true })
  end,
})
