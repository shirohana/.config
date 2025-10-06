---@class TabUtils
---Tab utilities for lualine components
local M = {}

---Get tab label or default to tab number
---@param tabnr number Tab number
---@return string Tab label or number as string
function M.get_tab_label(tabnr)
  local tab_label = vim.fn['ctrlspace#util#Gettabvar'](tabnr, 'CtrlSpaceLabel')
  if not tab_label or tab_label == '' then
    return tostring(tabnr)
  end
  return tab_label
end

---Check if a tab has any modified buffers
---@param tabnr number Tab number to check
---@return boolean True if tab contains modified buffers
function M.tab_has_modified_buffers(tabnr)
  local ok, buffers = pcall(vim.fn['ctrlspace#api#BufferList'], tabnr)
  if not ok or not buffers then
    return false
  end

  for _, buffer in ipairs(buffers) do
    if buffer.modified and buffer.modified ~= 0 and buffer.modified ~= false then
      return true
    end
  end
  return false
end

---Get buffer count for a tab
---@param tabnr number Tab number
---@return string Buffer count string from CtrlSpace (may be empty for single buffer)
function M.get_tab_buffer_count(tabnr)
  local ok, count = pcall(vim.fn['ctrlspace#api#TabBuffersNumber'], tabnr)
  if not ok then
    return ""
  end
  return count or ""
end

---Get tab state information
---@param tabnr number Tab number
---@param current_tabnr number Current active tab number
---@return table Tab state {is_current: boolean, has_modified: boolean, label: string, buffer_count: string}
function M.get_tab_state(tabnr, current_tabnr)
  return {
    is_current = tabnr == current_tabnr,
    has_modified = M.tab_has_modified_buffers(tabnr),
    label = M.get_tab_label(tabnr),
    buffer_count = M.get_tab_buffer_count(tabnr),
  }
end

---Format tab with appropriate highlight based on state
---@param state table Tab state from get_tab_state
---@return string Formatted tab string with highlight codes
function M.format_tab_with_highlight(state)
  local label = state.label
  local buffer_count = state.buffer_count or ""
  local display_text = label .. buffer_count

  if state.is_current and state.has_modified then
    -- Active tab with modified files: same style as focused modified buffer
    return '%#LualineActiveModified# ' .. display_text .. ' %#Normal#'
  elseif state.is_current then
    -- Active tab: accent background
    return '%#lualine_a_normal# ' .. display_text .. ' %#Normal#'
  elseif state.has_modified then
    -- Inactive tab with modified files: warning color
    return '%#lualine_b_diagnostics_warn_normal# ' .. display_text .. ' %#Normal#'
  else
    -- Inactive clean tab: dimmed
    return '%#Comment# ' .. display_text .. ' %#Normal#'
  end
end

---Get all tab states for current session
---@return table Array of tab states
function M.get_all_tab_states()
  local current_tabnr = vim.fn.tabpagenr()
  local tab_count = vim.fn.tabpagenr '$'
  local tab_states = {}

  for tabnr = 1, tab_count do
    table.insert(tab_states, M.get_tab_state(tabnr, current_tabnr))
  end

  return tab_states
end

return M
