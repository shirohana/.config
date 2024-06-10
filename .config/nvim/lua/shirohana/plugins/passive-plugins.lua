---@type LazyPluginSpec
local Notify = {
  -- https://github.com/rcarriga/nvim-notify
  'rcarriga/nvim-notify',
  lazy = true,
}

---@type LazyPluginSpec
local Nui = {
  -- https://github.com/MunifTanjim/nui.nvim
  'MunifTanjim/nui.nvim',
  lazy = true,
}

---@type LazyPluginSpec
local OpenBrowser = {
  -- https://github.com/tyru/open-browser.vim
  'tyru/open-browser.vim',
  lazy = true,
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

---@type LazyPluginSpec
local Plenary = {
  -- https://github.com/nvim-lua/plenary.nvim
  'nvim-lua/plenary.nvim',
  lazy = true,
}

---@type LazyPluginSpec
local WebDevIcons = {
  -- https://github.com/nvim-tree/nvim-web-devicons
  'nvim-tree/nvim-web-devicons',
  lazy = true,
}

return { Notify, Nui, OpenBrowser, Plenary, WebDevIcons }
