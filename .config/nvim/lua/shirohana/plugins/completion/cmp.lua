-- stylua: ignore
local CmpTheme = {
  Pmenu                    = { fg = '#C5CDD9', bg = '#004657' },
  PmenuSel                 = { fg = 'NONE', bg = '#006680' },

  CmpItemAbbrDeprecated    = { fg = '#7E8294', bg = 'NONE', strikethrough = true },
  CmpItemAbbrMatch         = { fg = '#82AAFF', bg = 'NONE', bold = true },
  CmpItemAbbrMatchFuzzy    = { fg = '#82AAFF', bg = 'NONE', bold = true },
  CmpItemMenu              = { fg = '#C792EA', bg = 'NONE', italic = true },

  CmpItemKindField         = { fg = '#EED8DA', bg = '#B5585F' },
  CmpItemKindProperty      = { fg = '#EED8DA', bg = '#B5585F' },
  CmpItemKindEvent         = { fg = '#EED8DA', bg = '#B5585F' },

  CmpItemKindText          = { fg = '#C3E88D', bg = '#7F965B' },
  CmpItemKindEnum          = { fg = '#C3E88D', bg = '#7F965B' },
  CmpItemKindKeyword       = { fg = '#C3E88D', bg = '#7F965B' },

  CmpItemKindConstant      = { fg = '#FFE082', bg = '#9A884E' },
  CmpItemKindConstructor   = { fg = '#FFE082', bg = '#9A884E' },
  CmpItemKindReference     = { fg = '#FFE082', bg = '#9A884E' },

  CmpItemKindFunction      = { fg = '#EADFF0', bg = '#A377BF' },
  CmpItemKindStruct        = { fg = '#EADFF0', bg = '#A377BF' },
  CmpItemKindClass         = { fg = '#EADFF0', bg = '#A377BF' },
  CmpItemKindModule        = { fg = '#EADFF0', bg = '#A377BF' },
  CmpItemKindOperator      = { fg = '#EADFF0', bg = '#A377BF' },

  CmpItemKindVariable      = { fg = '#C5CDD9', bg = '#7E8294' },
  CmpItemKindFile          = { fg = '#C5CDD9', bg = '#7E8294' },

  CmpItemKindUnit          = { fg = '#F5EBD9', bg = '#D4A959' },
  CmpItemKindSnippet       = { fg = '#F5EBD9', bg = '#D4A959' },
  CmpItemKindFolder        = { fg = '#F5EBD9', bg = '#D4A959' },

  CmpItemKindMethod        = { fg = '#DDE5F5', bg = '#6C8ED4' },
  CmpItemKindValue         = { fg = '#DDE5F5', bg = '#6C8ED4' },
  CmpItemKindEnumMember    = { fg = '#DDE5F5', bg = '#6C8ED4' },

  CmpItemKindInterface     = { fg = '#D8EEEB', bg = '#58B5A8' },
  CmpItemKindColor         = { fg = '#D8EEEB', bg = '#58B5A8' },
  CmpItemKindTypeParameter = { fg = '#D8EEEB', bg = '#58B5A8' },
}

---@type LazyPluginSpec
local Cmp = {
  -- https://github.com/hrsh7th/nvim-cmp
  'hrsh7th/nvim-cmp',

  event = 'InsertEnter',

  dependencies = {
    'SirVer/ultisnips',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'onsails/lspkind-nvim',
    'ray-x/cmp-treesitter',
  },

  ---@type cmp.ConfigSchema
  opts = {
    view = {
      entries = { name = 'custom', selection_order = 'near_cursor' },
    },
    -- snippet = {
    --   expand = function(args)
    --     luasnip.lsp_expand(args.body)
    --   end,
    -- },
    window = {
      completion = {
        col_offset = -3,
        side_padding = 0,
      },
    },
  },

  init = function()
    for name, opts in pairs(CmpTheme) do
      vim.api.nvim_set_hl(0, name, opts)
    end
  end,

  config = function(_, opts)
    local function get_document_color(entry, vim_item)
      if vim_item.kind == 'Color' and entry.completion_item.documentation then
        local _, _, r, g, b =
          string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
        if r then
          return string.format('%02x%02x%02x', r, g, b)
        end
      end
    end

    local cmp = require 'cmp'

    cmp.setup(vim.tbl_extend('error', opts, {
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'luasnip' },
        { name = 'ultisnips' },
      }, {
        { name = 'treesitter' },
        { name = 'buffer' },
        { name = 'path' },
      }),
      mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        menu = {
          buffer = '‹Buffer›',
          nvim_lsp = '‹LSP›',
        },
        format = function(entry, vim_item)
          local symbol_kind = vim_item.kind
          local symbol_icon = require('lspkind').symbolic(vim_item.kind)
          local color = get_document_color(entry, vim_item)

          if color then
            symbol_icon = ' '
            local hl_group = 'Tw_' .. color
            if vim.fn.hlID(hl_group) < 1 then
              vim.api.nvim_set_hl(0, hl_group, { bg = '#' .. color })
            end
            vim_item.kind_hl_group = hl_group
          end

          symbol_icon = symbol_icon == '' and ' ' or symbol_icon

          vim_item.kind = string.format(' %s ', symbol_icon)
          vim_item.menu = string.format('  (%s)', symbol_kind)
          vim_item.abbr = string.sub(vim_item.abbr, 1, 50)

          return vim_item
        end,
      },
    }))
  end,
}

---@type LazyPluginSpec
local CmpNvimLsp = {
  -- https://github.com/hrsh7th/cmp-nvim-lsp
  'hrsh7th/cmp-nvim-lsp',
  lazy = true,
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
}

return { Cmp, CmpNvimLsp }
