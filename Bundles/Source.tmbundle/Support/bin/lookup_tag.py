#!/usr/bin/env python

import os
import sys

""" Look for TextMate """
if os.environ.has_key('TM_MODE'):
	path = os.path.join(os.environ['TM_BUNDLE_SUPPORT'], 'bin')
	sys.path.append(path)
	sys.path.append(os.path.join(path, 'pytags.zip'))
	import pytags.exchtml as exchtml
else:
	import exchtml

if os.environ.has_key('TM_MODE'):

	tag = os.environ.get('TM_SELECTED_TEXT', sys.stdin.read())
	if not tag:
		current_word = os.environ.get('TM_CURRENT_WORD', 'search string').strip()
		dialog = os.path.join(os.environ['TM_SUPPORT_PATH'],
				'bin/CocoaDialog.app/Contents/MacOS/CocoaDialog')
		options = 'inputbox --title "Tag to lookup" --button1 '
		options += '"Lookup" --button2 "Cancel" --text "%s"' % (current_word)
		stdin, stdout = os.popen2('"' + dialog + '" ' + options)
		stdin.close()
		lines = stdout.readlines()
		if lines[0].strip() == '1':
			tag = lines[1].strip()
		else:
			print '<h1><center>Lookup cancelled</center></h1>'
			sys.exit(0)
			
	if not tag:
		print '<h1><center>No text to lookup</center></h1>'

	tagpath = None
	if os.environ.has_key('TM_TAG_FILE'):
		tagpath = os.environ['TM_TAG_FILE']
	elif os.environ.has_key('TM_PROJECT_DIRECTORY'):
		tmp = os.path.join(os.environ['TM_PROJECT_DIRECTORY'], 'tags')
		if os.path.exists(tmp):
			tagpath = tmp
	startdir = os.path.dirname(os.environ.get('TM_FILEPATH', 
			os.getcwd() + '/'))
	
	print exchtml.lookup(tag, tagpath, startdir)[0]
	
else:
	
	tag = sys.argv[1]
	
	if not tag:
		print 'No text to lookup'
	
	startdir = os.getcwd() + '/'
	print exchtml.lookup(tag, None, startdir)[0]
