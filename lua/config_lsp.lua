require('neodev').setup()

local coq = require('coq')
local lsp = require('lspconfig')

lsp.lua_ls.setup(coq.lsp_ensure_capabilities({}))
lsp.pyright.setup(coq.lsp_ensure_capabilities({}))
lsp.bashls.setup(coq.lsp_ensure_capabilities({}))

local on_attach = function(client)
    require'completion'.on_attach(client)
end

lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
}))
