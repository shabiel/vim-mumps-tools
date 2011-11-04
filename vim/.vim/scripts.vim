" for working with GT.M or other MUMPS
" save this file as your ~/.vim/scripts.vim
" or if you have one already, insert these commands
" -- Jim Self <jaself@ucdavis.edu> June 2, 2001

if did_filetype()	" filetype already set..
  finish		" ..don't do these checks
endif
if getline(1) =~ '^%\=\w\+\s\+;'  "first line - label and comment
  setfiletype mumps
elseif getline(1) =~ '^;'  "just a comment
  setfiletype mumps
endif
