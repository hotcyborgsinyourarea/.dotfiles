local set = vim.keymap.set

-- TAB moves one buffer ahead
-- SHIFT-TAB will go back one buffer
set("n", "<TAB>", function()
    return vim.cmd.bnext()
end)
set("n", "<S-TAB>", function()
    return vim.cmd.bprevious()
end)

-- Save buffer with Cntrl+s
set("n", "<C-s>", vim.cmd.w)

-- Leader+s replace string in file (with selection too)
-- set("n", "<leader>s", [[
--     :%s/\(<C-r><C-w>\)/\1/cgI<Left><Left><Left><Left>]])
-- Leader+s replace string in selected line
-- set("v", "<leader>s", vim.fn.expand([[
--     :s///cgI<Left><Left><Left><Left><Left>]]))

-- Navigate between windows (ew!) w/o `w`
set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")
-- Resize window (NOTE: <M- stands for alt/meta, go figure lol)
set("n", "<M-h>", ":vertical resize +2<CR>")
set("n", "<M-j>", ":resize -2<CR>")
set("n", "<M-k>", ":resize +2<CR>")
set("n", "<M-l>", ":vertical resize -2<CR>")

-- Move selection up/down
set("v", "<S-j>", ":m '>+1<CR>gv=gv")
set("v", "<S-k>", ":m '<-2<CR>gv=gv")

-- Indent selection without visual exiting mode (shift+>|<)
set("v", "<", "<gv")
set("v", ">", ">gv")

-- Move half screen, keep cursor in the middle
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")


-- Open interactive terminal
set("n", "<leader>`", "<cmd>terminal<CR>")
-- Exit Insert mode in terminal
set("t", "<Esc><Esc>", "<C-\\><C-N>")

-- Do the thingy go fmt does on structs
set("v", "<leader>t", ":!column --table<CR>")
