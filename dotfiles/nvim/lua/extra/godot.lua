local godot_group = vim.api.nvim_create_augroup('GodotGroup', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = godot_group,
  pattern = 'gdscript',
  callback = function()
  end,
})
