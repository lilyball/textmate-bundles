"""controller"""

import sys, re
from exceptions import *
from special_items import handler

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
        self.handler = handler.getHandler(self.mode)
        try:
            if self.sortEntities and not isinstance(self.handler, handler.SortableEntities):
                raise SortException, "Handler for mode '%s' does not support sorting" % self.mode
        except SortException, err:
            self.sortEntities = False
            if not self.sortEntitiesSilently:
                raise err
        self.handler.sortEntities = self.sortEntities
        self.handler.sortEntitiesSilently = self.sortEntitiesSilently
            
    def outputParsable(self):
        """outputs a <line number>:<line> entity list 
        
        return exit status
        @see EntityHandler.outputParsable()
        """
        try:
            self.findEntities()        
        except HandlerNoEntitiesException:
            sys.stdout.write("0:NO ENTITIES FOUND")
            return 1
            
        self.handler.outputParsable()
        return 0
            
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