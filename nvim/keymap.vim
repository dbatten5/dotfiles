" BASIC KEY MAPPINGS {{{1
" Quickly open and source my vimrc
nnoremap <leader>ev :vnew $NVIMCONFIG<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Center the screen on next match
nnoremap n nzz
" Make <c-c> the same as esc in insert mode
inoremap <c-c> <esc>
" Quicker window movement
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Quicker saves
nnoremap <silent> s :update<cr>
" Remap the hash key as it's awkward on a mac
nnoremap & #
" Swap ' and ` for going to marks
nnoremap ' `
nnoremap ` '
" Quick resizing
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<cr>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<cr>
nnoremap <right> :vertical resize +5<cr>
nnoremap <left> :vertical resize -5<cr>
" Exchange J and j in visual mode because I keep pressing it in my haste when I
" go into visual block / line mode and want to immediately move down a line
vnoremap J j
" Do the same for K and k
vnoremap K k
" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<cr>
" Swap 0 and ^ as ^ is more useful but more keystrokes to get to
nnoremap 0 ^
nnoremap ^ 0
" copy to system clipboard
vnoremap <c-c> "+y
" Paste from system clipboard
inoremap <c-v> <esc>"+p
" Indent without killing the selection in vmode
vnoremap < <gv
vnoremap > >gv
" open devdocs.io with chrome and search the word under the cursor (Phantas0s)
command! -nargs=? DevDocs :call system('type -p open >/dev/null 2>&1 && open https://devdocs.io/#q=<args> || chrome -url https://devdocs.io/#q=<args>')
nnoremap <silent> <leader>D :exec "DevDocs " . fnameescape(expand('<cword>'))<cr>
" Swap v and ctrl-v as visual block mode is more useful
nnoremap v <c-v>
nnoremap <c-v> v
vnoremap v <c-v>
vnoremap <c-v> v
" Quickly set the local working directory
nnoremap <leader>ld :lcd %:p:h<cr>
" Toggle folds
nnoremap <leader>fn :set foldenable!<cr>
" Remove whitespace
nnoremap <leader>ws :call general#StripTrailingWhiteSpaces()<cr>
" Insert filename
inoremap <leader>fn <c-r>=expand("%:t:r")<cr>
" Movement in insert mode
inoremap <c-h> <c-o>h
inoremap <c-l> <c-o>a
inoremap <c-j> <c-o>j
inoremap <c-k> <c-o>k
inoremap <c-^> <c-o><c-^>
" Open/close fold
nnoremap <silent> <space><space> @=(foldlevel('.')?'za':"\<space>")<cr>
" Output the current syntax group (shorturl.at/uwBHV)
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
" Paste last yanked item
noremap <space>p "0p
noremap <space>P "0P
" I don't use ex mode (should I???)
nnoremap Q @q
" Google the current word 
nnoremap <leader>? :call general#Google(expand("<cword>"), 0)<cr>

" QUICKFIX {{{1
" Toggle the quickfix
nnoremap <leader>qf :call ToggleQuickFix()<cr>
" Go back through the quickfix window
nnoremap <leader>qo :colder<cr>
" Go back through the quickfix window
nnoremap <leader>qn :cnewer<cr>

" TERMINAL EMULATOR {{{1
" Remap the escape from terminal mode
tnoremap <esc> <c-\><c-n>
" Open the terminal quickly
nnoremap <space>t :call general#OpenTerminal()<cr>
nnoremap <space>T :terminal<cr>

" FTPLUGIN {{{1
nnoremap <leader>of :call general#OpenFTPlugin()<cr>

" COMMONS {{{1
nnoremap <leader>lg :e logs/general.log<cr>Gzz

" NOTES {{{1
nnoremap gn :call general#OpenNote()<cr>

" SPELING {{{1
iabbrev adn and
iabbrev teh the

" COMPLETION MENU {{{1
" pressing enter selects the item rather than inserting a new line
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
