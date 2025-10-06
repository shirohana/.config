---@type vim.lsp.ClientConfig
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package.json',
        },
        {
          fileMatch = { 'tsconfig*.json' },
          url = 'https://json.schemastore.org/tsconfig.json',
        },
        {
          fileMatch = { '.prettierrc', '.prettierrc.json', 'prettier.config.json' },
          url = 'https://json.schemastore.org/prettierrc.json',
        },
        {
          fileMatch = { '.eslintrc', '.eslintrc.json' },
          url = 'https://json.schemastore.org/eslintrc.json',
        },
        {
          fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
          url = 'https://json.schemastore.org/babelrc.json',
        },
        {
          fileMatch = { 'lerna.json' },
          url = 'https://json.schemastore.org/lerna.json',
        },
        {
          fileMatch = { 'now.json', 'vercel.json' },
          url = 'https://json.schemastore.org/now.json',
        },
        {
          fileMatch = { 'jest.config.js' },
          url = 'https://json.schemastore.org/jest.config.json',
        },
      },
    },
  },
}
