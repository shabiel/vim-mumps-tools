" Author: Sam Habiel; parts inspired by David Wicksell
" License: AGPL

" Turn on Syntax Highlighting
syntax on

" Turn on syntax highlighting for EWD, mumps
augroup filetypedetect
au! BufRead,BufNewFile *.ewd	setfiletype html
au! BufRead,BufNewFile *.m  setfiletype mumps
au! BufRead,BufNewFile *.ro setfiletype mumps
augroup END

" Mumps Goto File. Doesn't work!!!
function! MumpsGF()
 let l:file = tr(expand("<cfile>"),"%","_")
 execute "set suffixesadd=.m"
 execute "new %:p:h/".l:file
endfunction

" Open mumps files (only if filetype is mumps)
au filetype mumps nmap gf :vsp %:p:h/<cfile><CR>
au filetype mumps noremap gf F^bywf^w<C-W>fgg/^<C-R>"<CR>
au filetype mumps set suffixesadd=.m

" Remove comma as a valid file name b/c in includes D ^XUP,PSS^DEE as one.
set isfname=@,48-57,/,.,-,_,+,#,$,%,~,=

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

source ~/.vim/scripts/m-ctags.vim
source ~/.vim/scripts/m-gdump.vim
source ~/.vim/scripts/m-datetime.vim
source ~/.vim/scripts/m-setpath.vim

autocmd BufEnter *.m call MapTags()
autocmd BufEnter *.m call GlobalDump()
autocmd BufEnter *.m call ZWRCommand()
autocmd BufEnter *.m call SetMumpsRoutinesPath()
autocmd BufLeave *.m call UnmapTags()
autocmd BufLeave *.m call UnGlobalDump()
autocmd BufLeave *.m call UnZWRCommand()
autocmd BufWrite *.m call DateTime()
