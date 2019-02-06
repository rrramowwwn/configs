" Return reviewer string from shell
function! s:GetReviewer(name)
    execute 'read !reviewer '.a:name
endfunction

command! -nargs=1 Reviewer call s:GetReviewer(<f-args>)

" This callback will be executed when the entire command is completed
function! BackgroundCommandClose(channel)
  " Read the output from the command into the quickfix window
  execute "cfile! " . g:backgroundCommandOutput
  " Open the quickfix window
  copen
  unlet g:backgroundCommandOutput
endfunction

function! RunBackgroundCommand(command)
  " Make sure we're running VIM version 8 or higher.
  if v:version < 800
    echoerr 'RunBackgroundCommand requires VIM version 8 or higher'
    return
  endif

  if exists('g:backgroundCommandOutput')
    echo 'Already running task in background'
  else
    echo 'Running task in background'
    " Launch the job.
    " Notice that we're only capturing out, and not err here. This is because, for some reason, the callback
    " will not actually get hit if we write err out to the same file. Not sure if I'm doing this wrong or?
    let g:backgroundCommandOutput = tempname()
    call job_start(a:command, {'close_cb': 'BackgroundCommandClose', 'out_io': 'file', 'out_name': g:backgroundCommandOutput})
  endif
endfunction

" So we can use :BackgroundCommand to call our function.
command! -nargs=+ -complete=shellcmd RunBackgroundCommand call RunBackgroundCommand(<q-args>)

" Set code style per repository
function! s:SetCodeStyle()
    let currentPath = fnamemodify(getcwd(), ':h')
    let currentRepo = fnamemodify(getcwd(), ':t')

    " default code style is from atlas
    let def_style = 'set tabstop=4 softtabstop=4 shiftwidth=4 expandtab'
    let stream = ''

    if currentRepo =~ "ipinfusion"
	setlocal sw=2 ts=8 tw=78
	setlocal cinoptions=>2s,e-s,n-s,f0,{s,^-s,:s,=s,g0,+.5s,p2s,t0,(0 cindent
	setlocal fo-=t fo+=croql
	setlocal comments=sO:*\ -,mO:\ \ \ ,exO:*/,s1:/*,mb:\ ,ex:*/
	set cpo-=C
	set expandtab
        echom "STYLE: ipinfusion"
    elseif currentRepo =~ "linux"
        echom "STYLE: linux"
        set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
    else
        echom "STYLE: default"
        execute def_style
    endif

    if currentPath =~ 'main'
        let stream = 'MAIN' 
    elseif currentPath =~ 'broadcom'
        let stream = 'BROADCOMDEV' 
    elseif currentPath =~ 'broadcom'
        let stream = currentPath
    endif

    execute "set title titlestring=[".l:stream."][".l:currentRepo."]-%F"

endfunction

command! -nargs=0 CodeStyle call s:SetCodeStyle(<f-args>)

function! s:SetCscopeIndex()
    let currentPath = fnamemodify('.', ':p')

    if currentPath =~ "bcm"
	" default sdk is 6.5.6
	let sdk = input('BCM SDK: ', '6.5.6/')
	let src_c = " -name '*.c' >> cscope.files"
	let src_h = " -name '*.h' >> cscope.files"

	" build csfiles for a specific sdk only
	execute 'silent !rm cscope.files || true'
	execute 'silent !find atl/'.l:src_c
	execute 'silent !find atl/'.l:src_h
	execute 'silent !find sdk/'.l:sdk.' '.l:src_c
	execute 'silent !find sdk/'.l:sdk.' '.l:src_h
	execute 'silent !find ext_phy/'.l:src_c
	execute 'silent !find ext_phy/'.l:src_h
    endif

    execute "silent !cscope -q -bR -P $(pwd)"
    cs kill -1
    cs add cscope.out
endfunction

command! -nargs=0 CsGen call s:SetCscopeIndex(<f-args>)

function! s:ImportCscope(repo)
    let path_dir = '../'.a:repo
    let path_file = '../'.a:repo.'/cscope.out'
    try
        execute 'cs add '.l:path_file.' '.l:path_dir
    catch
        echom "ERROR: cscope.out not initialised on that repo"
    endtry
endfunction

command! -nargs=1 ImportCscope call s:ImportCscope(<f-args>)
