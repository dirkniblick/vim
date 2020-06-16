set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on syntax highlighting.
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

set textwidth=80
set formatoptions=croqj


" Setup spaces for indenting
set expandtab shiftwidth=2 shiftround tabstop=2

" Expand searching ability
set hlsearch incsearch ignorecase smartcase

set noerrorbells visualbell
set scrolloff=4 sidescrolloff=4
set laststatus=2
set showmode

set backspace=indent,eol,start
set matchpairs+=<:>

set foldmethod=syntax
set foldcolumn=2


set ruler
set statusline=%<%f\ [%n]%h%w%m%r%=%-14.(%l,%c%V%)\ %P

set autoread
autocmd FocusGained,BufEnter * checktime

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf



" Create directory for backup files
if !isdirectory($HOME . "\\.vimfiles")
  call mkdir($HOME . "\\.vimfiles", "p")
endif

" Enable backups
set directory=$HOME\\.vimfiles
set backup writebackup backupdir=$HOME\\.vimfiles
set undodir=$HOME\\.vimfiles
set viewdir=$HOME\\.vimfiles

" Toggle paste mode with F2
nnoremap <F2> :set invnumber number?<CR>
imap <F2> <C-O>:set invnumber number?<CR>

" Toggle paste mode with F3
nnoremap <F3> :set invpaste paste?<CR>
imap <F3> <C-O>:set invpaste paste?<CR>
"set pastetoggle=<F3>

" Toggle paste mode with F4
nnoremap <F4> :set invspell spell?<CR>
imap <F4> <C-O>:set invspell spell?<CR>

" Ctrl Space for auto complete
inoremap <C-Space> <C-x><C-i>

" Search visually selected text using // or ??
vnoremap // y/<C-R>0<CR>
vnoremap ?? y?<C-R>0<CR>

" Tweaking how the Explorer works
let g:netrw_banner=0
let g:netrw_liststyle=3

" Shortcuts for accesing Explorer
nnoremap - :Explore<CR>
nnoremap _ :Vexplore!<CR>


if has("clipboard")
  " CTRL-C and CTRL-Insert are Copy
  vnoremap <C-C> "+y
  vnoremap <C-Insert> "+y
endif

if has("mouse")
  set mouse=a
endif

" Additional configs for Windows
if has("gui_running")
  try
    set t_Co=256
    colorscheme moonlight
  catch
    colorscheme torte
  endtry

  highlight Folded guibg=gray4 guifg=gray38
  highlight FoldColumn guibg=gray4 guifg=gray38

  set guioptions-=T

  set guifont=Courier_New:h10:cANSI

  " Allow for copying from windows
  vnoremap <C-C> "+y

  " Automatically save and load folds
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent loadview
endif

