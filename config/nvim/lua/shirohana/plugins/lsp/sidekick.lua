local Keys = require('shirohana.core.constants').Keys

---@type LazyPluginSpec
local Sidekick = {
  -- https://github.com/folke/sidekick.nvim
  'folke/sidekick.nvim',
  ---@class sidekick.Config
  opts = {
    cli = {
      win = {
        keys = {
          win_p = false,
        },
      },
      tools = {
        copilot = { cmd = { 'copilot' }, url = 'https://github.com/github/copilot-cli' },
      },
    },
  },
  config = function(_, opts)
    require('sidekick').setup(opts)
  end,
  keys = {
    {
      Keys['<M-p>'],
      function()
        require('sidekick').nes_jump_or_apply()
      end,
      expr = true,
      desc = 'Goto/Apply Next Edit Suggestion',
    },
    {
      '<leader>aa',
      function()
        require('sidekick.cli').toggle()
      end,
      desc = 'Sidekick Toggle CLI',
    },
    {
      '<leader>as',
      function()
        require('sidekick.cli').select()
      end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = 'Select CLI',
    },
    {
      '<leader>at',
      function()
        require('sidekick.cli').send { msg = '{this}' }
      end,
      mode = { 'x', 'n' },
      desc = 'Send This',
    },
    {
      '<leader>av',
      function()
        require('sidekick.cli').send { msg = '{selection}' }
      end,
      mode = { 'x' },
      desc = 'Send Visual Selection',
    },
    {
      '<leader>ap',
      function()
        require('sidekick.cli').prompt()
      end,
      mode = { 'n', 'x' },
      desc = 'Sidekick Select Prompt',
    },
    {
      '<c-.>',
      function()
        require('sidekick.cli').focus()
      end,
      mode = { 'n', 'x', 'i', 't' },
      desc = 'Sidekick Switch Focus',
    },
  },
}

return Sidekick
