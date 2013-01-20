""""""""""""""""""""
" Bundles settings
""""""""""""""""""""

" Solarized color scheme
let g:solarized_termcolors = 256
let g:solarized_termtrans = 1
colorscheme solarized

" Powerline
set laststatus=2
let g:Powerline_symbols = 'fancy'

" DetectIndent
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
function! DetectIndentOverride()
    :DetectIndent
    if &shiftwidth < 2
        set shiftwidth=2
    endif
endfunction
autocmd BufReadPost * :call DetectIndentOverride()

" Ident guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
if !has('gui_running')
    " really dark grey non-intrusive colors
    let g:indent_guides_auto_colors = 0
    autocmd VimEnter,Colorscheme * :highlight IndentGuidesOdd  ctermbg=234
    autocmd VimEnter,Colorscheme * :highlight IndentGuidesEven ctermbg=236
endif

" NERDTree
let g:NERDTreeWinSize = 30

" Tagbar
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_sort = 0

" Command-T
let g:CommandTMatchWindowAtTop = 1

" NERDCommenter
let g:NERDSpaceDelims = 1

" OmniCompletion
set omnifunc=syntaxcomplete#Complete
" OmniCompletion with SuperTab
let g:SuperTabDefaultCompletionType = '<C-X><C-O>'
" Close pop up window after leaving insert mode
autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['java', 'scala'] }