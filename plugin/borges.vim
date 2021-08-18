" borges.vim -- Alt Text Switcher
" Maintainer:   Joe OpenSrc
" Version:      0.3
" GetLatestVimScripts: 4359 1 :AutoInstall: borges.vim

if exists("g:loaded_borges") || v:version < 801 || &cp
  finish
endif
let g:loaded_borges = 0.3

let s:save_cpo = &cpo
set cpo&vim

" sets the current view number
" by default extracts the first alt in each region
" could be set to an <int> ?
if !exists("g:borges_currView")
  let g:borges_currView = '\d\+'
endif

let s:currView  = g:borges_currView

fun! borges#bifurcate(...)

  "get 'filtering' lvl 
  let l:lvl = get( a:, 1, g:borges_currView )
  " Alts region regex
  let alt_reg = '@' . l:lvl . '{'

  "clear our register as we use append
  call setreg( 'z', [] )

  " mark the start of our workspace
  " exe "silent! norm! mz"
  
  " look for opening token
  if searchpos('<|', 'Wb') != [0,0]
    " mark x; jump to 'z, append region into "z, jump back to `x
    exe "silent! norm! mz"
 
    " look for closing token
    if searchpairpos('<|', '', '|>', 'zW') != [0,0]

      "delete the token; mark c; jump to `x
      exe "silent! norm! mx`z"
      " look for an alt block ( e.g., '@1{' ) opening token 
      if search(alt_reg, 'W') > 0
        "skip to text; mark v
        exe "silent! norm! mc"
        " look for closing token
        if searchpairpos(alt_reg, '', '}', 'zW') != [0,0]
          " skip to text; mark b; append `b..`v to "z (charwise);
          " del `c..`z (charwise); paste "z prior. 
          exe "silent! norm! mv`xdiWdv`v`cdaWd`z"
         
          "call until end
          call borges#bifurcate(l:lvl)
        else

          call borges#bifurcate(l:lvl)
        endif 
      else
        call borges#bifurcate(l:lvl)

      endif

    else
  
      " skip unbound region
      call borges#bifurcate(l:lvl) 

    endif    

  endif

endfunction

command! -nargs=? IdioSync call cursor([getpos('$')[1], col(getpos('$')[1] )] ) | call borges#bifurcate(<f-args>)
nnoremap <C-F> :IdioSync 

let &cpo = s:save_cpo
unlet s:save_cpo
