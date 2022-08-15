require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'html',
    'javascript',
    'json',
    'markdown',
    'python',
    'toml',
    'tsx',
    'typescript',
    'yaml',
  },
  highlight = {
    enable = true,
    disable = {
      'plantuml',
      'stylus',
    },
  },
  indent = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = {
  'javascript',
  'typescript.tsx',
}
