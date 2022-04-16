local cmp = require 'cmp'
local lspkind = require 'lspkind'
-- local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
      -- luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'treesitter' },
    -- { name = 'ultisnips' },
    -- { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      -- mode = '',
      maxwidth = 50,
      symbol_map = {
        Text = '',
        Method = '',
        Function = '',
        Constructor = '',
        Field = 'ﰠ',
        Variable = '',
        Class = 'ﴯ',
        Interface = '',
        Module = '',
        Property = 'ﰠ',
        Unit = '塞',
        Value = '',
        Enum = '',
        Keyword = '',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = 'פּ',
        Event = '',
        Operator = '',
        TypeParameter = '',
      },
    }),
  },
}

-- vim.cmd [[highlight! default link CmpItemAbbr CmpItemMenuDefault]]
-- vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]
-- vim.cmd [[highlight! link CmpItemAbbr Pmenu]]
-- vim.cmd [[highlight! link CmpItemKind Pmenu]]
-- vim.cmd [[highlight! link CmpItemMenu Pmenu]]
