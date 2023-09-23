" Author: Valeran MAYTIE
" Arrakis simulator communication

let g:arrakis#simulator#nvim = has('nvim')

let s:arrakis_path = "~/workspace/ocaml/arrakis/_build/default/arrakis/bin/main.exe"

let s:counter = 0

if !g:arrakis#simulator#nvim

  function s:open(socket)
    let l:mode = {'mode': 'raw', 'timeout': 5000}
    let l:address = printf("unix:%s", a:socket)
    let g:chanel = ch_open(a:address, l:mode)
  endfunction

  function s:status()
    return ch_status(g:chanel)
  endfunction

  function s:send(expr)
    call chansend(g:chanel, a:expr)
  endfunction
else
  function s:open(socket)
    while !filereadable(a:socket)
    endwhile
    let g:chanel = sockconnect('pipe', a:socket)
  endfunction

  function s:status()
    return nvim_get_chan_info(g:chanel) != {} ? 'open' : ''
  endfunction

  function s:send(expr)
    call chansend(g:chanel, a:expr)
  endfunction
endif


function arrakis#simulator#init()
  let b:socket = printf("./socket_%d", s:counter)
  let l:file = expand('%')
  execute printf("silent ! %s %s -U -f %s &", s:arrakis_path, l:file, b:socket)

  execute s:open(b:socket)
  echo s:status()

  let s:counter += 1
endfunction

function arrakis#simulator#quit()
  execute s:send("q\n")
endfunction
