" Add more places to look
set runtimepath+=~/.vim

" Source some other macros
source $VIMRUNTIME/macros/matchit.vim

" Change the colors
colorscheme elflord

" Keep the cursor 10 lines away from the top and bottom
set scrolloff=10

" Add mouse support
set mouse=a

" Improve searching
set ignorecase smartcase incsearch

" Set tabs to 2 spaces
set expandtab tabstop=2 shiftwidth=2

" Enable plugins
filetype on
filetype plugin on
filetype indent on

" Tweak autocomplete plugin
let g:acp_behaviorPerlOmniLength=0
let g:acp_behaviorKeywordLength=2

" Alt-E will shift matched brackets/parens to the right
set <M-e>=^[e
" Alt-P will toggle AutoMatch
set <M-p>=^[p

" Toggle paste mode with F3
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode

" Shows an extra line of status at the bottom of the screen
set laststatus=2

" Search visually selected text using // or ??
vnoremap // y/<C-R>0<CR>
vnoremap ?? y?<C-R>0<CR>

" Tweaking how the Explorer works
let g:netrw_banner=0
let g:netrw_liststyle=3

" Shortcuts for accessing the Explore in the current window (use -) or a
" new one (_)
nnoremap - :Explore<CR>
nnoremap _ :Vexplore!<CR>

" Open the Explorer if vim is not given a file or standard input stream
let wmuse_nt = 0
autocmd StdinReadPost * let wmuse_nt = 1
autocmd VimEnter * if !argc() && wmuse_nt == 0 | Explore | endif
autocmd FileType netrw setl bufhidden=delete

" Adds removal of any search highlighting when redrawing the screen
noremap <silent> <C-l> :nohl<CR><C-l>
