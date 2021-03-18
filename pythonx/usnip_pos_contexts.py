# Ultisnip contexts for file positions
# see :h UltiSnips-custom-context-snippets

import vim

# at top `num_lines` of file?
def top_of_file(snip, num_lines = 1):
    return snip.line < num_lines
