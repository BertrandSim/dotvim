" knit current markdown file to html, pdf 
" using R > rmarkdown::render()

command ToHTML !R -e "rmarkdown::render('%', 'html_document')"
command ToPDF  !R -e "rmarkdown::render('%', 'pdf_document')"




" Teardown
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= '| '
endif

let b:undo_ftplugin .= 'delcommand ToHTML | delcommand ToPDF'
