call plug#begin('~/.vim/vim-plug-plugins')
	Plug 'preservim/nerdtree'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'qpkorr/vim-bufkill'
	Plug 'ap/vim-buftabline'
	Plug 'pangloss/vim-javascript'
	Plug 'leafgarland/typescript-vim'
	Plug 'preservim/tagbar'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
 	Plug 'flazz/vim-colorschemes'
	Plug 'Valloric/YouCompleteMe'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'myusuf3/numbers.vim'
	" {{{
		" This is the default extra key bindings
		let g:fzf_action = {
		\ 'ctrl-t': 'tab split',
		\ 'ctrl-x': 'split',
		\ 'ctrl-v': 'vsplit' }

		" Enable per-command history.
		" CTRL-N and CTRL-P will be automatically bound to next-history and
		" previous-history instead of down and up. If you don't like the change,
		" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
		let g:fzf_history_dir = '~/.local/share/fzf-history'

		" :map <C-f> :Files<CR>
		map <leader>b :Buffers<CR>
		nnoremap <leader>g :Rg<CR>
		nnoremap <leader>t :Tags<CR>
		nnoremap <leader>m :Marks<CR>


		let g:fzf_tags_command = 'ctags -R'
		" Border color
		let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

		let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
		let $FZF_DEFAULT_COMMAND="rg --files --hidden"


		" Customize fzf colors to match your color scheme
		let g:fzf_colors =
		\ { 'fg':      ['fg', 'Normal'],
		\ 'bg':      ['bg', 'Normal'],
		\ 'hl':      ['fg', 'Comment'],
		\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
		\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
		\ 'hl+':     ['fg', 'Statement'],
		\ 'info':    ['fg', 'PreProc'],
		\ 'border':  ['fg', 'Ignore'],
		\ 'prompt':  ['fg', 'Conditional'],
		\ 'pointer': ['fg', 'Exception'],
		\ 'marker':  ['fg', 'Keyword'],
		\ 'spinner': ['fg', 'Label'],
		\ 'header':  ['fg', 'Comment'] }

		"Get Files
		command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


		" Get text in files with Rg
		command! -bang -nargs=* Rg
		\ call fzf#vim#grep(
		\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
		\   fzf#vim#with_preview(), <bang>0)

		" Ripgrep advanced
		function! RipgrepFzf(query, fullscreen)
		let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
		let initial_command = printf(command_fmt, shellescape(a:query))
		let reload_command = printf(command_fmt, '{q}')
		let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
		call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
		endfunction

		command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

		" Git grep
		command! -bang -nargs=* GGrep
		\ call fzf#vim#grep(
		\   'git grep --line-number '.shellescape(<q-args>), 0,
		\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
	" }}}
call plug#end()

" Use true color
" https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
" You might have to force true color when using regular vim inside tmux as the
" colorscheme can appear to be grayscale with "termguicolors" option enabled.
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
set termguicolors
colorscheme Monokai

"let c='a'
"while c <= 'z'
"  exec "set <A-".c.">=\e".c
"  exec "imap \e".c." <A-".c.">"
"  let c = nr2char(1+char2nr(c))
"endw

set timeout ttimeoutlen=50
set clipboard=unnamed
" needed by YouCompleteMe
set encoding=utf-8
"colorscheme jellybeans

" move lines with alt j and alt k

nnoremap <A-j> :move .+1<CR>==
nnoremap <A-k> :move .-2<CR>==
inoremap <A-j> <Esc>:move .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :move '>+1<CR>gv=gv
vnoremap <A-k> :move '<-2<CR>gv=gv

" move buffer with ctrl pageup and pagedown
nmap <C-PageUp> :bp<CR>
nmap <C-PageDown> :bn<CR>

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

" Set working directory to the current file
" so NERDTree can open in current file path
" autocmd BufEnter * lcd %:p:h

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
" autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


" Tagbar
nmap <F8> :TagbarToggle<CR>

nmap <C-P> :FZF<CR>

" bufkill
" close a buffer with ctrl+c
map <C-c> :BD<cr>



"set hidden
"nnoremap <C-N> :bnext<CR>
"nnoremap <C-P> :bprev<CR>

"fzf.vim


