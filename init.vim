syntax on
set nocompatible
filetype indent on

set cpoptions+=$
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set foldmethod=indent
set foldnestmax=10
set foldlevel=0
set backspace=2

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'alvan/vim-closetag'
Plug 'Yggdroot/indentline'
Plug 'wincent/terminus'
Plug 'tpope/vim-fugitive'
Plug 'othree/yajs.vim', { 'for': 'javascript'}
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'
Plug 'vim-scripts/oceandeep'
Plug 'vim-scripts/Cthulhian'
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
call plug#end()

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
autocmd BufWritePost,BufEnter * Neomake
autocmd InsertChange,TextChanged * update | Neomake


let g:indentLine_char = '.'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

let g:airline#extensions#brach#empty_message = ''
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#fnamemod = ':t'
set laststatus=2

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_right_sep = ''

function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode',' ','branch'])
  let g:airline_section_b = airline#section#create_left(['%{getcwd()}'])
  let g:airline_section_c = airline#section#create(['%t'])
  let g:airline_section_x = airline#section#create([''])
  let g:airline_section_y = airline#section#create_right([''])
  let g:airline_section_z = airline#section#create_right(['(%l/%c) [%p%%]'])
endfunction
autocmd VimEnter * call AirlineInit()

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

syntax enable
set t_Co=256
colorscheme Cthulhian 
set background=dark


"set guifont=Inconsolata\ for\ Powerline:h14


let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript,jsx setlocal omnifunc=tern#Complete
endif


set tabline=%!MyTabLine()

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T' 

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1 
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label =  bufname(buflist[winnr - 1]) 
  return fnamemodify(label, ":t") 
endfunction
