What you currently can do with this Bundle:
===========================================
   
   - 'Add to Repository':
      adds the selected files to the repository.
   
   - update things:
      - 'Update to Latest':       updates the currently selected files to the newest available.
      - 'Update Entire Project':  updates everything.
   
   - 'Status':
      'svn st' in HTML.
   
   - 'Commit':
      sends your changes to the repository.
   
   - 'Blame':
      'svn blame' in clickable HTML, shows you who wrote which line in which revision.
   
   - view the the diff of the active file against various versions:
      - 'Diff With Base':      everything you changed since the last update / checkout. (needs no internet)
      - 'Diff With Latest':    everything different from the newest revision in the repository.
      - 'Diff With Previous':  everything different from previous rev in the repo.
   
   - Log:
      'svn log' in HTML, shows you the commit messages for the current file.  configurable
      via some vars, see below.
   
   
Configuration Options:
======================
   
   - $TM_SVN               -- the path to your svn executable,           default: svn
   - $TM_SVN_LOG_RANGE     -- the default range to query for messages,   default: BASE:1
   - $TM_SVN_LOG_LIMIT     -- the number of messages, to actually show,  default: 7
