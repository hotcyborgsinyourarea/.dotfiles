return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        -- Colorscheme
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        opts = {
            disable_background = true,
        },
        config = function(_)
            vim.cmd([[colorscheme rose-pine]])
        end
    }
}
