#!/usr/bin/python
# encoding: utf-8

import sys
import os
import codecs
import unicodedata
from binascii import hexlify

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

bundleLibPath = os.environ["TM_BUNDLE_SUPPORT"] + "/lib/"

sourceFile = "IPANames.txt"


def wunichr(dec):
    return ("\\U%08X" % dec).decode("unicode-escape")

def wuniord(s):
    if s:
        if u"\udc00" <= s[-1] <= u"\udfff" and len(s) >= 2 and u"\ud800" <= s[-2] <= u"\udbff":
            return (((ord(s[-2])&0x3ff)<<10 | (ord(s[-1])&0x3ff)) + 0x10000)
        return (ord(s[-1]))
    return (-1)

if len(sys.argv) != 3:
    print "Wrong number of arguments."

searchkind = sys.argv[1]
if not (searchkind == 'word' or searchkind == 'full'):
    print "Wrong first argument. Only 'word' or 'full'."

os.popen("touch /tmp/TM_db.busy")

if searchkind == "full":
    grepopt = ""
else:
    grepopt = "\\b"

pattern = sys.argv[2]

print "<p>&nbsp;<br><br></p>"

grepcmds = []
for pat in pattern.split(' '):
    if pat:
        if not grepcmds:
            grepcmds.append("egrep -i '%s%s' '%s%s'" % (grepopt, pat, bundleLibPath, sourceFile))
        else:
            grepcmds.append("egrep -i '%s%s'" % (grepopt, pat))

grepcmd = " | ".join(grepcmds)

suggestions = os.popen(grepcmd).read().decode("utf-8").strip()

if not suggestions:
    print "<i><small>Nothing found</small></i>"
    os.popen("rm -f /tmp/TM_db.busy")

print "<p class='res'>"
cnt = 0

for i in suggestions.split('\n'):
    cnt += 1
    c, n = i.split('\t')
    if len(c)==1:
        uname = unicodedata.name(c,'unknown')
        if uname == "unknown":
            if c == u"":
                uname = "Private Use Area (defined in e.g. Charis SIL)"
            elif c == u"ᶹ":
                uname = "MODIFIER LETTER SMALL V WITH HOOK"
            elif c == u"͓":
                uname = "COMBINING X BELOW"
            elif c == u"͜":
                uname = "COMBINING DOUBLE BREVE BELOW"
            elif c == u"͗":
                uname = "COMBINING RIGHT HALF RING ABOVE"
            elif c == u"͑":
                uname = "COMBINING LEFT HALF RING ABOVE"
            else:
                uname = ""
        t = ""
        if "COMBINING" in uname: t = u"<small>◌</small>"
        print "<span onclick='insertChar(\"%s\")' onmouseout='clearName()'; onmouseover='showName(\"U+%s : %s<br>%s\")' class='char'>%s%s</span> " % (hexlify(c.encode("UTF-8")),"%04X" % wuniord(c), n, uname, t, c)
    else:
        print "<span onclick='insertChar(\"%s\")' onmouseout='clearName()'; onmouseover='showName(\"%s\")' class='char'>%s%s</span> " % (hexlify(c.encode("UTF-8")), n, t, c)

pl = ""
if cnt > 1: pl = "es"

print "</p><i><small>"+str(cnt)+" match"+pl+"</small></i>"

os.popen("rm -f /tmp/TM_db.busy")
