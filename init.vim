" Commons
set nocompatible
set t_Co=256
set number
set ruler
set autoread
set encoding=utf-8
set fileencoding=utf-8
syntax on

" Plugins
call plug#begin('~/.config/nvim/vim-plug-root')
Plug 'preservim/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'djoshea/vim-autoread'
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

" @see https://github.com/ludovicchabant/vim-gutentags/blob/master/doc/gutentags.txt
let g:gutentags_project_root = ['.tags']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_add_ctrlp_root_markers = 0
set statusline+=%{gutentags#statusline()}

" Functions
function New_file_leader()
	echo expand('%:h')
	let new_file_name = input("New file name: " . expand('%:h') . "/")
	echo "\n"
	echo expand('%:h') . "/" . new_file_name . "\n"
	call system("touch " . expand('%:h') . "/" . new_file_name)
endfunction

function! ToggleSyntax()
"	exists("g:syntax_on") ? syntax off : syntax enable
	if exists("g:syntax_on")
		syntax off
	else
		syntax enable
	endif
	echo "Hightlight" . (exists("g:syntax_on") ? " is on" : " is off")
endfunction


function! AppendComment(comment, ...)
	let leader = a:0 >= 1 ? a:1 : '//'
	let box_char = a:0 >= 2 ? a:2 : '*'
	let width = a:0 >= 3 ? a:3 : strlen(a:comment)
	let boundary = leader . repeat(box_char, width)
	let app = append(line('.')-1, [boundary, leader . ' ' . a:comment, boundary])
	return ''
endfunction

imap <silent> """ <C-R>=AppendComment(input("Comment text: "), '"')<CR> | "Comment append shortcut

function StudyTest()
	call ToggleSyntax()
endfunction

" Maps
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTree<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap <leader>nf :call New_file_leader()<CR>
nnoremap <leader>rrc :so $MYVIMRC<CR>
nnoremap <leader>tm :call StudyTest()<CR>

" Short note StdinReadPre calls only if nvim ran with '-' option
autocmd StdinReadPre * let g:std_in=1

augroup Vide
  autocmd!
  autocmd VimEnter * if argc() == 0 && !exists("g:std_in") | NERDTree | endif
  nmap <silent> ;s :call ToggleSyntax()<CR>
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
