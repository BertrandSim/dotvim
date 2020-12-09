# provides math() context for tex snippets
# from Gilles Castel

# syntax regions for math.
# see :h tex-math, or
#     :h vimtex-syntax-reference 
# for details.

import vim

# math blocks
# simplified as per https://github.com/gillescastel/latex-snippets/pull/14/files
# and compatible with vimtex 2.0 syntax

texMathZones = ['texMathZone']
texTextZones = ['texMathText']
texZones     = texMathZones + texTextZones

def math():
    synstackNames = vim.eval("map(synstack(line('.'), max([col('.') - 1, 1])), 'synIDattr(v:val, ''name'')')")
    try:
        first = next(
            i for i in reversed(synstackNames)
            if any(i.find(z) == 0 for z in texZones)
        )
        return any(first.find(z) == 0 for z in texMathZones)
    except StopIteration:
        return False


# numbered (labelled) equation environments
# modified from Gilles Castel's original code for math context 

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
