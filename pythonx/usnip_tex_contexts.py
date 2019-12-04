# provides math() context for tex snippets
# from Gilles Castel

# syntax regions for math
# see :h tex-math for details.

import vim

texMathZones = ['texMathZone'+x for x in ['A', 'AS', 'B', 'BS', 'C', 'CS', 'D', 'DS',       \
    'E', 'ES', 'F', 'FS', 'G', 'GS', 'H', 'HS', 'I', 'IS', 'J', 'JS', 'K', 'KS', 'L', 'LS', \
    'V', 'W', 'X', 'Y', 'Z']]

texIgnoreMathZones = ['texMathText']

texMathZoneIds = vim.eval('map('+str(texMathZones)+", 'hlID(v:val)')")
texIgnoreMathZoneIds = vim.eval('map('+str(texIgnoreMathZones)+", 'hlID(v:val)')")

ignore = texIgnoreMathZoneIds[0]

def math():
	synstackids = vim.eval("synstack(line('.'), col('.') - (col('.')>=2 ? 1 : 0))")
	try:
		first = next(i for i in reversed(synstackids) if i in texIgnoreMathZoneIds or i in texMathZoneIds)
		return first != ignore
	except StopIteration:
		return False


# numbered (labelled) equation environments

texEqZones = ['texMathZoneC', 'texMathZoneE']
             # equation env ,  align env
texEqZoneIds = vim.eval('map('+str(texEqZones)+", 'hlID(v:val)')")

def eq_env():
	synstackids = vim.eval("synstack(line('.'), col('.') - (col('.')>=2 ? 1 : 0))")
	try:
		first = next(i for i in reversed(synstackids) if i in texEqZoneIds)
		return True
	except StopIteration:
		return False 
