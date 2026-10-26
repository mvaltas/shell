-- JavaScript / TypeScript LSP (npm i -g typescript typescript-language-server)
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  -- fall back to the global typescript when the project doesn't ship its own
  before_init = function(_, config)
    local root = config.root_dir or vim.uv.cwd()
    if vim.uv.fs_stat(root .. '/node_modules/typescript') then return end
    local global = vim.trim(vim.fn.system({ 'npm', 'root', '-g' }))
    config.init_options = vim.tbl_deep_extend('force', config.init_options or {}, {
      tsserver = { path = global .. '/typescript/lib/tsserver.js' },
    })
  end,
})
vim.lsp.enable('ts_ls')
