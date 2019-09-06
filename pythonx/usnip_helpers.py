# snippet helper functions, 
# for jumping and expanding

import vim

def jump_tab(snip, to_tab=1):

	"""jump from one tabstop to another tabstop in the snippet"""

	tabdiff = to_tab - snip.tabstop
	if tabdiff > 0:
		jump_forward(snip, tabdiff)
	elif tabdiff < 0:
		jump_backward(snip, -tabdiff)

def jump_forward(snip, times=1):

	"""simulates pressing the jump forward key n times"""

	for i in range(times):
		vim.command('call UltiSnips#JumpForwards()')
	snip.cursor.preserve()

def jump_backward(snip, times=1):

	"""simulates pressing the jump backward key n times"""

	for i in range(times):
		vim.command('call UltiSnips#JumpBackwards()')
	snip.cursor.preserve()

def expand(snip, at_tab=1):

	""" expand snippet only if at a certain tabstop """

	if snip.tabstop != at_tab:
		return
	vim.command('call UltiSnips#ExpandSnippet()')	# have not tried this alternative..
	# snip.cursor.preserve()
	# vim.eval('feedkeys("\<C-R>=UltiSnips#ExpandSnippet()\<CR>")')
	
