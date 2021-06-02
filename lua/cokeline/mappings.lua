local format = string.format

local map = vim.api.nvim_set_keymap

local M = {}

local Mapping = {
  lhs = '',
  rhs = '',
}

function Mapping:exec()
  map('n', self.lhs, self.rhs, {noremap = true, silent = true})
end

function Mapping:new(args)
  mapping = {}
  setmetatable(mapping, self)
  self.__index = self
  if args.lhs then
    mapping.lhs = args.lhs
  end
  if args.rhs then
    mapping.rhs = args.rhs
  end
  mapping:exec()
  return mapping
end

function M.setup()
  Mapping:new({
    lhs = '<Plug>(cokeline-focus-prev)',
    rhs = ':lua require"cokeline".focus({step = -1})<CR>',
  })

  Mapping:new({
    lhs = '<Plug>(cokeline-focus-next)',
    rhs = ':lua require"cokeline".focus({step = 1})<CR>',
  })

  Mapping:new({
    lhs = '<Plug>(cokeline-switch-prev)',
    rhs = ':lua require"cokeline".switch({step = -1})<CR>',
  })

  Mapping:new({
    lhs = '<Plug>(cokeline-switch-next)',
    rhs = ':lua require"cokeline".switch({step = 1})<CR>',
  })

  for target = 1,20 do
    Mapping:new({
      lhs = format('<Plug>(cokeline-focus-%s)', target),
      rhs = format(':lua require"cokeline".focus({target = %s})<CR>', target),
    })

    Mapping:new({
      lhs = format('<Plug>(cokeline-switch-%s)', target),
      rhs = format(':lua require"cokeline".switch({target = %s})<CR>', target),
    })
  end
end

return M
