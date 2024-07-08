function! s:insert_copyright()
  execute "normal! i// Copyright 2024"
  execute "normal! o//"
  execute "normal! o// Author: Nitendra Tomar (nitendra.tomar@cohesity.com)"
  execute "normal! o"
  normal! kk
endfunc
autocmd BufNewFile *.{cc,proto,go,sh} call <SID>insert_copyright()

" Tab switching
nnoremap<C-x> :tabprevious<CR>
nnoremap<C-z> :tabnext<CR>

set nocompatible " be iMproved, required
filetype off     " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'preservim/nerdtree'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'flazz/vim-colorschemes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'preservim/nerdcommenter'
Plugin 'valloric/youcompleteme'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" All of your Plugins must be added before the following line
call vundle#end()            " required

colorscheme znake
syntax enable
filetype plugin indent on

set tabstop=2 shiftwidth=2 expandtab
set mouse=a                 " enable scrolling
set number                  " enable line numbering
set hlsearch                " highlight search
set ignorecase smartcase    " make searches case-insensitive, unless they
                            "   contain upper-case letters
set t_Co=256                " 256 colors terminal
set showmode                " Show the current mode.
set showmatch               " show matching parenthesis
set title                   " Show the filename in the window title bar.
set cursorline              " Highlight current line
set textwidth=79
set foldenable              " enable folding
set foldlevel=50   " open most folds by default
set foldnestmax=10          " 10 nested fold max
nnoremap <space> za         " space open/closes folds
set foldmethod=indent        " fold based on indent level
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Fuzzy file finder
set runtimepath^=~/.vim/bundle/ctrlp"

" open file in a new tab by fuzzy search
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': [],
    \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
    \ }

let g:ycm_enable_diagnostic_highlighting = 0

let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

"let g:ycm_auto_hover = 'CursorHold'

nnoremap <C-m> :NERDTree<CR>

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Auto indent using Ctrl+K
map <C-K> :py3f ~/.vim/clang-format.py<cr>
map <C-K> <c-o>:py3f ~/.vim/clang-format.py<cr>
