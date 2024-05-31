local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local JsPrettyTemplate = {
  Plugins.JsPrettyTemplate,
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

return { JsPrettyTemplate }
