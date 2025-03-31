function ColorMyPencils(color)
  color = color or 'catppuccin-mocha'
  vim.cmd.colorscheme(color)
  vim.cmd.hi = 'Comment gui=none'
end

vim.api.nvim_create_user_command('ColorMyPencils', function(opts)
  ColorMyPencils(opts.fargs[1])
end, { nargs = '?' })

return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
    opts = {},
    config = function()
      ColorMyPencils()
    end,
  },
  {
    'Mofiqul/vscode.nvim',
  },
  {
    'catppuccin/nvim',
  },
}
