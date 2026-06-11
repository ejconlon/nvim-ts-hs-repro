local root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h')
local lazypath = root .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'romus204/tree-sitter-manager.nvim',
    lazy = false,
    config = function()
      require('tree-sitter-manager').setup({
        ensure_installed = { 'haskell' },
        auto_install = true,
      })
    end,
  },
}, {
  root = root .. '/lazy/plugins',
  lockfile = root .. '/lazy-lock.json',
  change_detection = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'haskell',
  callback = function(args)
    vim.treesitter.start(args.buf, 'haskell')
  end,
})
