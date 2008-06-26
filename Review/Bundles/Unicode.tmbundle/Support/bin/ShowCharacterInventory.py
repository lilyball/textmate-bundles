#!/usr/bin/python
# encoding: utf-8

import sys
import os
import codecs
import unicodedata
from UniTools import *

sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)

bundleLibPath = os.environ["TM_BUNDLE_SUPPORT"] + "/lib/"

text = list(codepoints(sys.stdin.read()))
if not text: sys.exit(200)

print """<html>
<head><title>Character Inventory</title>
<script type='text/javascript'>//<![CDATA[
function sortTable2(col) {
  var tblEl = document.getElementById('theTable');
  if (tblEl.reverseSort == null)
    tblEl.reverseSort = new Array();
  if (col == tblEl.lastColumn)
    tblEl.reverseSort[col] = !tblEl.reverseSort[col];
  tblEl.lastColumn = col;
  var oldDsply = tblEl.style.display;
  tblEl.style.display = 'none';
  var tmpEl;
  var i, j;
  var minVal, minIdx;
  var testVal;
  var cmp;
  for (i = 0; i < tblEl.rows.length - 1; i++) {
    minIdx = i;
    minVal = getTextValue(tblEl.rows[i].cells[col]);
    for (j = i + 1; j < tblEl.rows.length; j++) {
      testVal = getTextValue(tblEl.rows[j].cells[col]);
      cmp = compareValues(minVal, testVal);
      if (tblEl.reverseSort[col])
        cmp = -cmp;
      if (cmp > 0) {
        minIdx = j;
        minVal = testVal;
      }
    }
    if (minIdx > i) {
      tmpEl = tblEl.removeChild(tblEl.rows[minIdx]);
      tblEl.insertBefore(tmpEl, tblEl.rows[i]);
    }
  }
  tblEl.style.display = oldDsply;
  return false;
}
if (document.ELEMENT_NODE == null) {
  document.ELEMENT_NODE = 1;
  document.TEXT_NODE = 3;
}
function getTextValue(el) {
  var i;
  var s;
  s = '';
  for (i = 0; i < el.childNodes.length; i++)
    if (el.childNodes[i].nodeType == document.TEXT_NODE)
      s += el.childNodes[i].nodeValue;
    else if (el.childNodes[i].nodeType == document.ELEMENT_NODE &&
             el.childNodes[i].tagName == 'BR')
      s += ' ';
    else
      s += getTextValue(el.childNodes[i]);
  return normalizeString(s);
}
function compareValues(v1, v2) {
  var f1, f2;
  f1 = parseFloat(v1);
  f2 = parseFloat(v2);
  if (!isNaN(f1) && !isNaN(f2)) {
    v1 = f1;
    v2 = f2;
  }
  if (v1 == v2)
    return 0;
  if (v1 > v2)
    return 1
  return -1;
}
var whtSpEnds = new RegExp('^\\s*|\\s*$', 'g');
var whtSpMult = new RegExp('\\s\\s+', 'g');
function normalizeString(s) {
  s = s.replace(whtSpMult, ' ');  // Collapse any multiple whites space.
  s = s.replace(whtSpEnds, '');   // Remove leading or trailing white space.
  return s;
}
//]]></script>
<style type='text/css'>
th {
font-size:8pt;
text-align:left;
}
table {border:1px solid #silver;border-collapse: collapse;}
td {padding:1mm;}
.a {
text-align:center;
}
.b {
text-align:center;
cursor:pointer;
}
</style>
</head>
<body>
"""

chKeys = {}
for c in text:
    try:
        chKeys[c] += 1
    except KeyError:
        chKeys[c] = 1

keys = chKeys.keys()
keys.sort()


print "<table border=1><tr>"

if len(keys)<400:
    print "<th><a href='' onclick='return sortTable2(0)'>Character</a></th><th><a href='' onclick='return sortTable2(1)'>Occurrences</a></th><th><a href='' onclick='return sortTable2(0)'>UCS</a></th><th><a href='' onclick='return sortTable2(3)'>Unicode Block</a></th><th><a href='' onclick='return sortTable2(4)'>Unicode Name</a></th>"
else:
    print "<th>Character</th><th>Occurrences</th><th>UCS</th><th>Unicode Block</th><th>Unicode Name</th>"

print "</tr><tbody id='theTable'>"
#len(text) and len(keys) don't work caused by uni chars > U+FFFF
total = 0
distinct = 0
regExp = {}
data = {}
for ch in keys:
    try:
        data["%04X" % int(ch)] = unicodedata.name(wunichr(ch))
    except ValueError:
        regExp["%04X" % int(ch)] = 1
    except TypeError:
        regExp["%04X" % int(ch)] = 1

UnicodeData = os.popen("zgrep -E '^(" + "|".join(regExp.keys()) + ");' '" + bundleLibPath + "UnicodeData.txt.zip'").read().decode("UTF-8")

for c in UnicodeData.splitlines():
    uniData = c.strip().split(';')
    if len(uniData) > 1: data[uniData[0]] = uniData[1]

for c in keys:
    if c != 10:
        total += chKeys[c]
        distinct += 1
        t = wunichr(c)
        try:
            name = data["%04X" % int(c)]
        except KeyError:
            name = getNameForRange(c) + "-%04X" % int(c)
        if name[0] == '<': name = getNameForRange(c) + "-%04X" % int(c)
        if "COMBINING" in name: t = u"◌" + t
        print "<tr><td class='a'>", t, "</td><td class='a'>", chKeys[c], "</td><td>", "U+%04X" % (int(c)), "</td><td>", getBlockName(c), "</td><td>", name, "</tr>"

print "</tbody></table>"

print "<p style='font-size:8pt;'><i>"
pl = "s"
if total < 2: pl = ""
print str(total) + " character%s in total (without '\\n')<br>" % pl
print str(distinct) + " distinct characters</i></p>"

print "</body></html>"