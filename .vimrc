syntax on
set nocompatible
filetype indent on
"set cursorline
set timeoutlen=1000
set ttimeoutlen=0

set cpoptions+=$
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set foldmethod=indent
set foldnestmax=10
"set nofoldenable
set foldlevel=0

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'wookiehangover/jshint.vim'
Plugin 'bling/vim-airline'
Plugin 'Yggdroot/indentLine'
Plugin 'wincent/terminus'
call vundle#end()
filetype plugin indent on

let g:indentLine_char = '.'

let g:airline_powerline_fonts = 1
set laststatus=2
set guifont=Inconsolata\ for\ Powerline:h14
let g:airline_theme = 'solarized'

set background=dark
colorscheme solarized

if !has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
