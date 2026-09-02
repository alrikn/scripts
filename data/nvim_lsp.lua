-- Danis cool config

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("hls", {
    capabilities = capabilities,
    filetypes = { "haskell", "lhaskell", "cabal" },
})

vim.lsp.config("clangd", {
    cmd = { "clangd", "--header-insertion=never" },
    capabilities = capabilities,
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, { "compile_commands.json", ".git" })
        on_dir(root or vim.fs.dirname(fname))
    end,
})

vim.lsp.config("asm_lsp", {
    filetypes = { "asm" },
    settings = {
        asm = {
            dialect = "nasm",
            disableWarnings = true,
            highlightJumpLabels = true,
        },
    },
})

vim.lsp.config("pyright", {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
            },
        },
    },
})

vim.lsp.config("gopls", {
    capabilities = capabilities,
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, { "go.work", "go.mod", ".git" })
        on_dir(root or vim.fs.dirname(fname))
    end,
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                unusedwrite = true,
            },
        },
    },
})

vim.lsp.enable({
    "hls",
    "clangd",
    "asm_lsp",
    "pyright",
	"gopls",
})
