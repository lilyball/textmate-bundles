#!/usr/bin/python
# encoding: utf-8

import sys
import os
import codecs
import unicodedata
import cgi

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

bundleLibPath = os.environ["TM_BUNDLE_PATH"] + "/Support/lib/"
sourceFile = "IPAnames"

if len(sys.argv) != 3:
    print "Wrong number of arguments."

searchkind = sys.argv[1]
if not (searchkind == 'word' or searchkind == 'full'):
    print "Wrong first argument. Only 'word' or 'full'."

if searchkind == "full":
    grepopt = "%"
else:
    grepopt = ""

pattern = sys.argv[2]

if pattern.find(" ") == -1:
    grepcmd = "sqlite3 -separator ';' '%s%s' 'SELECT DISTINCT n.char, n.name, 1 FROM nameindex AS i, names AS n where i.word LIKE \"%s%s%s\" AND n.char = i.char ORDER BY n.name'" % (bundleLibPath, sourceFile, grepopt, pattern, '%')
else:
    grepcmds = []
    rank = 0
    for pat in pattern.split(' '):
        if pat:
            grepcmds.append("i.word LIKE \"%s%s%s\"" % (grepopt, pat, '%'))
            rank += 1
            grepcmd =  "sqlite3 -separator ';' '%s%s' 'SELECT DISTINCT n.char, n.name, count(*) AS rank FROM nameindex AS i, names AS n where (%s) AND n.char = i.char GROUP BY n.char HAVING rank = %s' ORDER BY n.char" %  (bundleLibPath, sourceFile, " OR ".join(grepcmds), rank)

try:
    suggestions = os.popen(grepcmd).read().decode("utf-8")
except:
    print "Error"

if not suggestions:
    print "Nothing found"

#print "<table border=1>"
print "<span style='font-family:Charis SIL, Lucida Grande'>"
for i in suggestions.split('\n'):
    if i:
        c, n, d = i.strip().split(';')
        print "e&#%s;g\t\t%s<br/>" % (str(ord(c)), "n.rstrip()")
 #       print "<tr><td style='font-family:Charis SIL, Lucida Grande'>"
#        if unicodedata.name(c).find("MODIFIER") > -1 or unicodedata.name(c).find("COMBINING") > -1:
 #       print "<big><font color=silver>e</font>%s<font color=silver>g</font></big></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>%s</td></tr>" % (c.strip(), n.strip())
 #       else:
  #      print "%s</span></td><td>%s</td></tr>" % (cgi.escape(c), cgi.escape(n))
#print "</table>"
print "</span>"
