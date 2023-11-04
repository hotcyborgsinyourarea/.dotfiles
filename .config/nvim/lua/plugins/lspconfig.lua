return {
    "neovim/nvim-lspconfig",
    opts = {},
    lazy = false,
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "stevearc/conform.nvim" },
        { "mfussenegger/nvim-lint" },
        { "folke/neodev.nvim" }, -- Neovim lua features
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function(event)
                -- Keybindings
                local opts = { buffer = event.buf, remap = false }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "g<S-d>", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "<S-k>", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set("n", "<space><S-d>", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<space>f", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
                vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
                -- Open diagnostics in a window
                vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
            end
        })

        ---@type "none" | "single" | "double" | "rounded" | "solid" | "shadow" | string[8]
        ---@see vim.api.nvim_open_win
        local window_style = "shadow"
        vim.diagnostic.config({
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            signs = true,
            virtual_text = {
                severity = { min = vim.diagnostic.severity.WARN },
                spacing = 2,
                source = true,
            },
            float = {
                focusable = true,
                style = "minimal",
                border = window_style,
                source = true,
                header = "Diagnostics:",
                -- format = function(diagnostic)
                --     if diagnostic.severity == vim.diagnostic.severity.ERROR then
                --         return string.format("🤡 %s", diagnostic.message)
                --     elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                --         return string.format("💅 %s", diagnostic.message)
                --     elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                --         return string.format("🖕 %s", diagnostic.message)
                --     elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                --         return string.format("🤯 %s", diagnostic.message)
                --     end
                --     return string.format("??? %s", diagnostic.message)
                -- end
            },
        })

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        local lspconfig = require("lspconfig")
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "bashls",
                "html",
                "cssls",
                "ts_ls",
                "gopls",
                "clangd",
                "pyright",
                "sqlls",
                -- "hls",
                -- Infra stuff
                unpack({
                    "dockerls",
                    "terraformls",
                    "bicep",
                }),
                -- YAML stuff...
                unpack({
                    "yamlls",
                    "ansiblels",
                })
            },

            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end, -- generic

                ["lua_ls"] = function()
                    require("neodev").setup({}) -- Needs to be setup before lua_ls
                    lspconfig.lua_ls.setup({
                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = "Replace",
                                }
                            },
                        },
                    })
                end, -- lua_ls

                ["bashls"] = function()
                    lspconfig.bashls.setup({
                        settings = {
                            bashIde = {
                                shellcheckArguments = "--enable=all",
                            },
                        },
                    })
                end, -- bashls

                -- Real ominous type shit config
                ["azure_pipelines_ls"] = function()
                    lspconfig.azure_pipelines_ls.setup({
                        settings = {
                            yaml = {
                                schemas = {
                                    ["https://raw.githubusercontent.com/Microsoft/azure-pipelines-vscode/main/service-schema.json"] = {
                                        "/azure-pipeline*.y*l",
                                        "/*.azure*",
                                    },
                                },
                            },
                        },
                    })
                end, -- azure_pipelines_ls

            },
        })

        -- Formatters
        require("conform").setup({
            formatters_by_ft = {
                python = { "isort", "black" },
                javascript = { "prettier" },
            },
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                local excluded_filetype_patterns = {
                    ".*%.[ch][p]+$",
                }
                for _, pattern in pairs(excluded_filetype_patterns) do
                    if string.match(args.file, pattern) then return end
                end
                require("conform").format({ bufnr = args.buf })
            end,
        })

        -- Linters >:(
        require("lint").linters_by_ft = {
            gitcommit = { "commitlint" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                -- try_lint without arguments runs the linters defined in `linters_by_ft`
                -- for the current filetype
                -- require("lint").try_lint()
                -- You can call `try_lint` with a linter name or a list of names to always
                -- run specific linters, independent of the `linters_by_ft` configuration
                require("lint").try_lint("woke")
            end,
        })
    end,
}
