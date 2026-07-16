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
          stopinsert = { '<C-k>', 'stopinsert', mode = 't', desc = 'enter normal mode' },
          nav_left = {
            Keys['<M-h>'],
            'nav_left',
            expr = true,
            desc = 'navigate to the left window',
          },
          nav_down = {
            Keys['<M-j>'],
            'nav_down',
            expr = true,
            desc = 'navigate to the below window',
          },
          nav_up = {
            Keys['<M-k>'],
            'nav_up',
            expr = true,
            desc = 'navigate to the above window',
          },
          nav_right = {
            Keys['<M-l>'],
            'nav_right',
            expr = true,
            desc = 'navigate to the right window',
          },
        },
      },
      tools = {
        copilot = { cmd = { 'copilot' }, url = 'https://github.com/github/copilot-cli' },
      },
    },
    nes = {
      enabled = function(buf)
        local disabled_ft_list = { 'neo-tree' }
        local ft = vim.bo[buf].filetype
        local modifiable = vim.bo[buf].modifiable

        for _, disabled_ft in ipairs(disabled_ft_list) do
          if ft == disabled_ft then
            return false
          end
        end

        -- Disable for non-editable filetypes
        if not modifiable then
          return false
        end

        -- return true, disable temporarily
        return false
      end,
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
