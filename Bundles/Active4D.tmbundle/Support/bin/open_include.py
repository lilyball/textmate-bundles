#!/usr/bin/env python
#
# This command searches around the caret/selection for the nearest quotes and expands
# the name to the full quoted text, then tries to open the file at the path described
# by that text.
#
# $Id$
#
# encoding: utf-8

import sys
import os
import string


def main():
	# Get the current word
	line = os.environ['TM_CURRENT_LINE']
	col = int(os.environ['TM_LINE_INDEX']) - 1  # Start at character before caret
	
	# Search backward until we find a non-word character or line start
	start = 0
	
	for start in range(col, -1, -1):
		c = line[start]
		
		if (c in string.letters) or (c in string.digits) or (c in "_-./"):
			continue
			
		# The start should be one past the first nonvalid character
		start += 1
		break
		
	# Search forward until we find a non-word character or line start
	end = col + 1
	
	for end in range(col + 1, len(line)):
		c = line[end]
		
		if (c in string.letters) or (c in string.digits) or (c in "_-./"):
			continue
			
		break
		
	if (end - start == 0):
		print "No filename found"
		sys.exit(206)
	else:	
		os.system('mate "%s" &>/dev/null &' % (os.path.join(os.environ['TM_DIRECTORY'], line[start:end])))
	

if __name__ == '__main__':
	main()

