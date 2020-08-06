" show line numbers by default in vim
set number

" making default horizontal slpit to split below 
set splitbelow

"making default vertical splirt to split right
set splitright

"set autoindent an by default
set autoindent

"changing default slpit navigation keyboard shortcuts
nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" UFT-8 support
set encoding=utf-8

" making code look good
let python_highlight_all=1
syntax on

" #############################################################
"               plugin management using vundle
" #############################################################
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
" ...
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" #############################################################
"          end of plugin managemet using vundle
" #############################################################

" making code look good
let python_highlight_all=1

" making nerdtree show hidden files
let NERDTreeShowHidden=1

