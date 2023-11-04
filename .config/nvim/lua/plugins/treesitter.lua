return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local treesitter_install = require('nvim-treesitter.install')
        treesitter_install.prefer_git = false

        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all" (the four listed parsers should always be installed)
            ensure_installed = {
                "bash",
                "bicep",
                "c",
                "dockerfile",
                "git_config",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "gotmpl",
                "gpg",
                "groovy",
                "haskell",
                "hcl",
                "html",
                "http",
                "ini",
                "javascript",
                "jsdoc",
                "json",
                "json5",
                "kusto",
                -- "latex",
                "lua",
                "luadoc",
                "make",
                "php",
                "python",
                "regex",
                "ruby",
                "rust",
                "scss",
                "sql",
                "templ",
                "terraform",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
                "norg",
            },

            modules = {},

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = false,


            -- List of parsers to ignore installing (for "all")
            ignore_install = { "javascript" },

            ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
            -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                -- the name of the parser)
                -- list of language that will be disabled
                -- disable = { "c", "rust" },
                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                disable = function(lang, buf)
                    local max_filesize = 1000 * 1024 -- 1000 KB or 1 MB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    return ok and stats and stats.size > max_filesize
                end,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    node_decremental = "grm",
                    scope_incremental = "grc",
                },
            },
        })
    end,
}
