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

" LaTeX-Box configuration
let g:LatexBox_latexmk_async=1                " Run compilation in background
let g:LatexBox_latexmk_preview_continuously=1 " Recompile when changes are saved
if has('mac')
    let g:LatexBox_viewer = 'open -a Skim'
    " View current line in pdf viewer Skim.
    noremap <silent> <leader>ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline 
      \ <c-r>=line('.')<cr> "<c-r>=LatexBox_GetOutputFile()<cr>" "%:p" <cr>
endif

