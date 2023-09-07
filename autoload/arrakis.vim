" Author: Valeran MAYTIE
" Arrakis, riscV simulator

" Only source once.
if exists('g:loaded_arrakis')
  finish
endif
let g:loaded_arrkis = 1
let b:arrakis_started = 0

function arrakis#start()
  if b:arrakis_started
    echo "Arrakis is already running"
  else
    let b:arrakis_started = 1
    echo "TODO\n"
  endif
endfunction

" Define Arrakis commands.
function arrakis#define_command()
  command -buffer ArrakiStart call arrakis#start()
endfunction

" Init Arrakis plugin
" Called from ftplugin/asm.vim, from the main buffer, meaning we can sefely
" refer to b: var here.
function arrakis#init()
  call arrakis#define_command()
endfunction
