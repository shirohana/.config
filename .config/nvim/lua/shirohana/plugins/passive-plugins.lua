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

return { Notify, Nui, Plenary, WebDevIcons }