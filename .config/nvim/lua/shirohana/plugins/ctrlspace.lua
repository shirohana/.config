---@type LazyPluginSpec
local CtrlSpace = {
  -- https://github.com/vim-ctrlspace/vim-ctrlspace
  'vim-ctrlspace/vim-ctrlspace',

  init = function()
    local g = vim.g
    -- vim.g.CtrlSpaceUseTabline = 0
    g.CtrlSpaceSetDefaultMapping = 0
    g.CtrlSpaceCacheDir = vim.fn.stdpath 'cache' .. '/ctrlspace'
    -- We'll only used to search buffers, keep it lower
    g.CtrlSpaceSearchTiming = 20
  end,

  config = function()
    -- Initialize workspace manually for custom workspace selector
    vim.fn['ctrlspace#workspaces#SetWorkspaceNames']()

    local load_workspace = function()
      local saved_workspaces = vim.fn['ctrlspace#workspaces#Workspaces']()
      local picker_opts = {
        results_title = 'Workspaces',
        layout_strategy = 'vertical',
        layout_config = {
          width = 30,
          height = 20,
        },
      }
      local picker_defaults = {
        prompt_title = 'Load workspace',
        finder = require('telescope.finders').new_table {
          results = saved_workspaces,
        },
        sorter = require('telescope.config').values.generic_sorter(),
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local selection = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
            if selection then
              require('telescope.actions').close(prompt_bufnr)
              vim.cmd('CtrlSpaceLoadWorkspace ' .. selection.value)
            end
          end)
          return true
        end,
      }
      require('telescope.pickers').new(picker_opts, picker_defaults):find()
    end

    local keymap = vim.keymap.set

    keymap('n', '<LocalLeader>c', '<Cmd>CtrlSpace<CR>', { desc = 'Show CtrlSpace menu' })
    keymap('n', '<M-w>', load_workspace, { desc = 'Load workspace' })
    keymap('n', '<M-s>', '<Cmd>SaveWorkspace<CR>', { desc = 'Save workspace' })
    keymap('n', '<M-S>', '<Cmd>SaveWorkspacePrompt<CR>', { desc = 'Save-as workspace' })
    keymap('n', '<LocalLeader>=', '<Cmd>RenameTabLabel<CR>', { desc = 'Rename tab' })
  end,
}

return CtrlSpace
