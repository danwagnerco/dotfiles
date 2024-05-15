" vim 8.2 install on dwco02
" create -> C:\Users\dan\vimfiles\autoload because autoload is not there to start
" cd C:\Users\dan\vimfiles\autoload
" curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --output plug.vim
" curl https://raw.githubusercontent.com/danwagnerco/dotfiles/master/_vimrc --output _vimrc
" download https://github.com/runsisi/consolas-font-for-powerline/blob/master/Powerline%20Consolas.ttf
" (just download the file to desktop double-click install then delete)
" vim _vimrc then :PlugInstall
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" Plug
call plug#begin()
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sensible'
Plug 'danwagnerco/tomorrow-theme', {'rtp': 'vim'}
Plug 'zenorocha/dracula-theme', {'rtp': 'vim'}
Plug 'tomasr/molokai'
call plug#end()

" Use colorscheme from package above
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
set backupdir=c:\tmp  " Do not clutter directory with swap
set directory=c:\tmp  " and temp files
set noundofile        " as well as undo files
set noerrorbells visualbell t_vb=
let g:netrw_liststyle=3
" set colorcolumn=80
set guifont=Powerline\ Consolas:h10
set encoding=utf-8
let g:airline_powerline_fonts=1

" ConEmu conflict with Vim check out
" Github issue https://github.com/Maximus5/ConEmu/issues/641
inoremap <Char-0x07F> <BS>
nnoremap <Char-0x07F> <BS>

" Specify .md files as markdown
au BufRead,BufNewFile *.md setlocal ft=markdown

" Configure tabstop softtabstop and expand or not by filetype
if has("autocmd")
  filetype on

  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType elm setlocal ts=4 sts=4 sw=4 expandtab

  " These highlight lines that extend past 80 chars
  " autocmd BufEnter * highlight OverLength ctermbg=red guibg=#592929
  " autocmd BufEnter * match OverLength /\%>80v.\+/

  " Turn off bells
  autocmd GUIEnter * set visualbell t_vb=

endif

" Leader customization
let mapleader=" "
map <Leader>ptt :Dispatch py.test %<cr>
map <Leader>pta :Dispatch py.test<cr>
map <Leader>rss :Dispatch bundle exec rspec %<cr>
map <Leader>rsa :Dispatch bundle exec rspec ./spec<cr>
map <Leader>c :ccl<cr>
" map <Leader>gs :Gstatus<cr> old vim-fugitive, updated to simply :Git
map <Leader>gs :Git<cr>
" map <Leader>gc :Gcommit<cr> old vim-fugitive, updated to :Git commit
map <Leader>gc :Git commit<cr>
