" Do not use conceal to replace with unicode and hide characters
let g:pandoc#syntax#conceal#use=0

" knit to html
nnoremap <silent> <buffer> <leader>m :!Rscript -e "rmarkdown::render('%')"<CR>

" Snippets
iabbrev <buffer> pb **Problème X**<CR>\<CR><Esc>?X<CR>:nohl<CR>xi
iabbrev <buffer> $$ $$<CR>\begin{aligned}X<CR>\end{aligned}<CR>$$<Esc>?X<CR>:nohl<CR>xa
iabbrev <buffer> ri `r`<Left>
iabbrev <buffer> rsig `r signif()`<Esc>?)<CR>:nohl<CR>i
iabbrev <buffer> rsigm $`r signif()`$<Esc>?)<CR>:nohl<CR>i
iabbrev <buffer> rb ```{r echo = FALSE}<CR>X<CR>```<Esc>?X<CR>:nohl<CR>xa
iabbrev <buffer> rfig <Esc>:set paste<CR>i```{r echo = FALSE, fig.width = 4, fig.height = 3, fig.align = "center", cache = TRUE, results = "asis"}<Esc>:set nopaste<CR>a<CR>library(ggplot2)<CR>X<CR>ggplot(data = df) + <CR>geom_line(mapping = aes(x = x, y = y))<CR>```<Esc>?X<CR>:nohl<CR>xa
iabbrev <buffer> derx \frac{d}{dx}
iabbrev <buffer> f \frac{X}{}<Esc>?X<CR>:nohl<CR>xi
iabbrev <buffer> choose \begin{pmatrix} N \\ k \end{pmatrix}
