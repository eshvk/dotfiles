""""""""""""""""""""
" Auto Commands
""""""""""""""""""""

function! ColumnsGuidesOn()
    if exists('+colorcolumn')
        highlight ColorColumn ctermbg=17
        setlocal colorcolumn=80,100
    else
        let w:m2=matchadd('WarningMsg', '\%>80v.\+', -1)
        let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
    endif
endfunction

function! ColumnsGuidesOff()
    if exists('+colorcolumn')
        setlocal colorcolumn=""
    else
        let w:m2=clearmatches()
    endif
endfunction

function! AutoCommand()
    " fallback fold method
    if &foldmethod == 'manual' && &filetype != ''
        set foldmethod=indent
    endif

    " specific file types only
    let l:filetypes = [
                \ 'c', 'cpp',
                \ 'groovy', 'java', 'scala', 'clojure',
                \ 'html', 'css', 'javascript', 'mkd', 'rst', 'text',
                \ 'eruby', 'perl', 'php', 'python', 'ruby',
                \ 'haskell',
                \ 'vim', 'sh', 'zsh',
                \ 'proto', 'xml', 'yaml', 'sbt.scala'
                \ ]
    if index(l:filetypes, &filetype) >= 0
        call ColumnsGuidesOn()
        call indent_guides#enable()

        " open all folds
        :execute 'normal zR'
    else
        call ColumnsGuidesOff()
        call indent_guides#disable()
    endif

    if &filetype == 'git'
        " open all folds
        :execute 'normal zR'
    endif

    let l:wide_filetypes = ['java', 'scala']
    if index(l:wide_filetypes, &filetype) >= 0
        set textwidth=98
    endif

    let l:texttypes = ['html', 'mkd', 'rst', 'text']
    if index(l:texttypes, &filetype) >= 0
        setlocal spell
        highlight SpellBad ctermbg=52
    endif
endfunction

autocmd BufRead,BufNewFile * :call AutoCommand()
