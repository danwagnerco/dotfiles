set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Tasty treats
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-ruby/vim-ruby'

" Color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on

" Use colorscheme from above
colorscheme Tomorrow-Night-Bright

" Settings
syntax on
set relativenumber
set number
set smarttab
set splitbelow
set splitright
set clipboard=unnamed
set laststatus=2
set scrolloff=5
" set textwidth=80
" set colorcolumn=+1
let g:netrw_liststyle=3

" Airline-specific jams
" set guifont=Menlo\ Regular:h12
" set encoding=utf-8
" let g:airline_powerline_fonts=1

" Configure tabstop softtabstop and expand or not by filetype
if has("autocmd")
  filetype on

  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab

endif

" Force Vim to read md files as markdown, not modula2
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Leader customization
let mapleader=" "
map <Leader>ptt :Dispatch py.test %<cr>
map <Leader>pta :Dispatch py.test<cr>
map <Leader>rss :Dispatch bundle exec rspec %<cr>
map <Leader>rsa :Dispatch bundle exec rspec ./spec<cr>
map <Leader>c :ccl<cr>
map <Leader>gs :Gstatus<cr>
map <Leader>gc :Gcommit<cr>

