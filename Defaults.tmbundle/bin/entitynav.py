#!/usr/bin/env python
# @author Kumar McMillan, Brad Miller

"""
Entitynav: Outputs a parsable list of functional entities for the given code file
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
    abstract class for language-specific Entity handlers
    
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
    entities = {}
    sortEntities = False
    sortEntitiesSilently = False
    entityMatchLine = None # re.compile() result, used in EntityHandler.readLine()
        
    def deconstructLine(self,lineMatch):
        """
        deconstructs a line into something meaningful, so that sorting can be applied
        
        @param (re.SRE_Match) lineMatch
        @return (tuple) of each hierarchical group, like (<class>, <function>, <args>)
        """
        return lineMatch.string
        
    def foundEntities(self):
        return (self.entities != {})
        
    def outputParsable(self):
        """
        takes dict of line numbers to file lines and outputs <line number>:<line>
        """
        entities = self.entities
        lineNums = entities.keys()
        lineNums.sort()
        entitiesAsCoded = zip(lineNums, map(entities.get, lineNums))
        sys.stdout.write( "".join( ["%s:%s" % (lineNum,line) for lineNum,line in entitiesAsCoded] ))
        
    def readLine(self, lineNum, line):
        if self.entityMatchLine.match is None:
            raise HandlerException("there is no pattern to readLine() with")
        lineMatch = self.entityMatchLine.match(line)
        if lineMatch:
            line = self.deconstructLine(lineMatch)
            self.entities[lineNum] = line
        return (line, lineMatch)
        
    def reconstructLine(self, line):
        """
        takes in a line that was deconstructed by deconstructLine and outputs it to taste
        
        @param (mixed) line - the line the way it was returned by deconstructLine
        """
        return line

class SortableEntities:
    """
    abstract class for sortable entities
    
    This can be inherited by any handler that wants to handle the --sort flag, so entities have 
    some way to sort themselves, like alphabetically grouped by class, function ... etc
    
    TODO: need to pull out more of the sorting-specific methods from EntityNav?
    """            
    def outputParsable(self):
        try:
            sys.stdout.write( "".join(map(self.reconstructLine, self.sort())) )
        except AttributeError:
            raise HandlerException("abstract class SortableEntities must be inherited alongside EntityHandler")
    
    def sort(self):
        """
        needs to sort entities and return a list that self.outputParsable() can understand
        """ 
        [ (self.entities[linNum], lineNum) for lineNum in self.entities ]
        
class SortableByMainEntity(SortableEntities):
    """
    abstract SortableEntities that sorts by an entity group named "main"
    It also expects matches to be defined as 3 groups, "main", "prefix", "suffix"
    """
    def deconstructLine(self, lineMatch):
        try:
            return (lineMatch.group('main'),lineMatch.group('prefix'),lineMatch.group('suffix'))
        except IndexError:
            raise SortException("expected lineMatch groups 'main', 'prefix', and 'suffix'")
        
    def reconstructLine(self, line):
        return "%s:%s\n" % (line[1],(line[0][1]+line[0][0]+line[0][2]))
        
    def sort(self):
        lineNums = self.entities.keys()
        sortedByMain = map(lambda lineNum: (self.entities[lineNum],lineNum), lineNums)
        sortedByMain.sort()
        return sortedByMain
        
class SortableByClass(SortableEntities):
    """
    abstract SortableEntities that sorts by matched groups matched as classes, then groups matched as functions
    Expects match groups: 'indent', 'entity', 'name', 'args'
    """
    functionPtrn = None
    classPtrn = None
    classes = []
    functions = {}
    functionIndex = '__GLOBAL__'
    
    def deconstructLine(self, lineMatch):
        try:
            return (lineMatch.group('entity'),lineMatch.group('name'),lineMatch.group('args'),lineMatch.group('indent'))
        except IndexError:
            raise HandlerException("abstract SortableByClass must define match groups 'entity', 'name', 'args', and 'indent'")
        
    def readLine(self, lineNum, line):
        (line, lineMatch) = EntityHandler.readLine(self, lineNum, line)
        if lineMatch:
            entity = lineMatch.group('entity')
            name = lineMatch.group('name')
            try:
                functionMatch = self.functionPtrn.match
                classMatch = self.classPtrn.match
            except AttributeError:
                raise HandlerException("abstract SortableByClass must define patterns functionPtrn and classPtrn")
            
            if functionMatch(entity):
                try:
                    self.functions[self.functionIndex].append((line, lineNum))
                except KeyError:
                    self.functions[self.functionIndex] = [(line, lineNum)]
            elif classMatch(entity):
                self.classes.append((line, lineNum))
                # major assumption, that could use fixing...
                # as we loop through lines (as they were typed), assume subsequent functions belong to the last class :
                self.functionIndex = name
            else:
                raise HandlerException("unexpected entity: '" + entity + "'")
        return (line, lineMatch)
        
    def reconstructLine(self, line):
        return "%s:%s\n" % (line[1],(line[0][3]+line[0][0]+line[0][1]+line[0][2]))
        
    def sort(self):
        """
        sort entities hierachically by class, then by function
        """
        sorted = []
        try:
            self.functions['__GLOBAL__'].sort()
            sorted.extend(self.functions['__GLOBAL__'])
        except KeyError:
            pass
        self.classes.sort()
        for line,lineNum in self.classes:
            sorted.append((line, lineNum))
            try:
                className = line[1]
                self.functions[className].sort()
                sorted.extend(self.functions[className])
            except KeyError:
                pass
                
        return sorted
        
class EntitiesCss(SortableByMainEntity, EntityHandler):
    """
    entity-matching handler for CSS (css) files
    """
    entityMatchLine = re.compile(r'(?P<prefix>^[\s]*)(?P<main>[a-zA-Z_\.,#]+[\sa-zA-Z_\.,#\{:]*)(?P<suffix>[^;]+)$')
        
class EntitiesCss_html(EntitiesCss): pass
class EntitiesCss_php(EntitiesCss): pass

class EntitiesLatex(SortableByMainEntity, EntityHandler):
    """
    entity-matching handler for LaTeX (tex) files
    """
    entityMatchLine = re.compile(r'^\s*(?P<prefix>\\(sub)*section{|\\paragraph{)(?P<main>.*)(?P<suffix>}.*$)')
        
class EntitiesTex(EntitiesLatex): pass
        
class EntitiesPhp(SortableByClass, EntityHandler):
    """
    entity-matching handler for PHP (php) files
    this adds to SortableByClass the 'visibility' group
    """
    entityMatchLine = re.compile(r'(?P<indent>^\s*)(?P<visibility>(final|abstract)?\s?(public|private|protected)?\s?(static)?\s*)(?P<entity>(function|class|interface)\s+)(?P<name>[^$]+[&a-zA-Z0-9_]+)(?P<args>.*$)')    
    functionPtrn = re.compile(r'function', re.IGNORECASE)
    classPtrn = re.compile(r'(class|interface)', re.IGNORECASE)
        
    def deconstructLine(self, lineMatch):
        return (lineMatch.group('entity'),lineMatch.group('name'),lineMatch.group('visibility'),lineMatch.group('args'),lineMatch.group('indent'))
        
    def reconstructLine(self, line):
        return "%s:%s\n" % (line[1],(line[0][4]+line[0][2]+line[0][0]+line[0][1]+line[0][3]))

class EntitiesHtml_php(EntitiesPhp): pass
class EntitiesInc(EntitiesPhp): pass
        
class EntitiesPerl(SortableByMainEntity, EntityHandler):
    """
    entity-matching handler for Perl (pl) files
    """
    entityMatchLine = re.compile(r'^\s*(?P<prefix>sub\s+)(?P<main>.*)(?P<suffix>\s*$)')

class EntitiesPl(EntitiesPerl): pass
class EntitiesPm(EntitiesPerl): pass
        
class EntitiesPython(EntityHandler):
    """
    entity-matching handler for Python (py) files
    """
    entityMatchLine = re.compile(r'^\s*(?P<type>(class|def)\s+)(?P<entity>.*:\s*$)')

class EntitiesPy(EntitiesPython): pass

class EntitiesRuby(EntityHandler):
    """
    entity-matching handler for Ruby (rb) files
    """
    entityMatchLine = re.compile(r'^\s*(?P<prefix>(class|module|def)\s+)(?P<main>.*)(?P<suffix>\s*$)')
        
class EntitiesHtml_ruby(EntitiesRuby): pass
class EntitiesRb(EntitiesRuby): pass

#-------------------------------------------------------------------------
# END: ENTITY HANDLERS
#-------------------------------------------------------------------------

class EntityNav:
    """
    Produces a parsable entity-navigation of a code file (designed for TextMate's command window)
    """
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
        """
        outputs a <line number>:<line> entity list 
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