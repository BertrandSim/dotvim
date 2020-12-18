" add [count] lines above or below current cursor

function lines#newlinesBelow(count)
  let curpos_save = getcurpos()
  exec "normal!" . repeat("o\e", a:count)
  call setpos(".", curpos_save)
endfunction

function lines#newlinesAbove(count)
  let curpos_save = getcurpos()
  let curpos_save[1] += a:count	" adjust line (row) position
  exec "normal!" . repeat("O\e", a:count)
  call setpos(".", curpos_save)
endfunction
