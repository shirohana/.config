local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local PlantUmlPreviewer = {
  Plugins.PlantUmlPreviewer,
  ft = { 'uml', 'plantuml' },
  cmd = { 'PlantumlOpen', 'PlantumlSave' },
  dependencies = { Plugins.OpenBrowser },
  init = function()
    vim.g['plantuml_previewer#plantuml_jar_path'] = vim.fn.matchlist(
      vim.fn.system 'cat `which plantuml` | grep plantuml.jar',
      [[\v.*\s['"]?(\S+plantuml\.jar).*]],
      1
    )
    vim.cmd [[
      augroup HanaPlantUmlPreviewer
        autocmd!
        autocmd FileType plantuml nnoremap <buffer> <silent> <CR> <Cmd>PlantumlOpen<CR>
      augroup END
    ]]
  end,
}

---@type LazyPluginSpec
local PlantUmlSyntax = {
  Plugins.PlantUmlSyntax,
  ft = { 'uml', 'plantuml' },
}

return { PlantUmlPreviewer, PlantUmlSyntax }
