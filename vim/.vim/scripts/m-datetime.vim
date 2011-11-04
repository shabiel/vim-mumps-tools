" David Wicksell ; .vim/m-datetime.vim ; dlw@linux.com
"
" $Source: /home/vpe/RCS/m-datetime.vim,v $
" $Revision: 20100111.3 $
"
" Copyright © 2010 Fourth Watch Software
" Licensed under the terms of the GNU Affero General
" Public License. See attached copy of the License.
"
" Imprints a Datetime stamp in either new or
" old VPE formats, at the end of the first line

function! DateTime()
  let l:dt = strftime("%-m/%-d/%y %-I:%M%P")
  let l:gl = getline(1)
  if l:gl =~ "^.*]$"
    call setline(1, strpart(l:gl, 0, strridx(l:gl, "[")) . "[" . l:dt . "]")
  elseif l:gl =~ "^.*;$"
    call setline(1, l:gl . " " . l:dt)
  elseif l:gl =~ "^.*/.*/.*:.*$"
    call setline(1, strpart(l:gl, 0, strridx(l:gl, ";")) . "; " . l:dt)
  else
    call setline(1, getline(1) . " ; " . l:dt)
  endif
endfunction

" $RCSfile: m-datetime.vim,v $
