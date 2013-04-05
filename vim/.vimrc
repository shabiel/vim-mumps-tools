" Author: Sam Habiel; parts inspired by David Wicksell
" License: AGPL
" Date: 2011 November 5

" Turn on Syntax Highlighting
syntax on

" Turn on syntax highlighting for EWD, mumps
augroup filetypedetect
au! BufRead,BufNewFile *.ewd	setfiletype html
au! BufRead,BufNewFile *.m  setfiletype mumps
au! BufRead,BufNewFile *.ro setfiletype mumps
augroup END
" Sam's specific settings
set ignorecase
set incsearch
set hls
set cc=80  " 80 column line (only in Vim 7.3)
set tabstop=4
set shiftwidth=4
set noexpandtab
set undofile " undo file (only in Vim 7.3)
set suffixesadd=.m
set path=.,p/,r/

au filetype *.txt set textwidth=80
au filetype *.txt set wrapmargin=80

autocmd BufWritePost *.m :!mumps -r \%XCMD 'D CHKROU^XTECROU("^KBAN","%:t:r") ZWRITE ^KBAN KILL ^KBAN'

" Open mumps files (only if filetype is mumps)
" au filetype mumps nmap gf :vsp %:p:h/<cfile><CR>
au filetype mumps noremap gf F^bywf^w<C-W>fgg/^<C-R>"<CR>           
au filetype mumps set suffixesadd=.m                               " Routine names end with .m 
au filetype mumps set includeexpr=substitute(v:fname,'\%','_','g') " Translate % to _
au filetype mumps map G <nop>       " Unmap G as I type it all the time by mistake.
au filetype mumps nmap GG <C-End>   " Instead of G, use GG to jump to the end. Almost the same.
au filetype mumps nmap GF gf        " And map GF to its lower case equivalent
" Remove comma as a valid file name b/c in includes D ^XUP,PSS^DEE as one.
au filetype mumps set isfname=@,48-57,/,.,-,_,+,#,$,%,~,=
au filetype mumps set iskeyword=@,48-57,192-255,#,^$,^_
au filetype mumps colorscheme desert

" Omni complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Make programs
au filetype python setlocal mp=python3\ %

" Smart Indentation
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class  

" Remember where I am in a file when I open it again
set viminfo='100  " for the last 100 files

" Autoindent
set ai

" Incremental search
set incsearch

" Don't highlight results of search
set nohlsearch

" Rule
set ruler

" Ignore case when searching
set ignorecase

set expandtab
set smarttab
set nomodeline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set tags+=~/tags,~/.tags

source ~/.vim/scripts/m-setpath.vim

autocmd BufEnter *.m call SetMumpsRoutinesPath()
set nocompatible

set modelines=0
set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
" set relativenumber
set undofile

let mapleader = ","
set smartcase
set gdefault
nnoremap <leader><space> :noh<cr>

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80


" Map F1 to ESC.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Write when losing focus.
au FocusLost * :wa 

" Leader functions
" Remove trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Ack
nnoremap <leader>a :Ack
" fold HTML tag
nnoremap <leader>ft Vatzf
" Rewrap text
nnoremap <leader>q gqip
" Select text that was just pasted
nnoremap <leader>v V`]
" Open this file quickly
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" Open split window and go to it
nnoremap <leader>w <C-w>v<C-w>l

" Pastie
set paste
set autoindent
