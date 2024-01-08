-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

local fn = vim.fn
local opt = vim.opt

-- General
opt.mouse = "a"
-- opt.clipboard = "unnamedplus"
opt.scrolloff = 4
opt.sidescrolloff = 15
opt.sidescroll = 5
opt.hidden = true
opt.wrap = true
opt.linebreak = true
opt.exrc = true
vim.opt.textwidth = 80

-- Indentation
opt.shiftwidth = 2
opt.tabstop = 2
opt.autoindent = true
opt.expandtab = true
opt.smartindent = true

-- Splits
opt.splitright = true
opt.splitbelow = true
opt.diffopt = "vertical"

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.colorcolumn = "80"
opt.termguicolors = true
vim.cmd.colorscheme("nord")

-- Maintenance
opt.swapfile = false
opt.undodir = fn.stdpath("data") .. "/undodir"
opt.undofile = true
opt.undolevels = 1000

-- Search
opt.completeopt = "menuone,noinsert,noselect"
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.showmatch = true
opt.wildmode = "longest:full,full"
opt.wildignorecase = true
opt.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class,*.mat,*.csv,*.tsv
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]]

-- Speling
vim.cmd("iabbrev adn and")
vim.cmd("iabbrev teh the")
vim.cmd("iabbrev hte the")
