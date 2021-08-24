" edit the quickfix list

":QFedit:     make the current quickfix / location list window editable (modifiable)
":QFupdate:   update changes in current quickfix / location list to vim
"               (for syncing qf window with the actual place to jump to in vim files / buffers)
":QFstopedit: terminate :QFedit
"kor details see autoload/qfedit.vim
command! QFedit call qfedit#edit()
command! QFupdate call qfedit#update()
command! QFstopedit call qfedit#stopedit()

