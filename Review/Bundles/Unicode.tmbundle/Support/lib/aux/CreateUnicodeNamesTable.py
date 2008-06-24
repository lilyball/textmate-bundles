#!/usr/bin/python
# encoding: utf-8

import sys
import os
import codecs
import unicodedata
import zipfile

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

bundleLibPath = os.environ["TM_BUNDLE_SUPPORT"] + "/lib/"

sourceFile = "UnicodeData.txt.zip"

def wunichr(dec):
   return ("\\U%08X" % dec).decode("unicode-escape")

f = zipfile.ZipFile(bundleLibPath + "UnicodeData.txt.zip", "r")
data = f.read("UnicodeData.txt").encode("UTF-8")
f.close()

for line in data.split('\n'):
    token = line.split(";")
    dec = int(token[0],16)
    if 44032 <= dec <=55203:
        for hangul in range(44032,55204):
            print unichr(hangul) + "\t" + unicodedata.name(unichr(hangul))
    else:
        if token[1][0] != '<' and not "COMPATIBILITY IDEOGRAPH" in token[1] and not "VARIATION SELECTOR" in token[1]:
            d = (wunichr(int(token[0],16)) + "\t" + token[1])
            print d
