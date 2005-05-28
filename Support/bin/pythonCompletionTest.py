#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  pythonCompletionTest
#
#  Created by Jeroen on 2005-05-28.
#  Copyright (c) 2005 . All rights reserved.
#

import unittest
import pythonCompletion

class pythonCompletionTest(unittest.TestCase):
    def setUp(self):
        pass

    def testGetModuleNameFromLine(self):
        self.assertEqual("something.getopt", pythonCompletion.getModuleNameFromLine(word="err", line="        except something.getopt.err, msg:", column=36))
        self.assertEqual("right.module", pythonCompletion.getModuleNameFromLine(word="word",
            line="          wrong.module.word module.word.internal right.module.word wrong.module.word", column=67))
        
    def testGetSuggestionListModule(self):
        self.assertEqual(["maxunicode"], pythonCompletion.getSuggestionListModule(module="sys", word="maxu"))
        self.assertEqual(["getSuggestionListFile", "getSuggestionListModule"], pythonCompletion.getSuggestionListModule(module="pythonCompletion", word="getSug"))
        self.assertEqual([], pythonCompletion.getSuggestionListModule(module="nonExistingModule", word="getSug"))

    def testGetSuggestionListFile(self):
        self.assertEqual(["getSuggestionListFile", "getSuggestionListModule"], pythonCompletion.getSuggestionListFile(word="getSug", filename="pythonCompletion.py"))
        self.assertEqual([], pythonCompletion.getSuggestionListFile(word="foobarsomethingsomething", filename="pythonCompletion.py"))
        self.assertEqual([], pythonCompletion.getSuggestionListFile(word="foobarsomethingsomething", filename="nonExistingFile"))
        
    def testComplete(self):
        self.assertEqual(["maxunicode"], pythonCompletion.complete(word="maxu",
            line="          wrong.module.word module.word.internal sys.maxu wrong.module.word", column=58))
        self.assertEqual(["getSuggestionListFile", "getSuggestionListModule"], pythonCompletion.complete(word="getSug",
            line="This is some stupid line to test pythonCompletion on getSug", column=28, filename="pythonCompletion.py"))

if __name__ == '__main__':
    unittest.main()
