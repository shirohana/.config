local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local OpenBrowser = {
  Plugins.OpenBrowser,
  event = 'VeryLazy',
  init = function()
    vim.g.openbrowser_browser_commands = {
      {
        name = 'open',
        args = { '{browser}', '-a', 'Safari', '{uri}' },
        background = 0,
      },
    }
  end,
}

--- @type LazySpec
return {
  OpenBrowser,
  { Plugins.Nui,         lazy = true },
  { Plugins.Plenary,     lazy = true },
  { Plugins.Repeat,      event = 'VeryLazy' },
  { Plugins.WebDevicons, lazy = true },
}
