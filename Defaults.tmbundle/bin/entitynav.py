#!/usr/bin/env python
# @author Kumar McMillan, Brad Miller

"""Entitynav: Outputs a parsable list of functional entities for the given code file

Usage:  entitynav -f <filename> [ -m $TM_MODE ]
        entitynav -f - -m $TM_MODE
        entitynav -f - -e <mode as extension>
        entitynav -f - -E <mode as extension of filename>

 -f, --file <filename>|-        : parse <filename> or stdin if `-'
 -m, --mode <mode>              : set mode to <mode>
 -e, --ext <extension>          : set mode to <extension>
 -E, --ext-from-file <filename> : set mode to extension of <filename>
 -s, --sort                     : sort output by function/method/class name
 -S, --sort-silently            : sort only if the mode supports it, otherwise output unsorted
 -h, --help                     : print usage

"""

import sys, re, getopt
from special_items.handlers import *
from special_items.transform import *

class UsageException(Exception): pass
        
def usage(reason=''):
    """print usage"""
    sys.stdout.flush()
    reason = reason.__str__()
    if reason: sys.stderr.write('ERROR: %s\n' % reason)
    usageMsg = __doc__
    sys.stderr.write(usageMsg)
    return 1
    
class EntityNav:
    """Produces a parsable entity-navigation of a code file (designed for TextMate's command window)"""
    sortEntities = False
    sortEntitiesSilently = False
    
    def __init__(self, opts, args):
        self.parseInput(opts, args)
        self.getHandler()
        
    def findEntities(self):
        lineNum = 1
        for line in self.file:
            self.handler.readLine(lineNum, line)
            lineNum = lineNum + 1
            
        if not self.handler.foundEntities():
            raise HandlerNoEntitiesException
            
    def getHandler(self):
        self.handler = getHandler(self.mode)
        try:
            if self.sortEntities and not isinstance(self.handler, SortableEntities):
                raise SortException, "Handler for mode '%s' does not support sorting" % self.mode
        except SortException, err:
            self.sortEntities = False
            if not self.sortEntitiesSilently:
                raise err
        self.handler.sortEntities = self.sortEntities
        self.handler.sortEntitiesSilently = self.sortEntitiesSilently
            
    def outputParsable(self):
        """outputs a <line number>:<line> entity list 
        
        @see EntityHandler.outputParsable()
        """
        self.findEntities()
        self.handler.outputParsable()
            
    def parseFile(self, filename):
        if filename == '-':
            return self.parseStdin()
        try:
            self.file = open(filename).readlines()
        except IOError:
            raise ParseException("could not open file '%s' for reading" % filename)
            
        self.setModeFromFileExt(filename)
        
    def parseInput(self, opts, args):
        file = None
        self.sortEntities = False
        for opt, arg in opts:
            if opt in ('-f', '--file'):
                file = arg
            elif opt in ('-m', '--mode'):
                self.setModeFromArg(arg)
            elif opt in ('-E', '--ext-from-file'):
                self.setModeFromFileExt(arg)
            elif opt in ('-s', '--sort'):
                self.sortEntities = True
            elif opt in ('-S', '--sort-silently'):
                self.sortEntities = True
                self.sortEntitiesSilently = True
            elif opt in ('-e', '--ext'):
                self.mode = arg
            elif opt in ("-h", "--help"):
                raise UsageException
            
        if file == None:
            raise UsageException
        self.parseFile(file)
        
    def parseStdin(self):
        self.file = sys.stdin.readlines()
        try:
            self.mode
        except AttributeError:
            raise UsageException("cannot parse stdin: did not receive mode")
            
    def setModeFromArg(self, arg):
        self.mode = re.sub(r'[^a-zA-Z0-9_]+', '_', arg)
            
    def setModeFromFileExt(self, filename):
        self.mode = filename.split('.')[-1]
        
def main(argv):
    """runs entity nav from command line
    
    returns exit status
    """
    try:
        opts, args = getopt.getopt(argv, "hsSf:e:E:m:", ["help", "sort", "sort-silently", "file=", "ext=", "ext-from-file=", "mode="])
        entityNav = EntityNav(opts, args)
        entityNav.outputParsable()
    except getopt.GetoptError, err:
        return usage(err)
    except UsageException, err:
        return usage(err)
    except HandlerNoEntitiesException:
        print "0:NO ENTITIES FOUND"
        return 1
    except HandlerException, err:
        return usage(err)
    except SortException, err:
        return usage(err)
    except ParseException, err:
        return usage(err)
    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]) or 0)