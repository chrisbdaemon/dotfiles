set nocompatible
set number
set encoding=utf-8
 
filetype plugin indent on
syntax enable
 
function! ApplyHighlighting() abort
	highlight NeedsToBeDone guibg=Red ctermbg=Red guifg=White ctermfg=White
	highlight HasBeenDone   guifg=Green ctermfg=Green
	syntax keyword HasBeenDone   DONE done Done
	syntax keyword NeedsToBeDone TODO todo Todo
endfunction

let g:go_fmt_command = "goimports"

autocmd BufRead,BufNewFile * call ApplyHighlighting()

function! GetProjectRoot() abort
	let newpath = '../'
	while !isdirectory(newpath . '.git')
		let newpath = newpath . '../'
	endwhile

	if isdirectory(newpath . '.git')
		return `=newpath`
	endif
endfunction

autocmd Filetype xml setlocal tabstop=2 expandtab shiftwidth=2
autocmd Filetype yaml setlocal tabstop=2 expandtab shiftwidth=2
autocmd Filetype html setlocal tabstop=2 expandtab shiftwidth=2
autocmd FileType python setl sw=4 sts=4 expandtab shiftwidth=4
