local M = {}

-- stylua: ignore
local Catppuccin = {
  yellow  = '#eed49f',
  red     = '#ed8796',
  magenta = '#f5bde6',
  blue    = '#8aadf4',
  cyan    = '#8bd5ca',
  green   = '#a6da95',
}

-- stylua: ignore
local NeoSolarized = {
  base03  = '#002b36',
  base02  = '#073642',
  base01  = '#586e75',
  base00  = '#657b83',
  base0   = '#839496',
  base1   = '#93a1a1',
  base2   = '#eee8d5',
  base3   = '#fdf6e3',
  yellow  = '#b58900',
  orange  = '#cb4b16',
  red     = '#dc322f',
  magenta = '#d33682',
  violet  = '#6c71c4',
  blue    = '#268bd2',
  cyan    = '#2aa198',
  green   = '#859900',
}

M.Colors = Catppuccin

if 'NeoSolarized' == require('shirohana.config').colorscheme then
  M.Colors = NeoSolarized
end

-- stylua: ignore
M.Icons = {
  Action        = '',
  Array         = '',
  Boolean       = '◩',
  Bug           = '',
  Class         = '',
  CodeComment   = '',
  Color         = '',
  Comment       = '',
  Constant      = '󰏿',
  Constructor   = '',
  Enum          = '',
  EnumMember    = '',
  Error         = '',
  Event         = '',
  Field         = '',
  File          = '󰈙',
  Folder        = '',
  Function      = '󰊕',
  Hint          = '',
  Info          = '', -- 
  Interface     = '',
  Key           = '󰌋',
  Keyword       = '',
  Method        = '󰆧',
  Module        = '󰏖',
  Namespace     = '󰮴',
  Null          = '󰟢',
  Number        = '󰎠',
  Object        = '󰅩',
  Operator      = '',
  Other         = '',
  Package       = '󰏗',
  Property      = '',
  Reference     = '󰈇',
  Snippet       = '',
  String        = '',
  Struct        = '󰙅',
  Text          = '󰉿',
  TypeParameter = '',
  Unit          = '',
  Value         = '󰎠',
  Variable      = '',
  Warning       = '',
}

local opt = require('shirohana.config').USE_MACOS_OPT_KEYMAPS
M.Keys = {
  ['<M-,>'] = opt and '≤' or '<M-,>',
  ['<M-.>'] = opt and '≥' or '<M-.>',
  ['<M-1>'] = opt and '¡' or '<M-1>',
  ['<M-2>'] = opt and '™' or '<M-2>',
  ['<M-3>'] = opt and '£' or '<M-3>',
  ['<M-4>'] = opt and '¢' or '<M-4>',
  ['<M-5>'] = opt and '∞' or '<M-5>',
  ['<M-6>'] = opt and '§' or '<M-6>',
  ['<M-7>'] = opt and '¶' or '<M-7>',
  ['<M-8>'] = opt and '•' or '<M-8>',
  ['<M-9>'] = opt and 'ª' or '<M-9>',
  ['<M-:>'] = opt and 'Ú' or '<M-:>',
  ['<M-;>'] = opt and '…' or '<M-;>',
  ['<M-H>'] = opt and 'Ó' or '<M-H>',
  ['<M-J>'] = opt and 'Ô' or '<M-J>',
  ['<M-K>'] = opt and '' or '<M-K>',
  ['<M-L>'] = opt and 'Ò' or '<M-L>',
  ['<M-S>'] = opt and 'Í' or '<M-S>',
  ['<M-[>'] = opt and '“' or nil,
  ['<M-]>'] = opt and '‘' or nil,
  ['<M-b>'] = opt and '∫' or '<M-b>',
  ['<M-f>'] = opt and 'ƒ' or '<M-f>',
  ['<M-h>'] = opt and '˙' or '<M-h>',
  ['<M-j>'] = opt and '∆' or '<M-j>',
  ['<M-k>'] = opt and '˚' or '<M-k>',
  ['<M-l>'] = opt and '¬' or '<M-l>',
  ['<M-r>'] = opt and '®' or '<M-r>',
  ['<M-s>'] = opt and 'ß' or '<M-s>',
  ['<M-t>'] = opt and '†' or '<M-t>',
  ['<M-w>'] = opt and '∑' or '<M-w>',
}

return M
