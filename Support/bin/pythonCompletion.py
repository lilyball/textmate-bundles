#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  pythonCompletion
#
#  Created by Jeroen on 2005-05-28.
#  Copyright (c) 2005 . All rights reserved.
#
"""
pythonCompletion --word=$TM_CURRENT_WORD --line=$TM_CURRENT_LINE 
    --column=$TM_COLUMN_NUMBER --filename=$TM_FILEPATH
pythonCompletion -w$TM_CURRENT_WORD -l$TM_CURRENT_LINE -c$TM_COLUMN_NUMBER
    -f=$TM_FILEPATH

Returns the completion for that word.
It searches through libraries that python itself can import. (If you have 
custom libraries, make sure that $PYTHONPATH is set).
If it can't find anything there, then it can't find a module on the current
line, it falls back to the current (saved!) file.
"""

import sys
import os
import sre
import getopt

def getModuleNameFromLine(word, line, column):
    # Take part of the line until column to make sure we don't get any matches after that.
    match = sre.findall(r'(?:[a-zA-Z0-9_]*\.)+'+word, line[:column])
    if not match:
        # We're not completing a modulename, so we return None
        return None
    # To be sure it's the right match, we take the last one and strip off the . and the word
    result = match[-1][:-len("."+word)]
    return result

def getSuggestionListModule(word, module):
    try:
        moduleDir = dir(__import__(module))
    except ImportError:
        return []
    matches = []
    for elem in moduleDir:
        if elem.startswith(word):
            matches.append(elem)
    return matches

def getSuggestionListFile(word, filename):
    try:
        f = file(filename, 'r')
    except IOError:
        return []
    pattern = sre.compile(word+r'.*?\b')
    matches = []
    for line in f.readlines():
        for match in pattern.findall(line):
            if match != word and match not in matches:
                matches.append(match)
    matches.sort()
    return matches
    
def complete(word, line, column, filename=None):
    moduleName = getModuleNameFromLine(word, line, column)
    # We have no module or the module refers to itself
    if not moduleName or moduleName == "self":
        return getSuggestionListFile(word=word, filename=filename)
    else:
        # We found some module name, let's try to get some matches from it.
        matches = getSuggestionListModule(word, moduleName)
        # We haven't found any matches, let's try our luck on the file itself.
        if not matches:
            return  getSuggestionListFile(word=word, filename=filename)
        else:
            return matches

class Usage(Exception):
    def __init__(self, msg):
        self.msg = msg

def main(argv=None):
    if argv is None:
        argv = sys.argv
    try:
        try:
            opts, args = getopt.getopt(argv[1:], "hw:l:c:f:", ["help","output=","word=","line=","column=","filename="])
        except getopt.error, msg:
             raise Usage(msg)

        # option processing
        tmColumn = None
        tmLine = None
        tmWord = None
        tmFilename = None
        for option, value in opts:
            if option in ("-h", "--help"):
                raise Usage(__doc__)
            if option in ("-w", "--word"):
                tmWord = value
            if option in ("-l", "--line"):
                tmLine = value
            if option in ("-c", "--column"):
                tmColumn = int(value)
            if option in ("-f", "--filename"):
                tmFilename = value
        if not (tmWord and tmLine and tmColumn and tmFilename):
            raise Usage(__doc__)
        
    except Usage, err:
        return 2

    # Add the current directory to the pythonpath so that it can find the modules there
    sys.path.append(os.path.dirname(tmFilename))
    for match in complete(word=tmWord, line=tmLine, column=tmColumn, filename=tmFilename):
        print match
    
if __name__ == "__main__":
    sys.exit(main())
