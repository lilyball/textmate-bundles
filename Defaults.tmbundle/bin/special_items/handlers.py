#!/usr/bin/env python

"""Contains handler classes for specific languages, listed alphabetically.
  
To create a new language handler, name the class Entities<Mode> where 
<Mode> is the $TM_MODE (TextMate file mode) converted to title case. 
I.E. HTML_PHP becomes Html_php.

Also note that any non alphanumeric/underscore characters get converted to `_'.
It is also possible to set a mode using a filename extension.  Therefore you need to assign the 
correct class to a variable named after a class that would be looked up for <mode>

For example, 
EntitiesCss gets assigned like so:

EntitiesCss_html = EntitiesCss
EntitiesCss_php = EntitiesCss

If you are unsure of a TextMate mode, just run this command on a file and you will see the error :)

To create sortable entity handlers, see the abstract SortableEntities class
"""

import sys, os, re, string, getopt

class HandlerException(Exception): pass
class HandlerNoEntitiesException(HandlerException): pass
class SortException(Exception): pass
class ParseException(Exception): pass

def getHandler(mode):
    """gets an entity-matching handler for the mode in question"""
    classSuffix = mode.capitalize()   
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
    """abstract class for language-specific Entity handlers"""
    entities = {}
    sortEntities = False
    sortEntitiesSilently = False
    entityMatchLine = None # re.compile() result, used in EntityHandler.readLine()
        
    def deconstructLine(self,lineMatch):
        """deconstructs a line into something meaningful, so that sorting can be applied
        
        @param (re.SRE_Match) lineMatch
        @return (tuple) of each hierarchical group, like (<class>, <function>, <args>)
        """
        return lineMatch.string
        
    def foundEntities(self):
        return (self.entities != {})
        
    def outputParsable(self):
        """takes dict of line numbers to file lines and outputs <line number>:<line>"""
        sys.stdout.write( "".join(map(self.reconstructLine, self.sort())) )
        #sys.stdout.write( "".join( ["%s:%s" % (lineNum,line) for lineNum,line in entitiesAsCoded] ))
        
    def readLine(self, lineNum, line):
        try:
            lineMatch = self.entityMatchLine.match(line)
        except AttributeError:
            raise HandlerException("there is no match method to readLine() with")
        if lineMatch:
            line = self.deconstructLine(lineMatch)
            self.entities[lineNum] = line
        return (line, lineMatch)
        
    def reconstructLine(self, line):
        """takes in a line that was deconstructed by deconstructLine and outputs it so that
        the result is <line number>:<line>
        
        @param (mixed) line - the line the way it was returned by deconstructLine
        """
        return "%s:%s" % (line[0],line[1])
        
    def sort(self):
        """needs to sort entities and return a list that self.outputParsable() can understand
        
        default is to sort entities by line number :
        """ 
        entities = self.entities
        lineNums = entities.keys()
        lineNums.sort()
        
        entitiesAsCoded = zip(lineNums, map(entities.get, lineNums))
        return entitiesAsCoded

class SortableEntities(EntityHandler):
    """abstract class for sortable entities
    
    This can be inherited by any handler who wants to handle the --sort flag, so entities have 
    some way to sort themselves, like alphabetically grouped by class, function ... etc
    """    
    def sort(self):
        if not self.sortEntities:
            return EntityHandler.sort(self)
            
        raise SortException("abstract: subclass must define sort() routine")
        
class SortableByMainEntity(SortableEntities):
    """abstract SortableEntities that sorts by an entity group named "main"
    It also expects matches to be defined as 3 groups, "main", "prefix", "suffix"
    """
    def deconstructLine(self, lineMatch):
        if not self.sortEntities:
            return EntityHandler.deconstructLine(self, lineMatch)
        try:
            return (lineMatch.group('main'),lineMatch.group('prefix'),lineMatch.group('suffix'))
        except IndexError:
            raise SortException("expected lineMatch groups 'main', 'prefix', and 'suffix'")
        
    def reconstructLine(self, line):
        if not self.sortEntities:
            return EntityHandler.reconstructLine(self, line)
        return "%s:%s\n" % (line[1],(line[0][1]+line[0][0]+line[0][2]))
        
    def sort(self):
        if not self.sortEntities:
            return EntityHandler.sort(self)
            
        lineNums = self.entities.keys()
        sortedByMain = map(lambda lineNum: (self.entities[lineNum],lineNum), lineNums)
        sortedByMain.sort()
        return sortedByMain
        
class SortableByClass(SortableEntities):
    """abstract SortableEntities that sorts by matched groups matched as classes then groups matched as functions
    Expects match groups: 'indent', 'entity', 'name', 'args'
    """
    # set these in the subclass:
    functionPtrn = None
    classPtrn = None
    
    # protected attributes:
    classes = []
    functions = {}
    functionIndex = '__GLOBAL__'
    
    def deconstructLine(self, lineMatch):
        """takes in a successful lineMatch and returns something that self.reconstructLine() will understand"""
        if not self.sortEntities:
            return EntityHandler.deconstructLine(self, lineMatch)
        try:
            return (lineMatch.group('entity'),lineMatch.group('name'),lineMatch.group('args'),lineMatch.group('indent'))
        except IndexError:
            raise HandlerException("abstract SortableByClass must define match groups: 'indent', 'entity', 'name', 'args'")
        
    def readLine(self, lineNum, line):
        """extends EntityHandler.readLine() so that classes and functions can be extracted"""
        (line, lineMatch) = EntityHandler.readLine(self, lineNum, line)
        if lineMatch:
            entity = lineMatch.group('entity')
            name = lineMatch.group('name')
            try:
                functionMatch = self.functionPtrn.match
                classMatch = self.classPtrn.match
            except AttributeError:
                raise HandlerException("abstract SortableByClass must define patterns self.functionPtrn and self.classPtrn")
            
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
        """reconstructs what was deconstructed by self.deconstructLine() and formats for proper output"""
        if not self.sortEntities:
            return EntityHandler.reconstructLine(self, line)
        return "%s:%s\n" % (line[1],(line[0][3]+line[0][0]+line[0][1]+line[0][2]))
        
    def sort(self):
        """sort entities hierachically by class, then by function"""
        if not self.sortEntities:
            return EntityHandler.sort(self)
            
        sorted = []
        try:
            self.functions['__GLOBAL__'].sort()
            sorted.extend(self.functions['__GLOBAL__'])
        except KeyError:
            pass
        self.classes.sort()
        for line,lineNum in self.classes:
            sorted.append((line, lineNum))
            className = line[1]
            try:
                self.functions[className].sort()
                sorted.extend(self.functions[className])
            except KeyError:
                pass
                
        return sorted
        
class EntitiesCss(SortableByMainEntity):
    """entity-matching handler for CSS (css) files"""
    entityMatchLine = re.compile(r'(?P<prefix>^[\s]*)(?P<main>([\*\s]+(html|body)\s+)?[a-zA-Z_\.,#]+[\sa-zA-Z_\.,#\{:]*)(?P<suffix>[^;]+)$')

EntitiesCss_html = EntitiesCss
EntitiesCss_php = EntitiesCss

class EntitiesJavascript(SortableByMainEntity):
    """entity-matching handler for JavaScript (js) files
    
    NOTE: does not handle prototypes (i.e. creating a pseudo-class).  This can happen once I rewrite the sorting stuff -Kumar
    """
    entityMatchLine = re.compile(r'(?P<prefix>^\s*function\s+)(?P<main>[^$]+[&a-zA-Z0-9_]+)(?P<suffix>.*$)')

EntitiesJs = EntitiesJavascript

class EntitiesLatex(SortableByMainEntity):
    """entity-matching handler for LaTeX (tex) files"""
    entityMatchLine = re.compile(r'^\s*(?P<prefix>\\(sub)*section{|\\paragraph{)(?P<main>.*)(?P<suffix>}.*$)')
    
EntitiesTex = EntitiesLatex
        
class EntitiesPhp(SortableByClass):
    """entity-matching handler for PHP (php) files
    this adds to SortableByClass the 'visibility' group
    """
    entityMatchLine = re.compile(r'(?P<indent>^\s*)(?P<visibility>(final|abstract)?\s?(public|private|protected)?\s?(static)?\s*)(?P<entity>(function|class|interface)\s+)(?P<name>[^$]+[&a-zA-Z0-9_]+)(?P<args>.*$)')    
    functionPtrn = re.compile(r'function', re.IGNORECASE)
    classPtrn = re.compile(r'(class|interface)', re.IGNORECASE)
        
    def deconstructLine(self, lineMatch):
        if not self.sortEntities:
            return EntityHandler.deconstructLine(self, lineMatch)
        return (lineMatch.group('entity'),lineMatch.group('name'),lineMatch.group('visibility'),lineMatch.group('args'),lineMatch.group('indent'))
        
    def reconstructLine(self, line):
        if not self.sortEntities:
            return EntityHandler.reconstructLine(self, line)
        return "%s:%s\n" % (line[1],(line[0][4]+line[0][2]+line[0][0]+line[0][1]+line[0][3]))

EntitiesHtml_php = EntitiesPhp
EntitiesInc = EntitiesPhp
        
class EntitiesPerl(SortableByMainEntity):
    """entity-matching handler for Perl (pl) files"""
    entityMatchLine = re.compile(r'^\s*(?P<prefix>sub\s+)(?P<main>.*)(?P<suffix>\s*$)')

EntitiesPl = EntitiesPerl
EntitiesPm = EntitiesPerl
        
class EntitiesPython(SortableByClass):
    """entity-matching handler for Python (py) files"""
    entityMatchLine = re.compile(r'(?P<indent>^\s*)(?P<entity>(class|def)\s+)(?P<name>[a-zA-Z0-9_]+)(?P<args>.*:.*$)')
    functionPtrn = re.compile(r'^def', re.IGNORECASE)
    classPtrn = re.compile(r'^class', re.IGNORECASE)
        
    def readLine(self, lineNum, line):
        """extends EntityHandler.readLine() so that classes and functions can be extracted"""
        (line, lineMatch) = EntityHandler.readLine(self, lineNum, line)
        if lineMatch:
            entity = lineMatch.group('entity')
            name = lineMatch.group('name')
            try:
                functionMatch = self.functionPtrn.match
                classMatch = self.classPtrn.match
            except AttributeError:
                raise HandlerException("abstract SortableByClass must define patterns self.functionPtrn and self.classPtrn")
            
            if functionMatch(entity):
                index = self.functionIndex
                if lineMatch.group('indent') is "":
                    # assume this is a global function :
                    index = '__GLOBAL__'
                try:
                    self.functions[index].append((line, lineNum))
                except KeyError:
                    self.functions[index] = [(line, lineNum)]
            elif classMatch(entity):
                self.classes.append((line, lineNum))
                self.functionIndex = name
            else:
                raise HandlerException("unexpected entity: '" + entity + "'")
        return (line, lineMatch)
        
EntitiesPy = EntitiesPython

class EntitiesRuby(SortableByClass):
    """entity-matching handler for Ruby (rb) files"""
    entityMatchLine = re.compile(r'(?P<indent>^\s*)(?P<entity>(class|module|def)\s+)(?P<name>.*)(?P<args>\s*$)')
    functionPtrn = re.compile(r'^def', re.IGNORECASE)
    modulePtrn = re.compile(r'^module', re.IGNORECASE)
    classPtrn = re.compile(r'^class', re.IGNORECASE)
    modules = []
    classes = {}
    functions = {}
    functionIndex = '__GLOBAL__'
    moduleIndex = '__GLOBAL__'
        
    def readLine(self, lineNum, line):
        """extends EntityHandler.readLine() so that classes and functions can be extracted"""
        (line, lineMatch) = EntityHandler.readLine(self, lineNum, line)
        if lineMatch:
            entity = lineMatch.group('entity')
            name = lineMatch.group('name')
                        
            if self.functionPtrn.match(entity):
                try:
                    self.functions[self.functionIndex].append((line, lineNum))
                except KeyError:
                    self.functions[self.functionIndex] = [(line, lineNum)]
            elif self.classPtrn.match(entity):
                try:
                    self.classes[self.moduleIndex].append((line, lineNum))
                except KeyError:
                    self.classes[self.moduleIndex] = [(line, lineNum)]
                self.functionIndex = name
            elif self.modulePtrn.match(entity):
                self.modules.append((line, lineNum))
                self.moduleIndex = name
            else:
                raise HandlerException("unexpected entity: '" + entity + "'")
        return (line, lineMatch)
                
    def sort(self):
        """sort entities hierachically by module, class, function"""
        if not self.sortEntities:
            return EntityHandler.sort(self)
            
        sorted = []
        try:
            self.classes['__GLOBAL__'].sort()
            sorted.extend(self.sortClassFunctions(self.classes['__GLOBAL__']))
        except KeyError:
            pass
        try:
            self.functions['__GLOBAL__'].sort()
            sorted.extend(self.functions['__GLOBAL__'])
        except KeyError:
            pass
        self.modules.sort()
        for line,lineNum in self.modules:
            sorted.append((line, lineNum))
            moduleName = line[1]
            try:
                self.classes[moduleName].sort()
                sorted.extend(self.sortClassFunctions(self.classes[moduleName]))
            except KeyError:
                pass
                
        return sorted
        
    def sortClassFunctions(self, classes):
        sorted = []
        for line, lineNum in classes:
            sorted.append((line, lineNum))
            className = line[1]
            try:
                self.functions[className].sort()
                sorted.extend(self.functions[className])
            except KeyError:
                pass
        return sorted
        
EntitiesHtml_ruby = EntitiesRuby
EntitiesRb = EntitiesRuby
