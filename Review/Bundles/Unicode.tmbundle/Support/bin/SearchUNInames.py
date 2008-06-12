#!/usr/bin/python
# encoding: utf-8

import sys
import os
import codecs
import unicodedata
import time

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

bundleLibPath = os.environ["TM_BUNDLE_SUPPORT"] + "/lib/"

sourceFile = "UNInames"

def wunichr(dec):
    return ("\\U%08X" % dec).decode("unicode-escape")


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

if not os.path.exists(bundleLibPath + sourceFile):
    res = os.popen("'" + bundleLibPath + "/aux/createUnicodeNamesDB.sh" + "'")
    print "<i><b>Index was built. Please press RETURN again.</b></i><br><br>"

if os.stat(bundleLibPath + "UnicodeData.txt.zip")[8] > os.stat(bundleLibPath + sourceFile)[8]:
    res = os.popen("'" + bundleLibPath + "/aux/createUnicodeNamesDB.sh" + "'")
    print "<i><b>Index was rebuilt. Please press RETURN again.</b></i><br><br>"

grepcmds = []
froms = []
jns = []
tbl = 1
for pat in pattern.split(' '):
    if pat:
        if tbl==1:
            grepcmds.append("i%s.word LIKE \"%s%s%s\"" % (str(tbl), grepopt, pat, grepopt))
        else:
            grepcmds.append("i%s.word LIKE \"%s%s%s\"" % (str(tbl), grepopt, pat, '%'))
        froms.append("nameindex AS i%s" % str(tbl))
        jns.append("n.char = i%s.char" % str(tbl))
        tbl += 1

grepcmd =  "sqlite3 -separator ';' '%s%s' 'SELECT DISTINCT n.char, n.name FROM %s, names AS n WHERE %s AND %s LIMIT 500'" %  (bundleLibPath, sourceFile, ", ".join(froms), " AND ".join(grepcmds), " AND ".join(jns))
#print grepcmd
suggestions = os.popen(grepcmd).read().decode("utf-8").strip()

if not suggestions:
    print "<i><small>Nothing found</small></i>"

print "<p>&nbsp;</p><p class='res'>"
for i in suggestions.split('\n'):
    c, n = i.split(';')
    t = ""
    if "COMBINING" in n: t = u"<small>◌</small>"
    print "<span onclick='insertChar(\"%s\")' onmouseout='clearName()'; onmouseover='showName(\"U+%s : %s\")' class='char'>%s%s</span> " % (wunichr(int(c,16)),c, n, t, wunichr(int(c,16)))
print "</p><p class='res'> </p>"

