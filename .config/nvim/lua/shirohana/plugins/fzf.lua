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
    'FzfAg',
    'Files',
    'GFiles',
    'Buffers',
    'Ag',
    'Tags',
    'BTags',
    'Marks',
    'Windows',
    'History',
    'Maps',
    'Filetypes',
  },
  keys = {
    { '<C-p>', '<Cmd>Files<CR>' },
    { '<C-o>', '<Cmd>Buffers<CR>' },
    { Keys['<M-f>'], ':<C-u>Ag<Space>' },
  },
  init = function()
    -- vim.env.FZF_DEFAULT_COMMAND = 'fd --type=f --hidden --strip-cwd-prefix'
    vim.env.FZF_DEFAULT_COMMAND = "ag -g '' --hidden --path-to-ignore ~/.fzf.ignore"
    vim.env.FZF_DEFAULT_OPTS = '--height 20% --reverse --border --multi'
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
