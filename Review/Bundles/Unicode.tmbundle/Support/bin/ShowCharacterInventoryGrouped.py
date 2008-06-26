#!/usr/bin/python
# encoding: utf-8


import sys
import os
import codecs
import unicodedata
import itertools
from UniTools import *
# import time

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

bundleLibPath = os.environ["TM_BUNDLE_SUPPORT"] + "/lib/"

# ts = time.time()
text = list(codepoints(sys.stdin.read()))

if not text: sys.exit(200)

class SeqDict(dict):
    """Dict that remembers the insertion order."""
    def __init__(self, *args):
        self._keys={}
        self._ids={}
        self._next_id=0
    def __setitem__(self, key, value):
        self._keys[key]=self._next_id
        self._ids[self._next_id]=key
        self._next_id+=1
        return dict.__setitem__(self, key, value)
    def keys(self):
        ids=list(self._ids.items())
        ids.sort()
        keys=[]
        for id, key in ids:
            keys.append(key)
        return keys



print """<html>
<head><title>Character Inventory</title>
<script type='text/javascript'>//<![CDATA[
//]]></script>
<style type='text/css'>
th {
font-size:8pt;
text-align:left;
}
table {border:1px solid #silver;border-collapse: collapse;}
td {padding:1mm;}
.a {
text-align:center;
}
.tr1 {
background-color:SandyBrown;
}
.tr2 {
background-color:Cornsilk;
}
.b {
text-align:center;
cursor:pointer;
}
</style>
</head>
<body>
"""

# dict of unique chars in doc and the number of its occurrence
chKeys = {}
for c in text:
    if c != 10: chKeys[c] = chKeys.get(c, 0) + 1

keys = chKeys.keys()
keys.sort()

relDataFile = file(bundleLibPath + "relatedChars.txt", 'r')
relData = relDataFile.read().decode("UTF-8").splitlines()
relDataFile.close()
groups = SeqDict()    # groups of related chars
unrel  = []    # list of chars which are not in groups

for ch in keys:
    wch = wunichr(ch)
    for index, group in enumerate(relData):
        if group.__contains__(wch):
            try:
                groups[index].append(ch)
            except KeyError:
                groups[index] = []
                groups[index].append(ch)
            break
    else:
        unrel.append(ch)

print "<table border=1>"
print "<tr><th>Character</th><th>Occurrences</th><th>UCS</th><th>Unicode Block</th><th>Unicode Name</th></tr>"

total = distinct = 0

# get Unicode names of all chars in doc; if not in Unicodedata, get them from UnicodeData.txt.zip
regExp = data = {}
for ch in keys:
    try:
        data["%04X" % int(ch)] = unicodedata.name(wunichr(ch), "<")
    except ValueError:
        regExp["%04X" % int(ch)] = 1
    except TypeError:
        regExp["%04X" % int(ch)] = 1

if regExp:
    UnicodeData = os.popen("zgrep -E '^(" + "|".join(regExp.keys()) + ");' '" + \
                    bundleLibPath + "UnicodeData.txt.zip'").read().decode("UTF-8")
    for c in UnicodeData.splitlines():
        uniData = c.strip().split(';')
        if len(uniData) > 1: data[uniData[0]] = uniData[1]

bgclasses = ['tr2', 'tr1']

for (clsstr, gr) in itertools.izip(itertools.cycle(bgclasses), groups.keys()):
    for c in groups[gr]:
        total += chKeys[c]
        distinct += 1
        t = wunichr(c)
        name = data.get("%04X" % int(c), getNameForRange(c) + "-%04X" % int(c))
        # I have no idea why name can be 1 ??
        if name == 1 or name[0] == '<': name = getNameForRange(c) + "-%04X" % int(c)
        if "COMBINING" in name: t = u"◌" + t
        # if groups[gr] has only one element shows up it as not grouped; otherwise bgcolor alternates
        if len(groups[gr]) == 1: clsstr = ''
        print "<tr class='" + clsstr + "'><td class='a'>", \
                t, "</td><td class='a'>", chKeys[c], "</td><td>", \
                "U+%04X" % (int(c)), "</td><td>", getBlockName(c), "</td><td>", name, "</tr>"

for c in unrel:
    total += chKeys[c]
    distinct += 1
    t = wunichr(c)
    name = data.get("%04X" % int(c), getNameForRange(c) + "-%04X" % int(c))
    if name == 1 or name[0] == '<': name = getNameForRange(c) + "-%04X" % int(c)
    if "COMBINING" in name: t = u"◌" + t
    print "<tr><td class='a'>", t, "</td><td class='a'>", chKeys[c], \
            "</td><td>", "U+%04X" % (int(c)), "</td><td>", \
            getBlockName(c), "</td><td>", name, "</tr>"

print "</table>"

# print str(time.time() - ts)

print "<p style='font-size:8pt;'><i>"

if total < 2:
    pl = ""
else:
    pl = "s"

print str(total) + " character%s in total (without '\\n')<br>" % pl
print str(distinct) + " distinct characters</i></p>"

print "</body></html>"
