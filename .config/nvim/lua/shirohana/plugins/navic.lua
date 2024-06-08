-- stylua: ignore
local NavicTheme = {
  NavicIconsField         = { fg = '#B5585F', bg = 'NONE' },
  NavicIconsProperty      = { fg = '#B5585F', bg = 'NONE' },
  NavicIconsEvent         = { fg = '#B5585F', bg = 'NONE' },

  NavicText               = { fg = '#82AAFF', bg = 'NONE' },
  NavicIconsEnum          = { fg = '#C3E88D', bg = 'NONE' },
  NavicIconsKey           = { fg = '#C3E88D', bg = 'NONE' },

  NavicIconsConstant      = { fg = '#FFE082', bg = 'NONE' },
  NavicIconsConstructor   = { fg = '#FFE082', bg = 'NONE' },

  NavicIconsFunction      = { fg = '#A377BF', bg = 'NONE' },
  NavicIconsStruct        = { fg = '#A377BF', bg = 'NONE' },
  NavicIconsClass         = { fg = '#A377BF', bg = 'NONE' },
  NavicIconsModule        = { fg = '#A377BF', bg = 'NONE' },
  NavicIconsOperator      = { fg = '#A377BF', bg = 'NONE' },

  NavicIconsVariable      = { fg = '#7E8294', bg = 'NONE' },
  NavicIconsFile          = { fg = '#7E8294', bg = 'NONE' },

  NavicIconsMethod        = { fg = '#6C8ED4', bg = 'NONE' },
  NavicIconsEnumMember    = { fg = '#6C8ED4', bg = 'NONE' },

  NavicIconsInterface     = { fg = '#58B5A8', bg = 'NONE' },
  NavicIconsTypeParameter = { fg = '#58B5A8', bg = 'NONE' },

  NavicIconsNamespace     = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsPackage       = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsString        = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsNumber        = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsBoolean       = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsArray         = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsObject        = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsNull          = { fg = '#0087ff', bg = 'NONE' },
  NavicSeparator          = { fg = '#004657', bg = 'NONE' },
}

---@type LazyPluginSpec
local Navic = {
  -- https://github.com/SmiteshP/nvim-navic
  'SmiteshP/nvim-navic',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  opts = {
    depth_limit = 0,
    depth_limit_indicator = '..',
    highlight = true,
    icons = vim.tbl_map(function(v)
      return string.format('%s ', v)
    end, require('shirohana.core.constants').Icons),
    safe_output = true,
    separator = '  ',
  },
  init = function()
    for name, opts in pairs(NavicTheme) do
      vim.api.nvim_set_hl(0, name, opts)
    end
  end,
}

return Navic
