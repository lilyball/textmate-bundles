#!/usr/bin/env python
# @author kumar.mcmillan/gmail.com
# Modifications to support sorted output by Brad Miller

"""
Entitynav: Outputs a parsable list of functional entities for the given code file
Usage:  entitynav -f <filename>
        entitynav -f - -e <extension/type>
        entitynav -f - -E <filename>

 -f, --file <filename>|-        : parse <filename> or stdin if `-'
 -e, --ext <ext>                : set extension/type as <ext> when stdin
 -E, --ext-from-file <filename> : set extension/type to that of <filename>
 -h, --help                     : print usage
 -s, --sort                     : sort output by function/method/class name

"""

import sys, os, re, string, getopt
        
def usage(reason=''):
    """
    print usage
    """
    sys.stdout.flush()
    if reason: sys.stderr.write('ERROR: %s\n' % reason)
    usageMsg = string.lstrip(__doc__)
    sys.stderr.write(usageMsg)
    sys.exit(1)
    
def getHandler(ext):
    """
    gets an entity-matching handler for the mode in question
    """    
    try:
        handler = globals()["Entities" + ext]
    except KeyError:
        raise HandlerError, "no handler for extension '%s'" % ext
        
    return handler()
    
def getSorter(ext):
    """
    gets a sort object for the mode in question
    """
    try:
        sorter = globals()["Sortable" + ext]
    except KeyError:
        raise SortError("No sorter defined for mode '%s'" % ext)
        
    return sorter()
    
#-------------------------------------------------------------------------
# ENTITY, SORT HANDLERS
# see EntityHandler() / SortableEntities() for the interface and notes on creating new handlers and sorters
#-------------------------------------------------------------------------
    
class EntityHandler:
    """
    Interface/abstract class for language-specific Entity handlers
    
    Below are handler classes for specific languages, listed alphabetically.  
    To create a new language handler, name the class Entities<Ext> where <Ext> is the extension
    of a code file for the language.  I.E. EntitiesPy for Python files. 
    If multiple extensions exist for the same language, make a subclass for each lang.
    
    Currently the interface for Entity Handlers only suggests defining a match object,
    which matches lines that should be considered function/class/etc. entities
    """
    def __init__(self):
        self.entityMatchLine = re.SRE_Pattern

class SortableEntities:
    """
    Interface/abstract class for sortable entities
    
    This needs to be defined for any entity that can handle the --sort flag, so entities have 
    some way to sort themselves, like alphabetically grouped by class, function ... etc
    
    TODO: need to pull out more of the sorting-specific methods from EntityNav?
    """
    def deconstructLine(self,lineMatch):
        """
        deconstructs a line into something meaningful, so that sorting can be applied
        
        @param (re.SRE_Match) lineMatch
        @return (tuple) of each hierarchical group, like (<class>, <function>, <args>)
        """
        return False
    
    def formatSortedLine(self, line):
        """
        takes in a sorted line that was deconstructed by deconstructLine and outputs it to tatse
        
        @param (mixed) line - the line the way it was returned by deconstructLine
        """
        return line
    
    def sort(self,dict):
        """
        takes in a dictionary that was created by EntityNav.findEntities() and outputs something
        that SortableEntities.formatSortedLine() will understand
        
        """ 
        if type(dict) is not type({}): return []
        keys = dict.keys()
        s = map(lambda k: (dict[k],k), keys)
        s.sort()
        return s
        
class SortableEntitiesIn3(SortableEntities):
    """
    abstract SortableEntities that expects matches to be defined as 3 groups, "main", "prefix", "suffix"
    """
    def deconstructLine(self, lineMatch):
        # TODO: exception if groups don't exist
        # TODO: maybe a little more flexible if groups were not labelled?  i.e. 1, 2, 3, which would correspond to the sort level.
        return (lineMatch.group('main'),lineMatch.group('prefix'),lineMatch.group('suffix'))
        
    def formatSortedLine(self, line):
        return "%s:%s\n" % (line[1],(line[0][1]+line[0][0]+line[0][2]))
        
class EntitiesCss(EntityHandler):
    """
    entity-matching handler for CSS (css) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^[\s]*[a-zA-Z_\.,#]+[\sa-zA-Z_\.,#\{:]*[^;]+$')
        
class EntitiesPhp(EntityHandler):
    """
    entity-matching handler for PHP (php) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^\s*(?P<type>(final|abstract|public|private|protected|function|class|interface)(\s+(function|static))?)(?P<entity>\s+[&a-zA-Z0-9_]+)(?P<args>.*$)')

class EntitiesInc(EntitiesPhp): pass

class SortablePhp(SortableEntities):        
    def deconstructLine(self, lineMatch):
        return (lineMatch.group('type'),lineMatch.group('entity'),lineMatch.group('args'))
        
    def formatSortedLine(self, line):
        return "%s:%s\n" % (line[1],(line[0][0]+line[0][1]+line[0][2]))
        
class SortableInc(SortablePhp): pass
        
class EntitiesPl(EntityHandler):
    """
    entity-matching handler for Perl (pl) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^\s*(?P<prefix>sub\s+)(?P<main>.*)(?P<suffix>\s*$)')

class EntitiesPm(EntitiesPl): pass
class SortablePl(SortableEntitiesIn3): pass
class SortablePm(SortablePl): pass

class EntitiesCss(EntityHandler):
    """
    entity-matching handler for CSS files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^.*\{$')
        
class EntitiesPy(EntityHandler):
    """
    entity-matching handler for Python (py) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^\s*(?P<type>(class|def)\s+)(?P<entity>.*:\s*$)')

class SortablePy(SortableEntities):
    def deconstructLine(self, lineMatch):
        return (lineMatch.group('type'),lineMatch.group('entity'))
        
    def formatSortedLine(self, line):
        return "%s:%s\n" % (line[1],(line[0][0]+line[0][1]))

class EntitiesTex(EntityHandler):
    """
    entity-matching handler for LaTeX (tex) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^\s*(?P<prefix>\\(sub)*section{|\\paragraph{)(?P<main>.*)(?P<suffix>}.*$)')

class SortableTex(SortableEntitiesIn3): pass

#-------------------------------------------------------------------------
# END: ENTITY, SORT HANDLERS
#-------------------------------------------------------------------------

class EntityNav:
    """
    Produces a parsable entity-navigation of a code file (designed for TextMate's command window)
    """
    def __init__(self, opts, args):
        self.parseInput(opts, args)
        self.handler = getHandler(self.ext.capitalize())
        self.constructFileDict(self.file)
        
    def constructFileDict(self, file):
        fileLines = range(1, len(file) + 1)
        self.fileDict = dict(zip(fileLines, file))
        
    def findEntities(self):
        self.entities = {}
        for lineNum,line in self.fileDict.iteritems():
            lineMatch = self.handler.entityMatchLine.match(line)
            
            if lineMatch and self.sorted:
                self.entities[lineNum] = self.sorter.deconstructLine(lineMatch)
            elif lineMatch:
                self.entities[lineNum] = line
        if self.entities == {}:
            raise HandlerNoEntitiesError
            
    def outputParsable(self):
        """
        outputs a lineNum:line entity list
        """
        self.findEntities()
        if self.sorted:
            outList = self.sorter.sort(self.entities)
            for outLine in outList:
                sys.stdout.write(self.sorter.formatSortedLine(outLine))
        else:
            sys.stdout.write( "".join( ["%s:%s" % (k,v) for k,v in self.splice(self.entities)] ))
            
    def parseFile(self, filename):
        if filename == '-':
            return self.parseStdin()
        try:
            self.file = open(filename).readlines()
        except IOError:
            raise ParseError("could not open file '%s' for reading" % filename)
            
        self.setExtFromFilename(filename)
        
    def parseInput(self, opts, args):
        file = None
        self.sorted = False
        for opt, arg in opts:
            if opt in ("-h", "--help"):
                raise UsageError
            elif opt in ('-f', '--file'):
                file = arg
            elif opt in ('-e', '--ext'):
                self.ext = arg
            elif opt in ('-E', '--ext-from-file'):
                self.setExtFromFilename(arg)
            elif opt in ('-s', '--sort'):
                self.sorted = True
                
        if self.sorted:
            self.sorter = getSorter(self.ext.capitalize())
            
        if file == None:
            raise UsageError
        self.parseFile(file)
        
    def parseStdin(self):
        self.file = sys.stdin.readlines()
        try:
            self.ext
        except AttributeError:
            raise UsageError("did not receive filename extension")
            
    def setExtFromFilename(self, filename):
        self.ext = filename.split('.')[-1]
    
    def splice(self, entities):
        """
        splices together the file dictionary so that every line is prefixed with lineNum:
        """
        keys = entities.keys()
        keys.sort()
        splicedEntities = zip(keys, map(entities.get, keys))
        return splicedEntities
        
class HandlerError(Exception): pass
class HandlerNoEntitiesError(HandlerError): pass
class SortError(Exception): pass
class ParseError(Exception): pass
class UsageError(Exception): pass
        
def main(argv):
    try:
        opts, args = getopt.getopt(argv, "hf:e:E:s", ["help", "file=", "ext=", "ext-from-file=", "sort"])
        entityNav = EntityNav(opts, args)
        entityNav.outputParsable()
    except getopt.GetoptError, err:
        usage(err)
    except UsageError, err:
        usage(err)
    except HandlerNoEntitiesError:
        print "0:NO ENTITIES FOUND"
    except HandlerError, err:
        usage(err)
    except SortError, err:
        usage(err)
    except ParseError, err:
        usage(err)
    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]) or 0)