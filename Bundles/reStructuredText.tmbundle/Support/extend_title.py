#!/usr/bin/env python
"""
	Extends the reST title. Cursor needs to be on the title line or the 
	title markup line. Must add one reST title markup character to extend.
"""

import os, sys, re

lines = sys.stdin.readlines()
lines = [i.rstrip() for i in lines]
# Last line should be the markup line
match = re.search(r'^(=|-|~|`|#|"|\^|\+|\*)+', lines[-1])
if not match:
	# Oops, there needs to be text to match. Don't change anything.
	print '\n'.join(lines)
	sys.exit(-1)
lineLen = len(lines[-2].expandtabs(int(os.environ['TM_TAB_SIZE'])))
# escape snippet characters
lines = [re.sub(r'([$`\\])', r'\\\1', i) for i in lines]
lines[-1] = lineLen * lines[-1][0] + '$0'
print '\n'.join(lines)

