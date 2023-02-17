" neovim config file

" vim-plug package management {{{
"""""""""""""""""""""""""""""
call plug#begin()
Plug 'tpope/vim-fugitive'         " A Git wrapper so awesome it should be illegal
Plug 'scrooloose/nerdcommenter'   " Comment functions so powerful—no comment necessary
Plug 'jamessan/vim-gnupg'         " Transparent editing of gpg encrypted files
Plug 'lervag/vimtex'
Plug 'itchyny/lightline.vim'     " Light and configurable statusline/tabline

" Color schemes
"Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'            " Retro groove color scheme for Vim 
"Plug 'junegunn/seoul256.vim'      " Low-contrast color scheme based on Seoul Colors
"Plug 'joshdick/onedark.vim'
call plug#end()
" }}}

" General options {{{
"""""""""""""""""
set autowrite           " Write file automatically upon some actions (see help)
set autoread            " Reread file automatically if modified on disk
set gdefault            " Replace globally by default (i.e., g at the end of substitutions
set undofile
" }}}
"
" Vim UI {{{
""""""""
"let g:seoul256_background = 235
"colorscheme seoul256
let g:lightline = {'colorscheme': 'seoul256'}
let g:gruvbox_italic=1
colorscheme gruvbox
set relativenumber      " Show relative line numbers
set number              " Show line number of current line
"set list               " Show hidden characters
set listchars=tab:▸\ ,eol:¬,trail:⋅,nbsp:␣
" }}}

" Formatting {{{
""""""""""""
set tabstop=4           " Use four spaces for tabs
set shiftwidth=4
set softtabstop=4
set expandtab           " Spaces, not tabs
set textwidth=79        " Wrap lines after 79 characters
" }}}
 
" Key mappings {{{
""""""""""""""
let mapleader="\<space>"       " Use space instead of \ for leader

" Move between screen lines, not real lines
nnoremap <silent> j gj
nnoremap <silent> k gk

" Backtick to move to mark unusable on non english keyboard
nnoremap <silent> <tab> `

" Toggle search highlighting
nnoremap <silent> <leader>hs :set invhlsearch<CR>

" Switch to previous buffer
nnoremap <leader>b :b#<CR>

" Quickly edit/reload vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" Delete all trailing spaces in a file.
nnoremap <silent> <leader>ts :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Fugitive plugin keymaps
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
" }}}

" GnuPG Extensions{{{
let g:GPGExecutable="gpg"
let g:GPGPreferArmor=1    " armor new files.
let g:GPGPreferSign=1     " sign new files.

augroup GnuPGExtra
    " Set extra file options.
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
    " Automatically close unmodified files after inactivity.
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function! SetGPGOptions()
    set updatetime=60000  " Set updatetime to 1 minute.
    set foldmethod=marker " Fold at markers.
    set foldclose=all     " Automatically close all folds.
    set foldopen=insert   " Only open folds with insert commands.
endfunction
" }}}
