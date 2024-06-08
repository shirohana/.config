local function get_document_color(entry, vim_item)
  if vim_item.kind == 'Color' and entry.completion_item.documentation then
    local _, _, r, g, b =
      string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
    if r then
      return string.format('%02x%02x%02x', r, g, b)
    end
  end
end

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
    snippet = {
      expand = function(args)
        -- luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = {
        col_offset = -3,
        side_padding = 0,
      },
    },
  },
  config = function(_, opts)
    local cmp = require 'cmp'
    cmp.setup(vim.tbl_extend('error', opts, {
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'luasnip' },
        -- { name = 'treesitter' },
        { name = 'ultisnips' },
      }, {
        -- { name = 'buffer' },
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
local UltiSnips = {
  -- https://github.com/SirVer/ultisnips
  'SirVer/ultisnips',
  init = function()
    local g = vim.g
    g.UltiSnipsSnippetDirectories = { 'UltiSnips' }
    g.UltiSnipsEnableSnipMate = 0
  end,
}

return Cmp
