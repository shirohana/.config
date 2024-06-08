---@type LazyPluginSpec
local AutoSession = {
  -- https://github.com/rmagatti/auto-session
  'rmagatti/auto-session',
  enabled = false,
  dependencies = {
    'rcarriga/nvim-notify',
  },
  opts = {
    auto_session_enabled = false,
  },
  config = function(_, opts)
    require('auto-session').setup(opts)

    local session_save = function()
      vim.cmd 'SessionSave'
      require('notify').notify('Session saved', vim.log.levels.INFO, {
        timeout = 800,
        render = 'compact',
      })
    end

    local session_restore = function()
      vim.cmd 'SessionRestore'
      require('notify').notify('Session restored', vim.log.levels.INFO, {
        timeout = 800,
        render = 'compact',
      })
    end

    local keymap = vim.keymap.set

    keymap('n', '<M-s>', session_save, { desc = 'Save session' })
    keymap('n', '<M-w>', session_restore, { desc = 'Restore session' })
  end,
}

return AutoSession
