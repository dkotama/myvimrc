language C

set nocompatible
set whichwrap=b,s,h,l,<,>,[,],~

" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin

colors desert
set guifont=Consolas:h10

syntax on
filetype plugin indent on

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
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set smarttab
set wrapscan

set showmatch

set backspace=indent,eol,start
set directory=~/vim/swap
set backupdir=~/vim/backup

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp-2,euc-jisx0213,euc-jp,cp932
set fileformat=unix
" set fileformats=unix,doc,mac

set iminsert=0
set imsearch=0

set title
set number
set ruler
set list
set listchars=tab:>-,extends:>,precedes:<
set cmdheight=2
set showcmd
set scrolloff=5
set laststatus=2

set ignorecase
set smartcase
set incsearch
set wrap

set browsedir=buffer
set foldmethod=marker

nnoremap j gj
nnoremap k gk

nnoremap 1     :tabprevious<CR>
nnoremap 2     :tabnext<CR>
nnoremap <C-t> :tab new<CR>
nnoremap <C-w> :tab close<CR>

" map control-backspace to delete the previous word
:imap <C-BS> <C-W>

"omni mapping
function InsertTabWrapper()
  if pumvisible()
    return "\<c-n>"
  endif
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k\|<\|/'
    return "\<tab>"
  elseif exists('&omnifunc') && &omnifunc == ''
    return "\<c-n>"
  else
    return "\<c-n>"
    "return "\<c-x>\<c-o>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
