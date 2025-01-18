---@type LazyPluginSpec
local CopilotCmp = {
  -- https://github.com/zbirenbaum/copilot-cmp
  'zbirenbaum/copilot-cmp',
  enabled = 'Copilot' == require('shirohana.config').CODE_COMPLETION_AI,
  lazy = true,
  config = true,
}

return CopilotCmp
