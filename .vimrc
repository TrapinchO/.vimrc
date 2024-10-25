" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

syntax on

" set lines on
set number


" remap buttons
"
nnoremap U <C-r>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" https://vi.stackexchange.com/a/16969
inoremap jk <Esc>

" https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/
" the next three things

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=5

" https://stackoverflow.com/questions/3938596/vim-autoindent-not-working
" fix autoindent
set autoindent
set smartindent
" helper for indent mistake
set list listchars=tab:»·,trail:·
