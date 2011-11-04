" Sam Habiel - Sam tries to set Mumps path
" Holy Crap! It works!
" Licensed under WTF license. (http://sam.zoy.org/wtfpl/)

function! SetMumpsRoutinesPath()
 let l:path = tr($gtmroutines,"() ",",,,")  " Decompose $gtmroutines into a bunch of csv's
 " Set path to $gtmroutines, then to the local directory.
 execute "set path=".l:path
 execute "set path+=".",."
endfunction
