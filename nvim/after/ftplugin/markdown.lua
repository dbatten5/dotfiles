local map = vim.keymap.set
local opt = vim.opt_local

opt.spell = true

map("i", "<c-i>", "<c-g>u<Esc>[s1z=`]a<c-g>u") -- correct spelling mistakes
