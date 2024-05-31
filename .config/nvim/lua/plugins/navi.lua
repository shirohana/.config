local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local Fzf = {
  Plugins.Fzf,
  dependencies = {
    { Plugins.FzfBin, build = ':call fzf#install()' },
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
    -- Search text, using <Opt-f>
    { 'ƒ',    ':<C-u>Ag<Space>' },
  },
  config = function()
    vim.env.FZF_DEFAULT_COMMAND =
    "ag -g '' --hidden --path-to-ignore ~/.fzf.ignore"
    vim.env.FZF_DEFAULT_OPTS = '--height 20% --reverse --border --multi'
  end,
}

return { Fzf }
