#!/usr/bin/env python
# @author Kumar McMillan, Brad Miller

"""
Entitynav: Outputs a parsable list of functional entities for the given code file
Usage:  entitynav -f <filename>
        entitynav -f - -m $TM_MODE
        entitynav -f - -e <extension/type>
        entitynav -f - -E <filename>

 -f, --file <filename>|-        : parse <filename> or stdin if `-'
 -m, --mode <mode>              : set extension/mode to <mode>
 -e, --ext <ext>                : set extension/mode as <ext> when stdin
 -E, --ext-from-file <filename> : set extension/mode to extension of <filename>
 -s, --sort                     : sort output by function/method/class name
 -S, --sort-silently            : sort only if the mode supports it, otherwise output unsorted
 -h, --help                     : print usage

"""

import sys, os, re, string, getopt
        
def usage(reason=''):
    """
    print usage
    """
    sys.stdout.flush()
    reason = reason.__str__()
    if reason: sys.stderr.write('ERROR: %s\n' % reason)
    usageMsg = __doc__
    sys.stderr.write(usageMsg)
    sys.exit(1)
    
def getHandler(mode):
    classSuffix = mode.capitalize()
    """
    gets an entity-matching handler for the mode in question
    """    
    try:
        handler = globals()["Entities" + classSuffix]
    except KeyError:
        raise HandlerException, "no handler for extension/mode '%s'" % mode
        
    return handler()
    
#-------------------------------------------------------------------------
# ENTITY HANDLERS
# see EntityHandler() / SortableEntities() for the interface and notes on creating new handlers
#-------------------------------------------------------------------------
    
class EntityHandler:
    """
    Interface/abstract class for language-specific Entity handlers
    
    Below are handler classes for specific languages, listed alphabetically.  
    To create a new language handler, name the class Entities<Mode> where 
    <Mode> is the $TM_MODE (TextMate file mode) converted to title case. 
    I.E. HTML_PHP becomes Html_php.
    
    Also note that any non alphanumeric/underscore characters get converted to `_'.
    It is also possible to set a mode using a filename extension.  Therefore you need to provide
    subclasses of your main class to account for all possible TextMate modes or filename extensions.
    
    For example, 
    EntitiesCss gets inherited like so:
    class EntitiesCss_html(EntitiesCss): pass
    class EntitiesCss_php(EntitiesCss): pass
    
    If you are unsure of a TextMate mode, just run this command on a file and you will see the error :)
    
    """
    def __init__(self):
        """
        self.entityMatchLine = match object to extract Special Items from code input
        """
        self.entityMatchLine = re.SRE_Pattern
        
    def outputParsable(self, entities):
        """
        takes in a dict of line numbers to file lines and outputs <line number>:<line>
        """
        keys = entities.keys()
        keys.sort()
        entitiesAsCoded = zip(keys, map(entities.get, keys))
        sys.stdout.write( "".join( ["%s:%s" % (k,v) for k,v in entitiesAsCoded] ))

class SortableEntities:
    """
    Interface/abstract class for sortable entities
    
    This can be inherited by any handler that wants to handle the --sort flag, so entities have 
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
        takes in a sortEntities line that was deconstructed by deconstructLine and outputs it to tatse
        
        @param (mixed) line - the line the way it was returned by deconstructLine
        """
        return line
        
    def outputParsable(self, entities):
        outList = self.sort(entities)
        for outLine in outList:
            sys.stdout.write(self.formatSortedLine(outLine))
    
    def sort(self,entities):
        """
        takes in a dictionary that was created by EntityNav.findEntities() 
        (in other words, a dictionary indexed by line number holding the value returned by SortableEntities.deconstructLine()) 
        and returns something that SortableEntities.formatSortedLine() will understand
        
        """ 
        if type(entities) is not type({}): return []
        keys = entities.keys()
        s = map(lambda k: (entities[k],k), keys)
        s.sort()
        return s
        
class SortableEntitiesIn3(SortableEntities):
    """
    abstract SortableEntities that expects matches to be defined as 3 groups, "main", "prefix", "suffix"
    """
    def deconstructLine(self, lineMatch):
        # TODO: exception if groups don't exist
        return (lineMatch.group('main'),lineMatch.group('prefix'),lineMatch.group('suffix'))
        
    def formatSortedLine(self, line):
        return "%s:%s\n" % (line[1],(line[0][1]+line[0][0]+line[0][2]))
        
class EntitiesCss(EntityHandler):
    """
    entity-matching handler for CSS (css) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^[\s]*[a-zA-Z_\.,#]+[\sa-zA-Z_\.,#\{:]*[^;]+$')
        
class EntitiesCss_html(EntitiesCss): pass
class EntitiesCss_php(EntitiesCss): pass

class EntitiesLatex(SortableEntitiesIn3, EntityHandler):
    """
    entity-matching handler for LaTeX (tex) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^\s*(?P<prefix>\\(sub)*section{|\\paragraph{)(?P<main>.*)(?P<suffix>}.*$)')
        
class EntitiesTex(EntitiesLatex): pass
        
class EntitiesPhp(SortableEntities, EntityHandler):
    """
    entity-matching handler for PHP (php) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'(?P<indent>^\s*)(?P<visibility>(final|abstract)?\s?(public|private|protected)?\s?(static)?\s*)(?P<entity>(function|class|interface)\s+)(?P<name>[^$]+[&a-zA-Z0-9_]+)(?P<args>.*$)')
        
    def deconstructLine(self, lineMatch):
        return (lineMatch.group('entity'),lineMatch.group('name'),lineMatch.group('visibility'),lineMatch.group('args'),lineMatch.group('indent'))
        
    def formatSortedLine(self, line):
        return "%s:%s\n" % (line[1],(line[0][4]+line[0][2]+line[0][0]+line[0][1]+line[0][3]))
        
    def sort(self,entities):
        """
        refactor me please!  Not being very agile with Python just yet, this is my "proof of concept" for sorting
        PHP entities hierachically, by class, then by function -Kumar
        """
        lineNums = entities.keys()
        entitiesAsCoded = map(lambda k: (k,entities[k]), lineNums)
        entitiesAsCoded.sort() # i.e. by line number, as the lines were typed
        
        functionPtrn = re.compile(r'function', re.IGNORECASE)
        classPtrn = re.compile(r'(class|interface)', re.IGNORECASE)
        classes = []
        functions = {}
        parentClass = '___global' # ugly hack to force this alphabetically first
        
        for lineNum,line in entitiesAsCoded:
            if classPtrn.match(line[0]):
                classes.append((line,lineNum))
                parentClass = line[1]
            elif functionPtrn.match(line[0]):
                try:
                    functions[parentClass].append((line,lineNum))
                except KeyError:
                    functions[parentClass] = [(line,lineNum)]
                    
        # this won't even acknowledge global functions and will probably screw everything up
        # if you put global functions at the bottom of your classes :
        classes.sort()
        output = []
        for line,lineNum in classes:
            output.append( (line, lineNum) )
            try:
                className = line[1] 
                functions[className].sort()
                output.extend(functions[className])
            except KeyError:
                pass
        
        return output

class EntitiesHtml_php(EntitiesPhp): pass
class EntitiesInc(EntitiesPhp): pass
        
class EntitiesPerl(SortableEntitiesIn3, EntityHandler):
    """
    entity-matching handler for Perl (pl) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^\s*(?P<prefix>sub\s+)(?P<main>.*)(?P<suffix>\s*$)')

class EntitiesPl(EntitiesPerl): pass
class EntitiesPm(EntitiesPerl): pass
        
class EntitiesPython(EntityHandler):
    """
    entity-matching handler for Python (py) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^\s*(?P<type>(class|def)\s+)(?P<entity>.*:\s*$)')

class EntitiesPy(EntitiesPython): pass

class EntitiesRuby(SortableEntitiesIn3, EntityHandler):
    """
    entity-matching handler for Ruby (rb) files
    """
    def __init__(self):
        self.entityMatchLine = re.compile(r'^\s*(?P<prefix>(class|module|def)\s+)(?P<main>.*)(?P<suffix>\s*$)')
        
class EntitiesHtml_ruby(EntitiesRuby): pass
class EntitiesRb(EntitiesRuby): pass

#-------------------------------------------------------------------------
# END: ENTITY HANDLERS
#-------------------------------------------------------------------------

class EntityNav:
    """
    Produces a parsable entity-navigation of a code file (designed for TextMate's command window)
    """
    def __init__(self, opts, args):
        self.sortEntities = False
        self.sortEntitiesSilently = False
        self.parseInput(opts, args)
        self.getHandler()
        self.constructFileDict(self.file)
        
    def constructFileDict(self, file):
        fileLines = range(1, len(file) + 1)
        self.fileDict = dict(zip(fileLines, file))
        
    def findEntities(self):
        self.entities = {}
        for lineNum,line in self.fileDict.iteritems():
            lineMatch = self.handler.entityMatchLine.match(line)
            
            if lineMatch and self.sortEntities:
                self.entities[lineNum] = self.handler.deconstructLine(lineMatch)
            elif lineMatch:
                self.entities[lineNum] = line
        if self.entities == {}:
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
            
    def outputParsable(self):
        """
        outputs a <line number>:<line> entity list 
        @see EntityHandler.outputParsable()
        """
        self.findEntities()
        self.handler.outputParsable(self.entities)
            
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
            raise UsageException("cannot parse stdin: did not receive extension/mode")
            
    def setModeFromArg(self, arg):
        self.mode = re.sub(r'[^a-zA-Z0-9_]+', '_', arg)
            
    def setModeFromFileExt(self, filename):
        self.mode = filename.split('.')[-1]
        
class HandlerException(Exception): pass
class HandlerNoEntitiesException(HandlerException): pass
class SortException(Exception): pass
class ParseException(Exception): pass
class UsageException(Exception): pass
        
def main(argv):
    try:
        opts, args = getopt.getopt(argv, "hf:e:E:m:sS", ["help", "file=", "ext=", "ext-from-file=", "mode=", "sort", "sort-silently"])
        entityNav = EntityNav(opts, args)
        entityNav.outputParsable()
    except getopt.GetoptError, err:
        usage(err)
    except UsageException, err:
        usage(err)
    except HandlerNoEntitiesException:
        print "0:NO ENTITIES FOUND"
    except HandlerException, err:
        usage(err)
    except SortException, err:
        usage(err)
    except ParseException, err:
        usage(err)
    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]) or 0)