---@type string
-- package_name, package_path
local package_name, _ = ...
local group = vim.api.nvim_create_augroup(package_name .. "_autocmd", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
    desc = "Center window on cursor when entering insert mode",
    pattern = "*",
    command = "norm zz",
    group = group,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Remove trailing spaces",
    pattern = "*",
    command = "%s/\\s\\+$//e",
    group = group,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    callback = function()
        vim.highlight.on_yank()
    end,
    group = group,
})
