---@type LazyPluginSpec
local Moody = {
  -- https://github.com/svampkorg/moody.nvim
  'svampkorg/moody.nvim',
  dependencies = {
    'catppuccin/nvim',
  },
  event = { 'ModeChanged', 'BufWinEnter', 'WinEnter' },
  opts = {
    -- you can set different blend values for your different modes.
    -- Some colours might look better more dark, so set a higher value
    -- will result in a darker shade.
    blends = {
      normal = 0.4,
      insert = 0.3,
      visual = 0.5,
      command = 0.4,
      operator = 0.3,
      replace = 0.4,
      select = 0.3,
      terminal = 0.5,
      terminal_n = 0.5,
    },
    -- there are two ways to define colours for the different modes.
    -- one way is to define theme here in colors. Another way is to
    -- set them up with highlight groups. Any highlight group set takes
    -- precedence over any colours defined here.
    colors = {
      normal = '#00BFFF',
      insert = '#70CF67',
      visual = '#AD6FF7',
      command = '#EB788B',
      operator = '#FF8F40',
      replace = '#E66767',
      select = '#AD6FF7',
      terminal = '#4CD4BD',
      terminal_n = '#00BBCC',
    },
    -- disable filetypes here. Add for example "TelescopePrompt" to
    -- not have any coloured cursorline for the telescope prompt.
    disabled_filetypes = { 'TelescopePrompt' },
    -- disabled buftypes here
    disabled_buftypes = {},
    -- you can turn on or off bold characters for the line numbers
    bold_nr = true,
    -- you can turn on and off a feature which shows a little icon and
    -- registry number at the end of the CursorLine, for when you are
    -- recording a macro! Default is false.
    recording = {
      enabled = true,
      icon = '󰑋',
      -- you can set some text to surround the recording registry char with
      -- or just set one to empty to maybe have just one letter, an arrow
      -- perhaps! For example recording to q, you could have! "󰑋    q" :D
      pre_registry_text = '[',
      post_registry_text = ']',
      -- if you have some other plugin showing up on the right you can pad
      -- the recording indicator on the right side, to shift it to the left.
      -- For example if you use Satellite you have to shift recording to the left.
      -- using right padding.
      right_padding = 2,
    },
    -- extend the cursorline to cover line numbers.
    extend_to_linenr = true,
    -- extend_to_linenr_visual enables moodys built in statuscolumn to cover linenr in
    -- visual selection to show the visual range of the selection highlighted by
    -- Visual hl group.
    extend_to_linenr_visual = false,
    -- setting reduce_cursorline to true will reduce the moodys cursorline to.. nothing!
    -- It will make the cursorline have the default value of whatever cursorline has in the
    -- default "hightlight namespace", 0. TLDR: no moody change in cursorline with ModeChanged.
    reduce_cursorline = false,
    -- fold_options.enabled also enables the built in SignColumn in moody. These folds takes a bit of a different
    -- approach to showing folds and their range. Try it out and see if you like it :) If not you can use
    -- the SignColumn as is, with extend_to_linenr. It will then only show diagnostic signs and linenr.
    -- This requires nvim-ufo, and will possibly break your current custom SignColumn (if you have any)
    fold_options = {
      enabled = false,
      -- these are two colors you can specifiy which will be used to generate a gradient
      -- with one step for each fold level, specified by vim.o.foldnestmax
      start_color = '#C1C1C1',
      end_color = '#2F2F2F',
    },
  },
}

return Moody
