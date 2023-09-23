" Author: Valeran MAYTIE
" Debug pannels setup

" Unique suffix for auxiliary panel names.
let s:counter = 0
" Panel identifiers.
let g:arrakis#panels#none = ''
let g:arrakis#panels#main = 'main'
let g:arrakis#panels#r_m  = 'regs_mem'
let g:arrakis#panels#info = 'info'
let g:arrakis#panels#code = 'code'
let g:arrakis#panels#aux  = [ g:arrakis#panels#r_m, g:arrakis#panels#info, g:arrakis#panels#code ]

" Open and init a pannel
function s:init(name)
  let l:name = a:name . 's'
  let l:bufname = substitute(a:name, '\l', '\u\0', '')

  " badd forces a new buffer to be created in case the main buffer is empty
  execute 'keepjumps badd ' . l:bufname . s:counter
  execute 'silent keepjumps keepalt hide edit ' . l:bufname . s:counter
  setlocal buftype=nofile
  execute 'setlocal filetype=arrakis-' . l:name
  setlocal noswapfile
  setlocal bufhidden=hide
  setlocal nobuflisted
  setlocal nocursorline
  setlocal wrap
  setlocal undolevels=50

  let b:arrakis_panel_open = 1
  let b:arrakis_panel_size = [-1, -1]
  let b:arrakis_panel_richpp = []
  return bufnr('%')
endfunction

function arrakis#panels#init()
  let l:main_buf = bufnr('%')
  let l:curpos = getcurpos()[1:]
  let l:arrakis_panel_bufs = {}
  let l:arrakis_panel_bufs[g:arrakis#panels#main] = l:main_buf

  " Add panels
  for l:panel in g:arrakis#panels#aux
    let l:arrakis_panel_bufs[l:panel] = s:init(l:panel)
  endfor

  " Switch back to main panel
  execute 'silent keepjumps keepalt buffer' . l:main_buf
  call cursor(l:curpos)
  let b:arrakis_panel_bufs = l:arrakis_panel_bufs

  let s:counter += 1
endfunction

function arrakis#panels#open()
  let l:left_win_size  = 80
  let l:below_win_size = 10

  let l:main_buf = b:arrakis_panel_bufs[g:arrakis#panels#main]
  let l:buf_rm   = b:arrakis_panel_bufs[g:arrakis#panels#r_m ]
  let l:buf_code = b:arrakis_panel_bufs[g:arrakis#panels#code]
  let l:buf_info = b:arrakis_panel_bufs[g:arrakis#panels#info]
  let l:main_wid = win_getid()

  execute printf('silent keepjumps keepalt vertical rightbelow sbuffer %d', l:buf_rm)
  execute printf('silent keepjumps keepalt rightbelow sbuffer %d', l:buf_code)
  execute printf("vertical resize %d", l:left_win_size)

  execute win_gotoid(l:main_wid)
  execute printf('silent keepjumps keepalt rightbelow sbuffer %d', l:buf_info)
  execute printf("resize %d", l:below_win_size)
  execute win_gotoid(l:main_wid)
endfunction

