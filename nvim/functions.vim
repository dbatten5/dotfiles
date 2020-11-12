function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

function! PromptUserForFilename(requestToUser, ...)
    let title = input(a:requestToUser)
    let ComputeFinalPath = a:0 ? a:1 : { x -> x }
    let GetRetryMessage = { x -> a:0 > 0 ? a:1 : printf('[%s] already exists. %s', x, a:requestToUser) }
    while title != '' && len(glob(ComputeFinalPath(title))) > 0
        redraw | let title= input(GetRetryMessage(title))
    endwhile
    redraw
    return title
endfunction

function! CreateDirectory()
    let dirname = PromptUserForFilename('Directory name: ')
    if trim(dirname) == ''
        return
    endif
    let dirpath = expand("%") . dirname
    silent exec '!mkdir' dirpath '&' | redraw!
    normal Rgg
    silent exec '/'.dirname
    nohlsearch
endf

function! CreateFile()
    let filename = PromptUserForFilename('File name: ')
    if trim(filename) == ''
        return
    endif
    let filepath = expand("%") . filename
    exec '!touch' filepath '&' | redraw!
    normal Rgg
    silent exec '/'.filename
    nohlsearch
endf

function! DeleteItemUnderCursor()
	let target = trim(getline('.'), '/\')
	let filename = fnamemodify(target, ':t')
    let target = '/'.target
    let cmd = (isdirectory(target)) ?  printf('rm -r "%s"',target) : printf('rm "%s"', target)
    silent exec '!'.cmd '&' | redraw!
	normal R
endfunction

function! RenameItemUnderCursor()
	let target = trim(getline('.'), '/\')
	let filename = fnamemodify(target, ':t')
	let newname = input('Rename into: ', filename)
    let cmd = printf('mv "%s" "%s"', filename, newname)
    silent exec '!'.cmd '&' | redraw!
    normal R
endfunction
