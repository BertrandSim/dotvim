import vim
import re

# get the maximum tab stop number in a current snippet
def max_tab_stop():
    # check if cursor is in a snippet definition
    # otherwise return 0
    b = vim.current.buffer
    boundary_above   = int( vim.eval( "search('\(^snippet\|^endsnippet$\)', 'bnW')" ) ) -1
    boundary_below   = int( vim.eval( "search('\(^snippet\|^endsnippet$\)',  'nW')" ) ) -1

    if boundary_above == 0 or \
       boundary_below == 0 or \
       not re.match('^snippet', b[boundary_above]) or \
       not re.match('^endsnippet$', b[boundary_below]) :
        return 0

    # find matches $n, ${n:}
    tab_nums = []
    for line in range(boundary_above + 1, boundary_below):
        nums1 = re.findall('\$(\d)+',     b[line])  # $n
        nums2 = re.findall('\$\{(\d+)\:', b[line])  # ${n:}
        nums1 = [int(n) for n in nums1]
        nums2 = [int(n) for n in nums2]
        tab_nums.extend(nums1)
        tab_nums.extend(nums2)

    return max(tab_nums) if tab_nums else 0
