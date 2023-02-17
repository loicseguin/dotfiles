" knit to html
nnoremap <silent> <buffer> <leader>m :!Rscript -e "knitr::knit('%')" && tectonic %<.tex<CR>

" Snippets
iabbrev <buffer> lgp loi des gaz parfaits

" Document structure
iabbrev <buffer> pb \begin{problem}<CR>\label{p:X}<CR>\end{problem}<CR><Esc>?X<CR>:nohl<CR>xi
iabbrev <buffer> soln \begin{proof}[Solution]X<CR>\end{proof}<CR><Esc>?X<CR>:nohl<CR>xa

" R
iabbrev <buffer> ri \Sexpr{}<Left>
iabbrev <buffer> rsig \Sexpr{signif()}<Esc>?)<CR>:nohl<CR>i
iabbrev <buffer> rsigm \(\Sexpr{signif()}\)<Esc>?)<CR>:nohl<CR>i
iabbrev <buffer> rb <<{echo = FALSE}>>=X<CR>@<Esc>?X<CR>:nohl<CR>xa
iabbrev <buffer> rfig <Esc>:set paste<CR>i<<echo = FALSE, fig.width = 4, fig.height = 3, fig.align = "center", cache = TRUE>>=<Esc>:set nopaste<CR>a<CR>library(ggplot2)X<CR>ggplot(data = df) + <CR>geom_line(mapping = aes(x = x, y = y))<CR>@<Esc>?X<CR>:nohl<CR>xa
