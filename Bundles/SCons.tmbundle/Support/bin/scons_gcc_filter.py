#!/usr/bin/env python
"""Filter for scons output, adds TextMate hyperlinks for gcc error msgs."""

import re
import sys
import os
import fnmatch
import cgi

class SConsGCCFilter(object):
    stlIgnore = ["iosfwd", "streambuf", "streambuf_iterator.h", "basic_ios.h",
                 "basic_string.h", "istream", "istream.tcc", 
                 "ostream", "ostream.tcc",
                 "fstream.tcc",
                 ]
                 
    def __init__(self, currdir=None):
        self._content = ""
        self._index = 0
        if currdir is None:
            currdir = os.getcwd()
        self._currdir = currdir
        
        self._ignorePatterns = []
        self._initIgnorePatterns()
        self._errExpr = re.compile(
            r"^(?P<preamble>"
            r"(?P<pathname>[/A-Za-z0-9_.+]*):"
            r"(?P<line_num>\d+):\s*"
            r"(?P<errwarn>(error|warning)):"
            r")"
            r"(?P<error_msg>.*(\n  .*)*)",
            re.MULTILINE)
            
    def _initIgnorePatterns(self):
        """Initialize with settings from TM_IGNORE_WARNINGS, if any."""
        value = os.environ.get("TM_IGNORE_WARNINGS")
        if value is not None:
            # Better hope nobody uses a filename containing ':'.
            patterns = value.split(":")
            for p in patterns:
                self._addIgnorePath(p)
        
    def _addIgnorePath(self, pattern):
        """Ignore (or rather, don't highlight) warnings from files 
        whose names match the glob pattern."""
        print "<i>Will not highlight warnings in %r</i><br/>" % cgi.escape(pattern)
        self._ignorePatterns.append(pattern)
             
    def _isIgnoredPath(self, pathname):
        for pattern in self._ignorePatterns:
            if fnmatch.fnmatch(pathname, pattern):
                return True
        return False

    def _isIgnoredSTLWarning(self, filename):
        # GCC 3.3 -Weffc++ 
        # produces some warnings because of code generated from
        # STL.  Uncomment the return statement to pass-through these warnings
        #return False
        result = ((filename in self.stlIgnore) or 
                  fnmatch.fnmatch(filename, "stl_*.h"))
        return result
        
    def feed(self, newContent):
        self._content += newContent
        
    def _worthHighlighting(self, pathname, isError):
        filename = os.path.basename(pathname)
        result = (isError or not 
                  (self._isIgnoredPath(pathname) or 
                   self._isIgnoredSTLWarning(filename)))
        return result
        
    def filter(self, consumeAll=False):
        resultList = []
        
        currdir = self._currdir
        content = self._content
        
        # b bdc we need to look through the content for a "dmd ". if we find one, use the D based search mechanism
        Dlang = re.compile(r"dmd ")
        if Dlang.search(content):
            self._errExpr = re.compile(
                r"^(?P<preamble>"
                r"(?P<pathname>[/A-Za-z0-9_.+]*):"
                r"(?P<line_num>\d+):\s*"
                r")"
                r"(?P<error_msg>.*(\n  .*)*)",
                re.MULTILINE)
        # e bdc
        
        search = self._errExpr.search
        while True:
            match = search(content)
            if match is None:
                if consumeAll:
                    resultList.append(content)
                    self._content = ""
                else:
                    # Error msgs start near beginning of a line, so flush
                    # all unmatched, complete lines.
                    iLine = content.rfind("\n")
                    if (iLine >= 0):
                        resultList.append(content[:iLine+1])
                        content = content[iLine+2:]
                    # Save the rest for later consumption.
                    self._content = content
                break
            else:
                resultList.append(content[:match.start()])
                pathname = match.group("pathname")
                # bdc orig line: isError = (match.group("errwarn") == "error")
                # b bdc check for D errors 
                if pathname.endswith(".d"):
                    isError = True
                else:
                    isError = (match.group("errwarn") == "error")
                # e bdc check for D errors
                
                if self._worthHighlighting(pathname, isError):
                    msg = match.group("error_msg")
                    lineNum = match.group("line_num")
                    errorURL = ("txmt://open?url=file://%s/%s&line=%s" %
                                (currdir, pathname, lineNum))
                    resultList.append('<a href="%s">' % errorURL)
                    resultList.append(match.group("preamble"))
                    resultList.append('</a>')
                    resultList.append(msg)
                    resultList.append("<br/>")
                else:
                    resultList.append(match.group(0))
            
                content = content[match.end()+1:]
                
        result = "".join(resultList).replace("\n", "<br/>\n")
        return result
    
def main():
    f = SConsGCCFilter()
    f.feed(sys.stdin.read())
    print f.filter(consumeAll=True)

if __name__ == "__main__":
    main()