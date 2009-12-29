#!/usr/bin/env python
"""Runs scons and wraps its output as HTML."""

import sys
import os
import select
from scons_gcc_filter import SConsGCCFilter
import cgi
import subprocess

def findSConstructDir():
    """Search upward from the current dir for the top-level SConstruct dir."""
    result = None
    d = os.getcwd()
    while (d != "/") and not result:
        candidate = os.path.join(d, "SConstruct")
        if os.path.exists(candidate) and os.path.isfile(candidate):
            result = d
        d = os.path.dirname(d)
    return result or os.getcwd()

def write(s):
    """Write a string to stdout, flushing immediately."""
    if s:
        sys.stdout.write(s)
        sys.stdout.flush()
    
def filterOutput(args):
    """Run a shell cmd, reformatting output as HTML."""
    theFilter = SConsGCCFilter(findSConstructDir())
    
    p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    outfd = p.stdout.fileno()
    errfd = p.stderr.fileno()
    inSet = [outfd, errfd]
    errSet = [outfd, errfd]
    
    while True:
        ins, outs, errs = select.select(inSet, [], errSet)
        if errs:
            print("<b>Error descriptors: <i>%s</i><b>" % repr(errs))
            for item in errs:
                errSet.remove(item)
            if not errSet:
                break
        for fd in ins:
            content = os.read(fd, 65536)
            if not content:
                inSet.remove(fd)
            else:
                theFilter.feed(content)
        if ins:
            write(theFilter.filter())
        if not inSet:
            p.stdout.close()
            p.stderr.close()
            write(theFilter.filter(consumeAll=True))
            break
        
    
def runSCons(args):
    """Run SCons in a not-very-flexible way."""
    args = ["scons"] + args

    print("<i># Working dir: %s</i><br/>" % cgi.escape(os.getcwd()))
    print("<b>%s</b><br/>" % cgi.escape(" ".join([str(a) for a in args])))
    filterOutput(args)
    
def main():
    args = sys.argv[1:] or []
    runSCons(args)
    
if __name__ == "__main__":
    main()