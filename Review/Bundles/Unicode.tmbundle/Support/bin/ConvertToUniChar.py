#!/usr/bin/python
# coding=utf-8

# written by Hans-Jörg Bibiko; bibiko at eva.mpg.de

import sys
import os
import codecs
import re
import zipfile

tm_support_path = os.path.join(os.environ["TM_SUPPORT_PATH"], "lib")
if not tm_support_path in os.environ:
     sys.path.insert(0, tm_support_path)

import dialog
import tm_helpers

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

bundleLibPath = os.environ["TM_BUNDLE_PATH"] + "/Support/lib/"
pyversion = int("".join(sys.version.split()[0].split('.')))

def wunichr(dec):
    return ("\\U%08X" % dec).decode("unicode-escape")

def codepoints(s):
    hs = 0
    for c in s:
        c = ord(c)
        if 0xdc00 <= c <= 0xdfff and hs:
            yield ((hs&0x3ff)<<10 | (c&0x3ff)) + 0x10000
            hs = 0
        elif 0xd800 <= c <= 0xdbff:
            hs = c
        else:
            yield c
    if hs:
        yield hs

def rangeName(dec):
    if 0x3400 <= dec <= 0x4DB5:
        return  "CJK Ideograph Extension A"
    elif 0x4E00 <= dec <= 0x9FC3:
        return  "CJK Ideograph"
    elif 0xAC00 <= dec <= 0xD7A3: # Hangul
        return  unicodedata.name(unichr(dec), "U+%04X" % dec)
    elif 0xD800 <= dec <= 0xDB7F:
        return  "Non Private Use High Surrogate"
    elif 0xDB80 <= dec <= 0xDBFF:
        return  "Private Use High Surrogate"
    elif 0xDC00 <= dec <= 0xDFFF:
        return  "Low Surrogate"
    elif 0xE000 <= dec <= 0xF8FF:
        return  "Private Use"
    elif 0x20000 <= dec <= 0x2A6D6:
        return  "CJK Ideograph Extension B"
    elif 0xF0000 <= dec <= 0xFFFFD:
        return  "Plane 15 Private Use"
    elif 0x100000 <= dec <= 0x10FFFD:
        return  "Plane 16 Private Use"
    else:
        return  "not defined"


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

# build Unicode name dict
unames = {}
zUniData = zipfile.ZipFile(bundleLibPath + "UnicodeData.txt.zip", "r")
for line in zUniData.read("UnicodeData.txt").decode("UTF-8").split('\n'):
    udata = line.split(';')
    if udata:
        unames[udata[0]] = udata[1]
zUniData.close()

# get the suggestion for 'char' by using grep against source.txt
frel = open(bundleLibPath + source + ".txt", "rb")
reldata = frel.read().decode("UTF-8")
frel.close()
for part in reldata.split('\n'):
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

sugglist = []
for c in suggestions:
    name = ""
    try:
        name = unames["%04X" % int(c)]
    except:
        name = rangeName(c)
    if name[0] == '<':
        name = rangeName(c)
    hexcode = "%04X" % int(c)
    theChar = re.sub(r"(?=[\"])", r'\\', wunichr(c))
    if theChar == '"': theChar = '\\"'
    if len(hexcode) > 4:
        sugglist.append(theChar + "\tU+" + hexcode + "\t" + name)
    else:
        sugglist.append(theChar + "\tU+" + hexcode + "\t\t" + name)

try:
    result=dialog.menu(sugglist)
    if not result: sys.exit(200)
    sys.__stdout__.write("".join(map(wunichr, head)).encode("UTF-8"))
    sys.__stdout__.write(result.split('\t')[0].encode("UTF-8"))
    sys.__stdout__.write(tail.encode("UTF-8"))
    sys.exit(201)
except KeyError:
    sys.exit(206)
