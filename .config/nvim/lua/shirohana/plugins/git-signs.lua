---@type LazyPluginSpec
local GitSigns = {
  -- https://github.com/lewis6991/gitsigns.nvim
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    current_line_blame_formatter = '<summary> | <author>, <author_time:%Y-%m-%d>',
    current_line_blame_opts = {
      virt_text_pos = 'overlay',
      delay = 0,
    },
    on_attach = function(bufnr)
      local function keymap(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      local gs = package.loaded['gitsigns']

      -- Hunk navigating
      keymap('n', 'sj', gs.next_hunk)
      keymap('n', 'sk', gs.prev_hunk)

      -- Stage hunk
      keymap('n', '<LocalLeader>ss', gs.stage_hunk)
      keymap('v', '<LocalLeader>ss', '<Cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>')

      -- Unstage hunk
      keymap('n', '<LocalLeader>su', gs.reset_buffer_index)
      keymap('v', '<LocalLeader>su', '<Cmd>lua require"gitsigns".reset_buffer_index({vim.fn.line("."), vim.fn.line("v")})<CR>')

      -- Hard reset hunk
      keymap('n', '<LocalLeader>sr', gs.reset_hunk)
      keymap('v', '<LocalLeader>sr', '<Cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>')

      -- Hard reset whole file
      keymap('n', '<LocalLeader>sR', gs.reset_buffer)

      -- Toggle hunk preview
      keymap('n', '<LocalLeader>s<Space>', gs.preview_hunk)
      -- Blame line
      keymap('n', '<LocalLeader>sa', gs.toggle_current_line_blame)
      -- Blame line with whole commit
      keymap('n', '<LocalLeader>sb', function()
        gs.blame_line { full = true }
      end)
      -- Diff with HEAD
      keymap('n', '<LocalLeader>sd', function()
        gs.diffthis '~'
      end)

      -- Select in hunk
      keymap({ 'o', 'x' }, 'ih', gs.select_hunk)
    end,
  },
}

return GitSigns
