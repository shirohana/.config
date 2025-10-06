---@class BufferUtils
---Buffer utilities for lualine components
local M = {}

---Extract buffer names from CtrlSpace buffer list
---@param buffer_list table List of buffers from CtrlSpace API
---@return table List of valid buffer file paths
function M.extract_buffer_names(buffer_list)
  local names = {}
  for _, buffer in ipairs(buffer_list) do
    if buffer.text and buffer.text ~= '' then
      table.insert(names, buffer.text)
    end
  end
  return names
end

---Build path candidate from parts at given depth
---@param parts table Path parts split by '/'
---@param depth number Number of path components to include
---@param basename string File basename
---@return string Path candidate
function M.build_path_candidate(parts, depth, basename)
  if depth == 1 then
    return basename
  end

  local start_idx = #parts - depth + 1
  local path_parts = {}
  for i = start_idx, #parts do
    table.insert(path_parts, parts[i])
  end
  return table.concat(path_parts, '/')
end

---Check if path candidate is unique among conflicting paths
---@param candidate string Path candidate to test
---@param full_path string Original full path
---@param path_infos table List of path info objects
---@param depth number Current depth being tested
---@param basename string File basename
---@return boolean True if candidate is unique
function M.is_candidate_unique(candidate, full_path, path_infos, depth, basename)
  for _, info in ipairs(path_infos) do
    if info.original ~= full_path then
      local other_candidate = M.build_path_candidate(info.parts, depth, basename)
      if candidate == other_candidate then
        return false
      end
    end
  end
  return true
end

---Get smart short name for a file path
---Finds the shortest unique path among all provided buffer names
---@param full_path string Full path to shorten
---@param all_buffer_names table List of all buffer paths to compare against
---@return string Shortened unique path
function M.get_smart_name(full_path, all_buffer_names)
  local basename = vim.fn.fnamemodify(full_path, ':t')

  -- Find all paths with same basename
  local conflicting_paths = {}
  for _, path in ipairs(all_buffer_names) do
    if vim.fn.fnamemodify(path, ':t') == basename then
      table.insert(conflicting_paths, path)
    end
  end

  -- If basename is unique, return it
  if #conflicting_paths == 1 then
    return basename
  end

  -- Convert paths to absolute and split into parts
  local path_infos = {}
  for _, path in ipairs(conflicting_paths) do
    local abs_path = vim.fn.fnamemodify(path, ':p')
    table.insert(path_infos, {
      original = path,
      parts = vim.split(abs_path, '/'),
    })
  end

  local current_parts = vim.split(vim.fn.fnamemodify(full_path, ':p'), '/')

  -- Find minimum depth needed for uniqueness
  for depth = 1, math.min(4, #current_parts - 1) do
    local candidate = M.build_path_candidate(current_parts, depth, basename)

    if M.is_candidate_unique(candidate, full_path, path_infos, depth, basename) then
      return candidate
    end
  end

  -- Fallback for very complex cases
  return '../' .. basename
end

---Get buffer state flags
---@param buffer table Buffer object from CtrlSpace
---@param current_bufnr number Current buffer number
---@return table State flags (is_current, is_modified, is_visible)
function M.get_buffer_state(buffer, current_bufnr)
  return {
    is_current = buffer.index == current_bufnr,
    is_modified = buffer.modified and buffer.modified ~= 0 and buffer.modified ~= false,
    is_visible = buffer.visible and buffer.visible ~= 0 and buffer.visible ~= false,
  }
end

---Format buffer name with appropriate highlight
---@param name string Buffer name to format
---@param state table Buffer state flags
---@return string Formatted string with highlight codes
function M.format_buffer_with_highlight(name, state)
  if state.is_current and state.is_modified then
    -- Focused and modified: yellow background
    return '%#LualineActiveModified# ' .. name .. ' %#Normal#'
  elseif state.is_current then
    -- Focused buffer: accent background
    return '%#lualine_a_normal# ' .. name .. ' %#Normal#'
  elseif state.is_modified then
    -- Modified non-focused: warning color
    return '%#lualine_b_diagnostics_warn_normal# ' .. name .. ' %#Normal#'
  elseif state.is_visible then
    -- Visible but not current: normal color
    return '%#lualine_c_normal# ' .. name .. ' %#Normal#'
  else
    -- Hidden buffer: dimmed color
    return '%#Comment# ' .. name .. ' %#Normal#'
  end
end

---Setup custom highlight group for active modified buffers
function M.setup_highlights()
  vim.api.nvim_set_hl(0, 'LualineActiveModified', {
    fg = '#000000', -- Black text for contrast
    bg = vim.api.nvim_get_hl(0, { name = 'WarningMsg' }).fg, -- Yellow background
    bold = true,
  })
end

return M
