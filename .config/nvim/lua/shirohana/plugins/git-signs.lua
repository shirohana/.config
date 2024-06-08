---@type LazyPluginSpec
local GitSigns = {
  -- https://github.com/lewis6991/gitsigns.nvim
  'lewis6991/gitsigns.nvim',
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  opts = {
    current_line_blame_formatter = '<summary> | <author>, <author_time:%Y-%m-%d>',
    current_line_blame_opts = {
      virt_text_pos = 'overlay',
      delay = 0,
    },
    on_attach = function(bufnr)
      local gs = package.loaded['gitsigns']

      gs.stage_hunk_v = function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end
      gs.reset_buffer_index_v = function()
        gs.reset_buffer { vim.fn.line '.', vim.fn.line 'v' }
      end
      gs.reset_hunk_v = function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end
      gs.blame_line_full = function()
        gs.blame_line { full = true }
      end
      gs.diff_head = function()
        gs.diffthis '~'
      end

      local function keymap(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      keymap('n', 'sj', gs.next_hunk, { desc = 'Jump to next hunk' })
      keymap('n', 'sk', gs.prev_hunk, { desc = 'Jump to previous hunk' })
      keymap('n', '<LocalLeader>s<Space>', gs.preview_hunk, { desc = 'Preview hunk' })
      keymap('n', '<LocalLeader>ss', gs.stage_hunk, { desc = 'Stage hunk' })
      keymap('v', '<LocalLeader>ss', gs.stage_hunk_v, { desc = 'Stage hunk' })
      keymap('n', '<LocalLeader>su', gs.reset_buffer_index, { desc = 'Unstage hunk' })
      keymap('v', '<LocalLeader>su', gs.reset_buffer_index_v, { desc = 'Unstage hunk' })
      keymap('n', '<LocalLeader>sr', gs.reset_hunk, { desc = 'Hard reset hunk' })
      keymap('v', '<LocalLeader>sr', gs.reset_hunk_v, { desc = 'Hard reset hunk' })
      keymap('n', '<LocalLeader>sR', gs.reset_buffer, { desc = 'Hard reset whole file' })
      keymap('n', '<LocalLeader>sa', gs.toggle_current_line_blame, { desc = 'Toggle line blame' })
      keymap('n', '<LocalLeader>sb', gs.blame_line_full, { desc = 'Blame line with whole commit' })
      keymap('n', '<LocalLeader>sd', gs.diff_head, { desc = 'Diff with HEAD' })

      keymap({ 'o', 'x' }, 'ih', gs.select_hunk, { desc = 'Select hunk' })
    end,
  },
}

return GitSigns
