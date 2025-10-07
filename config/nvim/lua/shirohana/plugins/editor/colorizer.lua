---@type LazyPluginSpec
local Colorizer = {
  -- https://github.com/NvChad/nvim-colorizer.lua
  'NvChad/nvim-colorizer.lua',
  -- event = 'BufReadPre',
  opts = {
    user_default_options = {
      names = false,
      tailwind = 'lsp',
      tailwind_opts = {      -- Options for highlighting tailwind names
        update_names = true, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
      },
    },
  },
}

return Colorizer
