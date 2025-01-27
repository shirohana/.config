---@type LazyPluginSpec
local JsPrettyTemplate = {
  -- https://github.com/Quramy/vim-js-pretty-template
  'Quramy/vim-js-pretty-template',
  event = 'BufEnter',
  config = function()
    vim.cmd [[
    call jspretmpl#register_tag('html', 'typescriptreact')
    augroup HanaJavascript
      autocmd!
      autocmd FileType javascript JsPreTmpl
    augroup END
    ]]
  end,
}

return JsPrettyTemplate
