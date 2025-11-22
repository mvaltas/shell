

vim.lsp.config('gdscript', {
  filetypes = { 'gdscript' },
  root_markers = { '.godot' },
})
vim.lsp.enable('gdscript')


local godot_group = vim.api.nvim_create_augroup('GodotGroup', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = godot_group,
  pattern = 'gdscript',
  callback = function()
  end,
})
