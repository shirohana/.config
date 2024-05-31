-- Theme https://github.com/overcache/NeoSolarized
-- Due to we need some customization, we cloned the scheme into
-- `colors/NeoSolarized.vim`.

local colors = require('themes.solarized_dark').colors
local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local Colorizer = {
  Plugins.Colorizer,
  opts = {
    user_default_options = {
      css = true,
      tailwind = true,
      sass = { enable = false, parsers = { 'css' } },
    },
  },
}

---@type LazyPluginSpec
local IndentBlankline = {
  Plugins.IndentBlankline,
  version = '2',
  -- main = 'ibl',
  opts = {
    space_char_blankline = ' ',
    show_current_context = true,
    show_current_context_start = true,
    char = '',
    char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
    },
    space_char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
    },
    show_trailing_blankline_indent = false,
  },
  init = function()
    vim.cmd [[
      highlight IndentBlanklineIndent1 guibg=#002b36 gui=nocombine
      highlight IndentBlanklineIndent2 guibg=#073642 gui=nocombine
    ]]
  end,
}

---@type LazyPluginSpec
local Hlslens = {
  Plugins.Hlslens,
  opts = {
    calm_down = true,
    override_lens = function(render, pos_list, nearest, index, rel_index)
      local offset = math.abs(rel_index) < 2 and '' or math.abs(rel_index)
      local direction = rel_index < 0 and 'N' or (rel_index < 1 and '' or 'n')
      -- local text = ('[%s%s %d/%d]'):format(offset, direction, index, #pos_list)
      -- local text = (' %s%s '):format(offset, direction)
      local text = offset .. direction
      text = text == '' and '' or ' ' .. text .. ' '
      local chunks
      if nearest then
        chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
      else
        chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
      end
      local row, col = unpack(pos_list[index])
      render.setVirt(0, row - 1, col - 1, chunks, nearest)
    end,
  },
  init = function()
    vim.cmd [[
        highlight link HlSearchLens LineNr
      ]]
  end,
}

---@type LazyPluginSpec
local Scrollbar = {
  Plugins.Scrollbar,
  dependencies = { Plugins.Hlslens },
  opts = {
    handle = { text = ' ', color = '#0b4f60' },
    marks = {
      Cursor = { text = '□', priority = 5, color = colors.cyan },
      Search = { text = { '◇', '◆' }, priority = 1, color = colors.blue },
      Error = { text = { '□', '■' }, priority = 2, color = colors.red },
      Warn = { text = { '□', '■' }, priority = 3, color = colors.yellow },
      Info = { text = { '-', '=' }, priority = 4, color = nil },
      Hint = { text = { '-', '=' }, priority = 5, color = nil },
      Misc = { text = { '-', '=' }, priority = 6, color = nil },
      GitAdd = { text = '▏', priority = 7, color = colors.green },
      GitChange = { text = '▏', priority = 7, color = colors.yellow },
      GitDelete = { text = '▏', priority = 7, color = colors.red },
    },
    excluded_buftypes = { 'nofile', 'terminal' },
    excluded_filetypes = { 'LspsagaHover', 'noice', 'prompt' },
    autocmd = {
      render = {
        'BufWinEnter',
        'TabEnter',
        'TermEnter',
        'WinEnter',
        'CmdwinLeave',
        'TextChanged',
        'VimResized',
        'WinScrolled',
      },
      clear = {
        'BufWinLeave',
        'TabLeave',
        'TermLeave',
        'WinLeave',
      },
    },
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = true,
      handle = true,
      search = true,
    },
  },
}

-- local Kanagawa = {
--   'rebelot/kanagawa.nvim',
--   config = true,
--   init = function()
--     vim.cmd 'colorscheme kanagawa'
--   end,
-- }

---@type LazySpec
return {
  Colorizer,
  Hlslens,
  IndentBlankline,
  Plugins.Cursorword,
  Scrollbar,
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
