local opt = vim.opt
local global = vim.g

-- Search
opt.hlsearch = true
vim.keymap.set("n", "<ESC>", ":nohlsearch<CR>", { silent = true })
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true

-- Tabline & buffers
opt.showtabline = 2
opt.laststatus = 2
opt.hidden = true

-- Window splitting & styling
opt.splitbelow = true
opt.splitright = true
opt.fillchars = {
    stl = " ",   -- current window statusline
    stlnc = "=", -- non-current window statusline
}
opt.mouse:append("a")
opt.clipboard = "unnamedplus"
opt.lazyredraw = false
opt.termguicolors = true
opt.pumheight = 10
opt.cmdheight = 1
opt.scrolloff = 8
opt.colorcolumn = "79"
opt.signcolumn = "yes"
opt.relativenumber = true
opt.backspace = { "indent", "eol", "start" }
opt.foldcolumn = "auto"
opt.guicursor = "n-v-c-sm-i-ci:block,ve:ver25,r-cr-o:hor20"

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true -- 4 spaces
opt.wrap = true

-- Save state
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") or os.getenv("LOCALAPPDATA") .. "/.local/share/nvim/undodir/"
opt.updatetime = 100

-- Misc
opt.exrc = false -- *Security feature*
opt.autochdir = true
opt.listchars = { space = "_", trail = "·", tab = "»·" }
opt.virtualedit = "block"
opt.inccommand = "split"

-- Try to remember that `:TOHtml` is a thing
global.html_use_encoding = "UTF-8"
global.html_prevent_copy = "fn"
global.html_expand_tabs = 1
global.html_use_xhtml = 0

-- Netrw stuff
global.netrw_banner = 1
global.netrw_liststyle = 0
