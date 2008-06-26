#!/usr/bin/python
# coding=utf-8

# written by Hans-Jörg Bibiko; bibiko at eva.mpg.de

import sys
import os
import codecs
import re
import zipfile
import unicodedata
from UniTools import wunichr, codepoints, getNameForRange

tm_support_path = os.path.join(os.environ["TM_SUPPORT_PATH"], "lib")
if not tm_support_path in os.environ:
     sys.path.insert(0, tm_support_path)

import dialog
import tm_helpers

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

bundleLibPath = os.environ["TM_BUNDLE_SUPPORT"] + "/lib/"
pyversion = int("".join(sys.version.split()[0].split('.')))


if "TM_SELECTED_TEXT" in os.environ:
     print "Please remove the selection firstly."
     sys.exit(206)

if len(sys.argv) != 2:
    print "No argument given!"
    sys.exit(206)

source = sys.argv[1]
if not os.path.exists(bundleLibPath + source + ".txt"):
     print "Source does not exist."
     sys.exit(206)


line, x = os.environ["TM_CURRENT_LINE"], int(os.environ["TM_LINE_INDEX"])
if not x: sys.exit(200)
inputleft = list(codepoints(unicode(line[:x], "UTF-8")))
tail = unicode(line[x:], "UTF-8")
char = wunichr(inputleft[-1])
head = inputleft[:-1]

# get the suggestion for 'char' by using grep against source.txt
frel = open(bundleLibPath + source + ".txt", "rb")
reldata = frel.read().decode("UTF-8")
frel.close()
for part in reldata.splitlines():
    if char in part: break
if not part:
    print "Nothing found for: U+" + "%04X " % int(inputleft[-1]) + char + "."
    sys.exit(206)

if pyversion > 250:
    suggestions = list(set(codepoints(part)))
else:
    suggestions = list(codepoints(part))
    skeys = {}
    for e in suggestions: skeys[e] = 1
    suggestions = skeys.keys()

suggestions.sort()

regExp = {}
unames = {}
for ch in suggestions:
    try:
        unames["%04X" % int(ch)] = unicodedata.name(unichr(ch))
    except ValueError:
        regExp["%04X" % int(ch)] = 1

# add Unicode names from 5.1 if desired
if regExp:
    UnicodeData = os.popen("zgrep -E '^(" + "|".join(regExp.keys()) + ");' '" + bundleLibPath + "UnicodeData.txt.zip'").read().decode("UTF-8")
    if UnicodeData:
        for c in UnicodeData.split('\n'):
            uniData = c.strip().split(';')
            if len(uniData) > 1: unames[uniData[0]] = uniData[1]

sugglist = []

for c in suggestions:
    name = ""
    try:
        name = unames["%04X" % int(c)]
    except KeyError:
        name = getNameForRange(c)
    if name[0] == '<':
        name = getNameForRange(c)
    theChar = re.sub(r"(?=[\"])", r'\\', wunichr(c))
    if theChar == '"': theChar = '\\"'
    sugglist.append("%s\t:   U+%-5s\t :   %s" % (theChar, "%04X" % int(c), name))

try:
    result=dialog.menu(sugglist)
    if not result: sys.exit(200)
    sys.__stdout__.write("".join(map(wunichr, head)).encode("UTF-8"))
    sys.__stdout__.write(result.split('\t')[0].encode("UTF-8"))
    sys.__stdout__.write(tail.encode("UTF-8"))
    sys.exit(201)
except KeyError:
    sys.exit(206)
