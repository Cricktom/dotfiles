function! s:insert_copyright()
  execute "normal! i// Copyright 2018"
  execute "normal! o//"
  execute "normal! o// Author: Nitendra Tomar (nitintomar332@gmail.com)"
  execute "normal! o"
  normal! kk
endfunc
autocmd BufNewFile *.{cc,proto,go,sh} call <SID>insert_copyright()

" Color Scheme. atom-dark-256: ~/.vim/colors/
colorscheme atom-dark-256

" Tab switching
nnoremap<C-Left> :tabprevious<CR>
nnoremap<C-Right> :tabnext<CR>

" Pathogen to install plugins in vim
execute pathogen#infect()
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

" auto load NerdTree
autocmd vimenter * NERDTree

" Auto indent using Ctrl+K
map <C-K> :pset autoindent smartindent      " auto/smart indentyf /home/cricktom/workspace/main/experimental/nitin/config/clang-format.py<cr>
map <C-K> <c-o>:pyf /home/cricktom/workspace/main/experimental/nitin/config/clang-format.py<cr>

