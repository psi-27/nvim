" Commons
set nocompatible
set t_Co=256
set number
set ruler
syntax on

" Plugins
call plug#begin('~/.config/nvim/vim-plug-root')
Plug 'preservim/nerdtree'
Plug 'editorconfig/editorconfig-vim'
call plug#end()

" Functions
function New_file_leader()
	echo expand('%:h')
	let new_file_name = input("New file name: " . expand('%:h') . "/")
	echo "\n"
	echo expand('%:h') . "/" . new_file_name . "\n"
	call system("touch " . expand('%:h') . "/" . new_file_name)
endfunction


" Maps
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTree<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap <leader>nf :call New_file_leader()<CR>
nnoremap <leader>rrc :so $MYVIMRC<CR>

augroup Vide
  autocmd!
  autocmd VimEnter * :NERDTree
augroup END

