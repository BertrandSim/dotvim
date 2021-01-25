# provides math() context for tex snippets
# from Gilles Castel

# syntax regions for math.
# see :h tex-math, or
#     :h vimtex-syntax-reference 
# for details.

import vim

# math blocks
# simplified as per https://github.com/gillescastel/latex-snippets/pull/14/files
# compatible with and without vimtex 2.0 

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
  # texMathZoneE requires 
  # http://www.drchip.org/astronaut/vim/vbafiles/amsmath.vba.gz or similar

def in_eq_env():
    if in_latex_env("equation") or in_latex_env("align"):
        return True

    synstackNames = vim.eval("map(synstack(line('.'), max([col('.') - 1, 1])), 'synIDattr(v:val, ''name'')')")
    try:
        first = next(
            i for i in reversed(synstackNames) if i in texEqZones
        )
        return True
    except StopIteration:
        return False 


# in \begin{ {name} } ... \end{ {name} }
def in_latex_env(name):
    if vim.eval('exists("*vimtex#env#is_inside")') == '1':
        return vim.eval("vimtex#env#is_inside('" + name + "')") != ['0','0']
    return False


# in comment
def in_comment():
    if vim.eval('exists("*vimtex#syntax#in_comment")') == '1':
        return vim.eval('vimtex#syntax#in_comment()') == '1'

    # look for 'texComment' in syntax stack
    synstackNames = vim.eval("map(synstack(line('.'), max([col('.') - 1, 1])), 'synIDattr(v:val, ''name'')')")
    try:
        first = next(
            i for i in reversed(synstackNames) if i == 'texComment'
        )
        return True
    except StopIteration:
        return False 

