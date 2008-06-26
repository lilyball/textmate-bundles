
import unicodedata

def expandUniCombiningClass(abbr):
    abbr = str(abbr)
    if   abbr == "0":   return "Spacing, split, enclosing, reordrant, and Tibetan subjoined"
    elif abbr == "1":   return "Overlays and interior"
    elif abbr == "7":   return "Nuktas"
    elif abbr == "8":   return "Hiragana/Katakana voicing marks"
    elif abbr == "9":   return "Viramas"
    elif abbr == "10":  return "Start of fixed position classes"
    elif abbr == "199": return "End of fixed position classes"
    elif abbr == "200": return "Below left attached"
    elif abbr == "202": return "Below attached"
    elif abbr == "204": return "Below right attached"
    elif abbr == "208": return "Left attached (reordrant around single base character)"
    elif abbr == "210": return "Right attached"
    elif abbr == "212": return "Above left attached"
    elif abbr == "214": return "Above attached"
    elif abbr == "216": return "Above right attached"
    elif abbr == "218": return "Below left"
    elif abbr == "220": return "Below"
    elif abbr == "222": return "Below right"
    elif abbr == "224": return "Left (reordrant around single base character)"
    elif abbr == "226": return "Right"
    elif abbr == "228": return "Above left"
    elif abbr == "230": return "Above"
    elif abbr == "232": return "Above right"
    elif abbr == "233": return "Double below"
    elif abbr == "234": return "Double above"
    elif abbr == "240": return "Below (iota subscript)"
    else: return ""


def expandUniDirectionClass(abbr):
    if   abbr == "L":   return "Left-to-Right"
    elif abbr == "LRE": return "Left-to-Right Embedding"
    elif abbr == "LRO": return "Left-to-Right Override"
    elif abbr == "R":   return "Right-to-Left"
    elif abbr == "AL":  return "Right-to-Left Arabic"
    elif abbr == "RLE": return "Right-to-Left Embedding"
    elif abbr == "RLO": return "Right-to-Left Override"
    elif abbr == "PDF": return "Pop Directional Format"
    elif abbr == "EN":  return "European Number"
    elif abbr == "ES":  return "European Number Separator"
    elif abbr == "ET":  return "European Number Terminator"
    elif abbr == "AN":  return "Arabic Number"
    elif abbr == "CS":  return "Common Number Separator"
    elif abbr == "NSM": return "Non-Spacing Mark"
    elif abbr == "BN":  return "Boundary Neutral"
    elif abbr == "B":   return "Paragraph Separator"
    elif abbr == "S":   return "Segment Separator"
    elif abbr == "WS":  return "Whitespace"
    elif abbr == "ON":  return "Other Neutrals"
    else: return ""


def expandUniCategories(abbr):
    if   abbr == "Lu": return "Letter, Uppercase"
    elif abbr == "Ll": return "Letter, Lowercase"
    elif abbr == "Lt": return "Letter, Titlecase"
    elif abbr == "Lm": return "Letter, Modelifier"
    elif abbr == "Lo": return "Letter, Other"
    elif abbr == "Mn": return "Mark, Nonspacing"
    elif abbr == "Mc": return "Mark, Spacing Combining"
    elif abbr == "Me": return "Mark, Enclosing"
    elif abbr == "Nd": return "Number, Decimal Digit"
    elif abbr == "Nl": return "Number, Letter"
    elif abbr == "No": return "Number, Other"
    elif abbr == "Pc": return "Punctuation, Connector"
    elif abbr == "Pd": return "Punctuation, Dash"
    elif abbr == "Ps": return "Punctuation, Open"
    elif abbr == "Pe": return "Punctuation, Close"
    elif abbr == "Pi": return "Punctuation, Initial quote (may behave like Ps or Pe depending on usage)"
    elif abbr == "Pf": return "Punctuation, Final quote (may behave like Ps or Pe depending on usage)"
    elif abbr == "Po": return "Punctuation, Other"
    elif abbr == "Sm": return "Symbol, Math"
    elif abbr == "Sc": return "Symbol, Currency"
    elif abbr == "Sk": return "Symbol, Modelifier"
    elif abbr == "So": return "Symbol, Other"
    elif abbr == "Zs": return "Separator, Space"
    elif abbr == "Zl": return "Separator, Line"
    elif abbr == "Zp": return "Separator, Paragraph"
    elif abbr == "Cc": return "Other, Control"
    elif abbr == "Cf": return "Other, Format"
    elif abbr == "Cs": return "Other, Surrogate"
    elif abbr == "Co": return "Other, Private Use"
    elif abbr == "Cn": return "Other, Not Assigned (no characters in the file have this property)"
    else: return ""


def expandUniDecompositionClass(abbr):
    if   abbr == "<font>":    return "A font variant (e.g. a blackletter form)."
    elif abbr == "<noBreak>": return "A no-break version of a space or hyphen."
    elif abbr == "<initial>": return "An initial presentation form (Arabic)."
    elif abbr == "<medial>":  return "A medial presentation form (Arabic)."
    elif abbr == "<final>":   return "A final presentation form (Arabic)."
    elif abbr == "<isolated>":return "An isolated presentation form (Arabic)."
    elif abbr == "<circle>":  return "An encircled form."
    elif abbr == "<super>":   return "A superscript form."
    elif abbr == "<sub>":     return "A subscript form."
    elif abbr == "<vertical>":return "A vertical layout presentation form."
    elif abbr == "<wide>":    return "A wide (or zenkaku) compatibility character."
    elif abbr == "<narrow>":  return "A narrow (or hankaku) compatibility character."
    elif abbr == "<font>":    return "A small variant form (CNS compatibility)."
    elif abbr == "<square>":  return "A CJK squared font variant."
    elif abbr == "<fraction>":return "A vulgar fraction form."
    elif abbr == "<compat>":  return "Otherwise unspecified compatibility character."
    else: return ""


def wunichr(dec):
    """Returns the Unicode glyph for a given decimal representation even if Python is not compile in UCS-4"""
    return ("\\U%08X" % dec).decode("unicode-escape")


def getNameForRange(dec):
    hexcode = " : U+%04X" % dec
    name = ""
    if 0x3400 <= dec <= 0x4DB5:
        return "CJK UNIFIED IDEOGRAPH" + "-%04X" % dec
    elif 0x4E00 <= dec <= 0x9FC3:
        return "CJK UNIFIED IDEOGRAPH" + "-%04X" % dec
    elif 0xAC00 <= dec <= 0xD7A3: # Hangul
        return unicodedata.name(unichr(dec), "U+%04X" % dec)
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
    elif 0x2E80 <= s <= 0x2EFF:
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
    else:
        return "unknown"
