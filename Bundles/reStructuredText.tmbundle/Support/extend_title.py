#!/usr/bin/env python
"""
	Extends the reST title. Cursor needs to be on the title line or the 
	title markup line. Must add one reST title markup character to extend.
"""


import os, sys, re

cur_line = int(os.environ['TM_LINE_NUMBER']) - 1
cur_column = int(os.environ['TM_COLUMN_NUMBER'])

buffer = sys.stdin.readlines()
mark_line = -1
# We're either on the title line or the marker line
if (cur_line >= 1) and \
	re.search(r'^(=|-|~|`|#|"|\^|\+|\*)+', buffer[cur_line]):
	title_line = cur_line - 1
	mark_line = cur_line
elif (cur_line < (len(buffer) - 1)) and \
	re.search(r'^(=|-|~|`|#|"|\^|\+|\*)+', buffer[cur_line + 1]):
	title_line = cur_line
	mark_line = cur_line + 1
	
for i in range(len(buffer)):
	if i == mark_line:
		print buffer[mark_line][0] * (len(buffer[title_line]) - 1)
	else:
		print buffer[i],


