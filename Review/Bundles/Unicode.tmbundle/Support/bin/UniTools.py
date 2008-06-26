
import unicodedata

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


def expandUniCombiningClass(abbr):
    d = {
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
    return d.get(str(abbr), "")


def expandUniDirectionClass(abbr):
    d = {
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
    return d.get(abbr, "")


def expandUniCategories(abbr):
    d = {
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
    return d.get(abbr, "")


def expandUniDecompositionClass(abbr):
    d = {
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
    '<font color=#555555>': 'A small variant form (CNS compatibility).',
    '<square>': 'A CJK squared font variant.',
    '<fraction>': 'A vulgar fraction form.',
    '<compat>': 'Otherwise unspecified compatibility character.',
    }
    return d.get(abbr, "")


def wunichr(dec):
    """Returns the Unicode glyph for a given decimal representation even if Python is not compile in UCS-4"""
    return ("\\U%08X" % dec).decode("unicode-escape")


def wuniord(s):
    if s:
        if u"\udc00" <= s[-1] <= u"\udfff" and len(s) >= 2 and u"\ud800" <= s[-2] <= u"\udbff":
            return (((ord(s[-2])&0x3ff)<<10 | (ord(s[-1])&0x3ff)) + 0x10000)
        return (ord(s[-1]))
    return (-1)


def getNameForRange(dec):
    hexcode = " : U+%04X" % dec
    if 0x3400 <= dec <= 0x4DB5:
        return "CJK UNIFIED IDEOGRAPH" + "-%04X" % dec
    elif 0x4E00 <= dec <= 0x9FC3:
        return "CJK UNIFIED IDEOGRAPH" + "-%04X" % dec
    elif 0xAC00 <= dec <= 0xD7A3: # Hangul
        return unicodedata.name(unichr(dec), hexcode)
    elif 0xD800 <= dec <= 0xDB7F:
        return "Non Private Use High Surrogate" + hexcode
    elif 0xDB80 <= dec <= 0xDBFF:
        return "Private Use High Surrogate" + hexcode
    elif 0xDC00 <= dec <= 0xDFFF:
        return "Low Surrogate" + hexcode
    elif 0xE000 <= dec <= 0xF8FF:
        return "Private Use" + hexcode
    elif 0x20000 <= dec <= 0x2A6D6:
        return "CJK UNIFIED IDEOGRAPH" + "-%04X" % dec
    elif 0xF0000 <= dec <= 0xFFFFD:
        return "Plane 15 Private Use" + hexcode
    elif 0x100000 <= dec <= 0x10FFFD:
        return "Plane 16 Private Use" + hexcode
    else:
        return "not defined"


def getBlockName(s):
    if s < 0x2E80:
        if 0x0000 <= s <= 0x007F:
            return "Basic Latin"
        elif 0x0080 <= s <= 0x00FF:
            return "Latin-1 Supplement"
        elif 0x0100 <= s <= 0x017F:
            return "Latin Extended-A"
        elif 0x0180 <= s <= 0x024F:
            return "Latin Extended-B"
        elif 0x0250 <= s <= 0x02AF:
            return "IPA Extensions"
        elif 0x02B0 <= s <= 0x02FF:
            return "Spacing Modifier Letters"
        elif 0x0300 <= s <= 0x036F:
            return "Combining Diacritical Marks"
        elif 0x0370 <= s <= 0x03FF:
            return "Greek and Coptic"
        elif 0x0400 <= s <= 0x04FF:
            return "Cyrillic"
        elif 0x0500 <= s <= 0x052F:
            return "Cyrillic Supplement"
        elif 0x0530 <= s <= 0x058F:
            return "Armenian"
        elif 0x0590 <= s <= 0x05FF:
            return "Hebrew"
        elif 0x0600 <= s <= 0x06FF:
            return "Arabic"
        elif 0x0700 <= s <= 0x074F:
            return "Syriac"
        elif 0x0750 <= s <= 0x077F:
            return "Arabic Supplement"
        elif 0x0780 <= s <= 0x07BF:
            return "Thaana"
        elif 0x07C0 <= s <= 0x07FF:
            return "NKo"
        elif 0x0900 <= s <= 0x097F:
            return "Devanagari"
        elif 0x0980 <= s <= 0x09FF:
            return "Bengali"
        elif 0x0A00 <= s <= 0x0A7F:
            return "Gurmukhi"
        elif 0x0A80 <= s <= 0x0AFF:
            return "Gujarati"
        elif 0x0B00 <= s <= 0x0B7F:
            return "Oriya"
        elif 0x0B80 <= s <= 0x0BFF:
            return "Tamil"
        elif 0x0C00 <= s <= 0x0C7F:
            return "Telugu"
        elif 0x0C80 <= s <= 0x0CFF:
            return "Kannada"
        elif 0x0D00 <= s <= 0x0D7F:
            return "Malayalam"
        elif 0x0D80 <= s <= 0x0DFF:
            return "Sinhala"
        elif 0x0E00 <= s <= 0x0E7F:
            return "Thai"
        elif 0x0E80 <= s <= 0x0EFF:
            return "Lao"
        elif 0x0F00 <= s <= 0x0FFF:
            return "Tibetan"
        elif 0x1000 <= s <= 0x109F:
            return "Myanmar"
        elif 0x10A0 <= s <= 0x10FF:
            return "Georgian"
        elif 0x1100 <= s <= 0x11FF:
            return "Hangul Jamo"
        elif 0x1200 <= s <= 0x137F:
            return "Ethiopic"
        elif 0x1380 <= s <= 0x139F:
            return "Ethiopic Supplement"
        elif 0x13A0 <= s <= 0x13FF:
            return "Cherokee"
        elif 0x1400 <= s <= 0x167F:
            return "Unified Canadian Aboriginal Syllabics"
        elif 0x1680 <= s <= 0x169F:
            return "Ogham"
        elif 0x16A0 <= s <= 0x16FF:
            return "Runic"
        elif 0x1700 <= s <= 0x171F:
            return "Tagalog"
        elif 0x1720 <= s <= 0x173F:
            return "Hanunoo"
        elif 0x1740 <= s <= 0x175F:
            return "Buhid"
        elif 0x1760 <= s <= 0x177F:
            return "Tagbanwa"
        elif 0x1780 <= s <= 0x17FF:
            return "Khmer"
        elif 0x1800 <= s <= 0x18AF:
            return "Mongolian"
        elif 0x1900 <= s <= 0x194F:
            return "Limbu"
        elif 0x1950 <= s <= 0x197F:
            return "Tai Le"
        elif 0x1980 <= s <= 0x19DF:
            return "New Tai Lue"
        elif 0x19E0 <= s <= 0x19FF:
            return "Khmer Symbols"
        elif 0x1A00 <= s <= 0x1A1F:
            return "Buginese"
        elif 0x1B00 <= s <= 0x1B7F:
            return "Balinese"
        elif 0x1B80 <= s <= 0x1BBF:
            return "Sundanese"
        elif 0x1C00 <= s <= 0x1C4F:
            return "Lepcha"
        elif 0x1C50 <= s <= 0x1C7F:
            return "Ol Chiki"
        elif 0x1D00 <= s <= 0x1D7F:
            return "Phonetic Extensions"
        elif 0x1D80 <= s <= 0x1DBF:
            return "Phonetic Extensions Supplement"
        elif 0x1DC0 <= s <= 0x1DFF:
            return "Combining Diacritical Marks Supplement"
        elif 0x1E00 <= s <= 0x1EFF:
            return "Latin Extended Additional"
        elif 0x1F00 <= s <= 0x1FFF:
            return "Greek Extended"
        elif 0x2000 <= s <= 0x206F:
            return "General Punctuation"
        elif 0x2070 <= s <= 0x209F:
            return "Superscripts and Subscripts"
        elif 0x20A0 <= s <= 0x20CF:
            return "Currency Symbols"
        elif 0x20D0 <= s <= 0x20FF:
            return "Combining Diacritical Marks for Symbols"
        elif 0x2100 <= s <= 0x214F:
            return "Letterlike Symbols"
        elif 0x2150 <= s <= 0x218F:
            return "Number Forms"
        elif 0x2190 <= s <= 0x21FF:
            return "Arrows"
        elif 0x2200 <= s <= 0x22FF:
            return "Mathematical Operators"
        elif 0x2300 <= s <= 0x23FF:
            return "Miscellaneous Technical"
        elif 0x2400 <= s <= 0x243F:
            return "Control Pictures"
        elif 0x2440 <= s <= 0x245F:
            return "Optical Character Recognition"
        elif 0x2460 <= s <= 0x24FF:
            return "Enclosed Alphanumerics"
        elif 0x2500 <= s <= 0x257F:
            return "Box Drawing"
        elif 0x2580 <= s <= 0x259F:
            return "Block Elements"
        elif 0x25A0 <= s <= 0x25FF:
            return "Geometric Shapes"
        elif 0x2600 <= s <= 0x26FF:
            return "Miscellaneous Symbols"
        elif 0x2700 <= s <= 0x27BF:
            return "Dingbats"
        elif 0x27C0 <= s <= 0x27EF:
            return "Miscellaneous Mathematical Symbols-A"
        elif 0x27F0 <= s <= 0x27FF:
            return "Supplemental Arrows-A"
        elif 0x2800 <= s <= 0x28FF:
            return "Braille Patterns"
        elif 0x2900 <= s <= 0x297F:
            return "Supplemental Arrows-B"
        elif 0x2980 <= s <= 0x29FF:
            return "Miscellaneous Mathematical Symbols-B"
        elif 0x2A00 <= s <= 0x2AFF:
            return "Supplemental Mathematical Operators"
        elif 0x2B00 <= s <= 0x2BFF:
            return "Miscellaneous Symbols and Arrows"
        elif 0x2C00 <= s <= 0x2C5F:
            return "Glagolitic"
        elif 0x2C60 <= s <= 0x2C7F:
            return "Latin Extended-C"
        elif 0x2C80 <= s <= 0x2CFF:
            return "Coptic"
        elif 0x2D00 <= s <= 0x2D2F:
            return "Georgian Supplement"
        elif 0x2D30 <= s <= 0x2D7F:
            return "Tifinagh"
        elif 0x2D80 <= s <= 0x2DDF:
            return "Ethiopic Extended"
        elif 0x2DE0 <= s <= 0x2DFF:
            return "Cyrillic Extended-A"
        elif 0x2E00 <= s <= 0x2E7F:
            return "Supplemental Punctuation"
    else:
        if 0x2E80 <= s <= 0x2EFF:
            return "CJK Radicals Supplement"
        elif 0x2F00 <= s <= 0x2FDF:
            return "Kangxi Radicals"
        elif 0x2FF0 <= s <= 0x2FFF:
            return "Ideographic Description Characters"
        elif 0x3000 <= s <= 0x303F:
            return "CJK Symbols and Punctuation"
        elif 0x3040 <= s <= 0x309F:
            return "Hiragana"
        elif 0x30A0 <= s <= 0x30FF:
            return "Katakana"
        elif 0x3100 <= s <= 0x312F:
            return "Bopomofo"
        elif 0x3130 <= s <= 0x318F:
            return "Hangul Compatibility Jamo"
        elif 0x3190 <= s <= 0x319F:
            return "Kanbun"
        elif 0x31A0 <= s <= 0x31BF:
            return "Bopomofo Extended"
        elif 0x31C0 <= s <= 0x31EF:
            return "CJK Strokes"
        elif 0x31F0 <= s <= 0x31FF:
            return "Katakana Phonetic Extensions"
        elif 0x3200 <= s <= 0x32FF:
            return "Enclosed CJK Letters and Months"
        elif 0x3300 <= s <= 0x33FF:
            return "CJK Compatibility"
        elif 0x3400 <= s <= 0x4DBF:
            return "CJK Unified Ideographs Extension A"
        elif 0x4DC0 <= s <= 0x4DFF:
            return "Yijing Hexagram Symbols"
        elif 0x4E00 <= s <= 0x9FFF:
            return "CJK Unified Ideographs"
        elif 0xA000 <= s <= 0xA48F:
            return "Yi Syllables"
        elif 0xA490 <= s <= 0xA4CF:
            return "Yi Radicals"
        elif 0xA500 <= s <= 0xA63F:
            return "Vai"
        elif 0xA640 <= s <= 0xA69F:
            return "Cyrillic Extended-B"
        elif 0xA700 <= s <= 0xA71F:
            return "Modifier Tone Letters"
        elif 0xA720 <= s <= 0xA7FF:
            return "Latin Extended-D"
        elif 0xA800 <= s <= 0xA82F:
            return "Syloti Nagri"
        elif 0xA840 <= s <= 0xA87F:
            return "Phags-pa"
        elif 0xA880 <= s <= 0xA8DF:
            return "Saurashtra"
        elif 0xA900 <= s <= 0xA92F:
            return "Kayah Li"
        elif 0xA930 <= s <= 0xA95F:
            return "Rejang"
        elif 0xAA00 <= s <= 0xAA5F:
            return "Cham"
        elif 0xAC00 <= s <= 0xD7AF:
            return "Hangul Syllables"
        elif 0xD800 <= s <= 0xDB7F:
            return "High Surrogates"
        elif 0xDB80 <= s <= 0xDBFF:
            return "High Private Use Surrogates"
        elif 0xDC00 <= s <= 0xDFFF:
            return "Low Surrogates"
        elif 0xE000 <= s <= 0xF8FF:
            return "Private Use Area"
        elif 0xF900 <= s <= 0xFAFF:
            return "CJK Compatibility Ideographs"
        elif 0xFB00 <= s <= 0xFB4F:
            return "Alphabetic Presentation Forms"
        elif 0xFB50 <= s <= 0xFDFF:
            return "Arabic Presentation Forms-A"
        elif 0xFE00 <= s <= 0xFE0F:
            return "Variation Selectors"
        elif 0xFE10 <= s <= 0xFE1F:
            return "Vertical Forms"
        elif 0xFE20 <= s <= 0xFE2F:
            return "Combining Half Marks"
        elif 0xFE30 <= s <= 0xFE4F:
            return "CJK Compatibility Forms"
        elif 0xFE50 <= s <= 0xFE6F:
            return "Small Form Variants"
        elif 0xFE70 <= s <= 0xFEFF:
            return "Arabic Presentation Forms-B"
        elif 0xFF00 <= s <= 0xFFEF:
            return "Halfwidth and Fullwidth Forms"
        elif 0xFFF0 <= s <= 0xFFFF:
            return "Specials"
        elif 0x10000 <= s <= 0x1007F:
            return "Linear B Syllabary"
        elif 0x10080 <= s <= 0x100FF:
            return "Linear B Ideograms"
        elif 0x10100 <= s <= 0x1013F:
            return "Aegean Numbers"
        elif 0x10140 <= s <= 0x1018F:
            return "Ancient Greek Numbers"
        elif 0x10190 <= s <= 0x101CF:
            return "Ancient Symbols"
        elif 0x101D0 <= s <= 0x101FF:
            return "Phaistos Disc"
        elif 0x10280 <= s <= 0x1029F:
            return "Lycian"
        elif 0x102A0 <= s <= 0x102DF:
            return "Carian"
        elif 0x10300 <= s <= 0x1032F:
            return "Old Italic"
        elif 0x10330 <= s <= 0x1034F:
            return "Gothic"
        elif 0x10380 <= s <= 0x1039F:
            return "Ugaritic"
        elif 0x103A0 <= s <= 0x103DF:
            return "Old Persian"
        elif 0x10400 <= s <= 0x1044F:
            return "Deseret"
        elif 0x10450 <= s <= 0x1047F:
            return "Shavian"
        elif 0x10480 <= s <= 0x104AF:
            return "Osmanya"
        elif 0x10800 <= s <= 0x1083F:
            return "Cypriot Syllabary"
        elif 0x10900 <= s <= 0x1091F:
            return "Phoenician"
        elif 0x10920 <= s <= 0x1093F:
            return "Lydian"
        elif 0x10A00 <= s <= 0x10A5F:
            return "Kharoshthi"
        elif 0x12000 <= s <= 0x123FF:
            return "Cuneiform"
        elif 0x12400 <= s <= 0x1247F:
            return "Cuneiform Numbers and Punctuation"
        elif 0x1D000 <= s <= 0x1D0FF:
            return "Byzantine Musical Symbols"
        elif 0x1D100 <= s <= 0x1D1FF:
            return "Musical Symbols"
        elif 0x1D200 <= s <= 0x1D24F:
            return "Ancient Greek Musical Notation"
        elif 0x1D300 <= s <= 0x1D35F:
            return "Tai Xuan Jing Symbols"
        elif 0x1D360 <= s <= 0x1D37F:
            return "Counting Rod Numerals"
        elif 0x1D400 <= s <= 0x1D7FF:
            return "Mathematical Alphanumeric Symbols"
        elif 0x1F000 <= s <= 0x1F02F:
            return "Mahjong Tiles"
        elif 0x1F030 <= s <= 0x1F09F:
            return "Domino Tiles"
        elif 0x20000 <= s <= 0x2A6DF:
            return "CJK Unified Ideographs Extension B"
        elif 0x2F800 <= s <= 0x2FA1F:
            return "CJK Compatibility Ideographs Supplement"
        elif 0xE0000 <= s <= 0xE007F:
            return "Tags"
        elif 0xE0100 <= s <= 0xE01EF:
            return "Variation Selectors Supplement"
        elif 0xF0000 <= s <= 0xFFFFF:
            return "Supplementary Private Use Area-A"
        elif 0x100000 <= s <= 0x10FFFF:
            return "Supplementary Private Use Area-B"
    return "unknown"
