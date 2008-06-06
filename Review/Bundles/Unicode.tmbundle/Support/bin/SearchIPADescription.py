#!/usr/bin/python
# encoding: utf-8

import sys
import os
import codecs

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

bundleLibPath = os.environ["TM_BUNDLE_PATH"] + "/Support/lib/"
sourceFile = "IPAnames.txt"

if len(sys.argv) != 3:
    print "Wrong number of arguments."
    sys.exit(206)

searchkind = sys.argv[1]
if not (searchkind == 'word' or searchkind == 'full'):
    print "Wrong first argument. Only 'word' or 'full'."
    sys.exit(206)

if searchkind == "full":
    grepopt = ""
else:
    grepopt = "\\b"

pattern = sys.argv[2]

if pattern.find(" ") == -1:
    grepcmd = "egrep '%s%s' '%s%s'" % (grepopt, pattern, bundleLibPath, sourceFile)
else:
    grepcmds = []
    for pat in pattern.split(' '):
        if pat:
            if not grepcmds:
                grepcmds.append("egrep '%s%s' '%s%s'" % (grepopt, pat, bundleLibPath, sourceFile))
            grepcmds.append("egrep '%s%s'" % (grepopt, pat))
    grepcmd = " | ".join(grepcmds)

try:
    suggestions = os.popen(grepcmd).read().decode("utf-8")
except:
    sys.exit(206)

if not suggestions:
    print "Nothing found"
    sys.exit(206)

print suggestions

