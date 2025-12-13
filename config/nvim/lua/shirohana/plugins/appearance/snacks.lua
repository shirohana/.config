---@type LazyPluginSpec
local Snacks = {
  -- https://github.com/folke/snacks.nvim
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    -- dim = { enabled = true },
    -- explorer = { enabled = false },
    -- gitbrowse = { enabled = false },
    -- image = { enabled = false },
    -- indent = { enabled = false },
    -- input = { enabled = false },
    -- layout = { enabled = false },
    -- lazygit = { enabled = false },
    -- notifier = { enabled = false },
    -- picker = { enabled = false },
    -- profiler = { enabled = false },
    -- -- quickfile = { enabled = false },
    -- scope = { enabled = false },
    -- scratch = { enabled = false },
    -- scroll = { enabled = false },
    -- statuscolumn = { enabled = false },
    -- styles = {}, -- keep this empty unless you want custom styles
    -- terminal = { enabled = false },
    -- toggle = { enabled = false },
    -- words = { enabled = false },
  },
}

return Snacks
