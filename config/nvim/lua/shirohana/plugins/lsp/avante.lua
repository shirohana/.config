---@type LazyPluginSpec
local Avante = {
  -- https://github.com/yetone/avante.nvim
  'yetone/avante.nvim',
  version = false,
  event = 'VeryLazy',
  build = 'make',
  enabled = false,
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
    -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    -- {
    --   -- support for image pasting
    --   "HakonHarnes/img-clip.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     -- recommended settings
    --     default = {
    --       embed_image_as_base64 = false,
    --       prompt_for_file_name = false,
    --       drag_and_drop = {
    --         insert_mode = true,
    --       },
    --       -- required for Windows users
    --       use_absolute_path = true,
    --     },
    --   },
    -- },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
  opts = {
    provider = 'copilot',
    auto_suggestions_provider = 'claude',
    behavior = {
      auto_set_keymaps = false,
    }
  },
}

return Avante
