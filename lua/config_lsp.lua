local coq = require('coq')

-- local lsp_group = vim.api.nvim_create_augroup('LSP', {clear = true})
-- vim.api.nvim_create_autocmd('BufEnter', {
--     callback = function() 
--         error('bbbb')
--     end,
--     group = lsp_group,
--     pattern = '*'
-- })
require('neodev').setup()
require('lspconfig').lua_ls.setup(coq.lsp_ensure_capabilities({}))

