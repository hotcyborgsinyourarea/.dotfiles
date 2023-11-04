return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.4",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "BurntSushi/ripgrep",          opt = true },
        { "nvim-tree/nvim-web-devicons", opt = true },
    },
    config = function()
        require("telescope").setup({
            defaults = {
                -- Default configuration for telescope goes here:
                -- config_key = value,
                -- ..
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
            }
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fp", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>fr", builtin.keymaps, {})
        vim.keymap.set("n", "<leader>fB", builtin.git_branches, {})
        vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
    end,
}
