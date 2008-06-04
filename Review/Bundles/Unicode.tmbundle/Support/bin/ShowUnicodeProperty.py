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

charIsPaneB = 0

if "TM_SELECTED_TEXT" in os.environ:
    sys.exit(200)

def lastCharInUCSdec(s):
    if s:
        if u"\udc00" <= s[-1] <= u"\udfff" and len(s) >= 2 and u"\ud800" <= s[-2] <= u"\udbff":
            global charIsPaneB
            charIsPaneB = 1
            return ((ord(s[-2])&0x3ff)<<10 | (ord(s[-1])&0x3ff)) + 0x10000
        return ord(s[-1])
    return -1


line, x = os.environ["TM_CURRENT_LINE"], int(os.environ["TM_LINE_INDEX"])

lastCharDecCode = lastCharInUCSdec(unicode(line[:x], "UTF-8"))
char = eval('u"\U' + "%08X" % lastCharInUCSdec(unicode(line[:x], "UTF-8")) + '"')
lastCharUCShexCode = "%04X" % lastCharDecCode

if len(char) == 0:
    sys.exit(200)

source1 = "/System/Library/Components/CharacterPalette.component/Contents/SharedSupport/\
CharPaletteServer.app/Contents/Frameworks/CharacterPaletteFramework.framework/Versions/A/Resources/kanji.db"
source2 = "/System/Library/Components/CharacterPalette.component/Contents/SharedSupport/\
CharPaletteServer.app/Contents/Resources/Radical.plist"

bundleLibPath = os.environ["TM_BUNDLE_PATH"] + "/Support/lib/"

inp, out = os.popen2("zgrep '^" + lastCharUCShexCode + "' '" + bundleLibPath + "UnicodeData.txt.zip'")
inp.close()
UnicodeData = unicode(out.read(), "UTF-8")
out.close()
if len(UnicodeData) == 0:
    if 0x3400 <= lastCharDecCode <= 0x4DB5:
        name = "CJK Ideograph Extension A : U+" + lastCharUCShexCode
    if 0x4E00 <= lastCharDecCode <= 0x9FC3:
        name = "CJK Ideograph : U+" + lastCharUCShexCode
    if 0xAC00 <= lastCharDecCode <= 0xD7A3: # Hangul
        name = unicodedata.name(char, "U+%04X" % ord(char))
    if 0xD800 <= lastCharDecCode <= 0xDB7F:
        name = "Non Private Use High Surrogate : U+" + lastCharUCShexCode
    if 0xDB80 <= lastCharDecCode <= 0xDBFF:
        name = "Private Use High Surrogate : U+" + lastCharUCShexCode
    if 0xDC00 <= lastCharDecCode <= 0xDFFF:
        name = "Low Surrogate : U+" + lastCharUCShexCode
    if 0xE000 <= lastCharDecCode <= 0xF8FF:
        name = "Private Use : U+" + lastCharUCShexCode
    if 0x20000 <= lastCharDecCode <= 0x2A6D6:
        name = "CJK Ideograph Extension B : U+" + lastCharUCShexCode
    if 0xF0000 <= lastCharDecCode <= 0xFFFFD:
        name = "Plane 15 Private Use : U+" + lastCharUCShexCode
    if 0x100000 <= lastCharDecCode <= 0x10FFFD:
        name = "Plane 16 Private Use : U+" + lastCharUCShexCode

else:
    dummy1,name,category,combingclass,bidiinfo,decomposition,numtype,bidimirror,oldname,comment,upcase,lowcase,titlecase,dummy2,dummy3 = UnicodeData.split(';')

def getBlockName(s):
    if 0x0000 <= s <= 0x007F:
        block = "Basic Latin"
    if 0x0080 <= s <= 0x00FF:
        block = "Latin-1 Supplement"
    if 0x0100 <= s <= 0x017F:
        block = "Latin Extended-A"
    if 0x0180 <= s <= 0x024F:
        block = "Latin Extended-B"
    if 0x0250 <= s <= 0x02AF:
        block = "IPA Extensions"
    if 0x02B0 <= s <= 0x02FF:
        block = "Spacing Modifier Letters"
    if 0x0300 <= s <= 0x036F:
        block = "Combining Diacritical Marks"
    if 0x0370 <= s <= 0x03FF:
        block = "Greek and Coptic"
    if 0x0400 <= s <= 0x04FF:
        block = "Cyrillic"
    if 0x0500 <= s <= 0x052F:
        block = "Cyrillic Supplement"
    if 0x0530 <= s <= 0x058F:
        block = "Armenian"
    if 0x0590 <= s <= 0x05FF:
        block = "Hebrew"
    if 0x0600 <= s <= 0x06FF:
        block = "Arabic"
    if 0x0700 <= s <= 0x074F:
        block = "Syriac"
    if 0x0750 <= s <= 0x077F:
        block = "Arabic Supplement"
    if 0x0780 <= s <= 0x07BF:
        block = "Thaana"
    if 0x07C0 <= s <= 0x07FF:
        block = "NKo"
    if 0x0900 <= s <= 0x097F:
        block = "Devanagari"
    if 0x0980 <= s <= 0x09FF:
        block = "Bengali"
    if 0x0A00 <= s <= 0x0A7F:
        block = "Gurmukhi"
    if 0x0A80 <= s <= 0x0AFF:
        block = "Gujarati"
    if 0x0B00 <= s <= 0x0B7F:
        block = "Oriya"
    if 0x0B80 <= s <= 0x0BFF:
        block = "Tamil"
    if 0x0C00 <= s <= 0x0C7F:
        block = "Telugu"
    if 0x0C80 <= s <= 0x0CFF:
        block = "Kannada"
    if 0x0D00 <= s <= 0x0D7F:
        block = "Malayalam"
    if 0x0D80 <= s <= 0x0DFF:
        block = "Sinhala"
    if 0x0E00 <= s <= 0x0E7F:
        block = "Thai"
    if 0x0E80 <= s <= 0x0EFF:
        block = "Lao"
    if 0x0F00 <= s <= 0x0FFF:
        block = "Tibetan"
    if 0x1000 <= s <= 0x109F:
        block = "Myanmar"
    if 0x10A0 <= s <= 0x10FF:
        block = "Georgian"
    if 0x1100 <= s <= 0x11FF:
        block = "Hangul Jamo"
    if 0x1200 <= s <= 0x137F:
        block = "Ethiopic"
    if 0x1380 <= s <= 0x139F:
        block = "Ethiopic Supplement"
    if 0x13A0 <= s <= 0x13FF:
        block = "Cherokee"
    if 0x1400 <= s <= 0x167F:
        block = "Unified Canadian Aboriginal Syllabics"
    if 0x1680 <= s <= 0x169F:
        block = "Ogham"
    if 0x16A0 <= s <= 0x16FF:
        block = "Runic"
    if 0x1700 <= s <= 0x171F:
        block = "Tagalog"
    if 0x1720 <= s <= 0x173F:
        block = "Hanunoo"
    if 0x1740 <= s <= 0x175F:
        block = "Buhid"
    if 0x1760 <= s <= 0x177F:
        block = "Tagbanwa"
    if 0x1780 <= s <= 0x17FF:
        block = "Khmer"
    if 0x1800 <= s <= 0x18AF:
        block = "Mongolian"
    if 0x1900 <= s <= 0x194F:
        block = "Limbu"
    if 0x1950 <= s <= 0x197F:
        block = "Tai Le"
    if 0x1980 <= s <= 0x19DF:
        block = "New Tai Lue"
    if 0x19E0 <= s <= 0x19FF:
        block = "Khmer Symbols"
    if 0x1A00 <= s <= 0x1A1F:
        block = "Buginese"
    if 0x1B00 <= s <= 0x1B7F:
        block = "Balinese"
    if 0x1B80 <= s <= 0x1BBF:
        block = "Sundanese"
    if 0x1C00 <= s <= 0x1C4F:
        block = "Lepcha"
    if 0x1C50 <= s <= 0x1C7F:
        block = "Ol Chiki"
    if 0x1D00 <= s <= 0x1D7F:
        block = "Phonetic Extensions"
    if 0x1D80 <= s <= 0x1DBF:
        block = "Phonetic Extensions Supplement"
    if 0x1DC0 <= s <= 0x1DFF:
        block = "Combining Diacritical Marks Supplement"
    if 0x1E00 <= s <= 0x1EFF:
        block = "Latin Extended Additional"
    if 0x1F00 <= s <= 0x1FFF:
        block = "Greek Extended"
    if 0x2000 <= s <= 0x206F:
        block = "General Punctuation"
    if 0x2070 <= s <= 0x209F:
        block = "Superscripts and Subscripts"
    if 0x20A0 <= s <= 0x20CF:
        block = "Currency Symbols"
    if 0x20D0 <= s <= 0x20FF:
        block = "Combining Diacritical Marks for Symbols"
    if 0x2100 <= s <= 0x214F:
        block = "Letterlike Symbols"
    if 0x2150 <= s <= 0x218F:
        block = "Number Forms"
    if 0x2190 <= s <= 0x21FF:
        block = "Arrows"
    if 0x2200 <= s <= 0x22FF:
        block = "Mathematical Operators"
    if 0x2300 <= s <= 0x23FF:
        block = "Miscellaneous Technical"
    if 0x2400 <= s <= 0x243F:
        block = "Control Pictures"
    if 0x2440 <= s <= 0x245F:
        block = "Optical Character Recognition"
    if 0x2460 <= s <= 0x24FF:
        block = "Enclosed Alphanumerics"
    if 0x2500 <= s <= 0x257F:
        block = "Box Drawing"
    if 0x2580 <= s <= 0x259F:
        block = "Block Elements"
    if 0x25A0 <= s <= 0x25FF:
        block = "Geometric Shapes"
    if 0x2600 <= s <= 0x26FF:
        block = "Miscellaneous Symbols"
    if 0x2700 <= s <= 0x27BF:
        block = "Dingbats"
    if 0x27C0 <= s <= 0x27EF:
        block = "Miscellaneous Mathematical Symbols-A"
    if 0x27F0 <= s <= 0x27FF:
        block = "Supplemental Arrows-A"
    if 0x2800 <= s <= 0x28FF:
        block = "Braille Patterns"
    if 0x2900 <= s <= 0x297F:
        block = "Supplemental Arrows-B"
    if 0x2980 <= s <= 0x29FF:
        block = "Miscellaneous Mathematical Symbols-B"
    if 0x2A00 <= s <= 0x2AFF:
        block = "Supplemental Mathematical Operators"
    if 0x2B00 <= s <= 0x2BFF:
        block = "Miscellaneous Symbols and Arrows"
    if 0x2C00 <= s <= 0x2C5F:
        block = "Glagolitic"
    if 0x2C60 <= s <= 0x2C7F:
        block = "Latin Extended-C"
    if 0x2C80 <= s <= 0x2CFF:
        block = "Coptic"
    if 0x2D00 <= s <= 0x2D2F:
        block = "Georgian Supplement"
    if 0x2D30 <= s <= 0x2D7F:
        block = "Tifinagh"
    if 0x2D80 <= s <= 0x2DDF:
        block = "Ethiopic Extended"
    if 0x2DE0 <= s <= 0x2DFF:
        block = "Cyrillic Extended-A"
    if 0x2E00 <= s <= 0x2E7F:
        block = "Supplemental Punctuation"
    if 0x2E80 <= s <= 0x2EFF:
        block = "CJK Radicals Supplement"
    if 0x2F00 <= s <= 0x2FDF:
        block = "Kangxi Radicals"
    if 0x2FF0 <= s <= 0x2FFF:
        block = "Ideographic Description Characters"
    if 0x3000 <= s <= 0x303F:
        block = "CJK Symbols and Punctuation"
    if 0x3040 <= s <= 0x309F:
        block = "Hiragana"
    if 0x30A0 <= s <= 0x30FF:
        block = "Katakana"
    if 0x3100 <= s <= 0x312F:
        block = "Bopomofo"
    if 0x3130 <= s <= 0x318F:
        block = "Hangul Compatibility Jamo"
    if 0x3190 <= s <= 0x319F:
        block = "Kanbun"
    if 0x31A0 <= s <= 0x31BF:
        block = "Bopomofo Extended"
    if 0x31C0 <= s <= 0x31EF:
        block = "CJK Strokes"
    if 0x31F0 <= s <= 0x31FF:
        block = "Katakana Phonetic Extensions"
    if 0x3200 <= s <= 0x32FF:
        block = "Enclosed CJK Letters and Months"
    if 0x3300 <= s <= 0x33FF:
        block = "CJK Compatibility"
    if 0x3400 <= s <= 0x4DBF:
        block = "CJK Unified Ideographs Extension A"
    if 0x4DC0 <= s <= 0x4DFF:
        block = "Yijing Hexagram Symbols"
    if 0x4E00 <= s <= 0x9FFF:
        block = "CJK Unified Ideographs"
    if 0xA000 <= s <= 0xA48F:
        block = "Yi Syllables"
    if 0xA490 <= s <= 0xA4CF:
        block = "Yi Radicals"
    if 0xA500 <= s <= 0xA63F:
        block = "Vai"
    if 0xA640 <= s <= 0xA69F:
        block = "Cyrillic Extended-B"
    if 0xA700 <= s <= 0xA71F:
        block = "Modifier Tone Letters"
    if 0xA720 <= s <= 0xA7FF:
        block = "Latin Extended-D"
    if 0xA800 <= s <= 0xA82F:
        block = "Syloti Nagri"
    if 0xA840 <= s <= 0xA87F:
        block = "Phags-pa"
    if 0xA880 <= s <= 0xA8DF:
        block = "Saurashtra"
    if 0xA900 <= s <= 0xA92F:
        block = "Kayah Li"
    if 0xA930 <= s <= 0xA95F:
        block = "Rejang"
    if 0xAA00 <= s <= 0xAA5F:
        block = "Cham"
    if 0xAC00 <= s <= 0xD7AF:
        block = "Hangul Syllables"
    if 0xD800 <= s <= 0xDB7F:
        block = "High Surrogates"
    if 0xDB80 <= s <= 0xDBFF:
        block = "High Private Use Surrogates"
    if 0xDC00 <= s <= 0xDFFF:
        block = "Low Surrogates"
    if 0xE000 <= s <= 0xF8FF:
        block = "Private Use Area"
    if 0xF900 <= s <= 0xFAFF:
        block = "CJK Compatibility Ideographs"
    if 0xFB00 <= s <= 0xFB4F:
        block = "Alphabetic Presentation Forms"
    if 0xFB50 <= s <= 0xFDFF:
        block = "Arabic Presentation Forms-A"
    if 0xFE00 <= s <= 0xFE0F:
        block = "Variation Selectors"
    if 0xFE10 <= s <= 0xFE1F:
        block = "Vertical Forms"
    if 0xFE20 <= s <= 0xFE2F:
        block = "Combining Half Marks"
    if 0xFE30 <= s <= 0xFE4F:
        block = "CJK Compatibility Forms"
    if 0xFE50 <= s <= 0xFE6F:
        block = "Small Form Variants"
    if 0xFE70 <= s <= 0xFEFF:
        block = "Arabic Presentation Forms-B"
    if 0xFF00 <= s <= 0xFFEF:
        block = "Halfwidth and Fullwidth Forms"
    if 0xFFF0 <= s <= 0xFFFF:
        block = "Specials"
    if 0x10000 <= s <= 0x1007F:
        block = "Linear B Syllabary"
    if 0x10080 <= s <= 0x100FF:
        block = "Linear B Ideograms"
    if 0x10100 <= s <= 0x1013F:
        block = "Aegean Numbers"
    if 0x10140 <= s <= 0x1018F:
        block = "Ancient Greek Numbers"
    if 0x10190 <= s <= 0x101CF:
        block = "Ancient Symbols"
    if 0x101D0 <= s <= 0x101FF:
        block = "Phaistos Disc"
    if 0x10280 <= s <= 0x1029F:
        block = "Lycian"
    if 0x102A0 <= s <= 0x102DF:
        block = "Carian"
    if 0x10300 <= s <= 0x1032F:
        block = "Old Italic"
    if 0x10330 <= s <= 0x1034F:
        block = "Gothic"
    if 0x10380 <= s <= 0x1039F:
        block = "Ugaritic"
    if 0x103A0 <= s <= 0x103DF:
        block = "Old Persian"
    if 0x10400 <= s <= 0x1044F:
        block = "Deseret"
    if 0x10450 <= s <= 0x1047F:
        block = "Shavian"
    if 0x10480 <= s <= 0x104AF:
        block = "Osmanya"
    if 0x10800 <= s <= 0x1083F:
        block = "Cypriot Syllabary"
    if 0x10900 <= s <= 0x1091F:
        block = "Phoenician"
    if 0x10920 <= s <= 0x1093F:
        block = "Lydian"
    if 0x10A00 <= s <= 0x10A5F:
        block = "Kharoshthi"
    if 0x12000 <= s <= 0x123FF:
        block = "Cuneiform"
    if 0x12400 <= s <= 0x1247F:
        block = "Cuneiform Numbers and Punctuation"
    if 0x1D000 <= s <= 0x1D0FF:
        block = "Byzantine Musical Symbols"
    if 0x1D100 <= s <= 0x1D1FF:
        block = "Musical Symbols"
    if 0x1D200 <= s <= 0x1D24F:
        block = "Ancient Greek Musical Notation"
    if 0x1D300 <= s <= 0x1D35F:
        block = "Tai Xuan Jing Symbols"
    if 0x1D360 <= s <= 0x1D37F:
        block = "Counting Rod Numerals"
    if 0x1D400 <= s <= 0x1D7FF:
        block = "Mathematical Alphanumeric Symbols"
    if 0x1F000 <= s <= 0x1F02F:
        block = "Mahjong Tiles"
    if 0x1F030 <= s <= 0x1F09F:
        block = "Domino Tiles"
    if 0x20000 <= s <= 0x2A6DF:
        block = "CJK Unified Ideographs Extension B"
    if 0x2F800 <= s <= 0x2FA1F:
        block = "CJK Compatibility Ideographs Supplement"
    if 0xE0000 <= s <= 0xE007F:
        block = "Tags"
    if 0xE0100 <= s <= 0xE01EF:
        block = "Variation Selectors Supplement"
    if 0xF0000 <= s <= 0xFFFFF:
        block = "Supplementary Private Use Area-A"
    if 0x100000 <= s <= 0x10FFFF:
        block = "Supplementary Private Use Area-B"
    return block


if charIsPaneB:
    res = char + "               : CJK U+" + lastCharUCShexCode
else:
    res = char + "               : " + unicodedata.name(char, "U+%04X" % ord(char))
print res
print "Unicode Block   : " + getBlockName(lastCharDecCode)

if res.find("CJK") != -1 and not charIsPaneB:

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
    inp, out = os.popen2("egrep '^" + char + "' '" + bundleLibPath + "zhSimTradHanzi.txt'")
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

if not charIsPaneB:
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
print "  UCS-2 dec/hex : " + str(lastCharDecCode) + " / U+" + lastCharUCShexCode 
print "  UTF-8         : %s" % " ".join([hex(ord(c))[2:].upper() for c in char.encode("utf-8")])
