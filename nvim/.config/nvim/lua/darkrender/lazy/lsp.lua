return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'whoissethdaniel/mason-tool-installer.nvim',

    -- useful status updates for lsp.
    -- note: `opts = {}` is the same as calling `require('fidget').setup({})
    { 'j-hui/fidget.nvim', opts = {} },

    -- `neodev` configures lua lsp for your neovim config, runtime and plugins
    -- useful for completion, annotations and signatures of neovim apis
    { 'folke/neodev.nvim', opts = {} },

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local cmp_lsp = require 'cmp_nvim_lsp'
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())

    local servers = {
      clangd = {
        cmd = { 'clangd', '--header-insertion=never' },
      },
      zls = {},
      lua_ls = {
        settings = {
          lua = {
            completion = {
              callsnippet = 'replace',
            },
          },
        },
      },
    }

    require('mason').setup()

    -- you can add other tools here that you want mason to install
    -- for you, so that they are available from within neovim
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- used to format lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
