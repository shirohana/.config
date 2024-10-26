---@type LazyPluginSpec
local Codeium = {
  -- https://github.com/Exafunction/codeium.vim
  'Exafunction/codeium.vim',
  enabled = 'Codeium' == require('shirohana.config').CODE_COMPLETION_AI,
  ---@todo https://github.com/Exafunction/codeium.vim/issues/376
  version = '1.8.37',
  cmd = 'Codeium',
  event = 'BufEnter',
  config = function()
    local keymap = vim.keymap.set
    -- vim.g.codeium_disable_bindings = 1
    keymap('i', '<Tab>', function()
      return vim.fn['codeium#Accept']()
    end, { desc = 'Codeium Accept', expr = true, nowait = true })
    -- keymap('i', '<C-[>', function() return vim.fn['codeium#CycleCompletions'](1) end, { desc = 'Codeium Next Suggestion' })
    -- keymap('i', '<C-]>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { desc = 'Codeium Previous Suggestion' })
    -- keymap('i', '<C-q>', function() return vim.fn['codeium#Clear']() end, { desc = 'Codeium Clear' })
  end,
}

return Codeium
