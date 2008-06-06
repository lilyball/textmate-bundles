#!/usr/bin/python
# encoding: utf-8

import sys
import os
import codecs

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

bundleLibPath = os.environ["TM_BUNDLE_PATH"] + "/Support/lib/"

def wunichr(dec):
    return eval('u"\U%08X"' % dec)

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

if len(sys.argv) != 2:
    print "No argument given!"
    sys.exit(206)

direction = sys.argv[1]
if not (direction == 'toFull' or direction == 'toHalf'):
    print "Wrong argument. Only 'toFull' or 'toHalf'."
    sys.exit(206)

text = sys.stdin.read()

convData = codecs.open( bundleLibPath +"HanZenKaku.txt", "r", "UTF-8" )
halffull = convData.read().strip()

if not halffull:
    print "File error for HanZenKaku.txt"
    sys.exit(206)

conv = {}

for c in halffull.split('\n'):
    half, full = c.split('\t')
    if direction == 'toFull':
        conv[half] = full
    else:
        conv[full] = half

for c in codepoints(text):
    try:
        half = conv[wunichr(c)]
        sys.stdout.write(half)
    except:
        sys.stdout.write(wunichr(c))

sys.exit(201)
