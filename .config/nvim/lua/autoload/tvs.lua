-- Tabs V. Spaces => tvs

---@type { [string]: function }
return {
    ---@alias tvsOpts { shiftwidth: integer?, tabstop: integer?, softtabstop: integer? }
    ---@param opts tvsOpts
    use_tabs = function(opts)
        vim.opt_local.expandtab = false
        vim.opt_local.shiftwidth = opts.shiftwidth or 4
        vim.opt_local.tabstop = opts.tabstop or 4
        vim.opt_local.softtabstop = opts.softtabstop or 0
    end,
    ---@param opts tvsOpts
    use_spaces = function(opts)
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = opts.shiftwidth or 4
        vim.opt_local.tabstop = opts.tabstop or 4
        vim.opt_local.softtabstop = opts.softtabstop or 0
    end,
}
