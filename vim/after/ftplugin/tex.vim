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
imap <buffer> [[ \begin{
imap <buffer> ]] <Plug>LatexCloseCurEnv
nmap <buffer> <F5> <Plug>LatexChangeEnv
vmap <buffer> <F7> <Plug>LatexWrapSelection
vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection

" LaTeX-Box configuration
let g:LatexBox_latexmk_async=1                " Run compilation in background
let g:LatexBox_latexmk_preview_continuously=1 " Recompile when changes are saved
if has('mac')
    let g:LatexBox_viewer = 'open -a Skim'
    " View current line in pdf viewer Skim.
    noremap <silent> <leader>ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline 
      \ <c-r>=line('.')<cr> "<c-r>=LatexBox_GetOutputFile()<cr>" "%:p" <cr>
endif

