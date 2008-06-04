#!/usr/bin/python
# encoding: utf-8
import unicodedata
import sys
import re
import os
import codecs

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

cat = {
'Lu': 'Letter, Uppercase',
'Ll': 'Letter, Lowercase',
'Lt': 'Letter, Titlecase',
'Lm': 'Letter, Modifier',
'Lo': 'Letter, Other',
'Mn': 'Mark, Nonspacing',
'Mc': 'Mark, Spacing Combining',
'Me': 'Mark, Enclosing',
'Nd': 'Number, Decimal Digit',
'Nl': 'Number, Letter',
'No': 'Number, Other',
'Pc': 'Punctuation, Connector',
'Pd': 'Punctuation, Dash',
'Ps': 'Punctuation, Open',
'Pe': 'Punctuation, Close',
'Pi': 'Punctuation, Initial quote (may behave like Ps or Pe depending on usage)',
'Pf': 'Punctuation, Final quote (may behave like Ps or Pe depending on usage)',
'Po': 'Punctuation, Other',
'Sm': 'Symbol, Math',
'Sc': 'Symbol, Currency',
'Sk': 'Symbol, Modifier',
'So': 'Symbol, Other',
'Zs': 'Separator, Space',
'Zl': 'Separator, Line',
'Zp': 'Separator, Paragraph',
'Cc': 'Other, Control',
'Cf': 'Other, Format',
'Cs': 'Other, Surrogate',
'Co': 'Other, Private Use',
'Cn': 'Other, Not Assigned (no characters in the file have this property)',
}

bidi = {
'L': 'Left-to-Right',
'LRE': 'Left-to-Right Embedding',
'LRO': 'Left-to-Right Override',
'R': 'Right-to-Left',
'AL': 'Right-to-Left Arabic',
'RLE': 'Right-to-Left Embedding',
'RLO': 'Right-to-Left Override',
'PDF': 'Pop Directional Format',
'EN': 'European Number',
'ES': 'European Number Separator',
'ET': 'European Number Terminator',
'AN': 'Arabic Number',
'CS': 'Common Number Separator',
'NSM': 'Non-Spacing Mark',
'BN': 'Boundary Neutral',
'B': 'Paragraph Separator',
'S': 'Segment Separator',
'WS': 'Whitespace',
'ON': 'Other Neutrals',
}

combclass = {
'0': 'Spacing, split, enclosing, reordrant, and Tibetan subjoined',
'1': 'Overlays and interior',
'7': 'Nuktas',
'8': 'Hiragana/Katakana voicing marks',
'9': 'Viramas',
'10': 'Start of fixed position classes',
'199': 'End of fixed position classes',
'200': 'Below left attached',
'202': 'Below attached',
'204': 'Below right attached',
'208': 'Left attached (reordrant around single base character)',
'210': 'Right attached',
'212': 'Above left attached',
'214': 'Above attached',
'216': 'Above right attached',
'218': 'Below left',
'220': 'Below',
'222': 'Below right',
'224': 'Left (reordrant around single base character)',
'226': 'Right',
'228': 'Above left',
'230': 'Above',
'232': 'Above right',
'233': 'Double below',
'234': 'Double above',
'240': 'Below (iota subscript)',
}

decompclass = {
'<font>': 'A font variant (e.g. a blackletter form).',
'<noBreak>': 'A no-break version of a space or hyphen.',
'<initial>': 'An initial presentation form (Arabic).',
'<medial>': 'A medial presentation form (Arabic).',
'<final>': 'A final presentation form (Arabic).',
'<isolated>': 'An isolated presentation form (Arabic).',
'<circle>': 'An encircled form.',
'<super>': 'A superscript form.',
'<sub>': 'A subscript form.',
'<vertical>': 'A vertical layout presentation form.',
'<wide>': 'A wide (or zenkaku) compatibility character.',
'<narrow>': 'A narrow (or hankaku) compatibility character.',
'<small>': 'A small variant form (CNS compatibility).',
'<square>': 'A CJK squared font variant.',
'<fraction>': 'A vulgar fraction form.',
'<compat>': 'Otherwise unspecified compatibility character.',
}

#name,cat,combclass,bidi,decomp,numtype,bidimirror,oldname,comment,upcase,lowcase,titlecase

if "TM_SELECTED_TEXT" in os.environ:
    sys.exit(200)

def lastchar(s):
    if s:
        if u"\udc00" <= s[-1] <= u"\udfff" and len(s) >= 2 and u"\ud800" <= s[-2] <= u"\udbff":
            return ((ord(s[-2])&0x3ff)<<10 | (ord(s[-1])&0x3ff)) + 0x10000
        return ord(s[-1])
    return -1


line, x = os.environ["TM_CURRENT_LINE"], int(os.environ["TM_LINE_INDEX"])
char = unicode(line[:x], "UTF-8")[-1]

if len(char) == 0:
    sys.exit(200)

source1 = "/System/Library/Components/CharacterPalette.component/Contents/SharedSupport/\
CharPaletteServer.app/Contents/Frameworks/CharacterPaletteFramework.framework/Versions/A/Resources/kanji.db"
source2 = "/System/Library/Components/CharacterPalette.component/Contents/SharedSupport/\
CharPaletteServer.app/Contents/Resources/Radical.plist"

res = char + "               : " + unicodedata.name(char, "U+%04X" % ord(char))
print res
if res.find("CJK") != -1:

    # get CJK data from Apple's internal plist
    inp, out = os.popen2("grep -A 9 '" + char + "' " + source2 + " | perl -pe 's/<key>.*?<\/key>//g;s/<.*?>//g;s/\t*//g;' | perl -e 'undef $/;$a=\"%0,\";$a.=<>;$a=~s/(\n)+/\t/mg; $a=~s/.*%(\d+).*?" + char +".*?\t(.*)/$1\t$2/;$a=~s/\x0D//g;print $a'")
    inp.close()
    gdata = unicode(out.read(), "UTF-8")
    out.close()
    if len(gdata):
        ExtStrokeCnt, RadNum, RadName, Rad, RadStrokeCnt, Dummy = gdata.split('\t')
        print "Radical (trad.) : " + Rad + " (" + RadStrokeCnt + u"画 - " + RadName + ") " + RadNum + "." + ExtStrokeCnt
        print "Strokes (trad.) : " + str(int(RadStrokeCnt) + int(ExtStrokeCnt))

    # get all data from Apple's internal UniDict
    inp, out = os.popen2("sqlite3 " + source1 + " 'select * from unihan_dict where uchr=\"" + char + "\";'")
    inp.close()
    uChar, a1, readings, hangul_name_sound, pinyin, zhWubiXing, zhWubiHua, zhBishuBianhao, a2, zhCangjieCh, glyph1, pinyin1, Bopomofo, jaKun, jaOn, pinyin, zhCangjie = unicode(out.read().rstrip(), "UTF-8").split('|')
    out.close()
    if len(readings):
        print "Japanese"
        print "  kun / on      : " + readings

    # get Chinese simplified/traditional equivalent
    inp, out = os.popen2("egrep '^" + char + "' '" + os.environ["TM_BUNDLE_PATH"] + "/support/lib/zhSimTradHanzi.txt'")
    inp.close()
    simtrad = unicode(out.read(), "UTF-8")
    out.close()
    data = ""
    if len(simtrad):
        c1,st,data = simtrad.split('\t')
    if len(pinyin1)+len(Bopomofo)+len(data) > 0:
        print "Chinese"
        if len(data):
            if st == 'T':
                print "  Traditional   : " + data.rstrip()
            if st == 'S':
                print "  Simplified     : " + data.rstrip()
        if len(pinyin1):
            print "  Pinyin        : " + pinyin1
        if len(Bopomofo):
            print "  Zhuyin        : " + Bopomofo
    if len(zhWubiXing):
            print "  Wubi Xing     : " + zhWubiXing
    if len(zhWubiHua):
            print "  Wubi Hua      : " + zhWubiHua
    if len(zhBishuBianhao):
            print "  Bishu Bianhao : " + zhBishuBianhao
    if len(zhCangjie):
            print "  Cang Jie      : " + zhCangjie + " " + zhCangjieCh
    if len(hangul_name_sound):
        print "Korean"
        print "  name <sound>  : " + hangul_name_sound

print "Category        : " + cat[unicodedata.category(char)]
print "Bidirectional   : " + bidi[unicodedata.bidirectional(char)]
print "Combining Class : " + combclass[str(unicodedata.combining(char))]

if unicodedata.mirrored(char) != 0:
    print "Mirrored        : " + str(unicodedata.mirrored(char))

decomp = unicodedata.decomposition(char).strip()
if len(decomp):
    def cDec(x): return unichr(int(x,16))
    def rDec(x): return "%04X" % ord(x)
    clist = decomp.split(' ')
    decomp = "Decomposition   : " + " ".join(map(cDec, clist)) + " (U+" + " U+".join(clist) + ")"
    cflist = list(unicodedata.normalize("NFKD", char))
    if len(clist) != len(cflist):
        print decomp + "; " + " ".join(cflist) + "(U+" + " U+".join(map(rDec, cflist)) + ")"
    else:
        print decomp

print "Codepoints      "
print "  UCS-2 dec/hex : %(val)u / U+%(val)04X "   % {'val': ord(char)}
print "  UTF-8         : %s" % " ".join([hex(ord(c))[2:].upper() for c in char.encode("utf-8")])
