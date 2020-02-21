" The base directory for neovim config is
"     :echo stdpath('config')
"
" The base directory for neovim data is
"     :echo stdpath('data')
"
" vim-plug package management {{{
call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'jamessan/vim-gnupg'
Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
call plug#end()
" }}}

" General options {{{
"""""""""""""""""
set hidden                      " Hide file instead of closing it
set autoread                    " Reread file automatically if modified outside of Vim
set autowrite                   " Write file automatically upon some actions (see help)
set history=1000                " Longer history
set encoding=utf-8              " Default encoding
set visualbell t_vb=            " Disable the bell
set splitbelow                  " New vertical split below current windows
set splitright                  " New horizontal split right of current windows
" }}}

" Vim UI {{{
""""""""
set showmatch                   " Highlight matching parentheses
set number                      " Show line numbers

" Colors
let g:lightline = {'colorscheme': 'one'}
colorscheme onedark

" Font for Mac, Windows and Linux
set guifont=Consolas:h11

" Show hidden characters
set listchars=tab:▸\ ,eol:¬,trail:⋅,nbsp:␣

" }}}

" Persistent undo {{{
"""""""""""""""""
if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
endif
" }}}

" Backups {{{
"""""""""
set backup
" }}}

" Formatting {{{
""""""""""""
set nowrap         " Do not wrap long lines
set autoindent     " Indent at the same level of the previous line
set tabstop=4      " Use four spaces for tabs
set shiftwidth=4
set softtabstop=4
set expandtab      " Spaces, not tabs
set textwidth=79   " Wrap lines after 79 characters
" }}}

" Key mappings {{{
""""""""""""""
let mapleader=","  " Use comma instead of \ for leader

" Save
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Better navigation between split windows
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

" To normal mode with jk
inoremap jk <Esc>

" One less keystroke to enter commands
nnoremap ; :

" Yank to end of line with Y
nnoremap Y y$

" Move between screen lines, not real lines
nnoremap j gj
nnoremap k gk

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Close/open folds with space
nnoremap <space> za

" Move between matching brackets with tab in normal mode
nnoremap <tab> <s-%>

" Toggle search highlighting
nnoremap <silent> <leader>hs :set invhlsearch<CR>

" Upper/lowercase a word
nnoremap <leader>u mQviwU`Q
nnoremap <leader>l mQviwu`Q

" Switch to previous buffer
nnoremap <leader>b :b#<CR>

" Quickly edit/reload vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" Spell checking (word checking)
nnoremap <leader>st :set spell!<CR>
nnoremap <leader>sf :set spelllang=fr<CR>
nnoremap <leader>se :set spelllang=en<CR>

" Toggle numbering and fold column on and off.
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" Delete all trailing spaces in a file.
nnoremap <silent> <F3> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Fugitive plugin keymaps
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>

" Toggle NERDTree
noremap <leader>n :NERDTreeToggle<CR>

" Go to tag for non US keyboard is broken. Use leader + t instead.
nnoremap <leader>t <C-]>

" Esc to normal mode in terminal
tnoremap <Esc> <C-\><C-n>

" Create new terminal as horizontal split
nnoremap <F1> :split<CR> :terminal<CR> :resize 15<CR>i

" }}}

" GnuPG Extensions{{{

" Use gpg
let g:GPGExecutable="gpg"

" Tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1

" Tell the GnuPG plugin to sign new files.
let g:GPGPreferSign=1

augroup GnuPGExtra
" Set extra file options.
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
" Automatically close unmodified files after inactivity.
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function! SetGPGOptions()
" Set updatetime to 1 minute.
    set updatetime=60000
" Fold at markers.
    set foldmethod=marker
" Automatically close all folds.
    set foldclose=all
" Only open folds with insert commands.
    set foldopen=insert
endfunction
" }}}

" NERDTree {{{

let NERDTreeIgnore=['\.pyc$', '__pycache__$[[dir]]']
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"}}}

" Send to terminal {{{
"set shell=powershell
augroup Terminal
    au!
    au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
augroup END

function! REPLSend(lines)
    call jobsend(g:last_terminal_job_id, add(a:lines, ''))
endfunction

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

command! REPLSendLine call REPLSend([getline('.')])
command! REPLSendSelection call REPLSend(split(s:get_visual_selection(), "\n"))

nnoremap <silent> <S-Enter> :REPLSendLine<CR>+
inoremap <silent> <S-Enter> <Esc>:REPLSendLine<CR>o
vnoremap <silent> <S-Enter> :<C-u>REPLSendSelection<CR>
" }}}
