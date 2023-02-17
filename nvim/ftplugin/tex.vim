" Only two spaces of indentation for LaTeX files
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

" Decent localleader key
let maplocalleader = "\<space>"

" Key mappings
nnoremap <buffer> <leader>tex :-1r ~/projects/dotfiles/templates/latex.tex<CR>

" Snippets
inoremap <buffer> [[ \begin{
inoremap <buffer> $$ \begin{align*}<CR><Esc>mai<CR>\end{align*}<Esc>`aa
inoremap <buffer> derx \frac{d}{dx}
inoremap <buffer> fr \frac{}<Esc>maa{}<Esc>`ai
inoremap <buffer> nck \begin{pmatrix} N \\ k \end{pmatrix}
inoremap <buffer> lp \left(
inoremap <buffer> rp \right)
