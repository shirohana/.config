import vim

def expand(snip, expand_pos_list=[1]):
    if snip.tabstop in expand_pos_list:
        vim.eval('feedkeys("\<C-R>=UltiSnips#ExpandSnippet()\<CR>")')

def unit(num, has_unit, default_unit='px'):
    return (num if has_unit else num + default_unit) if num else ''
