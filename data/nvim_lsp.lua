-- Danis cool config
local lspconfig = require("lspconfig")

lspconfig.hls.setup {
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,
	filetypes = { 'haskell', 'lhaskell', 'cabal' },
}

lspconfig.clangd.setup {
    cmd = { "clangd", "--header-insertion=never" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = function(fname)
        return lspconfig.util.root_pattern("compile_commands.json", ".git")(fname) or lspconfig.util.path.dirname(fname)
    end,
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.asm_lsp.setup({
    filetypes = { "asm" },
    settings = {
        asm = {
            dialect = "nasm",
            disableWarnings = true,  -- Disable unnecessary warnings
            highlightJumpLabels = true,
        }
    },
	handlers = { ["textDocument/publishDiagnostics"] = function() end }
})

lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",  -- Adjust based on your needs
        autoImportCompletions = true,
      },
    },
  },
})
