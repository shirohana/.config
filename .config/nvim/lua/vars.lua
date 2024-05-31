local M = {}

M.NVIM_DIR = vim.fn.fnamemodify(vim.fn.expand '<sfile>', ':h')
M.CACHE_DIR = vim.env.HOME .. '/.cache/nvim'

M.LAZY_PATH = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

M.Plugins = {
  -- AutoPairs https://github.com/jiangmiao/auto-pairs
  AutoPairs = 'jiangmiao/auto-pairs',
  -- BetterWhitespace https://github.com/ntpeters/vim-better-whitespace
  BetterWhitespace = 'ntpeters/vim-better-whitespace',
  -- Cmp https://github.com/hrsh7th/nvim-cmp
  Cmp = 'hrsh7th/nvim-cmp',
  -- CmpBuffer https://github.com/hrsh7th/cmp-buffer
  CmpBuffer = 'hrsh7th/cmp-buffer',
  -- CmpNvimLsp https://github.com/hrsh7th/cmp-nvim-lsp
  CmpNvimLsp = 'hrsh7th/cmp-nvim-lsp',
  -- CmpTreeSitter https://github.com/ray-x/cmp-treesitter
  CmpTreeSitter = 'ray-x/cmp-treesitter',
  -- Colorizer https://github.com/NvChad/nvim-colorizer.lua
  Colorizer = 'NvChad/nvim-colorizer.lua',
  -- Commentary https://github.com/tpope/vim-commentary
  Commentary = 'tpope/vim-commentary',
  -- Copilot https://github.com/github/copilot.vim
  Copilot = 'github/copilot.vim',
  -- CtrlSpace https://github.com/vim-ctrlspace/vim-ctrlspace
  CtrlSpace = 'vim-ctrlspace/vim-ctrlspace',
  -- Cursorword https://github.com/itchyny/vim-cursorword
  Cursorword = 'itchyny/vim-cursorword',
  -- DocumentColor https://github.com/mrshmllow/document-color.nvim
  DocumentColor = 'mrshmllow/document-color.nvim',
  -- EasyAlign https://github.com/junegunn/vim-easy-align
  EasyAlign = 'junegunn/vim-easy-align',
  -- Fidget https://github.com/j-hui/fidget.nvim
  Fidget = 'j-hui/fidget.nvim',
  -- Flash https://github.com/folke/flash.nvim
  Flash = 'folke/flash.nvim',
  -- Fugitive https://github.com/tpope/vim-fugitive
  Fugitive = 'tpope/vim-fugitive',
  -- Fzf https://github.com/junegunn/fzf.vim
  Fzf = 'junegunn/fzf.vim',
  -- FzfBin https://github.com/junegunn/fzf
  FzfBin = 'junegunn/fzf',
  -- GitSigns https://github.com/lewis6991/gitsigns.nvim
  GitSigns = 'lewis6991/gitsigns.nvim',
  -- Hlslens https://github.com/kevinhwang91/nvim-hlslens
  Hlslens = 'kevinhwang91/nvim-hlslens',
  -- Hop https://github.com/phaazon/hop.nvim
  Hop = 'phaazon/hop.nvim',
  -- IndentBlankline https://github.com/lukas-reineke/indent-blankline.nvim
  IndentBlankline = 'lukas-reineke/indent-blankline.nvim',
  -- https://github.com/Quramy/vim-js-pretty-template
  JsPrettyTemplate = 'Quramy/vim-js-pretty-template',
  -- LlmNvim https://github.com/huggingface/llm.nvim
  LlmNvim = 'huggingface/llm.nvim',
  -- LspConfig https://github.com/neovim/nvim-lspconfig
  LspConfig = 'neovim/nvim-lspconfig',
  -- LspKind https://github.com/onsails/lspkind-nvim
  LspKind = 'onsails/lspkind-nvim',
  -- LspLines https://git.sr.ht/~whynothugo/lsp_lines.nvim
  LspLines = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  -- LspSaga https://github.com/tami5/lspsaga.nvim
  LspSaga = 'tami5/lspsaga.nvim',
  -- LuaDev https://github.com/folke/neodev.nvim
  LuaDev = 'folke/neodev.nvim',
  -- LuaSnip https://github.com/L3MON4D3/LuaSnip
  LuaSnip = 'L3MON4D3/LuaSnip',
  -- MarkdownPreview https://github.com/JamshedVesuna/vim-markdown-preview
  MarkdownPreview = 'JamshedVesuna/vim-markdown-preview',
  -- Mason https://github.com/williamboman/mason.nvim
  Mason = 'williamboman/mason.nvim',
  -- MasonLspConfig https://github.com/williamboman/mason-lspconfig.nvim
  MasonLspConfig = 'williamboman/mason-lspconfig.nvim',
  -- Navic https://github.com/SmiteshP/nvim-navic
  Navic = 'SmiteshP/nvim-navic',
  -- NeoTree https://github.com/nvim-neo-tree/neo-tree.nvim
  NeoTree = 'nvim-neo-tree/neo-tree.nvim',
  -- NoneLs https://github.com/nvimtools/none-ls.nvim
  NoneLs = 'nvimtools/none-ls.nvim',
  -- Nui https://github.com/MunifTanjim/nui.nvim
  Nui = 'MunifTanjim/nui.nvim',
  -- NullLs https://github.com/jose-elias-alvarez/null-ls.nvim
  -- NullLs = 'jose-elias-alvarez/null-ls.nvim',
  -- Oil https://github.com/stevearc/oil.nvim
  Oil = 'stevearc/oil.nvim',
  -- OpenBrowser https://github.com/tyru/open-browser.vim
  OpenBrowser = 'tyru/open-browser.vim',
  -- PlantUmlPreviewer https://github.com/weirongxu/plantuml-previewer.vim
  PlantUmlPreviewer = 'weirongxu/plantuml-previewer.vim',
  -- PlantUmlSyntax https://github.com/aklt/plantuml-syntax
  PlantUmlSyntax = 'aklt/plantuml-syntax',
  -- Plenary https://github.com/nvim-lua/plenary.nvim
  Plenary = 'nvim-lua/plenary.nvim',
  -- Repeat https://github.com/tpope/vim-repeat
  Repeat = 'tpope/vim-repeat',
  -- Scrollbar https://github.com/petertriho/nvim-scrollbar
  Scrollbar = 'petertriho/nvim-scrollbar',
  -- Spectre https://github.com/nvim-pack/nvim-spectre
  Spectre = 'nvim-pack/nvim-spectre',
  -- Surround https://github.com/kylechui/nvim-surround
  Surround = 'kylechui/nvim-surround',
  -- SymbolsOutline https://github.com/simrat39/symbols-outline.nvim
  SymbolsOutline = 'simrat39/symbols-outline.nvim',
  -- TreeSitter https://github.com/nvim-treesitter/nvim-treesitter
  TreeSitter = 'nvim-treesitter/nvim-treesitter',
  -- TreeSitterContext https://github.com/nvim-treesitter/nvim-treesitter-context
  TreeSitterContext = 'nvim-treesitter/nvim-treesitter-context',
  -- TreeSitterIndentObject https://github.com/kiyoon/treesitter-indent-object.nvim
  TreeSitterIndentObject = 'kiyoon/treesitter-indent-object.nvim',
  -- TreeSitterRainbow https://github.com/HiPhish/nvim-ts-rainbow2
  TreeSitterRainbow = 'HiPhish/nvim-ts-rainbow2',
  -- TreeSitterTextobjects https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  TreeSitterTextobjects = 'nvim-treesitter/nvim-treesitter-textobjects',
  -- https://github.com/folke/trouble.nvim
  Trouble = 'folke/trouble.nvim',
  -- https://github.com/marilari88/twoslash-queries.nvim
  TwoslashQueries = 'marilari88/twoslash-queries.nvim',
  -- UltiSnips https://github.com/SirVer/ultisnips
  UltiSnips = 'SirVer/ultisnips',
  -- Undotree https://github.com/mbbill/undotree
  Undotree = 'mbbill/undotree',
  -- VisualMulti https://github.com/mg979/vim-visual-multi
  VisualMulti = 'mg979/vim-visual-multi',
  -- WebDevicons https://github.com/nvim-tree/nvim-web-devicons
  WebDevicons = 'nvim-tree/nvim-web-devicons',
  -- Wilder https://github.com/gelguy/wilder.nvim
  Wilder = 'gelguy/wilder.nvim',
}

M.Icons = {
  Action = '',
  Array = '',
  Boolean = '',
  Bug = '',
  Class = '',
  CodeComment = '',
  Color = '',
  Comment = '',
  Constant = '󰏿',
  Constructor = '',
  Enum = '',
  EnumMember = '',
  Error = '',
  Event = '',
  Field = '',
  File = '󰈙',
  Folder = '',
  Function = '󰊕',
  Hint = '',
  Info = '', -- 
  Interface = '',
  Key = '󰌋',
  Keyword = '',
  Method = '󰆧',
  Module = '󰏖',
  Namespace = '󰮴',
  Null = '󰟢',
  Number = '󰎠',
  Object = '󰅩',
  Operator = '',
  Other = '',
  Package = '󰏗',
  Property = '',
  Reference = '󰈇',
  Snippet = '',
  String = '',
  Struct = '󰙅',
  Text = '󰉿',
  TypeParameter = '',
  Unit = '',
  Value = '󰎠',
  Variable = '',
  Warning = '',
}

return M
