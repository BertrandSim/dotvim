" tabstops and related settings
setlocal tabstop=4 softtabstop=0 shiftwidth=0 noexpandtab

" Teardown
if !exists("b:undo_ftplugin") | let b:undo_ftplugin = '' | endif
let b:undo_ftplugin .= '| setlocal ts< sts< sw< et<'
