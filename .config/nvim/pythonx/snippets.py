import vim

def expand(snip, expand_pos_list=[1]):
  if snip.tabstop in expand_pos_list:
    vim.eval('feedkeys("\<C-R>=UltiSnips#ExpandSnippet()\<CR>")')

def unit(num, unit, default_unit = 'rem'):
  if num is None:
    return ''
  if unit == '' or unit is None:
    return '0' if num == '0' else num + default_unit
  else:
    return num + {
      'e': 'em',
      'r': 'rem',
      'x': 'px',
      'p': '%'
    }.get(unit, unit)
