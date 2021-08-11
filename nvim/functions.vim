" GENERAL  {{{1
function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

function! OpenJiraTicket()
  let branch = fugitive#head()
  let ticket_id = matchstr(branch, '[A-Z]\+-\d\+')
  if ticket_id !=# ''
    call system('open ' . $JIRA_URL . '/' . ticket_id)
  else
    echo 'ticket id not found!'
  endif
endfunction

function! CleanLogs()
    call system('> logs/general.log')
    call system('> logs/errors.log')
    echo 'logs cleaned'
endfunction

" DIRVISH {{{1
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
  silent execute 'Dirvish %'
  silent execute 'normal! gg'
  silent exec '/'.filename
  nohlsearch
endf

function! DeleteItemUnderCursor()
	let target = trim(getline('.'), '/\')
	let filename = fnamemodify(target, ':t')
  let target = '/'.target
  let cmd = (isdirectory(target)) ?  printf('rm -r "%s"',target) : printf('rm "%s"', target)
  silent exec '!'.cmd '&' | redraw!
  silent execute 'Dirvish %'
endfunction

function! RenameItemUnderCursor()
  let target = trim(getline('.'))
  let filename = fnamemodify(target, ':t')
  let newname = input('Rename: ', filename)
  if empty(newname) || newname == filename
    return
  endif
  let cmd = printf('mv "%s" "%s"', target, expand('%') . newname)
  silent exec '!'.cmd '&' | redraw!
  silent execute 'Dirvish %'
endfunction

function! CreateInitPy()
  let filepath = expand('%') . '__init__.py'
  exec '!touch' filepath '&' | redraw!
  silent execute 'Dirvish %'
endfunction
