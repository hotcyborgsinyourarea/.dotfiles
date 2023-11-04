return {
    "tpope/vim-commentary",
    config = function()
        vim.keymap.set("v", "<leader>/", ":Commentary<CR>", { silent = true })
    end,
}
