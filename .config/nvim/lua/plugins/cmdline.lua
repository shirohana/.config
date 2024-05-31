local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local Wilder = {
  Plugins.Wilder,
  opts = {
    modes = { ':', '/', '?' },
    next_key = '<C-n>',
    previous_key = '<C-p>',
  },
  config = function(_, opts)
    local wilder = require 'wilder'
    wilder.setup(opts)
    wilder.set_option(
      'renderer',
      wilder.popupmenu_renderer {
        reverse = 1,
        pumblend = 20,
        highlighter = wilder.basic_highlighter(),
        left = { ' ', wilder.popupmenu_devicons() },
        right = { ' ', wilder.popupmenu_scrollbar() },
      }
    )
  end,
}

return { Wilder }
