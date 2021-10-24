syn match jsFlowTypeCustom contained /[0-9a-zA-Z_$.]*/ skipwhite skipempty nextgroup=jsFlowGeneric
syn match jsFlowReturnKeyword contained /\$\?\k\+/ contains=jsFlowType,jsFlowTypeCustom skipwhite skipempty nextgroup=jsFlowReturnGroup,jsFuncBlock,jsFlowReturnOrOp,jsFlowReturnArray
