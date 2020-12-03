# provides math() context for tex snippets
# from Gilles Castel

# syntax regions for math.
# see :h tex-math, or
#     :h vimtex-syntax-reference 
# for details.

import vim

# math blocks

texMathZones = ['texMathZone'+x for x in ['A', 'AS', 'B', 'BS', 'C', 'CS', 'D', 'DS',       \
    'E', 'ES', 'F', 'FS', 'G', 'GS', 'H', 'HS', 'I', 'IS', 'J', 'JS', 'K', 'KS', 'L', 'LS', \
    'V', 'W', 'X', 'Y', 'Z']]

texIgnoreMathZones = ['texMathText']

texMathZoneIds = vim.eval('map('+str(texMathZones)+", 'hlID(v:val)')")
texIgnoreMathZoneIds = vim.eval('map('+str(texIgnoreMathZones)+", 'hlID(v:val)')")

def math():
	synstackids = vim.eval("synstack(line('.'), col('.') - (col('.')>=2 ? 1 : 0))")
	try:
		first = next(i for i in reversed(synstackids) if i in texIgnoreMathZoneIds or i in texMathZoneIds)
		# return first != texIgnoreMathZoneIds[0]
		return first not in texIgnoreMathZoneIds
	except StopIteration:
		return False


# math blocks, with vimtex 2.0 plugin

texMathRegions = ['texMathRegion'+x for x in ['', 'X', 'XX', 'Env', 'EnvStarred', 'Ensured']]
texIgnoreMathRegions = ['texMathTextArg']

texMathRegionIds = vim.eval('map('+str(texMathRegions)+", 'hlID(v:val)')")
texIgnoreMathRegionIds = vim.eval('map('+str(texIgnoreMathRegions)+", 'hlID(v:val)')")

def math_vimtex_2():
	synstackids = vim.eval("synstack(line('.'), col('.') - (col('.')>=2 ? 1 : 0))")
	try:
		first = next(i for i in reversed(synstackids) if i in texIgnoreMathRegionIds or i in texMathRegionIds)
		# return first != texIgnoreMathRegionIds[0]
		return first not in texIgnoreMathRegionIds
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
