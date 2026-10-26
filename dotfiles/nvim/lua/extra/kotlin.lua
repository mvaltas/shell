
-- lsp configurations
-- Kotlin LSP setup
vim.lsp.config('kotlin_lsp', {
  cmd = { '/opt/homebrew/bin/kotlin-lsp', '--stdio' },
  filetypes = { 'kotlin' },
  root_markers = { 'settings.gradle.kts', 'settings.gradle', 'build.gradle.kts', 'build.gradle', 'pom.xml', '.git' },
})
vim.lsp.enable('kotlin_lsp')

