#!/usr/bin/env python

"""reads stdin, removes line breaks, replaces whitespace with one space, and pipes to pbcopy

kumar.mcmillan/gmail.com if you have any questions/suggestions.  run onelinecopy.py -h for usage"""

import sys, re, os, optparse, commands

class UsageException(Exception): pass

def main():
    parser = optparse.OptionParser(usage='stdin | %prog [options]')
    (options, args) = parse_input(parser)
    
    if options.test:
        test()
    else:
        lines = sys.stdin.readlines()
        try:
            sys.exit(onelinecopy(lines, discard=options.discard))
        except UsageException, e:
            parser.error(e)
    
def onelinecopy(lines, discard=None):
    if len(lines) is 0:
        raise UsageException('did not receive any input')
        
    if discard is not None:
        def filter(line):
            if re.match(discard, line): return ''
            else: return line
        lines = map(filter, lines)
    
    blob = ' '.join(lines)
    blob = re.sub(r'[\s]+', ' ', blob)
    blob = re.sub(r'"', r'\"', blob)
    os.system('echo -n "%s" | pbcopy' % blob)
    print "copied %d bytes to clipboard" % len(blob)
    return 0

def parse_input(parser):
    parser.add_option('-t', '--test', help='run tests and exit', action='store_true')
    parser.add_option('-d', '--discard', help='discard lines that match this regular expression', type='string')
    
    (options, args) = parser.parse_args()
    
    if options.discard is not None:
        try:
            options.discard = re.compile(options.discard)
        except re.error, e:
            parser.error('invalid DISCARD pattern (%s)' % e)
    
    return (options, args)

def test():
    def assert_copied(exp):
        out = commands.getoutput('pbpaste').strip()
        assert exp == out, 'actual: %s' % out
        
    print "testing..."
    
    blob = """
blah,       
blah,       blah"""
    onelinecopy(blob.split("\n"))
    assert_copied('blah, blah, blah')
    
    blob = """
one,
--two,
    --three,
four   \t\r\n     """
    onelinecopy(blob.split("\n"), discard=re.compile(r'^[\s]*--'))
    assert_copied( 'one, four')
    
if __name__ == '__main__':
    main()