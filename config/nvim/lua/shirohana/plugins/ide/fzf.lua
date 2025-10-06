local Keys = require('shirohana.core.constants').Keys

---@type LazyPluginSpec
local Fzf = {
  -- https://github.com/junegunn/fzf.vim
  'junegunn/fzf.vim',
  enabled = 'fzf' == require('shirohana.config').FILE_EXPLORER,
  dependencies = {
    'junegunn/fzf',
  },
  cmd = {
    'Ag',
    'BTags',
    'Buffers',
    'Files',
    'Filetypes',
    'FzfAg',
    'GFiles',
    'History',
    'Maps',
    'Marks',
    'RG',
    'Rg',
    'Tags',
    'Windows',
  },
  keys = {
    { '<C-p>', '<Cmd>Files<CR>' },
    { '<C-o>', '<Cmd>Buffers<CR>' },
    { Keys['<M-f>'], ':<C-u>Rg<Space>' },
    { Keys['<M-F>'], ':<C-u>RG<Space>' },
  },
  init = function()
    vim.env.FZF_DEFAULT_COMMAND = 'fd --type=f --hidden --strip-cwd-prefix'
    vim.env.FZF_DEFAULT_OPTS = '--reverse'
  end,
}

---@type LazyPluginSpec
local FzfBin = {
  -- https://github.com/junegunn/fzf
  'junegunn/fzf',
  build = ':call fzf#install()',
  lazy = true,
}

return { Fzf, FzfBin }
