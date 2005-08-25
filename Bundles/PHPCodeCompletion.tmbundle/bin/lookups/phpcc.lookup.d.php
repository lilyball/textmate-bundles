<?php
$_LOOKUP = array( 
"date_sunrise" => array( 
	"methodname" => "date_sunrise", 
	"version" => "PHP5", 
	"method" => "mixed date_sunrise ( int timestamp [, int format [, float latitude [, float longitude [, float zenith [, float gmt_offset]]]]] )", 
	"snippet" => "( \${1:\$timestamp} )", 
	"desc" => "Returns time of sunrise for a given day and location", 
	"docurl" => "function.date-sunrise.html" 
),
"date_sunset" => array( 
	"methodname" => "date_sunset", 
	"version" => "PHP5", 
	"method" => "mixed date_sunset ( int timestamp [, int format [, float latitude [, float longitude [, float zenith [, float gmt_offset]]]]] )", 
	"snippet" => "( \${1:\$timestamp} )", 
	"desc" => "Returns time of sunset for a given day and location", 
	"docurl" => "function.date-sunset.html" 
),
"date" => array( 
	"methodname" => "date", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string date ( string format [, int timestamp] )", 
	"snippet" => "( \${1:\$format} )", 
	"desc" => "Format a local time/date", 
	"docurl" => "function.date.html" 
),
"dba_close" => array( 
	"methodname" => "dba_close", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "void dba_close ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Close a DBA database", 
	"docurl" => "function.dba-close.html" 
),
"dba_delete" => array( 
	"methodname" => "dba_delete", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool dba_delete ( string key, resource handle )", 
	"snippet" => "( \${1:\$key}, \${2:\$handle} )", 
	"desc" => "Delete DBA entry specified by key", 
	"docurl" => "function.dba-delete.html" 
),
"dba_exists" => array( 
	"methodname" => "dba_exists", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool dba_exists ( string key, resource handle )", 
	"snippet" => "( \${1:\$key}, \${2:\$handle} )", 
	"desc" => "Check whether key exists", 
	"docurl" => "function.dba-exists.html" 
),
"dba_fetch" => array( 
	"methodname" => "dba_fetch", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "string dba_fetch ( string key, resource handle )", 
	"snippet" => "( \${1:\$key}, \${2:\$handle} )", 
	"desc" => "Fetch data specified by key", 
	"docurl" => "function.dba-fetch.html" 
),
"dba_firstkey" => array( 
	"methodname" => "dba_firstkey", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "string dba_firstkey ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Fetch first key", 
	"docurl" => "function.dba-firstkey.html" 
),
"dba_handlers" => array( 
	"methodname" => "dba_handlers", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array dba_handlers ( [bool full_info] )", 
	"snippet" => "( \$1 )", 
	"desc" => "List all the handlers available", 
	"docurl" => "function.dba-handlers.html" 
),
"dba_insert" => array( 
	"methodname" => "dba_insert", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool dba_insert ( string key, string value, resource handle )", 
	"snippet" => "( \${1:\$key}, \${2:\$value}, \${3:\$handle} )", 
	"desc" => "Insert entry", 
	"docurl" => "function.dba-insert.html" 
),
"dba_key_split" => array( 
	"methodname" => "dba_key_split", 
	"version" => "PHP5", 
	"method" => "mixed dba_key_split ( mixed key )", 
	"snippet" => "( \${1:\$key} )", 
	"desc" => "Splits a key in string representation into array representation", 
	"docurl" => "function.dba-key-split.html" 
),
"dba_list" => array( 
	"methodname" => "dba_list", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array dba_list ( void  )", 
	"snippet" => "(  )", 
	"desc" => "List all open database files", 
	"docurl" => "function.dba-list.html" 
),
"dba_nextkey" => array( 
	"methodname" => "dba_nextkey", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "string dba_nextkey ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Fetch next key", 
	"docurl" => "function.dba-nextkey.html" 
),
"dba_open" => array( 
	"methodname" => "dba_open", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "resource dba_open ( string path, string mode, string handler [, ...] )", 
	"snippet" => "( \${1:\$path}, \${2:\$mode}, \${3:\$handler} )", 
	"desc" => "Open database", 
	"docurl" => "function.dba-open.html" 
),
"dba_optimize" => array( 
	"methodname" => "dba_optimize", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool dba_optimize ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Optimize database", 
	"docurl" => "function.dba-optimize.html" 
),
"dba_popen" => array( 
	"methodname" => "dba_popen", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "resource dba_popen ( string path, string mode, string handler [, ...] )", 
	"snippet" => "( \${1:\$path}, \${2:\$mode}, \${3:\$handler} )", 
	"desc" => "Open database persistently", 
	"docurl" => "function.dba-popen.html" 
),
"dba_replace" => array( 
	"methodname" => "dba_replace", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool dba_replace ( string key, string value, resource handle )", 
	"snippet" => "( \${1:\$key}, \${2:\$value}, \${3:\$handle} )", 
	"desc" => "Replace or insert entry", 
	"docurl" => "function.dba-replace.html" 
),
"dba_sync" => array( 
	"methodname" => "dba_sync", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool dba_sync ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Synchronize database", 
	"docurl" => "function.dba-sync.html" 
),
"dbase_add_record" => array( 
	"methodname" => "dbase_add_record", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool dbase_add_record ( int dbase_identifier, array record )", 
	"snippet" => "( \${1:\$dbase_identifier}, \${2:\$record} )", 
	"desc" => "Adds a record to a database", 
	"docurl" => "function.dbase-add-record.html" 
),
"dbase_close" => array( 
	"methodname" => "dbase_close", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool dbase_close ( int dbase_identifier )", 
	"snippet" => "( \${1:\$dbase_identifier} )", 
	"desc" => "Closes a database", 
	"docurl" => "function.dbase-close.html" 
),
"dbase_create" => array( 
	"methodname" => "dbase_create", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int dbase_create ( string filename, array fields )", 
	"snippet" => "( \${1:\$filename}, \${2:\$fields} )", 
	"desc" => "Creates a database", 
	"docurl" => "function.dbase-create.html" 
),
"dbase_delete_record" => array( 
	"methodname" => "dbase_delete_record", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool dbase_delete_record ( int dbase_identifier, int record_number )", 
	"snippet" => "( \${1:\$dbase_identifier}, \${2:\$record_number} )", 
	"desc" => "Deletes a record from a database", 
	"docurl" => "function.dbase-delete-record.html" 
),
"dbase_get_header_info" => array( 
	"methodname" => "dbase_get_header_info", 
	"version" => "PHP5", 
	"method" => "array dbase_get_header_info ( int dbase_identifier )", 
	"snippet" => "( \${1:\$dbase_identifier} )", 
	"desc" => "Gets the header info of a database", 
	"docurl" => "function.dbase-get-header-info.html" 
),
"dbase_get_record_with_names" => array( 
	"methodname" => "dbase_get_record_with_names", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "array dbase_get_record_with_names ( int dbase_identifier, int record_number )", 
	"snippet" => "( \${1:\$dbase_identifier}, \${2:\$record_number} )", 
	"desc" => "Gets a record from a database as an associative array", 
	"docurl" => "function.dbase-get-record-with-names.html" 
),
"dbase_get_record" => array( 
	"methodname" => "dbase_get_record", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array dbase_get_record ( int dbase_identifier, int record_number )", 
	"snippet" => "( \${1:\$dbase_identifier}, \${2:\$record_number} )", 
	"desc" => "Gets a record from a database as an indexed array", 
	"docurl" => "function.dbase-get-record.html" 
),
"dbase_numfields" => array( 
	"methodname" => "dbase_numfields", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int dbase_numfields ( int dbase_identifier )", 
	"snippet" => "( \${1:\$dbase_identifier} )", 
	"desc" => "Gets the number of fields of a database", 
	"docurl" => "function.dbase-numfields.html" 
),
"dbase_numrecords" => array( 
	"methodname" => "dbase_numrecords", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int dbase_numrecords ( int dbase_identifier )", 
	"snippet" => "( \${1:\$dbase_identifier} )", 
	"desc" => "Gets the number of records in a database", 
	"docurl" => "function.dbase-numrecords.html" 
),
"dbase_open" => array( 
	"methodname" => "dbase_open", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int dbase_open ( string filename, int mode )", 
	"snippet" => "( \${1:\$filename}, \${2:\$mode} )", 
	"desc" => "Opens a database", 
	"docurl" => "function.dbase-open.html" 
),
"dbase_pack" => array( 
	"methodname" => "dbase_pack", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool dbase_pack ( int dbase_identifier )", 
	"snippet" => "( \${1:\$dbase_identifier} )", 
	"desc" => "Packs a database", 
	"docurl" => "function.dbase-pack.html" 
),
"dbase_replace_record" => array( 
	"methodname" => "dbase_replace_record", 
	"version" => "PHP3>= 3.0.11, PHP4, PHP5", 
	"method" => "bool dbase_replace_record ( int dbase_identifier, array record, int record_number )", 
	"snippet" => "( \${1:\$dbase_identifier}, \${2:\$record}, \${3:\$record_number} )", 
	"desc" => "Replaces a record in a database", 
	"docurl" => "function.dbase-replace-record.html" 
),
"dblist" => array( 
	"methodname" => "dblist", 
	"version" => "PHP3, PHP4", 
	"method" => "string dblist ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Describes the DBM-compatible library being used", 
	"docurl" => "function.dblist.html" 
),
"dbmclose" => array( 
	"methodname" => "dbmclose", 
	"version" => "PHP3, PHP4", 
	"method" => "bool dbmclose ( resource dbm_identifier )", 
	"snippet" => "( \${1:\$dbm_identifier} )", 
	"desc" => "Closes a dbm database", 
	"docurl" => "function.dbmclose.html" 
),
"dbmdelete" => array( 
	"methodname" => "dbmdelete", 
	"version" => "PHP3, PHP4", 
	"method" => "bool dbmdelete ( resource dbm_identifier, string key )", 
	"snippet" => "( \${1:\$dbm_identifier}, \${2:\$key} )", 
	"desc" => "Deletes the value for a key from a DBM database", 
	"docurl" => "function.dbmdelete.html" 
),
"dbmexists" => array( 
	"methodname" => "dbmexists", 
	"version" => "PHP3, PHP4", 
	"method" => "bool dbmexists ( resource dbm_identifier, string key )", 
	"snippet" => "( \${1:\$dbm_identifier}, \${2:\$key} )", 
	"desc" => "Tells if a value exists for a key in a DBM database", 
	"docurl" => "function.dbmexists.html" 
),
"dbmfetch" => array( 
	"methodname" => "dbmfetch", 
	"version" => "PHP3, PHP4", 
	"method" => "string dbmfetch ( resource dbm_identifier, string key )", 
	"snippet" => "( \${1:\$dbm_identifier}, \${2:\$key} )", 
	"desc" => "Fetches a value for a key from a DBM database", 
	"docurl" => "function.dbmfetch.html" 
),
"dbmfirstkey" => array( 
	"methodname" => "dbmfirstkey", 
	"version" => "PHP3, PHP4", 
	"method" => "string dbmfirstkey ( resource dbm_identifier )", 
	"snippet" => "( \${1:\$dbm_identifier} )", 
	"desc" => "Retrieves the first key from a DBM database", 
	"docurl" => "function.dbmfirstkey.html" 
),
"dbminsert" => array( 
	"methodname" => "dbminsert", 
	"version" => "PHP3, PHP4", 
	"method" => "int dbminsert ( resource dbm_identifier, string key, string value )", 
	"snippet" => "( \${1:\$dbm_identifier}, \${2:\$key}, \${3:\$value} )", 
	"desc" => "Inserts a value for a key in a DBM database", 
	"docurl" => "function.dbminsert.html" 
),
"dbmnextkey" => array( 
	"methodname" => "dbmnextkey", 
	"version" => "PHP3, PHP4", 
	"method" => "string dbmnextkey ( resource dbm_identifier, string key )", 
	"snippet" => "( \${1:\$dbm_identifier}, \${2:\$key} )", 
	"desc" => "Retrieves the next key from a DBM database", 
	"docurl" => "function.dbmnextkey.html" 
),
"dbmopen" => array( 
	"methodname" => "dbmopen", 
	"version" => "PHP3, PHP4", 
	"method" => "resource dbmopen ( string filename, string flags )", 
	"snippet" => "( \${1:\$filename}, \${2:\$flags} )", 
	"desc" => "Opens a DBM database", 
	"docurl" => "function.dbmopen.html" 
),
"dbmreplace" => array( 
	"methodname" => "dbmreplace", 
	"version" => "PHP3, PHP4", 
	"method" => "int dbmreplace ( resource dbm_identifier, string key, string value )", 
	"snippet" => "( \${1:\$dbm_identifier}, \${2:\$key}, \${3:\$value} )", 
	"desc" => "Replaces the value for a key in a DBM database", 
	"docurl" => "function.dbmreplace.html" 
),
"dbplus_add" => array( 
	"methodname" => "dbplus_add", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_add ( resource relation, array tuple )", 
	"snippet" => "( \${1:\$relation}, \${2:\$tuple} )", 
	"desc" => "Add a tuple to a relation", 
	"docurl" => "function.dbplus-add.html" 
),
"dbplus_aql" => array( 
	"methodname" => "dbplus_aql", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "resource dbplus_aql ( string query [, string server [, string dbpath]] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Perform AQL query", 
	"docurl" => "function.dbplus-aql.html" 
),
"dbplus_chdir" => array( 
	"methodname" => "dbplus_chdir", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "string dbplus_chdir ( [string newdir] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get/Set database virtual current directory", 
	"docurl" => "function.dbplus-chdir.html" 
),
"dbplus_close" => array( 
	"methodname" => "dbplus_close", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_close ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Close a relation", 
	"docurl" => "function.dbplus-close.html" 
),
"dbplus_curr" => array( 
	"methodname" => "dbplus_curr", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_curr ( resource relation, array &tuple )", 
	"snippet" => "( \${1:\$relation}, \${2:\$tuple} )", 
	"desc" => "Get current tuple from relation", 
	"docurl" => "function.dbplus-curr.html" 
),
"dbplus_errcode" => array( 
	"methodname" => "dbplus_errcode", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "string dbplus_errcode ( [int errno] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get error string for given errorcode or last error", 
	"docurl" => "function.dbplus-errcode.html" 
),
"dbplus_errno" => array( 
	"methodname" => "dbplus_errno", 
	"version" => "undefined", 
	"method" => "int dbplus_errno ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get error code for last operation", 
	"docurl" => "function.dbplus-errno.html" 
),
"dbplus_find" => array( 
	"methodname" => "dbplus_find", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_find ( resource relation, array constraints, mixed tuple )", 
	"snippet" => "( \${1:\$relation}, \${2:\$constraints}, \${3:\$tuple} )", 
	"desc" => "Set a constraint on a relation", 
	"docurl" => "function.dbplus-find.html" 
),
"dbplus_first" => array( 
	"methodname" => "dbplus_first", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_first ( resource relation, array &tuple )", 
	"snippet" => "( \${1:\$relation}, \${2:\$tuple} )", 
	"desc" => "Get first tuple from relation", 
	"docurl" => "function.dbplus-first.html" 
),
"dbplus_flush" => array( 
	"methodname" => "dbplus_flush", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_flush ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Flush all changes made on a relation", 
	"docurl" => "function.dbplus-flush.html" 
),
"dbplus_freealllocks" => array( 
	"methodname" => "dbplus_freealllocks", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_freealllocks ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Free all locks held by this client", 
	"docurl" => "function.dbplus-freealllocks.html" 
),
"dbplus_freelock" => array( 
	"methodname" => "dbplus_freelock", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_freelock ( resource relation, string tname )", 
	"snippet" => "( \${1:\$relation}, \${2:\$tname} )", 
	"desc" => "Release write lock on tuple", 
	"docurl" => "function.dbplus-freelock.html" 
),
"dbplus_freerlocks" => array( 
	"methodname" => "dbplus_freerlocks", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_freerlocks ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Free all tuple locks on given relation", 
	"docurl" => "function.dbplus-freerlocks.html" 
),
"dbplus_getlock" => array( 
	"methodname" => "dbplus_getlock", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_getlock ( resource relation, string tname )", 
	"snippet" => "( \${1:\$relation}, \${2:\$tname} )", 
	"desc" => "Get a write lock on a tuple", 
	"docurl" => "function.dbplus-getlock.html" 
),
"dbplus_getunique" => array( 
	"methodname" => "dbplus_getunique", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_getunique ( resource relation, int uniqueid )", 
	"snippet" => "( \${1:\$relation}, \${2:\$uniqueid} )", 
	"desc" => "Get an id number unique to a relation", 
	"docurl" => "function.dbplus-getunique.html" 
),
"dbplus_info" => array( 
	"methodname" => "dbplus_info", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_info ( resource relation, string key, array &result )", 
	"snippet" => "( \${1:\$relation}, \${2:\$key}, \${3:\$result} )", 
	"desc" => "Get information about a relation", 
	"docurl" => "function.dbplus-info.html" 
),
"dbplus_last" => array( 
	"methodname" => "dbplus_last", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_last ( resource relation, array &tuple )", 
	"snippet" => "( \${1:\$relation}, \${2:\$tuple} )", 
	"desc" => "Get last tuple from relation", 
	"docurl" => "function.dbplus-last.html" 
),
"dbplus_lockrel" => array( 
	"methodname" => "dbplus_lockrel", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "int dbplus_lockrel ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Request write lock on relation", 
	"docurl" => "function.dbplus-lockrel.html" 
),
"dbplus_next" => array( 
	"methodname" => "dbplus_next", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_next ( resource relation, array &tuple )", 
	"snippet" => "( \${1:\$relation}, \${2:\$tuple} )", 
	"desc" => "Get next tuple from relation", 
	"docurl" => "function.dbplus-next.html" 
),
"dbplus_open" => array( 
	"methodname" => "dbplus_open", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "resource dbplus_open ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Open relation file", 
	"docurl" => "function.dbplus-open.html" 
),
"dbplus_prev" => array( 
	"methodname" => "dbplus_prev", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_prev ( resource relation, array &tuple )", 
	"snippet" => "( \${1:\$relation}, \${2:\$tuple} )", 
	"desc" => "Get previous tuple from relation", 
	"docurl" => "function.dbplus-prev.html" 
),
"dbplus_rchperm" => array( 
	"methodname" => "dbplus_rchperm", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_rchperm ( resource relation, int mask, string user, string group )", 
	"snippet" => "( \${1:\$relation}, \${2:\$mask}, \${3:\$user}, \${4:\$group} )", 
	"desc" => "Change relation permissions", 
	"docurl" => "function.dbplus-rchperm.html" 
),
"dbplus_rcreate" => array( 
	"methodname" => "dbplus_rcreate", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "resource dbplus_rcreate ( string name, mixed domlist [, bool overwrite] )", 
	"snippet" => "( \${1:\$name}, \${2:\$domlist} )", 
	"desc" => "Creates a new DB++ relation", 
	"docurl" => "function.dbplus-rcreate.html" 
),
"dbplus_rcrtexact" => array( 
	"methodname" => "dbplus_rcrtexact", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "resource dbplus_rcrtexact ( string name, resource relation [, bool overwrite] )", 
	"snippet" => "( \${1:\$name}, \${2:\$relation} )", 
	"desc" => "Creates an exact but empty copy of a relation including indices", 
	"docurl" => "function.dbplus-rcrtexact.html" 
),
"dbplus_rcrtlike" => array( 
	"methodname" => "dbplus_rcrtlike", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "resource dbplus_rcrtlike ( string name, resource relation [, int overwrite] )", 
	"snippet" => "( \${1:\$name}, \${2:\$relation} )", 
	"desc" => "Creates an empty copy of a relation with default indices", 
	"docurl" => "function.dbplus-rcrtlike.html" 
),
"dbplus_resolve" => array( 
	"methodname" => "dbplus_resolve", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_resolve ( string relation_name )", 
	"snippet" => "( \${1:\$relation_name} )", 
	"desc" => "Resolve host information for relation", 
	"docurl" => "function.dbplus-resolve.html" 
),
"dbplus_restorepos" => array( 
	"methodname" => "dbplus_restorepos", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_restorepos ( resource relation, array tuple )", 
	"snippet" => "( \${1:\$relation}, \${2:\$tuple} )", 
	"desc" => "Restore position", 
	"docurl" => "function.dbplus-restorepos.html" 
),
"dbplus_rkeys" => array( 
	"methodname" => "dbplus_rkeys", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "resource dbplus_rkeys ( resource relation, mixed domlist )", 
	"snippet" => "( \${1:\$relation}, \${2:\$domlist} )", 
	"desc" => "Specify new primary key for a relation", 
	"docurl" => "function.dbplus-rkeys.html" 
),
"dbplus_ropen" => array( 
	"methodname" => "dbplus_ropen", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "resource dbplus_ropen ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Open relation file local", 
	"docurl" => "function.dbplus-ropen.html" 
),
"dbplus_rquery" => array( 
	"methodname" => "dbplus_rquery", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_rquery ( string query [, string dbpath] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Perform local (raw) AQL query", 
	"docurl" => "function.dbplus-rquery.html" 
),
"dbplus_rrename" => array( 
	"methodname" => "dbplus_rrename", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_rrename ( resource relation, string name )", 
	"snippet" => "( \${1:\$relation}, \${2:\$name} )", 
	"desc" => "Rename a relation", 
	"docurl" => "function.dbplus-rrename.html" 
),
"dbplus_rsecindex" => array( 
	"methodname" => "dbplus_rsecindex", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "resource dbplus_rsecindex ( resource relation, mixed domlist, int type )", 
	"snippet" => "( \${1:\$relation}, \${2:\$domlist}, \${3:\$type} )", 
	"desc" => "Create a new secondary index for a relation", 
	"docurl" => "function.dbplus-rsecindex.html" 
),
"dbplus_runlink" => array( 
	"methodname" => "dbplus_runlink", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_runlink ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Remove relation from filesystem", 
	"docurl" => "function.dbplus-runlink.html" 
),
"dbplus_rzap" => array( 
	"methodname" => "dbplus_rzap", 
	"version" => "undefined", 
	"method" => "int dbplus_rzap ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Remove all tuples from relation", 
	"docurl" => "function.dbplus-rzap.html" 
),
"dbplus_savepos" => array( 
	"methodname" => "dbplus_savepos", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_savepos ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Save position", 
	"docurl" => "function.dbplus-savepos.html" 
),
"dbplus_setindex" => array( 
	"methodname" => "dbplus_setindex", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_setindex ( resource relation, string idx_name )", 
	"snippet" => "( \${1:\$relation}, \${2:\$idx_name} )", 
	"desc" => "Set index", 
	"docurl" => "function.dbplus-setindex.html" 
),
"dbplus_setindexbynumber" => array( 
	"methodname" => "dbplus_setindexbynumber", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_setindexbynumber ( resource relation, int idx_number )", 
	"snippet" => "( \${1:\$relation}, \${2:\$idx_number} )", 
	"desc" => "Set index by number", 
	"docurl" => "function.dbplus-setindexbynumber.html" 
),
"dbplus_sql" => array( 
	"methodname" => "dbplus_sql", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "resource dbplus_sql ( string query [, string server [, string dbpath]] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Perform SQL query", 
	"docurl" => "function.dbplus-sql.html" 
),
"dbplus_tcl" => array( 
	"methodname" => "dbplus_tcl", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_tcl ( int sid, string script )", 
	"snippet" => "( \${1:\$sid}, \${2:\$script} )", 
	"desc" => "Execute TCL code on server side", 
	"docurl" => "function.dbplus-tcl.html" 
),
"dbplus_tremove" => array( 
	"methodname" => "dbplus_tremove", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_tremove ( resource relation, array tuple [, array &current] )", 
	"snippet" => "( \${1:\$relation}, \${2:\$tuple} )", 
	"desc" => "Remove tuple and return new current tuple", 
	"docurl" => "function.dbplus-tremove.html" 
),
"dbplus_undo" => array( 
	"methodname" => "dbplus_undo", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_undo ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Undo", 
	"docurl" => "function.dbplus-undo.html" 
),
"dbplus_undoprepare" => array( 
	"methodname" => "dbplus_undoprepare", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_undoprepare ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Prepare undo", 
	"docurl" => "function.dbplus-undoprepare.html" 
),
"dbplus_unlockrel" => array( 
	"methodname" => "dbplus_unlockrel", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_unlockrel ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Give up write lock on relation", 
	"docurl" => "function.dbplus-unlockrel.html" 
),
"dbplus_unselect" => array( 
	"methodname" => "dbplus_unselect", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_unselect ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Remove a constraint from relation", 
	"docurl" => "function.dbplus-unselect.html" 
),
"dbplus_update" => array( 
	"methodname" => "dbplus_update", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_update ( resource relation, array old, array new )", 
	"snippet" => "( \${1:\$relation}, \${2:\$old}, \${3:\$new} )", 
	"desc" => "Update specified tuple in relation", 
	"docurl" => "function.dbplus-update.html" 
),
"dbplus_xlockrel" => array( 
	"methodname" => "dbplus_xlockrel", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_xlockrel ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Request exclusive lock on relation", 
	"docurl" => "function.dbplus-xlockrel.html" 
),
"dbplus_xunlockrel" => array( 
	"methodname" => "dbplus_xunlockrel", 
	"version" => "4.1.0 - 4.2.3 only", 
	"method" => "int dbplus_xunlockrel ( resource relation )", 
	"snippet" => "( \${1:\$relation} )", 
	"desc" => "Free exclusive lock on relation", 
	"docurl" => "function.dbplus-xunlockrel.html" 
),

"dbx_close" => array( 
	"methodname" => "dbx_close", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool dbx_close ( object link_identifier )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Close an open connection/database", 
	"docurl" => "function.dbx-close.html" 
),
"dbx_compare" => array( 
	"methodname" => "dbx_compare", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int dbx_compare ( array row_a, array row_b, string column_key [, int flags] )", 
	"snippet" => "( \${1:\$row_a}, \${2:\$row_b}, \${3:\$column_key} )", 
	"desc" => "Compare two rows for sorting purposes", 
	"docurl" => "function.dbx-compare.html" 
),
"dbx_connect" => array( 
	"methodname" => "dbx_connect", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "object dbx_connect ( mixed module, string host, string database, string username, string password [, int persistent] )", 
	"snippet" => "( \${1:\$module}, \${2:\$host}, \${3:\$database}, \${4:\$username}, \${5:\$password} )", 
	"desc" => "Open a connection/database", 
	"docurl" => "function.dbx-connect.html" 
),
"dbx_error" => array( 
	"methodname" => "dbx_error", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string dbx_error ( object link_identifier )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Report the error message of the latest function call in the   module (not just in the connection)", 
	"docurl" => "function.dbx-error.html" 
),
"dbx_escape_string" => array( 
	"methodname" => "dbx_escape_string", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string dbx_escape_string ( object link_identifier, string text )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$text} )", 
	"desc" => "Escape a string so it can safely be used in an sql-statement", 
	"docurl" => "function.dbx-escape-string.html" 
),
"dbx_fetch_row" => array( 
	"methodname" => "dbx_fetch_row", 
	"version" => "PHP5", 
	"method" => "object dbx_fetch_row ( object result_identifier )", 
	"snippet" => "( \${1:\$result_identifier} )", 
	"desc" => "Fetches rows from a query-result that had the   DBX_RESULT_UNBUFFERED flag set", 
	"docurl" => "function.dbx-fetch-row.html" 
),
"dbx_query" => array( 
	"methodname" => "dbx_query", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "object dbx_query ( object link_identifier, string sql_statement [, int flags] )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$sql_statement} )", 
	"desc" => "Send a query and fetch all results (if any)", 
	"docurl" => "function.dbx-query.html" 
),
"dbx_sort" => array( 
	"methodname" => "dbx_sort", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool dbx_sort ( object result, string user_compare_function )", 
	"snippet" => "( \${1:\$result}, \${2:\$user_compare_function} )", 
	"desc" => "Sort a result from a dbx_query by a custom sort function", 
	"docurl" => "function.dbx-sort.html" 
),
"dcgettext" => array( 
	"methodname" => "dcgettext", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string dcgettext ( string domain, string message, int category )", 
	"snippet" => "( \${1:\$domain}, \${2:\$message}, \${3:\$category} )", 
	"desc" => "Overrides the domain for a single lookup", 
	"docurl" => "function.dcgettext.html" 
),
"dcngettext" => array( 
	"methodname" => "dcngettext", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string dcngettext ( string domain, string msgid1, string msgid2, int n, int category )", 
	"snippet" => "( \${1:\$domain}, \${2:\$msgid1}, \${3:\$msgid2}, \${4:\$n}, \${5:\$category} )", 
	"desc" => "Plural version of dcgettext", 
	"docurl" => "function.dcngettext.html" 
),
"deaggregate" => array( 
	"methodname" => "deaggregate", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "void deaggregate ( object object [, string class_name] )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Removes the aggregated methods and properties from an object", 
	"docurl" => "function.deaggregate.html" 
),
"debug_backtrace" => array( 
	"methodname" => "debug_backtrace", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array debug_backtrace ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Generates a backtrace", 
	"docurl" => "function.debug-backtrace.html" 
),
"debug_print_backtrace" => array( 
	"methodname" => "debug_print_backtrace", 
	"version" => "PHP5", 
	"method" => "void debug_print_backtrace ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Prints a backtrace", 
	"docurl" => "function.debug-print-backtrace.html" 
),
"debug_zval_dump" => array( 
	"methodname" => "debug_zval_dump", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void debug_zval_dump ( mixed variable )", 
	"snippet" => "( \${1:\$variable} )", 
	"desc" => "Dumps a string representation of an internal zend value to output", 
	"docurl" => "function.debug-zval-dump.html" 
),
"debugger_off" => array( 
	"methodname" => "debugger_off", 
	"version" => "PHP3", 
	"method" => "int debugger_off ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Disable internal PHP debugger (PHP3)", 
	"docurl" => "function.debugger-off.html" 
),
"debugger_on" => array( 
	"methodname" => "debugger_on", 
	"version" => "PHP3", 
	"method" => "int debugger_on ( string address )", 
	"snippet" => "( \${1:\$address} )", 
	"desc" => "Enable internal PHP debugger (PHP3)", 
	"docurl" => "function.debugger-on.html" 
),
"decbin" => array( 
	"methodname" => "decbin", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string decbin ( int number )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Decimal to binary", 
	"docurl" => "function.decbin.html" 
),
"dechex" => array( 
	"methodname" => "dechex", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string dechex ( int number )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Decimal to hexadecimal", 
	"docurl" => "function.dechex.html" 
),
"decoct" => array( 
	"methodname" => "decoct", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string decoct ( int number )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Decimal to octal", 
	"docurl" => "function.decoct.html" 
),
"define_syslog_variables" => array( 
	"methodname" => "define_syslog_variables", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void define_syslog_variables ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Initializes all syslog related constants", 
	"docurl" => "function.define-syslog-variables.html" 
),
"define" => array( 
	"methodname" => "define", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool define ( string name, mixed value [, bool case_insensitive] )", 
	"snippet" => "( \${1:\$name}, \${2:\$value} )", 
	"desc" => "Defines a named constant", 
	"docurl" => "function.define.html" 
),
"defined" => array( 
	"methodname" => "defined", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool defined ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Checks whether a given named constant exists", 
	"docurl" => "function.defined.html" 
),
"deg2rad" => array( 
	"methodname" => "deg2rad", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "float deg2rad ( float number )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Converts the number in degrees to the radian equivalent", 
	"docurl" => "function.deg2rad.html" 
),
"delete" => array( 
	"methodname" => "delete", 
	"version" => "undefined", 
	"method" => "void delete ( string file )", 
	"snippet" => "( \${1:\$file} )", 
	"desc" => "See  unlink() to delete files, unset() to delete variables.", 
	"docurl" => "function.delete.html" 
),
"dgettext" => array( 
	"methodname" => "dgettext", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string dgettext ( string domain, string message )", 
	"snippet" => "( \${1:\$domain}, \${2:\$message} )", 
	"desc" => "Override the current domain", 
	"docurl" => "function.dgettext.html" 
),
"die" => array( 
	"methodname" => "die", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void die ( [string status] )", 
	"snippet" => "( \$1 )", 
	"desc" => "This language construct is equivalent to exit()", 
	"docurl" => "function.die.html" 
),
"dio_close" => array( 
	"methodname" => "dio_close", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void dio_close ( resource fd )", 
	"snippet" => "( \${1:\$fd} )", 
	"desc" => "Closes the file descriptor given by fd", 
	"docurl" => "function.dio-close.html" 
),
"dio_fcntl" => array( 
	"methodname" => "dio_fcntl", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "mixed dio_fcntl ( resource fd, int cmd [, mixed args] )", 
	"snippet" => "( \${1:\$fd}, \${2:\$cmd} )", 
	"desc" => "Performs a c library fcntl on fd", 
	"docurl" => "function.dio-fcntl.html" 
),
"dio_open" => array( 
	"methodname" => "dio_open", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "resource dio_open ( string filename, int flags [, int mode] )", 
	"snippet" => "( \${1:\$filename}, \${2:\$flags} )", 
	"desc" => "Opens a new filename with specified permissions of flags and   creation permissions of mode", 
	"docurl" => "function.dio-open.html" 
),
"dio_read" => array( 
	"methodname" => "dio_read", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string dio_read ( resource fd [, int n] )", 
	"snippet" => "( \${1:\$fd} )", 
	"desc" => "Reads n bytes from fd and returns them, if n is not specified,   reads 1k block", 
	"docurl" => "function.dio-read.html" 
),
"dio_seek" => array( 
	"methodname" => "dio_seek", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int dio_seek ( resource fd, int pos [, int whence] )", 
	"snippet" => "( \${1:\$fd}, \${2:\$pos} )", 
	"desc" => "Seeks to pos on fd from whence", 
	"docurl" => "function.dio-seek.html" 
),
"dio_stat" => array( 
	"methodname" => "dio_stat", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array dio_stat ( resource fd )", 
	"snippet" => "( \${1:\$fd} )", 
	"desc" => "Gets stat information about the file descriptor fd", 
	"docurl" => "function.dio-stat.html" 
),
"dio_tcsetattr" => array( 
	"methodname" => "dio_tcsetattr", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "void dio_tcsetattr ( resource fd, array options )", 
	"snippet" => "( \${1:\$fd}, \${2:\$options} )", 
	"desc" => "Sets terminal attributes and baud rate for a serial port", 
	"docurl" => "function.dio-tcsetattr.html" 
),
"dio_truncate" => array( 
	"methodname" => "dio_truncate", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool dio_truncate ( resource fd, int offset )", 
	"snippet" => "( \${1:\$fd}, \${2:\$offset} )", 
	"desc" => "Truncates file descriptor fd to offset bytes", 
	"docurl" => "function.dio-truncate.html" 
),
"dio_write" => array( 
	"methodname" => "dio_write", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int dio_write ( resource fd, string data [, int len] )", 
	"snippet" => "( \${1:\$fd}, \${2:\$data} )", 
	"desc" => "Writes data to fd with optional truncation at length", 
	"docurl" => "function.dio-write.html" 
),
"dirname" => array( 
	"methodname" => "dirname", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string dirname ( string path )", 
	"snippet" => "( \${1:\$path} )", 
	"desc" => "Returns directory name component of path", 
	"docurl" => "function.dirname.html" 
),
"disk_free_space" => array( 
	"methodname" => "disk_free_space", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float disk_free_space ( string directory )", 
	"snippet" => "( \${1:\$directory} )", 
	"desc" => "Returns available space in directory", 
	"docurl" => "function.disk-free-space.html" 
),
"disk_total_space" => array( 
	"methodname" => "disk_total_space", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float disk_total_space ( string directory )", 
	"snippet" => "( \${1:\$directory} )", 
	"desc" => "Returns the total size of a directory", 
	"docurl" => "function.disk-total-space.html" 
),
"diskfreespace" => array( 
	"methodname" => "diskfreespace", 
	"version" => "(PHP4 >= 4.1.0, PHP5)", 
	"method" => "float diskfreespace ( string directory )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of disk_free_space()\nReturns available space in directory", 
	"docurl" => "function.diskfreespace.html" 
),
"dl" => array( 
	"methodname" => "dl", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int dl ( string library )", 
	"snippet" => "( \${1:\$library} )", 
	"desc" => "Loads a PHP extension at runtime", 
	"docurl" => "function.dl.html" 
),
"dngettext" => array( 
	"methodname" => "dngettext", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string dngettext ( string domain, string msgid1, string msgid2, int n )", 
	"snippet" => "( \${1:\$domain}, \${2:\$msgid1}, \${3:\$msgid2}, \${4:\$n} )", 
	"desc" => "Plural version of dgettext", 
	"docurl" => "function.dngettext.html" 
),
"dns_check_record" => array( 
	"methodname" => "dns_check_record", 
	"version" => "PHP5", 
	"method" => "int dns_check_record ( string host [, string type] )", 
	"snippet" => "( \${1:\$host} )", 
	"desc" => "Synonym for checkdnsrr()", 
	"docurl" => "function.dns-check-record.html" 
),
"dns_get_mx" => array( 
	"methodname" => "dns_get_mx", 
	"version" => "PHP5", 
	"method" => "int dns_get_mx ( string hostname, array &mxhosts [, array &weight] )", 
	"snippet" => "( \${1:\$hostname}, \${2:\$mxhosts} )", 
	"desc" => "Synonym for getmxrr()", 
	"docurl" => "function.dns-get-mx.html" 
),
"dns_get_record" => array( 
	"methodname" => "dns_get_record", 
	"version" => "PHP5", 
	"method" => "array dns_get_record ( string hostname [, int type [, array &authns, array &addtl]] )", 
	"snippet" => "( \${1:\$hostname} )", 
	"desc" => "Fetch DNS Resource Records associated with a hostname", 
	"docurl" => "function.dns-get-record.html" 
),
"dom_domattr_construct" => array( 
	"methodname" => "dom_domattr_construct", 
	"version" => "undefined", 
	"method" => "class DOMAttr { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domattr-construct.html" 
),
"dom_domattr_isid" => array( 
	"methodname" => "dom_domattr_isid", 
	"version" => "undefined", 
	"method" => "class DOMAttr { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domattr-isid.html" 
),
"dom_domcharacterdata_appenddata" => array( 
	"methodname" => "dom_domcharacterdata_appenddata", 
	"version" => "undefined", 
	"method" => "class DOMCharacterData { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domcharacterdata-appenddata.html" 
),
"dom_domcharacterdata_deletedata" => array( 
	"methodname" => "dom_domcharacterdata_deletedata", 
	"version" => "undefined", 
	"method" => "class DOMCharacterData { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domcharacterdata-deletedata.html" 
),
"dom_domcharacterdata_insertdata" => array( 
	"methodname" => "dom_domcharacterdata_insertdata", 
	"version" => "undefined", 
	"method" => "class DOMCharacterData { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domcharacterdata-insertdata.html" 
),
"dom_domcharacterdata_replacedata" => array( 
	"methodname" => "dom_domcharacterdata_replacedata", 
	"version" => "undefined", 
	"method" => "class DOMCharacterData { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domcharacterdata-replacedata.html" 
),
"dom_domcharacterdata_substringdata" => array( 
	"methodname" => "dom_domcharacterdata_substringdata", 
	"version" => "undefined", 
	"method" => "class DOMCharacterData { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domcharacterdata-substringdata.html" 
),
"dom_domcomment_construct" => array( 
	"methodname" => "dom_domcomment_construct", 
	"version" => "undefined", 
	"method" => "class DOMComment { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domcomment-construct.html" 
),
"dom_domdocument_construct" => array( 
	"methodname" => "dom_domdocument_construct", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-construct.html" 
),
"dom_domdocument_createattribute" => array( 
	"methodname" => "dom_domdocument_createattribute", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-createattribute.html" 
),
"dom_domdocument_createattributens" => array( 
	"methodname" => "dom_domdocument_createattributens", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-createattributens.html" 
),
"dom_domdocument_createcdatasection" => array( 
	"methodname" => "dom_domdocument_createcdatasection", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-createcdatasection.html" 
),
"dom_domdocument_createcomment" => array( 
	"methodname" => "dom_domdocument_createcomment", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-createcomment.html" 
),
"dom_domdocument_createdocumentfragment" => array( 
	"methodname" => "dom_domdocument_createdocumentfragment", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-createdocumentfragment.html" 
),
"dom_domdocument_createelement" => array( 
	"methodname" => "dom_domdocument_createelement", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-createelement.html" 
),
"dom_domdocument_createelementns" => array( 
	"methodname" => "dom_domdocument_createelementns", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-createelementns.html" 
),
"dom_domdocument_createentityreference" => array( 
	"methodname" => "dom_domdocument_createentityreference", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-createentityreference.html" 
),
"dom_domdocument_createprocessinginstruction" => array( 
	"methodname" => "dom_domdocument_createprocessinginstruction", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-createprocessinginstruction.html" 
),
"dom_domdocument_createtextnode" => array( 
	"methodname" => "dom_domdocument_createtextnode", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-createtextnode.html" 
),
"dom_domdocument_getelementbyid" => array( 
	"methodname" => "dom_domdocument_getelementbyid", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-getelementbyid.html" 
),
"dom_domdocument_getelementsbytagname" => array( 
	"methodname" => "dom_domdocument_getelementsbytagname", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-getelementsbytagname.html" 
),
"dom_domdocument_getelementsbytagnamens" => array( 
	"methodname" => "dom_domdocument_getelementsbytagnamens", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-getelementsbytagnamens.html" 
),
"dom_domdocument_importnode" => array( 
	"methodname" => "dom_domdocument_importnode", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-importnode.html" 
),
"dom_domdocument_load" => array( 
	"methodname" => "dom_domdocument_load", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-load.html" 
),
"dom_domdocument_loadhtml" => array( 
	"methodname" => "dom_domdocument_loadhtml", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-loadhtml.html" 
),
"dom_domdocument_loadhtmlfile" => array( 
	"methodname" => "dom_domdocument_loadhtmlfile", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-loadhtmlfile.html" 
),
"dom_domdocument_loadxml" => array( 
	"methodname" => "dom_domdocument_loadxml", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-loadxml.html" 
),
"dom_domdocument_normalize" => array( 
	"methodname" => "dom_domdocument_normalize", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-normalize.html" 
),
"dom_domdocument_relaxngvalidate" => array( 
	"methodname" => "dom_domdocument_relaxngvalidate", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-relaxngvalidate.html" 
),
"dom_domdocument_relaxngvalidatesource" => array( 
	"methodname" => "dom_domdocument_relaxngvalidatesource", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-relaxngvalidatesource.html" 
),
"dom_domdocument_save" => array( 
	"methodname" => "dom_domdocument_save", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-save.html" 
),
"dom_domdocument_savehtml" => array( 
	"methodname" => "dom_domdocument_savehtml", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-savehtml.html" 
),
"dom_domdocument_savehtmlfile" => array( 
	"methodname" => "dom_domdocument_savehtmlfile", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-savehtmlfile.html" 
),
"dom_domdocument_savexml" => array( 
	"methodname" => "dom_domdocument_savexml", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-savexml.html" 
),
"dom_domdocument_schemavalidate" => array( 
	"methodname" => "dom_domdocument_schemavalidate", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-schemavalidate.html" 
),
"dom_domdocument_schemavalidatesource" => array( 
	"methodname" => "dom_domdocument_schemavalidatesource", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-schemavalidatesource.html" 
),
"dom_domdocument_validate" => array( 
	"methodname" => "dom_domdocument_validate", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-validate.html" 
),
"dom_domdocument_xinclude" => array( 
	"methodname" => "dom_domdocument_xinclude", 
	"version" => "undefined", 
	"method" => "class DOMDocument { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domdocument-xinclude.html" 
),
"dom_domelement_construct" => array( 
	"methodname" => "dom_domelement_construct", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-construct.html" 
),
"dom_domelement_getattribute" => array( 
	"methodname" => "dom_domelement_getattribute", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-getattribute.html" 
),
"dom_domelement_getattributenode" => array( 
	"methodname" => "dom_domelement_getattributenode", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-getattributenode.html" 
),
"dom_domelement_getattributenodens" => array( 
	"methodname" => "dom_domelement_getattributenodens", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-getattributenodens.html" 
),
"dom_domelement_getattributens" => array( 
	"methodname" => "dom_domelement_getattributens", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-getattributens.html" 
),
"dom_domelement_getelementsbytagname" => array( 
	"methodname" => "dom_domelement_getelementsbytagname", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-getelementsbytagname.html" 
),
"dom_domelement_getelementsbytagnamens" => array( 
	"methodname" => "dom_domelement_getelementsbytagnamens", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-getelementsbytagnamens.html" 
),
"dom_domelement_hasattribute" => array( 
	"methodname" => "dom_domelement_hasattribute", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-hasattribute.html" 
),
"dom_domelement_hasattributens" => array( 
	"methodname" => "dom_domelement_hasattributens", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-hasattributens.html" 
),
"dom_domelement_removeattribute" => array( 
	"methodname" => "dom_domelement_removeattribute", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-removeattribute.html" 
),
"dom_domelement_removeattributenode" => array( 
	"methodname" => "dom_domelement_removeattributenode", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-removeattributenode.html" 
),
"dom_domelement_removeattributens" => array( 
	"methodname" => "dom_domelement_removeattributens", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-removeattributens.html" 
),
"dom_domelement_setattribute" => array( 
	"methodname" => "dom_domelement_setattribute", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-setattribute.html" 
),
"dom_domelement_setattributenode" => array( 
	"methodname" => "dom_domelement_setattributenode", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-setattributenode.html" 
),
"dom_domelement_setattributenodens" => array( 
	"methodname" => "dom_domelement_setattributenodens", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-setattributenodens.html" 
),
"dom_domelement_setattributens" => array( 
	"methodname" => "dom_domelement_setattributens", 
	"version" => "undefined", 
	"method" => "class DOMElement { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domelement-setattributens.html" 
),
"dom_domentityreference_construct" => array( 
	"methodname" => "dom_domentityreference_construct", 
	"version" => "undefined", 
	"method" => "class DOMEntityReference { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domentityreference-construct.html" 
),
"dom_domimplementation_createdocument" => array( 
	"methodname" => "dom_domimplementation_createdocument", 
	"version" => "undefined", 
	"method" => "class DOMImplementation { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domimplementation-createdocument.html" 
),
"dom_domimplementation_createdocumenttype" => array( 
	"methodname" => "dom_domimplementation_createdocumenttype", 
	"version" => "undefined", 
	"method" => "class DOMImplementation { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domimplementation-createdocumenttype.html" 
),
"dom_domimplementation_hasfeature" => array( 
	"methodname" => "dom_domimplementation_hasfeature", 
	"version" => "undefined", 
	"method" => "class DOMImplementation { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domimplementation-hasfeature.html" 
),
"dom_domnamednodemap_getnameditem" => array( 
	"methodname" => "dom_domnamednodemap_getnameditem", 
	"version" => "undefined", 
	"method" => "class DOMNamedNodeMap { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnamednodemap-getnameditem.html" 
),
"dom_domnamednodemap_getnameditemns" => array( 
	"methodname" => "dom_domnamednodemap_getnameditemns", 
	"version" => "undefined", 
	"method" => "class DOMNamedNodeMap { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnamednodemap-getnameditemns.html" 
),
"dom_domnamednodemap_item" => array( 
	"methodname" => "dom_domnamednodemap_item", 
	"version" => "undefined", 
	"method" => "class DOMNamedNodeMap { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnamednodemap-item.html" 
),
"dom_domnode_appendchild" => array( 
	"methodname" => "dom_domnode_appendchild", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-appendchild.html" 
),
"dom_domnode_clonenode" => array( 
	"methodname" => "dom_domnode_clonenode", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-clonenode.html" 
),
"dom_domnode_hasattributes" => array( 
	"methodname" => "dom_domnode_hasattributes", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-hasattributes.html" 
),
"dom_domnode_haschildnodes" => array( 
	"methodname" => "dom_domnode_haschildnodes", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-haschildnodes.html" 
),
"dom_domnode_insertbefore" => array( 
	"methodname" => "dom_domnode_insertbefore", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-insertbefore.html" 
),
"dom_domnode_issamenode" => array( 
	"methodname" => "dom_domnode_issamenode", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-issamenode.html" 
),
"dom_domnode_issupported" => array( 
	"methodname" => "dom_domnode_issupported", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-issupported.html" 
),
"dom_domnode_lookupnamespaceuri" => array( 
	"methodname" => "dom_domnode_lookupnamespaceuri", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-lookupnamespaceuri.html" 
),
"dom_domnode_lookupprefix" => array( 
	"methodname" => "dom_domnode_lookupprefix", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-lookupprefix.html" 
),
"dom_domnode_normalize" => array( 
	"methodname" => "dom_domnode_normalize", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-normalize.html" 
),
"dom_domnode_removechild" => array( 
	"methodname" => "dom_domnode_removechild", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-removechild.html" 
),
"dom_domnode_replacechild" => array( 
	"methodname" => "dom_domnode_replacechild", 
	"version" => "undefined", 
	"method" => "class DOMNode { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnode-replacechild.html" 
),
"dom_domnodelist_item" => array( 
	"methodname" => "dom_domnodelist_item", 
	"version" => "undefined", 
	"method" => "class DOMNodeList { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domnodelist-item.html" 
),
"dom_domprocessinginstruction_construct" => array( 
	"methodname" => "dom_domprocessinginstruction_construct", 
	"version" => "undefined", 
	"method" => "class DOMProcessingInstruction { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domprocessinginstruction-construct.html" 
),
"dom_domtext_construct" => array( 
	"methodname" => "dom_domtext_construct", 
	"version" => "undefined", 
	"method" => "class DOMText { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domtext-construct.html" 
),
"dom_domtext_iswhitespaceinelementcontent" => array( 
	"methodname" => "dom_domtext_iswhitespaceinelementcontent", 
	"version" => "undefined", 
	"method" => "class DOMText { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domtext-iswhitespaceinelementcontent.html" 
),
"dom_domtext_splittext" => array( 
	"methodname" => "dom_domtext_splittext", 
	"version" => "undefined", 
	"method" => "class DOMText { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domtext-splittext.html" 
),
"dom_domxpath_construct" => array( 
	"methodname" => "dom_domxpath_construct", 
	"version" => "undefined", 
	"method" => "class DOMXPath { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domxpath-construct.html" 
),
"dom_domxpath_evaluate" => array( 
	"methodname" => "dom_domxpath_evaluate", 
	"version" => "undefined", 
	"method" => "class DOMXPath { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domxpath-evaluate.html" 
),
"dom_domxpath_query" => array( 
	"methodname" => "dom_domxpath_query", 
	"version" => "undefined", 
	"method" => "class DOMXPath { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domxpath-query.html" 
),
"dom_domxpath_registernamespace" => array( 
	"methodname" => "dom_domxpath_registernamespace", 
	"version" => "undefined", 
	"method" => "class DOMXPath { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.dom-domxpath-registernamespace.html" 
),
"dom_import_simplexml" => array( 
	"methodname" => "dom_import_simplexml", 
	"version" => "PHP5", 
	"method" => "DOMElement dom_import_simplexml ( SimpleXMLElement node )", 
	"snippet" => "( \${1:\$node} )", 
	"desc" => "Gets a DOMElement object from a SimpleXMLElement object", 
	"docurl" => "function.dom-import-simplexml.html" 
),
"domattribute_name" => array( 
	"methodname" => "domattribute_name", 
	"version" => "undefined", 
	"method" => "string DomAttribute-&#62;name ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domattribute-name.html" 
),
"domattribute_specified" => array( 
	"methodname" => "domattribute_specified", 
	"version" => "undefined", 
	"method" => "bool DomAttribute-&#62;specified ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domattribute-specified.html" 
),
"domattribute_value" => array( 
	"methodname" => "domattribute_value", 
	"version" => "undefined", 
	"method" => "mixed DomAttribute-&#62;value ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domattribute-value.html" 
),
"domdocument_add_root" => array( 
	"methodname" => "domdocument_add_root", 
	"version" => "undefined", 
	"method" => "domelement DomDocument-&#62;add_root ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-add-root.html" 
),
"domdocument_create_attribute" => array( 
	"methodname" => "domdocument_create_attribute", 
	"version" => "undefined", 
	"method" => "domattribute DomDocument-&#62;create_attribute ( string name, string value )", 
	"snippet" => "( \${1:\$name}, \${2:\$value} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-create-attribute.html" 
),
"domdocument_create_cdata_section" => array( 
	"methodname" => "domdocument_create_cdata_section", 
	"version" => "undefined", 
	"method" => "domcdata DomDocument-&#62;create_cdata_section ( string content )", 
	"snippet" => "( \${1:\$content} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-create-cdata-section.html" 
),
"domdocument_create_comment" => array( 
	"methodname" => "domdocument_create_comment", 
	"version" => "undefined", 
	"method" => "domcomment DomDocument-&#62;create_comment ( string content )", 
	"snippet" => "( \${1:\$content} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-create-comment.html" 
),
"domdocument_create_element_ns" => array( 
	"methodname" => "domdocument_create_element_ns", 
	"version" => "undefined", 
	"method" => "domelement DomDocument-&#62;create_element_ns ( string uri, string name [, string prefix] )", 
	"snippet" => "( \${1:\$uri}, \${2:\$name} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-create-element-ns.html" 
),
"domdocument_create_element" => array( 
	"methodname" => "domdocument_create_element", 
	"version" => "undefined", 
	"method" => "domelement DomDocument-&#62;create_element ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-create-element.html" 
),
"domdocument_create_entity_reference" => array( 
	"methodname" => "domdocument_create_entity_reference", 
	"version" => "undefined", 
	"method" => "domentityreference DomDocument-&#62;create_entity_reference ( string content )", 
	"snippet" => "( \${1:\$content} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-create-entity-reference.html" 
),
"domdocument_create_processing_instruction" => array( 
	"methodname" => "domdocument_create_processing_instruction", 
	"version" => "undefined", 
	"method" => "domprocessinginstruction DomDocument-&#62;create_processing_instruction ( string content )", 
	"snippet" => "( \${1:\$content} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-create-processing-instruction.html" 
),
"domdocument_create_text_node" => array( 
	"methodname" => "domdocument_create_text_node", 
	"version" => "undefined", 
	"method" => "domtext DomDocument-&#62;create_text_node ( string content )", 
	"snippet" => "( \${1:\$content} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-create-text-node.html" 
),
"domdocument_doctype" => array( 
	"methodname" => "domdocument_doctype", 
	"version" => "undefined", 
	"method" => "domdocumenttype DomDocument-&#62;doctype ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domdocument-doctype.html" 
),
"domdocument_document_element" => array( 
	"methodname" => "domdocument_document_element", 
	"version" => "undefined", 
	"method" => "domelement DomDocument-&#62;document_element ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domdocument-document-element.html" 
),
"domdocument_dump_file" => array( 
	"methodname" => "domdocument_dump_file", 
	"version" => "undefined", 
	"method" => "string DomDocument-&#62;dump_file ( string filename [, bool compressionmode [, bool format]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-dump-file.html" 
),
"domdocument_dump_mem" => array( 
	"methodname" => "domdocument_dump_mem", 
	"version" => "undefined", 
	"method" => "string DomDocument-&#62;dump_mem ( [bool format [, string encoding]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.domdocument-dump-mem.html" 
),
"domdocument_get_element_by_id" => array( 
	"methodname" => "domdocument_get_element_by_id", 
	"version" => "undefined", 
	"method" => "domelement DomDocument-&#62;get_element_by_id ( string id )", 
	"snippet" => "( \${1:\$id} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-get-element-by-id.html" 
),
"domdocument_get_elements_by_tagname" => array( 
	"methodname" => "domdocument_get_elements_by_tagname", 
	"version" => "undefined", 
	"method" => "array DomDocument-&#62;get_elements_by_tagname ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.domdocument-get-elements-by-tagname.html" 
),
"domdocument_html_dump_mem" => array( 
	"methodname" => "domdocument_html_dump_mem", 
	"version" => "undefined", 
	"method" => "string DomDocument-&#62;html_dump_mem ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domdocument-html-dump-mem.html" 
),
"domdocument_xinclude" => array( 
	"methodname" => "domdocument_xinclude", 
	"version" => "undefined", 
	"method" => "int DomDocument-&#62;xinclude ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domdocument-xinclude.html" 
),
"domdocumenttype_entities" => array( 
	"methodname" => "domdocumenttype_entities", 
	"version" => "undefined", 
	"method" => "array DomDocumentType-&#62;entities ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domdocumenttype-entities.html" 
),
"domdocumenttype_internal_subset" => array( 
	"methodname" => "domdocumenttype_internal_subset", 
	"version" => "undefined", 
	"method" => "bool DomDocumentType-&#62;internal_subset ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domdocumenttype-internal-subset.html" 
),
"domdocumenttype_name" => array( 
	"methodname" => "domdocumenttype_name", 
	"version" => "undefined", 
	"method" => "string DomDocumentType-&#62;name ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domdocumenttype-name.html" 
),
"domdocumenttype_notations" => array( 
	"methodname" => "domdocumenttype_notations", 
	"version" => "undefined", 
	"method" => "array DomDocumentType-&#62;notations ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domdocumenttype-notations.html" 
),
"domdocumenttype_public_id" => array( 
	"methodname" => "domdocumenttype_public_id", 
	"version" => "undefined", 
	"method" => "string DomDocumentType-&#62;public_id ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domdocumenttype-public-id.html" 
),
"domdocumenttype_system_id" => array( 
	"methodname" => "domdocumenttype_system_id", 
	"version" => "undefined", 
	"method" => "string DomDocumentType-&#62;system_id ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domdocumenttype-system-id.html" 
),
"domelement_get_attribute_node" => array( 
	"methodname" => "domelement_get_attribute_node", 
	"version" => "undefined", 
	"method" => "domattribute DomElement-&#62;get_attribute_node ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.domelement-get-attribute-node.html" 
),
"domelement_get_attribute" => array( 
	"methodname" => "domelement_get_attribute", 
	"version" => "undefined", 
	"method" => "string DomElement-&#62;get_attribute ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.domelement-get-attribute.html" 
),
"domelement_get_elements_by_tagname" => array( 
	"methodname" => "domelement_get_elements_by_tagname", 
	"version" => "undefined", 
	"method" => "array DomElement-&#62;get_elements_by_tagname ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.domelement-get-elements-by-tagname.html" 
),
"domelement_has_attribute" => array( 
	"methodname" => "domelement_has_attribute", 
	"version" => "undefined", 
	"method" => "bool DomElement-&#62;has_attribute ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.domelement-has-attribute.html" 
),
"domelement_remove_attribute" => array( 
	"methodname" => "domelement_remove_attribute", 
	"version" => "undefined", 
	"method" => "bool DomElement-&#62;remove_attribute ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.domelement-remove-attribute.html" 
),
"domelement_set_attribute" => array( 
	"methodname" => "domelement_set_attribute", 
	"version" => "undefined", 
	"method" => "domattribute DomElement-&#62;set_attribute ( string name, string value )", 
	"snippet" => "( \${1:\$name}, \${2:\$value} )", 
	"desc" => "", 
	"docurl" => "function.domelement-set-attribute.html" 
),
"domelement_tagname" => array( 
	"methodname" => "domelement_tagname", 
	"version" => "undefined", 
	"method" => "string DomElement-&#62;tagname ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domelement-tagname.html" 
),
"domnode_add_namespace" => array( 
	"methodname" => "domnode_add_namespace", 
	"version" => "undefined", 
	"method" => "bool DomNode-&#62;add_namespace ( string uri, string prefix )", 
	"snippet" => "( \${1:\$uri}, \${2:\$prefix} )", 
	"desc" => "", 
	"docurl" => "function.domnode-add-namespace.html" 
),
"domnode_append_child" => array( 
	"methodname" => "domnode_append_child", 
	"version" => "undefined", 
	"method" => "domelement DomNode-&#62;append_child ( domelement newnode )", 
	"snippet" => "( \${1:\$newnode} )", 
	"desc" => "", 
	"docurl" => "function.domnode-append-child.html" 
),
"domnode_append_sibling" => array( 
	"methodname" => "domnode_append_sibling", 
	"version" => "undefined", 
	"method" => "domelement DomNode-&#62;append_sibling ( domelement newnode )", 
	"snippet" => "( \${1:\$newnode} )", 
	"desc" => "", 
	"docurl" => "function.domnode-append-sibling.html" 
),
"domnode_attributes" => array( 
	"methodname" => "domnode_attributes", 
	"version" => "undefined", 
	"method" => "array DomNode-&#62;attributes ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-attributes.html" 
),
"domnode_child_nodes" => array( 
	"methodname" => "domnode_child_nodes", 
	"version" => "undefined", 
	"method" => "array DomNode-&#62;child_nodes ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-child-nodes.html" 
),
"domnode_clone_node" => array( 
	"methodname" => "domnode_clone_node", 
	"version" => "undefined", 
	"method" => "domelement DomNode-&#62;clone_node ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-clone-node.html" 
),
"domnode_dump_node" => array( 
	"methodname" => "domnode_dump_node", 
	"version" => "undefined", 
	"method" => "string DomNode-&#62;dump_node ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-dump-node.html" 
),
"domnode_first_child" => array( 
	"methodname" => "domnode_first_child", 
	"version" => "undefined", 
	"method" => "domelement DomNode-&#62;first_child ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-first-child.html" 
),
"domnode_get_content" => array( 
	"methodname" => "domnode_get_content", 
	"version" => "undefined", 
	"method" => "string DomNode-&#62;get_content ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-get-content.html" 
),
"domnode_has_attributes" => array( 
	"methodname" => "domnode_has_attributes", 
	"version" => "undefined", 
	"method" => "bool DomNode-&#62;has_attributes ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-has-attributes.html" 
),
"domnode_has_child_nodes" => array( 
	"methodname" => "domnode_has_child_nodes", 
	"version" => "undefined", 
	"method" => "bool DomNode-&#62;has_child_nodes ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-has-child-nodes.html" 
),
"domnode_insert_before" => array( 
	"methodname" => "domnode_insert_before", 
	"version" => "undefined", 
	"method" => "domelement DomNode-&#62;insert_before ( domelement newnode, domelement refnode )", 
	"snippet" => "( \${1:\$newnode}, \${2:\$refnode} )", 
	"desc" => "", 
	"docurl" => "function.domnode-insert-before.html" 
),
"domnode_is_blank_node" => array( 
	"methodname" => "domnode_is_blank_node", 
	"version" => "undefined", 
	"method" => "bool DomNode-&#62;is_blank_node ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-is-blank-node.html" 
),
"domnode_last_child" => array( 
	"methodname" => "domnode_last_child", 
	"version" => "undefined", 
	"method" => "domelement DomNode-&#62;last_child ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-last-child.html" 
),
"domnode_next_sibling" => array( 
	"methodname" => "domnode_next_sibling", 
	"version" => "undefined", 
	"method" => "domelement DomNode-&#62;next_sibling ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-next-sibling.html" 
),
"domnode_node_name" => array( 
	"methodname" => "domnode_node_name", 
	"version" => "undefined", 
	"method" => "string DomNode-&#62;node_name ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-node-name.html" 
),
"domnode_node_type" => array( 
	"methodname" => "domnode_node_type", 
	"version" => "undefined", 
	"method" => "int DomNode-&#62;node_type ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-node-type.html" 
),
"domnode_node_value" => array( 
	"methodname" => "domnode_node_value", 
	"version" => "undefined", 
	"method" => "string DomNode-&#62;node_value ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-node-value.html" 
),
"domnode_owner_document" => array( 
	"methodname" => "domnode_owner_document", 
	"version" => "undefined", 
	"method" => "domdocument DomNode-&#62;owner_document ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-owner-document.html" 
),
"domnode_parent_node" => array( 
	"methodname" => "domnode_parent_node", 
	"version" => "undefined", 
	"method" => "domnode DomNode-&#62;parent_node ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-parent-node.html" 
),
"domnode_prefix" => array( 
	"methodname" => "domnode_prefix", 
	"version" => "undefined", 
	"method" => "string DomNode-&#62;prefix ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-prefix.html" 
),
"domnode_previous_sibling" => array( 
	"methodname" => "domnode_previous_sibling", 
	"version" => "undefined", 
	"method" => "domelement DomNode-&#62;previous_sibling ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-previous-sibling.html" 
),
"domnode_remove_child" => array( 
	"methodname" => "domnode_remove_child", 
	"version" => "undefined", 
	"method" => "domtext DomNode-&#62;remove_child ( domtext oldchild )", 
	"snippet" => "( \${1:\$oldchild} )", 
	"desc" => "", 
	"docurl" => "function.domnode-remove-child.html" 
),
"domnode_replace_child" => array( 
	"methodname" => "domnode_replace_child", 
	"version" => "undefined", 
	"method" => "domelement DomNode-&#62;replace_child ( domelement oldnode, domelement newnode )", 
	"snippet" => "( \${1:\$oldnode}, \${2:\$newnode} )", 
	"desc" => "", 
	"docurl" => "function.domnode-replace-child.html" 
),
"domnode_replace_node" => array( 
	"methodname" => "domnode_replace_node", 
	"version" => "undefined", 
	"method" => "domelement DomNode-&#62;replace_node ( domelement newnode )", 
	"snippet" => "( \${1:\$newnode} )", 
	"desc" => "", 
	"docurl" => "function.domnode-replace-node.html" 
),
"domnode_set_content" => array( 
	"methodname" => "domnode_set_content", 
	"version" => "undefined", 
	"method" => "bool DomNode-&#62;set_content ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-set-content.html" 
),
"domnode_set_name" => array( 
	"methodname" => "domnode_set_name", 
	"version" => "undefined", 
	"method" => "bool DomNode-&#62;set_name ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-set-name.html" 
),
"domnode_set_namespace" => array( 
	"methodname" => "domnode_set_namespace", 
	"version" => "undefined", 
	"method" => "void DomNode-&#62;set_namespace ( string uri [, string prefix] )", 
	"snippet" => "( \${1:\$uri} )", 
	"desc" => "", 
	"docurl" => "function.domnode-set-namespace.html" 
),
"domnode_unlink_node" => array( 
	"methodname" => "domnode_unlink_node", 
	"version" => "undefined", 
	"method" => "void DomNode-&#62;unlink_node ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domnode-unlink-node.html" 
),
"domprocessinginstruction_data" => array( 
	"methodname" => "domprocessinginstruction_data", 
	"version" => "undefined", 
	"method" => "string DomProcessingInstruction-&#62;data ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domprocessinginstruction-data.html" 
),
"domprocessinginstruction_target" => array( 
	"methodname" => "domprocessinginstruction_target", 
	"version" => "undefined", 
	"method" => "string DomProcessingInstruction-&#62;target ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.domprocessinginstruction-target.html" 
),
"domxml_new_doc" => array( 
	"methodname" => "domxml_new_doc", 
	"version" => "PHP4 >= 4.2.1", 
	"method" => "domdocument domxml_new_doc ( string version )", 
	"snippet" => "( \${1:\$version} )", 
	"desc" => "Creates new empty XML document", 
	"docurl" => "function.domxml-new-doc.html" 
),
"domxml_open_file" => array( 
	"methodname" => "domxml_open_file", 
	"version" => "PHP4 >= 4.2.1", 
	"method" => "domdocument domxml_open_file ( string filename [, int mode [, array &error]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Creates a DOM object from XML file", 
	"docurl" => "function.domxml-open-file.html" 
),
"domxml_open_mem" => array( 
	"methodname" => "domxml_open_mem", 
	"version" => "PHP4 >= 4.2.1", 
	"method" => "domdocument domxml_open_mem ( string str [, int mode [, array &error]] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Creates a DOM object of an XML document", 
	"docurl" => "function.domxml-open-mem.html" 
),
"domxml_version" => array( 
	"methodname" => "domxml_version", 
	"version" => "PHP4 >= 4.1.0", 
	"method" => "string domxml_version ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets the XML library version", 
	"docurl" => "function.domxml-version.html" 
),
"domxml_xmltree" => array( 
	"methodname" => "domxml_xmltree", 
	"version" => "PHP4 >= 4.2.1", 
	"method" => "domdocument domxml_xmltree ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Creates a tree of PHP objects from an XML document", 
	"docurl" => "function.domxml-xmltree.html" 
),
"domxml_xslt_stylesheet_doc" => array( 
	"methodname" => "domxml_xslt_stylesheet_doc", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "XsltStylesheet domxml_xslt_stylesheet_doc ( domdocument DocDocumentObject )", 
	"snippet" => "( \${1:\$DocDocumentObject} )", 
	"desc" => "Creates a DomXsltStylesheet Object from a DomDocument Object", 
	"docurl" => "function.domxml-xslt-stylesheet-doc.html" 
),
"domxml_xslt_stylesheet_file" => array( 
	"methodname" => "domxml_xslt_stylesheet_file", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "XsltStylesheet domxml_xslt_stylesheet_file ( string xsl_file )", 
	"snippet" => "( \${1:\$xsl_file} )", 
	"desc" => "Creates a DomXsltStylesheet Object from an XSL document in a file", 
	"docurl" => "function.domxml-xslt-stylesheet-file.html" 
),
"domxml_xslt_stylesheet" => array( 
	"methodname" => "domxml_xslt_stylesheet", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "XsltStylesheet domxml_xslt_stylesheet ( string xsl_document )", 
	"snippet" => "( \${1:\$xsl_document} )", 
	"desc" => "Creates a DomXsltStylesheet Object from an XML document in a string", 
	"docurl" => "function.domxml-xslt-stylesheet.html" 
),
"domxsltstylesheet_process" => array( 
	"methodname" => "domxsltstylesheet_process", 
	"version" => "undefined", 
	"method" => "domdocument DomXsltStylesheet-&#62;process ( domdocument DomDocument [, array xslt_parameters [, bool param_is_xpath]] )", 
	"snippet" => "( \${1:\$DomDocument} )", 
	"desc" => "", 
	"docurl" => "function.domxsltstylesheet-process.html" 
),
"domxsltstylesheet_result_dump_file" => array( 
	"methodname" => "domxsltstylesheet_result_dump_file", 
	"version" => "undefined", 
	"method" => "string DomXsltStylesheet-&#62;result_dump_file ( domdocument DomDocument, string filename )", 
	"snippet" => "( \${1:\$DomDocument}, \${2:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.domxsltstylesheet-result-dump-file.html" 
),
"domxsltstylesheet_result_dump_mem" => array( 
	"methodname" => "domxsltstylesheet_result_dump_mem", 
	"version" => "undefined", 
	"method" => "string DomXsltStylesheet-&#62;result_dump_mem ( domdocument DomDocument )", 
	"snippet" => "( \${1:\$DomDocument} )", 
	"desc" => "", 
	"docurl" => "function.domxsltstylesheet-result-dump-mem.html" 
),
"dotnet_load" => array( 
	"methodname" => "dotnet_load", 
	"version" => "undefined", 
	"method" => "int dotnet_load ( string assembly_name [, string datatype_name [, int codepage]] )", 
	"snippet" => "( \${1:\$assembly_name} )", 
	"desc" => "", 
	"docurl" => "function.dotnet-load.html" 
),
"doubleval" => array( 
	"methodname" => "doubleval", 
	"version" => "undefined", 
	"method" => "float doubleval ( mixed var )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of floatval()\nGet float value of a variable", 
	"docurl" => "function.doubleval.html" 
),

); # end of main array
?>