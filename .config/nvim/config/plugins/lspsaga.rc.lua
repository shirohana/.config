local saga = require 'lspsaga'

saga.setup {
  -- diagnostic sign
  error_sign = '',
  -- warn_sign = '',
  -- hint_sign = '',
  -- infor_sign = '',
  -- error_sign = "",
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  diagnostic_header_icon = '   ',
  code_action_icon = ' ',
  border_style = 'round',
  -- finder_definition_icon = "  ",
  -- finder_reference_icon = "  ",
}
