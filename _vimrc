" Jake's VIM Config
" 2026-10-25

set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on syntax highlighting.
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

set textwidth=80
set formatoptions=cjoqr
" Vim default for formatoptions is tcq
" c Auto-wrap comments
" j Remove comment leader with joining lines
" o Automatically insert the current comment leader after o/O
" q Allow formatting of comments with gq
" r Automatically insert the current comment leader after <Enter>
" t Auto-wrap text using textwidth

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
set statusline=%n%(\ %M%)\ %(%h%w\ %)%<%f%=\ %y%r\ \ %-5.(%l/%L,%c%V%)\ \ %P
" n Buffer number
" M Modified flag: ,+ or ,-
" h Help buffer flag: [Help]
" w Preview window flag: [Preview]
" f Path to the file in the buffer
" Y Type of file in the buffer
" R Readonly flag: ,RO
" l Line number
" L Number of lines in buffer
" c Column number
" V Virtual column number: -{num}
" P Percentage through file of displayed window

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

" F2 - Toggle line numbers
nnoremap <F2> :set invnumber number?<CR>
xnoremap <F2> <C-O>:set invnumber number?<CR>
imap <F2> <C-O>:set invnumber number?<CR>

" F3 - Toggle paste mode
nnoremap <F3> :set invpaste paste?<CR>
imap <F3> <C-O>:set invpaste paste?<CR>

" F4 - Toggle spell check
nnoremap <F4> :set invspell spell?<CR>
xnoremap <F4> <C-O>:set invspell spell?<CR>
imap <F4> <C-O>:set invspell spell?<CR>

" F5 - Toggle vertical line motion between regular and display
let g:display_motion_enabled = 0
function! DisplayMotionToggle()
  let g:display_motion_enabled = !g:display_motion_enabled
  if g:display_motion_enabled
    echo "Motion: Display"
  else
    echo "Motion: Standard"
  endif
endfunction
nnoremap <silent> <F5> :call DisplayMotionToggle()<CR>
xnoremap <silent> <F5> :<C-u>call DisplayMotionToggle()<CR>

nnoremap <expr> j (g:display_motion_enabled ? 'gj' : 'j')
xnoremap <expr> j (g:display_motion_enabled ? 'gj' : 'j')
nnoremap <expr> k (g:display_motion_enabled ? 'gk' : 'k')
xnoremap <expr> k (g:display_motion_enabled ? 'gk' : 'k')
nnoremap <expr> gj (g:display_motion_enabled ? 'j' : 'gj')
xnoremap <expr> gj (g:display_motion_enabled ? 'j' : 'gj')
nnoremap <expr> gk (g:display_motion_enabled ? 'k' : 'gk')
xnoremap <expr> gk (g:display_motion_enabled ? 'k' : 'gk')

" Ctrl-Backspace - delete word
noremap! <C-BS> <C-W>

" Ctrl-Space - for auto complete
inoremap <C-Space> <C-X><C-I>

" // or ?? - Search visually selected text
vnoremap // y/<C-R>0<CR>
vnoremap ?? y?<C-R>0<CR>

" Ctrl-L - Adds removal of any search highlighting when redrawing the screen
noremap <silent> <C-l> :nohl<CR><C-l>

" Tweaking how the Explorer works
let g:netrw_banner=0
let g:netrw_liststyle=3

" Shortcuts for accesing Explorer
nnoremap - :Explore<CR>
nnoremap _ :Vexplore!<CR>

if has("mouse")
  set mouse=a
endif

" Additional configs for Windows
if has("gui_running") || has("win32") || has("win64")
  try
    set t_Co=256
    colorscheme moonlight
  catch
    colorscheme torte
  endtry

  highlight Folded guibg=gray4 guifg=gray38
  highlight FoldColumn guibg=gray4 guifg=gray38
  highlight Cursor guibg=dimgray guifg=white

  set guioptions-=T
  set guioptions-=t

  set guifont=Courier_New:h10:cANSI

  " Automatically save and load folds
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent loadview

  " Tweak clipboard shortcuts
  if has("clipboard")
    " Alt-X is cut
    vnoremap <M-x> "+x
    " Alt-C is copy
    vnoremap <M-c> "+y
    " Alt-V is paste
    nnoremap <M-v> "+p
    vnoremap <M-v> "+gP
    cnoremap <M-v> <C-R>+
    inoremap <M-v> <C-R>+
  endif
endif

" Alt-Shift-Left, Alt-Shift-Right - Shifting indents
nnoremap <M-S-Left> <<
inoremap <M-S-Left> <C-D>
vnoremap <M-S-Left> <gv
nnoremap <M-S-Right> >>
inoremap <M-S-Right> <C-T>
vnoremap <M-S-Right> >gv

" Customization for Markdown files
autocmd FileType markdown setlocal comments=n:*,n:-,n:+,n:> formatoptions=lnqr shiftwidth=4 tabstop=4

" Add python-capable tools
if executable('python')
  " PPJson (command) - Reformat the text as pretty JSON
  command PPJson %!python -m json.tool
endif
