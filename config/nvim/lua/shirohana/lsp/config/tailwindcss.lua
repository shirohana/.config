---@type vim.lsp.ClientConfig
return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'css',
    'html',
    'javascript',
    'svelte',
    'typescript',
    'typescriptreact',
  },
  root_markers = {
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.ts',
    'package.json',
  },
  settings = {
    tailwindCSS = {
      classAttributes = { 'class', 'className' },
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidConfigPath = 'error',
        invalidScreen = 'error',
        invalidTailwindDirective = 'error',
        invalidVariant = 'error',
        recommendedVariantOrder = 'warning',
      },
      validate = true,
    },
  },
}
