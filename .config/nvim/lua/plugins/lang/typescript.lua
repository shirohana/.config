local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local TwoslashQueries = {
  Plugins.TwoslashQueries,
  lazy = true,
  cmd = { 'TwoslashQueries' },
  keys = {
    { 'z;', '<Cmd>TwoslashQueriesInspect<CR>', { noremap = true } },
  },
  opts = {
    highlight = 'Type',
    is_enabled = true,
    multi_line = true,
  },
}

return { TwoslashQueries }
