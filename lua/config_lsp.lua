require('neodev').setup()

local coq = require('coq')
local lsp = require('lspconfig')

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'lua',
    callback = function() lsp.lua_ls.setup(coq.lsp_ensure_capabilities({})) end
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function() lsp.pyright.setup(coq.lsp_ensure_capabilities({})) end
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'sh',
    callback = function() lsp.bashls.setup(coq.lsp_ensure_capabilities({})) end
})
