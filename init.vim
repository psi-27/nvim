" Commons
set number

nmap <leader>f :Vexplore<CR>
nmap <leader><s-f> :edit.<CR>
nmap <leader>fr :Lexplore<CR>
nmap <leader>w <C-W>w

" Let's imagine we are in NERDTree
" @see https://shapeshed.com/vim-netrw/
let g:netrw_banner = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

function s:refreshNetrwExplorer()
	if expand('%') == 'NetrwTreeListing'
		exe winnr() . "wincmd q"
		:Vexplore
	endif
endfunction

function New_file_leader()
	echo expand('%:h')
	let new_file_name = input("New file name: " . expand('%:h') . "/")
	echo "\n"
	echo expand('%:h') . "/" . new_file_name . "\n"
	call system("touch " . expand('%:h') . "/" . new_file_name)
endfunction

nmap <leader>nf :call New_file_leader()<cr>
nmap <leader>rrc :so $MYVIMRC<cr>

augroup Vide
  autocmd!
  autocmd VimEnter * :Vexplore
  autocmd BufEnter * call s:refreshNetrwExplorer()
augroup END

" Plugins
call plug#begin('~/.local/share/nvim/site/plugin')
Plug 'editorconfig/editorconfig-vim'
"Plug 'tpope/vim-sensible'
call plug#end()

