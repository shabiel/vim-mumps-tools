" David Wicksell ; .vim/m-gdump.vim ; dlw@linux.com
"
" $Source: /home/vpe/RCS/m-gdump.vim,v $
" $Revision: 20100322.1 $
"
" Copyright © 2010 Fourth Watch Software
" Licensed under the terms of the GNU Affero General
" Public License. See attached copy of the License.
"
" Binds Ctl-K to jump to a MUMPS global
" Creates an ex command called :ZWR that will dump a global

function! ZWRCommand()
    command! -nargs=1 ZWR call ZWRArgument(<q-args>)
endfunction

function! ZWRArgument(global)
    let l:global = a:global
    let l:global = system("mumps -r KBAWDUMP '-" . l:global . "'")
    if l:global =~ "%GTM-E-FILENOTFND"
        echohl ErrorMsg
        echo "%GTM-E-FILENOTFND: Put KBAWDUMP.m in your MUMPS search path"
        echohl None
    elseif l:global =~ "command not found"
        echohl ErrorMsg
        echo "mumps: command not found: Install MUMPS on your system"
        echohl None
    else
        echo l:global
    endif
endfunction

function! UnZWRCommand()
    delcommand ZWR 
endfunction

function! GlobalDump()
    nmap <silent> <C-K> "byE:call MGlobal(@b)<CR>
endfunction

function! UnGlobalDump()
    nunmap <C-K>
endfunction

function! MGlobal(global)
    let l:global = a:global
    let l:paren = 0
    for l:char in range(0, len(l:global))
        if strpart(l:global, l:char, 1) == "," && l:paren != 1
            let l:global = strpart(l:global, 0, l:char)
            break
        elseif strpart(l:global, l:char, 1) == "("
            let l:paren = 1 
        elseif strpart(l:global, l:char, 1) == ")"
            if l:paren == 1
                let l:global = strpart(l:global, 0, l:char) . ")"
            else
                let l:global = strpart(l:global, 0, l:char)
            endif
            break
        elseif strpart(l:global, l:char, 1) == "&"
            let l:global = strpart(l:global, 0, l:char) . "&"
            break
        elseif strpart(l:global, l:char, 1) == ":"
            let l:global = strpart(l:global, 0, l:char) . ":"
            break
        endif
    endfor
    let b:global = system("mumps -r KBAWDUMP '-" . l:global . "'")
    if b:global =~ "%GTM-E-FILENOTFND"
        echohl ErrorMsg 
        echo "%GTM-E-FILENOTFND: Put KBAWDUMP.m in your MUMPS search path"
        echohl None
    else
        echo b:global
    endif
endfunction 

" $RCSfile: m-gdump.vim,v $
