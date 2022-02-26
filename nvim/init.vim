let g:netrw_nogx = 1 " disable netrw's gx mapping.

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
