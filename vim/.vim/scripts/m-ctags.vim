" David Wicksell ; .vim/m-ctags.vim ; dlw@linux.com
"
" $Source: /home/vpe/RCS/m-ctags.vim,v $
" $Revision: 20100111.3 $
"
" Copyright © 2010 Fourth Watch Software
" Licensed under the terms of the GNU Affero General
" Public License. See attached copy of the License.
"
" Binds Ctl-] to jump to a MUMPS tag
" Works with local tags as well
"
" Examples:
"   D INIT - Will work as expected
"
"   D EN^XUP - You must be on the tag name to jump
"       to EN or if you are on the ^ you will jump
"       to the first line of XUP
"
"   D ^XUP - You must be on the ^ to work, will
"       jump to the first line of XUP
"
"   D %DTC^RGUT - You must be on the % to work
"
"   G %A - You must be on the % to work
"   
"   G A - Will work as expected
"
"   D DT^DICRW:'$D(DUZ)#2!'$D(DTIME),EN^XQH -
"       Works for either DT^DICRW on the DT or ^ and
"       for EN^XQH on the EN or ^, respectively
"
"   W $$%A^RGUT - You must be on the % or one of
"       the $ to work
"
"   W $$EN^XUP,$$%A^RGUT - EN^XUP will work on the EN
"       or one of the $, and %A^RGUT will work as long
"       as you are on the % or one of the $

function! MapTags()
    if &virtualedit =~ "onemore"
        let s:onemore = 1
    else
        let s:onemore = 0
        set virtualedit+=onemore
    endif
    nmap <silent> <C-]> lb"ayE:call MTag(@a)<CR>
endfunction

function! UnmapTags()
    if s:onemore == 0
        set virtualedit-=onemore
    endif
    nunmap <C-]>
endfunction

function! MTag(atag)
    let l:atag = a:atag
    while 1
        if l:atag == ""
            break
        elseif strpart(l:atag, 0, 1) =~ "[%A-Za-z0-9^]"
            break
        else
            let l:atag = strpart(l:atag, 1)
        endif
    endwhile
    if strpart(l:atag, 1, 1) =~ "\n"
        let l:atag = strpart(l:atag, 0, 1)
    endif
    if stridx(l:atag, "(") >= 0
        let l:atag = strpart(l:atag, 0, stridx(l:atag, "("))
    endif
    if stridx(l:atag, ")") >= 0
        let l:atag = strpart(l:atag, 0, stridx(l:atag, ")"))
    endif
    if stridx(l:atag, ",") >= 0
        let l:atag = strpart(l:atag, 0, stridx(l:atag, ","))
    endif
    if stridx(l:atag, ":") >= 0
        let l:atag = strpart(l:atag, 0, stridx(l:atag, ":"))
    endif
    if stridx(l:atag, '"') >= 0
        let l:atag = strpart(l:atag, 0, stridx(l:atag, '"'))
    endif
    if l:atag =~ "^^"
        let l:atag = strpart(l:atag, 1)
        let l:path = tr($gtmroutines, '( )', ',,,')
        let l:ffile = findfile(tr(l:atag, "%", "_") . ".m", l:path) 
        if l:ffile == ""
            "Routine doesn't exist, so can't search for the tag name
            let l:atag = tr(l:atag, "%", "_")
            echohl ErrorMsg 
            echo "E484: Can't open file " . l:atag . ".m"
            echohl None 
            return
        endif
        let l:ftag = get(readfile(l:ffile), 0)
        if l:ftag =~ "\t"
            let l:ftag = strpart(l:ftag, 0, stridx(l:ftag, "\t"))
        endif
        if l:ftag =~ " "
            let l:ftag = strpart(l:ftag, 0, stridx(l:ftag, " "))
        endif
        if l:ftag =~ "("
            let l:ftag = strpart(l:ftag, 0, stridx(l:ftag, "("))
        endif
        let l:atag = l:ftag . "^" . l:atag
    endif
    if l:atag !~ "\\^"
        let l:routine = bufname("%")
        let l:routine = tr(l:routine, "_", "%")
        let l:length = strlen(l:routine)-2
        let l:routine = strpart(l:routine, 0, l:length)
        let l:routine = strpart(l:routine, strridx(l:routine, "/")+1)
        let l:atag = l:atag . "^" . l:routine
    endif
    try
        execute "tjump " . l:atag
    catch /^Vim(\a\+):E426:/ "No tag in the .tags file
        echohl ErrorMsg 
        echo "E257: cstag: tag not found" 
        echohl None
    catch /^Vim(\a\+):E434:/ "No tag in the .tags file
        echohl ErrorMsg 
        echo "E257: cstag: tag not found" 
        echohl None
    catch /^Vim(\a\+):E429:/ "Tag is in .tags file, but routine doesn't exist
        let l:routine = strpart(l:atag, stridx(l:atag, "^")+1)
        let l:routine = tr(l:routine, "%", "_")
        echohl ErrorMsg 
        echo "E484: Can't open file " . l:routine . ".m"
        echohl None
    endtry
endfunction 

" $RCSfile: m-ctags.vim,v $
