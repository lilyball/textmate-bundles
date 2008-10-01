#!/usr/bin/python
# encoding: utf-8

import unicodedata
import sys
import os
import codecs

from binascii import hexlify
from UniTools import *

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

source1 = "/System/Library/Components/CharacterPalette.component/Contents/SharedSupport/\
CharPaletteServer.app/Contents/Frameworks/CharacterPaletteFramework.framework/Versions/A/Resources/kanji.db"
source2 = "/System/Library/Components/CharacterPalette.component/Contents/SharedSupport/\
CharPaletteServer.app/Contents/Resources/Radical.plist"
source3 = "/System/Library/Components/CharacterPalette.component/Contents/SharedSupport/\
CharPaletteServer.app/Contents/Frameworks/CharacterPaletteFramework.framework/Versions/A/\
Resources/CharPaletteRelatedChar.charDict"

bundleLibPath = os.environ["TM_BUNDLE_SUPPORT"] + "/lib/"


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
    def __delitem__(self, key):
         id=self._keys[key]
         del(self._keys[key])
         del(self._ids[id])
         return dict.__delitem__(self, key)
    def items(self):
        items=[]
        ids=list(self._ids.items())
        ids.sort()
        for id, key in ids:
            items.append((key, self[key]))
        return items


def lastCharInUCSdec(s):
    isPaneB = False
    if s:
        if u"\udc00" <= s[-1] <= u"\udfff" and len(s) >= 2 and u"\ud800" <= s[-2] <= u"\udbff":
            isPaneB = True
            return (((ord(s[-2])&0x3ff)<<10 | (ord(s[-1])&0x3ff)) + 0x10000, isPaneB)
        return (ord(s[-1]), isPaneB)
    return (-1, isPaneB)


if "TM_SELECTED_TEXT" in os.environ: sys.exit(200)

if os.environ["DIALOG"][-1] == '2':
    dialog2 = True
else:
    dialog2 = False

outDict = SeqDict()

if "TM_CURRENT_LINE" in os.environ and "TM_LINE_INDEX" in os.environ and int(os.environ["TM_LINE_INDEX"]):
    line, x = os.environ["TM_CURRENT_LINE"], int(os.environ["TM_LINE_INDEX"])
else:
    sys.exit(206)


(lastCharDecCode, charIsPaneB) = lastCharInUCSdec(unicode(line[:x], "UTF-8"))
char = wunichr(lastCharDecCode)
lastCharUCShexCode = "%04X" % lastCharDecCode

UnicodeData = os.popen("zgrep '^" + lastCharUCShexCode + ";' '" + bundleLibPath + 
                        "UnicodeData.txt.zip'").read().decode("utf-8")

name = ""

if not UnicodeData:
    name = getNameForRange(lastCharDecCode)
else:
    (dummy1, name, category, combiningclass, bididir, 
    decomposition, numtype1, numtype2, numtype3, bidimirror, 
    oldname, comment, upcase, lowcase, titlecase) = UnicodeData.strip().split(';')

if name[0] == '<': name = getNameForRange(lastCharDecCode)
block = getBlockName(lastCharDecCode)

outDict['Character'] = char
outDict['Name'] = name
outDict['Block'] = block

# look for related chars
frel = open(bundleLibPath + "relatedChars.txt", "rb")
reldata = frel.read().decode("UTF-8")
frel.close()
for part in reldata.split('\n'):
    if char in part: break
if part: outDict["Related to"] = part

if "CJK" in name and ("IDEO" in name or "Ideo" in name):
    # get CJK data from Apple's internal plist
    cmd = "grep -A 9 '" + char + "' '" + source2 + \
            "' | perl -pe 's/<key>.*?<\/key>//g;s/<.*?>//g;s/\t*//g;' | perl -e 'undef $/;$a=\"%0,\";$a.=<>;$a=~s/(\n)+/\t/mg; $a=~s/.*%(\d+).*?" \
            + char +".*?\t(.*)/$1\t$2/;$a=~s/\x0D//g;print $a'"
    gdata = os.popen(cmd.encode("UTF-8")).read().decode("UTF-8")
    if gdata != '%0,':
        ExtStrokeCnt, RadNum, RadName, Rad, RadStrokeCnt, Dummy = gdata.split('\t')
        outDict['Radical (trad.)'] = [Rad, RadStrokeCnt, u"画", RadName, RadNum, ExtStrokeCnt]
        outDict['Strokes (trad.)'] = str(int(RadStrokeCnt) + int(ExtStrokeCnt))

    # get all data from Apple's internal UniDict
    cmd = "sqlite3 " + source1 + " 'select * from unihan_dict where uchr=\"" + char + "\";'"
    udata = os.popen(cmd.encode("UTF-8")).read().decode("UTF-8")
    if udata:
        (uChar, a1, readings, hangul_name_sound, pinyin, zhWubiXing, 
        zhWubiHua, zhBianhao, a2, zhCangjieCh, zhDayi, pinyin1, 
        Bopomofo, jaKun, jaOn, pinyin, zhCangjie) = udata.split('|')
        zhCangjie = zhCangjie.strip()
        if readings:
            japDict = SeqDict()
            kunon = readings.split('/')
            if kunon[0]: japDict['Kun'] = kunon[0]
            if kunon[1]: japDict['On']  = kunon[1]
            outDict['Japanese'] = japDict

        # get Chinese simplified/traditional equivalent
        cmd = "egrep '^" + char + "' '" + bundleLibPath + "zhSimTradHanzi.txt'"
        simtrad = os.popen(cmd.encode("UTF-8")).read().decode("UTF-8")
        data = ""
        if simtrad: c1, st, data = simtrad.split('\t')
        if pinyin1 or Bopomofo or data or zhWubiXing or zhWubiHua or \
            zhBianhao or zhCangjie or zhCangjieCh or zhDayi:
            zhDict = SeqDict()
            if data:
                if st == 'T': zhDict['Traditional'] = data.rstrip()
                elif st == 'S': zhDict['Simplified'] = data.rstrip()
            if pinyin1: zhDict['Pinyin'] = pinyin1
            if Bopomofo: zhDict['Zhuyin'] = Bopomofo
            if zhWubiXing: zhDict['Wubi Xing'] = zhWubiXing
            if zhWubiHua: zhDict['Wubi Hua'] = zhWubiHua
            if zhBianhao: zhDict['Bishu Bianhao'] = zhBianhao
            if zhCangjie: zhDict['Cangjie'] =  zhCangjie + " " + zhCangjieCh
            if zhDayi: zhDict['Dayi'] = zhDayi
            outDict['Chinese'] = zhDict
        if hangul_name_sound:
            outDict['Korean'] = hangul_name_sound
else:
    if 'HANGUL' in name and not 'Jamo' in block:
        outDict['Decomposition'] = " ".join(unicodedata.normalize("NFKD", char))

    if UnicodeData:
        if category:       outDict['Category'] = expandUniCategories(category)
        if oldname:        outDict['Old Name'] = oldname
        if bididir:        outDict['Bidirectional'] = expandUniDirectionClass(bididir)
        if combiningclass: outDict['Combining Class'] = expandUniCombiningClass(combiningclass)
        if bidimirror:     outDict['Mirrored'] = bidimirror
        if upcase:         outDict['Upper Case'] = wunichr(int(upcase,16)) + " (U+" + upcase + ")"
        if lowcase:        outDict['Lower Case'] = wunichr(int(lowcase,16)) + " (U+" + lowcase + ")"
        if titlecase:      outDict['Title Case'] = wunichr(int(titlecase,16)) + " (U+" + titlecase + ")"
        if numtype1:       outDict['Numeral Type'] = (numtype1 + " " + numtype2 + " " + numtype3).strip()

        if decomposition and not charIsPaneB:
            decompDict = SeqDict()
            if decomposition[0] == '<':
                dc = decomposition.split(' ')
                decompDict['Class'] = expandUniDecompositionClass(dc[0])
                decomposition = " ".join(dc[1:])
            decomp = decomposition
            def cDec(x): return unichr(int(x,16))
            def rDec(x): return "U+%04X" % ord(x)
            clist = decomp.split(' ')
            decomp = " ".join(map(cDec, clist)) + " (U+" + " U+".join(clist) + ")"
            cflist = unicodedata.normalize("NFKD", char)
            if len(clist) != len(cflist):
                decompDict['into'] = decomp + "; " + " ".join(cflist) + "(" + " ".join(map(rDec, cflist)) + ")"
            else:
                decompDict['into'] = decomp
            outDict['Decomposition'] = decompDict


cpDict = SeqDict()
cpDict['UCS dec/hex'] = "%s / U+%s" % (str(lastCharDecCode), lastCharUCShexCode)
cpDict['UTF-8'] = " ".join([hex(ord(c))[2:].upper() for c in char.encode("utf-8")])
utf16be = hexlify(char.encode("utf-16-be")).upper()
if len(utf16be)>4: cpDict['UTF-16BE'] = utf16be[:4] + "+" + utf16be[4:]
outDict['Codepoints'] = cpDict

if dialog2:
    dlgout = "<table style=\"border-collapse:collapse;\">"
    plh = ""
    if outDict.has_key('Category') and "Nonspacing" in outDict['Category']: plh = u"o"
    dlgout += "<tr><td rowspan=2 style=\"border:1px dotted silver;font-size:20pt;text-align:center;\"><font color=#CCCCCC>%s</font>%s</td><td>&nbsp;</td><td style=\"color:grey;\">Name</td><td>%s</td></tr>" % (plh, outDict['Character'], outDict['Name'])
    dlgout += "<tr><td>&nbsp;</td><td style=\"color:grey;\">Block</td><td>%s</td></tr>" % outDict['Block']
    dlgout += "</table><table style=\"border-collapse:collapse;width:200px;\">"
    del outDict['Character']
    del outDict['Name']
    del outDict['Block']
    for k, v in outDict.items():
        if "Radical" in k:
            dlgout += "<tr><td align=right style=\"color:grey;\">%s</td><td>&nbsp;</td><td style=\"white-space:nowrap;\">%s (%s%s - %s) %s.%s" % (k, v[0], v[1], v[2], v[3], v[4], v[5])
        elif "Related" in k:
            #  and len(v) > 60
            dlgout += "<tr><td align=right style=\"color:grey;\">%s</td><td>&nbsp;</td><td>%s</td></tr>" % (k, v)
        else:
            try:
                v.items()
                dlgout += "<tr><td colspan=2 align=right style=\"color:grey;\"><b><i>%s</i></b></td></tr>" % k
                for ku, vu in v.items():
                    dlgout += "<tr><td align=right style=\"color:grey;white-space:nowrap;\">%s</td><td>&nbsp;</td><td style=\"white-space:nowrap;\">%s</td></tr>" % (ku, vu)
            except AttributeError:
                dlgout += "<tr><td align=right style=\"color:grey;white-space:nowrap;\">%s</td><td>&nbsp;</td><td style=\"white-space:nowrap;\">%s</td></tr>" % (k, v)

    cmd = "'%s' tooltip --html '%s'" % (os.environ["DIALOG"], dlgout.replace("'", u"＇"))
    os.popen(cmd.encode("UTF-8"))
    sys.exit(206)
else:
    sep = u"┊"
    for k, v in outDict.items():
        if "Radical" in k:
            print "%-15s %s %s (%s%s - %s) %s.%s" % (k, sep, v[0], v[1], v[2], v[3], v[4], v[5])
        else:
            try:
                v.items()
                print "%-15s" % k
                for ku, vu in v.items():
                    print "%15s %s %s" % (ku, sep, vu)
            except AttributeError:
                print "%-15s %s %s" % (k, sep, v)
    sys.exit(206)