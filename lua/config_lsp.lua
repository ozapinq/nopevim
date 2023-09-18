require('neodev').setup()

local coq = require('coq')
local lsp = require('lspconfig')

lsp.lua_ls.setup(coq.lsp_ensure_capabilities({}))
lsp.pyright.setup(coq.lsp_ensure_capabilities({}))
lsp.bashls.setup(coq.lsp_ensure_capabilities({}))
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities({}))
