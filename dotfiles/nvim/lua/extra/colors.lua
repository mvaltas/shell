-- edge
vim.g.edge_style = 'aura'
vim.g.edge_colors_override = {
  bg0 = { '#171717', '235' },
}

-- sonokai
vim.g.sonokai_style = "andromeda"
vim.g.sonokai_colors_override = {
  bg0 = { '#171717', '235' },
}


require('kanagawa').setup({
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    theme = "wave",              -- Load "wave" theme
})


vim.cmd.colorscheme "kanagawa"

