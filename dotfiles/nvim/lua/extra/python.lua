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
