local root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h')

vim.opt.runtimepath:prepend(root .. '/build')

vim.treesitter.language.add('haskell', {
  path = root .. '/build/parser/haskell.so',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'haskell',
  callback = function(args)
    vim.treesitter.start(args.buf, 'haskell')
  end,
})
