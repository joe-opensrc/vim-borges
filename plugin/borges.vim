" borges.vim -- Alt Text Switcher
" Maintainer:   Joe OpenSrc
" Version:      0.4
" GetLatestVimScripts: 4359 1 :AutoInstall: borges.vim

if exists("g:loaded_borges") || v:version < 801 || &cp
  finish
endif
let g:loaded_borges = 0.4

let s:save_cpo = &cpo
set cpo&vim

" sets the current view number
" by default extracts the first alt in each region
" could be set to an <int> ?
if !exists("g:borges_currView")
  let g:borges_currView = '\d\+'
endif

let s:currView  = g:borges_currView

fun! borges#idio(...)

  let l:lvl = get( a:, 1, g:borges_currView )
  let alt_reg = '@' . l:lvl . '{'
    exe "silent! norm! G$"
    while search('<|', 'nWb' ) > 0 
      call borges#bifurcate(lvl) 
    endwhile
endfunction

fun! borges#bifurcate(...)

  "get 'filtering' lvl 
  let l:lvl = get( a:, 1, g:borges_currView )
  " Alts region regex
  let alt_reg = '@' . l:lvl . '{'

  "clear our register as we use append
  call setreg( 'z', [] )

  " mark the start of our workspace
  " exe "silent! norm! mz"

  if expand('<cWORD>') == '<|'
    exe "silent! norm! w" 
  endif 

  " look for opening token
  if searchpos('<|', 'Wb' ) != [0,0]
    " mark x; jump to 'z, append region into "z, jump back to `x
    exe "silent! norm! mz"
 
    " look for closing token
    if searchpairpos('<|', '', '|>', 'zW') != [0,0]

      " find closing token move to its right edge; mark x; jump z
      exe "silent! norm! lmx`z"
      " look for an alt block ( e.g., '@1{' ) opening token 
      if search(alt_reg, 'We', line("'x") ) > 0
        "skip to text; mark v
        exe "silent! norm! mc"
        " look for closing token
        if searchpairpos(alt_reg, '', '}', 'zW') != [0,0]
          exe "silent! norm! mvdv`x"
          exe "silent! s/\\s\\+\\%'v//g"
          exe "silent! norm! `cwd`z"
        else
          exe "silent! norm! `zb"  
        endif 

      else 
        exe "silent! norm! `zb"
        return 1
      endif    
    else
      return 2
    endif

  else 

    return 1

  endif

  return 0

endfunction

command! -nargs=? IdioSync call borges#idio(<f-args>)
nnoremap <C-F> :IdioSync 

command! -nargs=? Bifurcate call borges#bifurcate(<f-args>)
nnoremap <C-D> :Bifurcate 

let &cpo = s:save_cpo
unlet s:save_cpo
