---@type LazyPluginSpec
local Codeium = {
  -- https://github.com/Exafunction/codeium.nvim
  'Exafunction/codeium.nvim',
  enabled = 'Codeium' == require('shirohana.config').CODE_COMPLETION_AI,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
}

return Codeium
