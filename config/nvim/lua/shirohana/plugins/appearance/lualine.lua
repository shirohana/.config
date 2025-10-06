-- ============================================================================
-- LUALINE COMPONENT FUNCTIONS
-- ============================================================================

-- CtrlSpace buffer list component for tabline section C
local function buffer_list_component()
  local buffer_utils = require 'shirohana.utils.buffer'

  -- Setup custom highlights
  buffer_utils.setup_highlights()

  -- Early return if CtrlSpace not available
  if not vim.g.CtrlSpaceLoaded then
    return ''
  end

  -- Get buffer list for current tab
  local tabnr = vim.fn.tabpagenr()
  local ok, buffers = pcall(vim.fn['ctrlspace#api#BufferList'], tabnr)

  if not ok or not buffers or #buffers == 0 then
    return ''
  end

  local current_bufnr = vim.fn.bufnr '%'
  local buffer_names = buffer_utils.extract_buffer_names(buffers)
  local buffer_parts = {}

  -- Process each buffer
  for _, buffer in ipairs(buffers) do
    if buffer.text and buffer.text ~= '' then
      local short_name = buffer_utils.get_smart_name(buffer.text, buffer_names)
      local buffer_state = buffer_utils.get_buffer_state(buffer, current_bufnr)
      local formatted_buffer = buffer_utils.format_buffer_with_highlight(short_name, buffer_state)
      table.insert(buffer_parts, formatted_buffer)
    end
  end

  -- Combine results with proper color reset
  return '%#Normal#' .. table.concat(buffer_parts, '│')
end

-- CtrlSpace tab list component for tabline section X
local function tab_list_component()
  local tab_utils = require 'shirohana.utils.tab'

  -- Early return if CtrlSpace not available
  if not vim.g.CtrlSpaceLoaded then
    return ''
  end

  -- Get all tab states and format them
  local tab_states = tab_utils.get_all_tab_states()
  local tab_parts = {}

  for _, state in ipairs(tab_states) do
    local formatted_tab = tab_utils.format_tab_with_highlight(state)
    table.insert(tab_parts, formatted_tab)
  end

  -- Combine results with proper color reset
  return '%#Normal#' .. table.concat(tab_parts, '│')
end

-- ============================================================================
-- LUALINE CONFIGURATION
-- ============================================================================

---@type LazyPluginSpec
local Lualine = {
  -- https://github.com/nvim-lualine/lualine.nvim
  'nvim-lualine/lualine.nvim',
  enabled = require('shirohana.config').USE_LUALINE,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = {
        {
          function()
            return ' '
          end,
          color = function()
            local status = require('sidekick.status').get()
            if status then
              return status.kind == 'Error' and 'DiagnosticError'
                  or status.busy and 'DiagnosticWarn'
                  or 'Special'
            end
          end,
          cond = function()
            local status = require 'sidekick.status'
            return status.get() ~= nil
          end,
        },
        { 'lsp_status', ignore_lsp = { 'GitHub Copilot', 'null-ls' } },
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = {
        { 'lsp_status', ignore_lsp = { 'GitHub Copilot', 'null-ls' } },
        'location',
      },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = {
        function()
          return '󰈙'
        end,
      },
      lualine_b = {},
      lualine_c = { buffer_list_component },
      lualine_x = { tab_list_component },
      lualine_y = {},
      lualine_z = {
        function()
          return ''
        end,
      },
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {
      'avante',
      'ctrlspace',
      'fugitive',
      'fzf',
      'lazy',
      'man',
      'mason',
      'neo-tree',
      'oil',
      'quickfix',
      'trouble',
    },
  },
}

return Lualine
