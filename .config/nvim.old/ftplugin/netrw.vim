"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTO COMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable the s key in netrw as it messes up the structure
autocmd FileType netrw noremap <buffer> s <nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle=4
let g:netrw_preview=1
let g:netrw_alto=0
let g:netrw_winsize=25
let g:netrw_keepdir=1
let g:netrw_menu=0
let g:netrw_banner=0
" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'
let g:netrw_bufsettings='noma nomod nu nowrap ro nobl'
let g:netrw_list_hide= '.*\.png$,.*\.pdf,.*\.mp4,.*\.tga,.*\.mp3,.*\.jpg,.*\.svg,/*\.stl,.*\.mtl,.*\.ply'
