#!/usr/bin/env python
# @author kumar.mcmillan/gmail.com

"""
Entitynav: Outputs a parsable list of functional entities for the given code file
Usage:  entitynav -f <filename>
        entitynav -f - -e <extension/type>
        entitynav -f - -E <filename>

 -f, --file <filename>|-        : parse <filename> or stdin if `-'
 -e, --ext <ext>                : set extension/type as <ext> when stdin
 -E, --ext-from-file <filename> : set extension/type to that of <filename>
 -h, --help                     : print usage

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
    gets an entity-matching handler based on filename extension
    """
    classSuffix = ext.capitalize()
    
    try:
        handler = globals()["Entities" + classSuffix]
    except KeyError:
        raise HandlerError, "no handler for extension '%s'" % ext
        
    return handler()
    
#-------------------------------------------------------------------------
# ENTITY HANDLERS
# see EntityHandler() for the interface and notes on creating new handlers
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
        self.entityMatchLine = re.compile(r'^\s*(final|abstract|public|private|protected|function|class|interface)\s+[&a-zA-Z0-9_]+.*$')
        
class EntitiesInc(EntitiesPhp): pass
        
class EntitiesPl(EntityHandler):
    """
    entity-matching handler for Perl (pl) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^\s*(?P<prefix>sub)\b(?P<main>.*)(?P<suffix>\s*$)')

class EntitiesPm(EntitiesPl): pass

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
        self.entityMatchLine = re.compile(r'^\s*(?P<prefix>class|def)\b(?P<main>.*)(?P<suffix>:\s*$)')

class EntitiesTex(EntityHandler):
    """
    entity-matching handler for LaTeX (tex) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^\s*(?P<prefix>\\(sub)*section{|\\paragraph{)(?P<main>.*)(?P<suffix>}.*$)')



#-------------------------------------------------------------------------
# END: ENTITY HANDLERS
#-------------------------------------------------------------------------

class EntityNav:
    """
    Produces a parsable entity-navigation of a code file (designed for TextMate's command window)
    """
    def __init__(self, opts, args):
        self.parseInput(opts, args)
        self.handler = getHandler(self.ext)
        self.constructFileDict(self.file)
        
    def constructFileDict(self, file):
        fileLines = range(1, len(file) + 1)
        self.fileDict = dict(zip(fileLines, file))
        
    def findEntities(self):
        self.entities = {}
        for lineNum,line in self.fileDict.iteritems():
            # TODO: make this match return a prefix a main part and a suffix so we can sort by name
            if self.sorted:
                m = self.handler.entityMatchLine.match(line)
                if m:
                    if len(m.groups()) < 3:   # check to make sure captures for sorting are in
                        raise HandlerNoEntitiesError
                    self.entities[lineNum] = (m.group('main'),m.group('prefix'),m.group('suffix'))
            else:
                if self.handler.entityMatchLine.match(line):
                    self.entities[lineNum] = line
        if self.entities == {}:
            raise HandlerNoEntitiesError
            
    def outputParsable(self):
        """
        outputs a lineNum:line entity list
        """
        self.findEntities()
        if self.sorted:
            outList = self.sort_byval(self.entities)
            for i in outList:
                sys.stdout.write("%s:%s\n"%(i[1],(i[0][1]+i[0][0]+i[0][2])))
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

    def sort_byval(self,dict):         
        if type(dict) is not type({}): return []
        keys = dict.keys()
        s = map(lambda k: (dict[k],k), keys)
        s.sort()
        return s
        
class HandlerError(Exception): pass
class HandlerNoEntitiesError(HandlerError): pass
class ParseError(Exception): pass
class UsageError(Exception): pass
        
def main(argv):
    try:
        opts, args = getopt.getopt(argv, "hf:e:E:", ["help", "file=", "ext=", "ext-from-file="])
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
    except ParseError, err:
        usage(err)
    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]) or 0)