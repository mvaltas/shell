local group_sensitivity = {
  -- critical: Important information if wrong could lead to failures.
  -- Operators such as :? , !!, !=, >=
  critical = {
    "@operator", "@keyword.operator", "Operator",
  },

  -- moderate: Information that represents the structure of 
  -- the problem solving, also known as actions, with side
  -- effects, reach and delegation.
  moderate = {
    "@function.method", "@lsp.type.method",
    "@type", "@lsp.type.class", "@type.builtin",
    "@label",
    "@number", "@number.float",
    "gitcommitOverflow",
    "zshFunction",
  },

  -- neutral: don't carry side effects, are
  -- not calls by themselves or operators
  neutral  = {
    "@punctuation.delimiter",
    "@variable.parameter", "@type.qualifier",
    "@function", "@lsp.type.function",
    "@lsp.type.parameter",
    "gitcommitSummary",
    "justBody",
  },

  -- markers: Or notice, not necessarily informational but
  -- can be use to accent parts of the code or surround
  -- neutral information, like {}, [], <>, and other 
  -- delimiters, like ';', also builtin functions
  marker = {
    "@punctuation.bracket",
    "@constructor",
    "@function.builtin", "@keyword.function",
    "@keyword", "@keyword.exception",
    "zshSubstDelim",
  },

  -- target: as in keys, globals, booleans things
  -- that are "fixed" in their definition
  target = {
    "@lsp.typemod.variable.global", "@variable.member",
    "@property", "@lsp.type.property",
    "@boolean",
    "@variable", "@lsp.type.variable", -- variables are important but not as much as function calls
  },

  -- entry: Entries done by the programmer: Strings mostly
  -- and other defined entries, besides numbers and
  -- booleans as these are moderate.
  entry    = {
    "@string", "String",
  },

  -- subtle: comments, line numbers, things that 
  -- can be ignored most of the time without prejudice
  subtle   = {
    "@string.documentation.python", "Comment",
    "gitcommitDiff"
  },

}

local function category_colors(colors)
  return {
    critical = {
      fg = colors.red, bold = true
    },
    moderate = {
      fg = colors.orange
    },
    entry    = {
      fg = colors.green
    },
    marker   = {
      fg = colors.cyan
    },
    neutral  = {
      fg = colors.off_white
    },
    target   = {
      fg = colors.purple
    },
    subtle   = {
      fg = colors.gray, italic = true,
    },
  }
end


local function category_highlights(colors)
  local cat_colors = category_colors(colors)
  local cat_highlight = {}
  for category, groups in pairs(group_sensitivity) do
    local hl_opts = cat_colors[category]
    for _, group in ipairs(groups) do
      cat_highlight[group] = vim.tbl_extend("force", hl_opts, cat_highlight[group] or {})
    end
  end
  return cat_highlight
end

local function groups(colors)
   local overrides = {
      Normal = { fg = colors.fg, bg = colors.bg, },

      NormalFloat = { fg = colors.white, bg = colors.dark_gray, },

      Constant = { fg = colors.yellow, },
      Character = { fg = colors.green, },
      Number = { fg = colors.orange, },
      Boolean = { fg = colors.cyan, },
      Float = { fg = colors.orange, },
      FloatBorder = { fg = colors.white, },
      Keyword = { fg = colors.cyan, },
      Keywords = { fg = colors.cyan, },
      Identifier = { fg = colors.cyan, },
      Function = { fg = colors.yellow, },
      Statement = { fg = colors.magenta, },
      Conditional = { fg = colors.pink, },
      Repeat = { fg = colors.pink, },
      Label = { fg = colors.cyan, },
      Exception = { fg = colors.magenta, },
      PreProc = { fg = colors.yellow, },
      Include = { fg = colors.magenta, },
      Define = { fg = colors.magenta, },
      Title = { fg = colors.cyan, },
      Macro = { fg = colors.magenta, },
      PreCondit = { fg = colors.cyan, },
      Type = { fg = colors.cyan, },
      StorageClass = { fg = colors.pink, },
      Structure = { fg = colors.yellow, },
      TypeDef = { fg = colors.yellow, },
      Special = { fg = colors.green, italic = false },
      SpecialComment = { fg = colors.gray, italic = true, },
      Error = { fg = colors.bright_red, },
      Todo = { fg = colors.magenta, bold = true, italic = true, },
      Underlined = { fg = colors.cyan, underline = true, },

      Cursor = { reverse = true, },
      LineNr = { fg = colors.gray, },
      CursorLineNr = { fg = colors.white, bold = true, },

      SignColumn = { bg = colors.bg, },

      Conceal = { fg = colors.gray, },
      CursorColumn = { bg = colors.black, },
      CursorLine = { bg = colors.selection, },
      ColorColumn = { bg = colors.selection, },

      StatusLine = { fg = colors.white, bg = colors.dark_green, },
      StatusLineNC = { fg = colors.white, bg = colors.dark_gray },
      StatusLineTerm = { fg = colors.white, bg = colors.dark_blue, },
      StatusLineTermNC = { fg = colors.white, bg = colors.dark_gray, },

      Directory = { fg = colors.cyan, },

      -- diff from git commit
      Added = { fg = colors.green },
      Removed = { fg = colors.red },
      diffOldFile = { link = "Removed" },
      diffNewfile = { link = "Added" },
      diffFile    = { fg = colors.yellow },

      DiffAdd = { fg = colors.bg, bg = colors.green, },
      DiffChange = { fg = colors.orange, },
      DiffDelete = { fg = colors.red, },
      DiffText = { fg = colors.gray, },

      ErrorMsg = { fg = colors.bright_red, },
      VertSplit = { fg = colors.black, },
      WinSeparator = { fg = colors.black, },
      Folded = { fg = colors.gray, },
      FoldColumn = {},

      MatchParen = { underline = true, },

      NonText = { fg = colors.nontext, },
      Pmenu = { fg = colors.white, bg = colors.menu, },
      PmenuSel = { fg = colors.white, bg = colors.selection, },
      PmenuSbar = { bg = colors.bg, },
      PmenuThumb = { bg = colors.selection, },

      Question = { fg = colors.magenta, },
      QuickFixLine = { fg = colors.black, bg = colors.yellow, },
      SpecialKey = { fg = colors.nontext, },

      SpellBad = { fg = colors.bright_red, underline = true, },
      SpellCap = { fg = colors.yellow, },
      SpellLocal = { fg = colors.yellow, },
      SpellRare = { fg = colors.yellow, },

      TabLine = { fg = colors.gray, },
      TabLineSel = { fg = colors.white, },
      TabLineFill = { bg = colors.bg, },
      Terminal = { fg = colors.white, bg = colors.black, },

      -- when you type '/' and search...
      Search    = { fg = colors.dark_blue, bg = colors.highlight_blue, },
      IncSearch = { fg = colors.dark_green, bg = colors.highlight_green, },
      CurSearch = { fg = colors.dark_yellow, bg = colors.highlight_yellow, },

      Visual    = { fg = colors.bright_green, bg = colors.dark_green, },
      VisualNOS = { fg = colors.bright_green, bg = colors.dark_green, },

      DiagnosticUnnecessary = { fg = colors.bright_gray },

      WarningMsg = { fg = colors.yellow, },
      WildMenu = { fg = colors.black, bg = colors.white, },

      -- TreeSitter
      ['@error'] = { fg = colors.bright_red, },
      ['@markup.list'] = { fg = colors.cyan, },

      ['@constant'] = { fg = colors.magenta, },
      ['@constant.builtin'] = { fg = colors.magenta, },
      ['@markup.link.label.symbol'] = { fg = colors.magenta, },

      ['@constant.macro'] = { fg = colors.cyan, },
      ['@string.regexp'] = { fg = colors.red, },
      ['@string'] = { fg = colors.yellow, },
      ['@string.escape'] = { fg = colors.cyan, },
      ['@string.special.symbol'] = { fg = colors.magenta, },
      ['@character'] = { fg = colors.green, },
      ['@annotation'] = { fg = colors.yellow, },
      ['@attribute'] = { fg = colors.cyan, },
      ['@module'] = { fg = colors.orange, },

      ['@function.builtin'] = { fg = colors.cyan, },
      ['@function'] = { fg = colors.green, },
      ['@function.macro'] = { fg = colors.green, },
      ['@variable.parameter.reference'] = { fg = colors.orange, },

      ['@keyword.conditional'] = { fg = colors.pink, },
      ['@keyword.repeat'] = { fg = colors.pink, },


      ['@keyword.function.ruby'] = { fg = colors.pink, },
      ['@keyword.operator'] = { fg = colors.pink, },
      ['@operator'] = { fg = colors.pink, },
      ['@keyword.exception'] = { fg = colors.magenta, },
      ['@structure'] = { fg = colors.magenta, },
      ['@keyword.include'] = { fg = colors.pink, },

      ['@variable'] = { fg = colors.fg, },
      ['@variable.builtin'] = { fg = colors.magenta, },

      ['@markup'] = { fg = colors.orange, },
      ['@markup.strong'] = { fg = colors.orange, bold = true, },     -- bold
      ['@markup.emphasis'] = { fg = colors.yellow, italic = true, }, -- italic
      ['@markup.underline'] = { fg = colors.orange, },
      ['@markup.heading'] = { fg = colors.pink, bold = true, },        -- title
      ['@markup.raw'] = { fg = colors.yellow, },                 -- inline code
      ['@markup.link.url'] = { fg = colors.yellow, italic = true, },      -- urls
      ['@markup.link'] = { fg = colors.orange, bold = true, },

      ['@tag'] = { fg = colors.cyan, },
      ['@tag.attribute'] = { fg = colors.green, },
      ['@tag.delimiter'] = { fg = colors.cyan, },

      -- Semantic
      ['@class'] = { fg = colors.cyan },
      ['@struct'] = { fg = colors.cyan },
      ['@enum'] = { fg = colors.cyan },
      ['@enumMember'] = { fg = colors.magenta },
      ['@event'] = { fg = colors.cyan },
      ['@interface'] = { fg = colors.cyan },
      ['@modifier'] = { fg = colors.cyan },
      ['@regexp'] = { fg = colors.yellow },
      ['@typeParameter'] = { fg = colors.cyan },
      ['@decorator'] = { fg = colors.cyan },

      -- LSP Semantic (0.9+)
      ['@lsp.type.enum'] = { fg = colors.cyan },
      ['@lsp.type.decorator'] = { fg = colors.green },
      ['@lsp.type.enumMember'] = { fg = colors.magenta },
      ['@lsp.type.function'] = { fg = colors.green, },
      ['@lsp.type.interface'] = { fg = colors.cyan },
      ['@lsp.type.macro'] = { fg = colors.cyan },
      ['@lsp.type.namespace'] = { fg = colors.orange, },
      ['@lsp.type.struct'] = { fg = colors.cyan },
      ['@lsp.type.type'] = { fg = colors.bright_cyan, },
      ['@lsp.type.variable'] = { fg = colors.fg, },

      ['@lsp.mod.defaultLibrary.lua'] = { link = "@function.builtin" },

      -- Kotlin LSP
      ['@attribute.kotlin'] = { fg = colors.orange },

      -- HTML
      htmlArg = { fg = colors.green, },
      htmlBold = { fg = colors.yellow, bold = true, },
      htmlEndTag = { fg = colors.cyan, },
      htmlH1 = { fg = colors.pink, },
      htmlH2 = { fg = colors.pink, },
      htmlH3 = { fg = colors.pink, },
      htmlH4 = { fg = colors.pink, },
      htmlH5 = { fg = colors.pink, },
      htmlH6 = { fg = colors.pink, },
      htmlItalic = { fg = colors.magenta, italic = true, },
      htmlLink = { fg = colors.magenta, underline = true, },
      htmlSpecialChar = { fg = colors.yellow, },
      htmlSpecialTagName = { fg = colors.cyan, },
      htmlTag = { fg = colors.cyan, },
      htmlTagN = { fg = colors.cyan, },
      htmlTagName = { fg = colors.cyan, },
      htmlTitle = { fg = colors.white, },

      -- Markdown
      markdownBlockquote = { fg = colors.yellow, italic = true, },
      markdownBold = { fg = colors.orange, bold = true, },
      markdownCode = { fg = colors.green, },
      markdownCodeBlock = { fg = colors.orange, },
      markdownCodeDelimiter = { fg = colors.red, },
      markdownH2 = { link = "rainbow2" },
      markdownH1 = { link = "rainbow1" },
      markdownH3 = { link = "rainbow3" },
      markdownH4 = { link = "rainbow4" },
      markdownH5 = { link = "rainbow5" },
      markdownH6 = { link = "rainbow6" },
      markdownHeadingDelimiter = { fg = colors.red, },
      markdownHeadingRule = { fg = colors.gray, },
      markdownId = { fg = colors.magenta, },
      markdownIdDeclaration = { fg = colors.cyan, },
      markdownIdDelimiter = { fg = colors.magenta, },
      markdownItalic = { fg = colors.yellow, italic = true, },
      markdownLinkDelimiter = { fg = colors.magenta, },
      markdownLinkText = { fg = colors.pink, },
      markdownListMarker = { fg = colors.cyan, },
      markdownOrderedListMarker = { fg = colors.red, },
      markdownRule = { fg = colors.gray, },
      ['@markup.heading.1.markdown'] = { link = 'rainbowcol1' },
      ['@markup.heading.2.markdown'] = { link = 'rainbowcol2' },
      ['@markup.heading.3.markdown'] = { link = 'rainbowcol3' },
      ['@markup.heading.4.markdown'] = { link = 'rainbowcol4' },
      ['@markup.heading.5.markdown'] = { link = 'rainbowcol5' },
      ['@markup.heading.6.markdown'] = { link = 'rainbowcol6' },

      -- Git Signs
      GitSignsAdd = { fg = colors.bright_green, },
      GitSignsChange = { fg = colors.cyan, },
      GitSignsDelete = { fg = colors.bright_red, },
      GitSignsAddLn = { fg = colors.black, bg = colors.bright_green, },
      GitSignsChangeLn = { fg = colors.black, bg = colors.cyan, },
      GitSignsDeleteLn = { fg = colors.black, bg = colors.bright_red, },
      GitSignsCurrentLineBlame = { fg = colors.white, },

      -- Telescope
      TelescopePromptBorder = { fg = colors.purple, },
      TelescopeResultsBorder = { fg = colors.bright_gray, },
      TelescopePreviewBorder = { fg = colors.bright_gray, },
      TelescopeSelection = { fg = colors.white, bg = colors.selection, },
      TelescopeMultiSelection = { bg = colors.dark_green, },
      TelescopeNormal = { fg = colors.fg, bg = colors.bg, },
      TelescopeMatching = { fg = colors.green, },
      TelescopePromptPrefix = { fg = colors.magenta, },
      TelescopeResultsDiffDelete = { fg = colors.red },
      TelescopeResultsDiffChange = { fg = colors.cyan },
      TelescopeResultsDiffAdd = { fg = colors.green },

      -- LSP
      DiagnosticError = { fg = colors.red, },
      DiagnosticWarn = { fg = colors.yellow, },
      DiagnosticInfo = { fg = colors.cyan, },
      DiagnosticHint = { fg = colors.cyan, },
      DiagnosticUnderlineError = { undercurl = true, sp = colors.red, },
      DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow, },
      DiagnosticUnderlineInfo = { undercurl = true, sp = colors.cyan, },
      DiagnosticUnderlineHint = { undercurl = true, sp = colors.cyan, },
      DiagnosticSignError = { fg = colors.red, },
      DiagnosticSignWarn = { fg = colors.yellow, },
      DiagnosticSignInfo = { fg = colors.cyan, },
      DiagnosticSignHint = { fg = colors.cyan, },

      DiagnosticFloatingError = { fg = colors.red, },
      DiagnosticFloatingWarn  = { fg = colors.yellow, },
      DiagnosticFloatingInfo  = { fg = colors.cyan, },
      DiagnosticFloatingHint  = { fg = colors.cyan, },
      DiagnosticVirtualTextError = { fg = colors.red, },
      DiagnosticVirtualTextWarn = { fg = colors.yellow, },
      DiagnosticVirtualTextInfo = { fg = colors.cyan, },
      DiagnosticVirtualTextHint = { fg = colors.cyan, },

      LspDiagnosticsDefaultError = { fg = colors.red, },
      LspDiagnosticsDefaultWarning = { fg = colors.yellow, },
      LspDiagnosticsDefaultInformation = { fg = colors.cyan, },
      LspDiagnosticsDefaultHint = { fg = colors.cyan, },
      LspDiagnosticsUnderlineError = { fg = colors.red, undercurl = true, },
      LspDiagnosticsUnderlineWarning = { fg = colors.yellow, undercurl = true, },
      LspDiagnosticsUnderlineInformation = { fg = colors.cyan, undercurl = true, },
      LspDiagnosticsUnderlineHint = { fg = colors.cyan, undercurl = true, },
      LspReferenceText = { fg = colors.orange, },
      LspReferenceRead = { fg = colors.orange, },
      LspReferenceWrite = { fg = colors.orange, },
      LspCodeLens = { fg = colors.cyan, },
      LspInlayHint = { fg = "#969696", bg = "#2f3146" },
   }

   return vim.tbl_deep_extend("force", overrides, category_highlights(colors))
 end

 return {
   groups = groups
 }
