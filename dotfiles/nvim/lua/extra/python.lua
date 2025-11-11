-- enable LSP for python
vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      typeCheckingMode = "basic",
      analysis = {
        strictParameterNoneValue = false,
        reportUnknownVariableType = false,
      },
    },
  },
})
vim.lsp.enable('basedpyright')


local python_group = vim.api.nvim_create_augroup('PythonCustomStuff', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = python_group,
  pattern = 'python',
  callback = function()
    vim.keymap.set('i', '(',  '()<Left>',  { buffer = true, noremap = true })
    vim.keymap.set('i', '[',  '[]<Left>',  { buffer = true, noremap = true })
    vim.keymap.set('i', '{',  '{}<Left>',  { buffer = true, noremap = true })
  end,
})
