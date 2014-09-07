" Only two spaces of indentation for LaTeX files
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Decent localleader key
let maplocalleader = ","

" Key mappings
imap <buffer> [[ \begin{
imap <buffer> ]] <Plug>LatexCloseCurEnv
nmap <buffer> <F5> <Plug>LatexChangeEnv
vmap <buffer> <F7> <Plug>LatexWrapSelection
vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection

" LaTeX-Box configuration
let g:LatexBox_latexmk_options = '-pvc'
if has('mac')
    let g:LatexBox_viewer = 'open -a Skim'
    " View current line in pdf viewer Skim.
    noremap <silent> <leader>ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline 
      \ <c-r>=line('.')<cr> "<c-r>=LatexBox_GetOutputFile()<cr>" "%:p" <cr>
endif

