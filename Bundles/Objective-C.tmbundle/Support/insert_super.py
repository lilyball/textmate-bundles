#!/usr/bin/env python

"""Inserts a [super method] call suitable for the current method.
   Inserted as a snippet with the incoming arguments used as defaults.

   The default behavior is to add brackets if there is no "[" to the left
   of the caret (ignoring the tab trigger). This can be changed by modifying
   the useBrackets line below.

   The command uses heuristics to find which method implementation is
   being edited. It should be reasonably tolerant to various coding styles,
   including different bracket and indentation styles.
"""

import sys, os, re, itertools

try:
    useBrackets = sys.argv[1]
except IndexError:
    useBrackets = "automatic"	# "always", "never"

try:
    postfix = sys.argv[2]
except (KeyError,), ex:
    postfix = ""

protoRe = re.compile(r"^\s*(\+|-)\s*\([^)]+\)((\n|[^{])*)[^;]\{", re.M)

nlines = int(os.environ["TM_LINE_NUMBER"])-1
interestingLines = [l for (count, l) in itertools.takewhile(lambda (n, l): n <= nlines, enumerate(sys.stdin))]
invokationLine = interestingLines[-1]

if useBrackets == "automatic":
	needsBracket = invokationLine[int(os.environ["TM_LINE_INDEX"])-1] != '['
elif useBrackets == "always":
	needsBracket = True
else:
	needsBracket = False

protos = protoRe.findall(''.join(interestingLines))

if len(protos) == 0:
    sys.exit(1)

lastProtoSelWithTypes = re.sub(r'\s+', ' ', protos[-1][1])

counter = itertools.count(1)
def replFunc(match):
    return '${%i:%s}' % (counter.next(), match.groups()[0])

methodCall = re.sub(r'\([^)]+\)\s*(([A-Za-z0-9_][A-Za-z0-9_]*))', replFunc, lastProtoSelWithTypes)

brackets = needsBracket and ('[', ']') or ('', '')
outString = '%ssuper %s%s%s' % (brackets[0], methodCall.strip(), brackets[1], postfix)

sys.stdout.write(outString)
