vim.filetype.add({
    filename = {
        ["Jenkinsfile"] = "groovy",
    },
})

vim.filetype.add({
    filename = {
        ["templ"] = "templ",
    },
})

vim.filetype.add({
    pattern = {
        ["*.cgi"] = "perl",
    }
})

-- vim.filetype.add({
--     filename = {
--         [".clang-format"] = "yaml",
--     },
-- })
