require 'darkrender.set'
require 'darkrender.remap'
require 'darkrender.lazy_init'

local augroup = vim.api.nvim_create_augroup
local DarkrenderGroup = augroup('Darkrender', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', { clear = true })

autocmd('textyankpost', {
  desc = 'highlight when yanking (copying) text',
  group = yank_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd('LspAttach', {
  group = DarkrenderGroup,
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'lsp: ' .. desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
    map('gi', require('telescope.builtin').lsp_implementations, '[g]oto [i]mplementation')
    map('<leader>d', require('telescope.builtin').lsp_type_definitions, 'type [d]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[d]ocument [s]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')
    map('K', vim.lsp.buf.hover, 'hover documentation')
    map('gD', vim.lsp.buf.declaration, '[g]oto [d]eclaration')

    -- the following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    see `:help cursorhold` for information about when this is executed
    --
    -- when you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.name == 'clangd' then
      map('gf', vim.cmd.ClangdSwitchSourceHeader, '[g]oto header or source file, depending on which one is active')
    end

    if client and client.server_capabilities.documenthighlightprovider then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'cursorhold', 'cursorholdi' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'cursormoved', 'cursormovedi' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('lspdetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- the following autocommand is used to enable inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- this may be unwanted, since they displace some of your code
    if client and client.server_capabilities.inlayhintprovider and vim.lsp.inlay_hint then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, '[t]oggle inlay [h]ints')
    end
  end,
})
