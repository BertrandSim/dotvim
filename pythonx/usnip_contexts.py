# Ultisnip contexts 
# see :h UltiSnips-custom-context-snippets


# at top `num_lines` of file?
def top_of_file(snip, num_lines = 1):
    return snip.line < num_lines


# check if text after the snippet trigger (in the current line)
# matches a certain regex
#
# used as a workaround to lookahead assertions
# 
# example usage: `context text_after_cursor_matches(snip, "[ \n]")`
def text_after_cursor_matches(snip, string):
    (line, col) = snip.cursor
    text_after_cursor = snip.buffer[line][col:]
    # print(text_after_cursor)
    return re.match(string, text_after_cursor)


