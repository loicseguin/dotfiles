" Proper filetype for LaTeX
let g:tex_flavor = "latex"
let g:LatexBox_quickfix = 4

" Only two spaces of indentation for LaTeX files
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

" Decent localleader key
let maplocalleader = ","

" Key mappings
inoremap <buffer> [[ \begin{
inoremap <buffer> ]] <Plug>LatexCloseCurEnv
nnoremap <buffer> <F5> <Plug>LatexChangeEnv
vnoremap <buffer> <F7> <Plug>LatexWrapSelection
vnoremap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
nnoremap <buffer> <silent> <leader>m :!pdflatex -shell-escape %<CR>
nnoremap <buffer> <leader>tex :-1r ~/code/dotfiles/templates/latex.tex<CR>

" LaTeX-Box configuration
"let g:LatexBox_latexmk_async=1                " Run compilation in background
"let g:LatexBox_latexmk_preview_continuously=1 " Recompile when changes are saved
if has('mac')
    let g:LatexBox_viewer = 'open -a Skim'
    " View current line in pdf viewer Skim.
    noremap <silent> <leader>ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline 
      \ <c-r>=line('.')<cr> "<c-r>=LatexBox_GetOutputFile()<cr>" "%:p" <cr>
endif

" Snippets
iabbrev <buffer> $$ \[<CR>\begin{align*}X<CR>\end{align*}<CR>\]<Esc>?X<CR>:nohl<CR>xa
iabbrev <buffer> derx \frac{d}{dx}
iabbrev <buffer> fr \frac{X}{}<Esc>?X<CR>:nohl<CR>xi
iabbrev <buffer> nck \begin{pmatrix} N \\ k \end{pmatrix}
iabbrev <buffer> lp \left(
iabbrev <buffer> rp \right)
