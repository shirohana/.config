import vim

def expand(snip, expand_pos_list=[1]):
    if snip.tabstop in expand_pos_list:
        vim.eval('feedkeys("\<C-R>=UltiSnips#ExpandSnippet()\<CR>")')

def unit(num, unit, default_unit='px'):
    if num is None:
        return ''
    elif unit is '' or unit is None:
        return num + default_unit
    else:
        return num + {
            'e': 'em',
            'r': 'rem'
        }.get(unit, unit)
