return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },                -- lsp completions
        { "hrsh7th/cmp-buffer" },                  -- buffer words
        { "hrsh7th/cmp-path" },                    -- paths
        { "L3MON4D3/LuaSnip" },                    -- snippet engine
        { "hrsh7th/cmp-calc" },                    -- calculator
        { "hrsh7th/cmp-nvim-lsp-signature-help" }, -- function signatures
        { "hrsh7th/cmp-nvim-lua" },                -- qol ricing
        { "f3fora/cmp-spell" },                    -- splelcheck
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.set_config({
            history = false,
            updateevents = "TextChanged,TextChangedI",
        })

        ---@type "none" | "single" | "double" | "rounded" | "solid" | "shadow" | string[8]
        ---@see vim.api.nvim_open_win
        local window_style = "shadow"

        vim.opt.completeopt = { "menu", "menuone", "noselect" }
        cmp.setup({
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                {
                    name = "luasnip",
                    option = {
                        use_show_condition = false,
                        show_autosnippets = true
                    },
                },
                { name = "buffer" },
                { name = "nvim_lua" },
                { name = "calc" },
                { name = "nvim_lsp_signature_help" },
                { name = "path" },
            }),
            mapping = cmp.mapping.preset.insert({
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-c>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            }),
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered({
                    border = window_style,
                }),
                documentation = cmp.config.window.bordered({
                    border = window_style,
                }),
            },
            view = {
                entries = {
                    name = "custom",
                    selection_order = "near_cursor",
                },
            },
        })

        cmp.setup.filetype({ "sql" }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
            },
        })

        cmp.setup.filetype({ "text", "markdown" }, {
            sources = {
                { name = "buffer" },
                { name = "spell" },
            },
        })

        cmp.setup.filetype({ "norg" }, {
            sources = {
                { name = "neorg" },
            },
        })

        vim.keymap.set({ "i", "s" }, "<c-k>", function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<c-j>", function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { silent = true })
    end
}
