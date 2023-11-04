return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = true,
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp", -- undocumented?
                },
            },
            ["core.integrations.nvim-cmp"] = {},
            ["core.export"] = {},
            ["core.export.markdown"] = {},
            ["core.summary"] = {},
            ["core.concealer"] = {
                config = {
                    icon_preset = "varied", -- basic | diamond | varied
                },
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/Notes",
                    },
                    default_workspace = "notes",
                },
            },
        },
    },
    dependencies = {
        { "nvim-lua/plenary.nvim", },
    },
}
