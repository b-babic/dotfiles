-- All language servers are expected to be installed with 'mason.vnim'.
-- Currently used ones:
-- - clangd for C/C++
-- - pyright for Python
-- - r_language_server for R
-- - sumneko_lua for Lua
-- - tsserver(ts_ls rename) for Typescript and Javascript
local lspconfig = require('lspconfig')

-- Preconfiguration ===========================================================
local on_attach_custom = function(client, buf_id)
    vim.bo[buf_id].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

    -- Mappings are created globally for simplicity

    -- Currently all formatting is handled with 'null-ls' plugin
    if vim.fn.has('nvim-0.8') == 1 then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    else
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end
end

-- local diagnostic_opts = {
--   float = { border = 'double' },
--   -- Show gutter sings
--   signs = {
--     -- With highest priority
--     priority = 9999,
--     -- Only for warnings and errors
--     severity = { min = 'WARN', max = 'ERROR' },
--   },
--   -- Show virtual text only for errors
--   virtual_text = { severity = { min = 'ERROR', max = 'ERROR' } },
--   -- Don't update diagnostics when typing
--   update_in_insert = false,
-- }
local icons = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}

---@type vim.diagnostic.Opts
local diagnostic_opts = {
    float = {
        border = 'double'
    },
    underline = true,
    update_in_insert = false,
    virtual_text = {
        -- Show virtual text only for errors
        -- severity = { min = "ERROR", max = "ERROR" },

        spacing = 4,
        source = "if_many",
        prefix = function(diagnostic)
            for d, icon in pairs(icons) do
                if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                    return icon
                end
            end
            return "●"
        end
    },
    severity_sort = true,
    signs = {
        priority = 9999,
        text = {
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN] = icons.Warn,
            [vim.diagnostic.severity.HINT] = icons.Hint,
            [vim.diagnostic.severity.INFO] = icons.Info
        }
    }
}
vim.diagnostic.config(vim.deepcopy(diagnostic_opts))

-- vim.diagnostic.config(diagnostic_opts)

-- R (r_language_server) ======================================================
lspconfig.r_language_server.setup({
    on_attach = on_attach_custom,
    -- Debounce "textDocument/didChange" notifications because they are slowly
    -- processed (seen when going through completion list with `<C-N>`)
    flags = {
        debounce_text_changes = 150
    }
})

-- Python (pyright) ===========================================================
lspconfig.pyright.setup({
    on_attach = on_attach_custom
})

-- Lua (sumneko_lua) ==========================================================
local luals_root = vim.fn.stdpath('data') .. '/mason'
if vim.fn.isdirectory(luals_root) == 1 then
    -- if false then
    local sumneko_binary = luals_root .. '/bin/lua-language-server'

    lspconfig.lua_ls.setup({
        handlers = {
            -- Show only one definition to be usable with `a = function()` style.
            -- Because LuaLS treats both `a` and `function()` as definitions of `a`.
            ['textDocument/definition'] = function(err, result, ctx, config)
                if type(result) == 'table' then
                    result = {result[1]}
                end
                vim.lsp.handlers['textDocument/definition'](err, result, ctx, config)
            end
        },
        cmd = {sumneko_binary},
        on_attach = function(client, bufnr)
            on_attach_custom(client, bufnr)
            -- Reduce unnecessarily long list of completion triggers for better
            -- `MiniCompletion` experience
            client.server_capabilities.completionProvider.triggerCharacters = {'.', ':'}
        end,
        root_dir = function(fname)
            return lspconfig.util.root_pattern('.git')(fname) or lspconfig.util.path.dirname(fname)
        end,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';')
                },
                diagnostics = {
                    -- Get the language server to recognize common globals
                    globals = {'vim', 'describe', 'it', 'before_each', 'after_each'},
                    disable = {'need-check-nil'},
                    -- Don't make workspace diagnostic, as it consumes too much CPU and RAM
                    workspaceDelay = -1
                },
                workspace = {
                    -- Don't analyze code from submodules
                    ignoreSubmodules = true
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false
                }
            }
        }
    })
end

-- C/C++ (clangd) =============================================================
lspconfig.clangd.setup({
    on_attach = on_attach_custom
})

-- Typescript (ts_ls) ======================================================
lspconfig.ts_ls.setup({
    on_attach = on_attach_custom,
    single_file_support = true
})

-- Stimulus (solargraph) ======================================================
lspconfig.stimulus_ls.setup({
    on_attach = on_attach_custom
})

-- Ruby (solargraph) ==========================================================
lspconfig.solargraph.setup({
    on_attach = on_attach_custom,
    filetypes = {'ruby', 'eruby'}
})

-- Tailwind CSS (tailwindcss) =================================================
lspconfig.tailwindcss.setup({
    on_attach = on_attach_custom
})

-- Emmet (emmet_ls) ===========================================================
lspconfig.emmet_ls.setup({
    on_attach = on_attach_custom
})

-- HTML (html) ================================================================
lspconfig.html.setup({
    on_attach = on_attach_custom,
    filetypes = {'html', 'eruby'}
})

-- CSS (cssls) ================================================================
lspconfig.cssls.setup({
    on_attach = on_attach_custom
})

-- Stylelint (stylelint_lsp) ==================================================
lspconfig.stylelint_lsp.setup({
    on_attach = on_attach_custom
})

-- JSON (jsonls) ==============================================================
lspconfig.jsonls.setup({
    on_attach = on_attach_custom
})

-- YAML (yamlls) ==============================================================
lspconfig.yamlls.setup({
    on_attach = on_attach_custom
})

-- Dockerfile (dockerls) ======================================================
lspconfig.dockerls.setup({
    on_attach = on_attach_custom
})

-- Docker compose (dockerls) ==================================================
lspconfig.docker_compose_language_service.setup({
    on_attach = on_attach_custom
})

-- Bash (bashls) ==============================================================
lspconfig.bashls.setup({
    on_attach = on_attach_custom
})

-- SQL (sqls) =================================================================
lspconfig.sqls.setup({
    on_attach = on_attach_custom
})

-- Svelte (svelte) ============================================================
lspconfig.svelte.setup({
    on_attach = on_attach_custom
})

-- Typos (cspell) ============================================================
-- lspconfig.typos_lsp.setup({ on_attach = on_attach_custom })

-- Typos (harper) ============================================================
lspconfig.harper_ls.setup({
    on_attach = on_attach_custom,
    settings = {
        ["harper-ls"] = {
            userDictPath = "../misc/dict/english.txt"
        }
    }
})

-- Markdown (marksman) ========================================================
lspconfig.marksman.setup({
    on_attach = on_attach_custom
})

-- Gleam (gleam) ==============================================================
lspconfig.gleam.setup({
    on_attach = on_attach_custom
})

-- Intelephense (php) ========================================================
lspconfig.intelephense.setup({
  on_attach = on_attach_custom
})

-- Golang (gopls) ========================================================
lspconfig.gopls.setup({
  on_attach = on_attach_custom
})

lspconfig.golangci_lint_ls.setup {
	filetypes = {'go','gomod'}
}
