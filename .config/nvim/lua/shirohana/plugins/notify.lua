---@type LazyPluginSpec
local Notify = {
  -- https://github.com/rcarriga/nvim-notify
  'rcarriga/nvim-notify',
  VeryLazy = true,
  opts = {
    fps = 60,
    -- stages = 'static',
  },
}

return Notify
