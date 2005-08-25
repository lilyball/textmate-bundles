<?php
$_LOOKUP = array( 
"scandir" => array( 
	"methodname" => "scandir", 
	"version" => "PHP5", 
	"method" => "array scandir ( string directory [, int sorting_order [, resource context]] )", 
	"snippet" => "( \${1:\$directory} )", 
	"desc" => "List files and directories inside the specified path", 
	"docurl" => "function.scandir.html" 
),
"sem_acquire" => array( 
	"methodname" => "sem_acquire", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool sem_acquire ( resource sem_identifier )", 
	"snippet" => "( \${1:\$sem_identifier} )", 
	"desc" => "Acquire a semaphore", 
	"docurl" => "function.sem-acquire.html" 
),
"sem_get" => array( 
	"methodname" => "sem_get", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource sem_get ( int key [, int max_acquire [, int perm [, int auto_release]]] )", 
	"snippet" => "( \${1:\$key} )", 
	"desc" => "Get a semaphore id", 
	"docurl" => "function.sem-get.html" 
),
"sem_release" => array( 
	"methodname" => "sem_release", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool sem_release ( resource sem_identifier )", 
	"snippet" => "( \${1:\$sem_identifier} )", 
	"desc" => "Release a semaphore", 
	"docurl" => "function.sem-release.html" 
),
"sem_remove" => array( 
	"methodname" => "sem_remove", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool sem_remove ( resource sem_identifier )", 
	"snippet" => "( \${1:\$sem_identifier} )", 
	"desc" => "Remove a semaphore", 
	"docurl" => "function.sem-remove.html" 
),
"serialize" => array( 
	"methodname" => "serialize", 
	"version" => "PHP3>= 3.0.5, PHP4, PHP5", 
	"method" => "string serialize ( mixed value )", 
	"snippet" => "( \${1:\$value} )", 
	"desc" => "Generates a storable representation of a value", 
	"docurl" => "function.serialize.html" 
),
"sesam_affected_rows" => array( 
	"methodname" => "sesam_affected_rows", 
	"version" => "PHP3 CVS only", 
	"method" => "int sesam_affected_rows ( string result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Get number of rows affected by an immediate query", 
	"docurl" => "function.sesam-affected-rows.html" 
),
"sesam_commit" => array( 
	"methodname" => "sesam_commit", 
	"version" => "PHP3 CVS only", 
	"method" => "bool sesam_commit ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Commit pending updates to the SESAM database", 
	"docurl" => "function.sesam-commit.html" 
),
"sesam_connect" => array( 
	"methodname" => "sesam_connect", 
	"version" => "PHP3 CVS only", 
	"method" => "bool sesam_connect ( string catalog, string schema, string user )", 
	"snippet" => "( \${1:\$catalog}, \${2:\$schema}, \${3:\$user} )", 
	"desc" => "Open SESAM database connection", 
	"docurl" => "function.sesam-connect.html" 
),
"sesam_diagnostic" => array( 
	"methodname" => "sesam_diagnostic", 
	"version" => "PHP3 CVS only", 
	"method" => "array sesam_diagnostic ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return status information for last SESAM call", 
	"docurl" => "function.sesam-diagnostic.html" 
),
"sesam_disconnect" => array( 
	"methodname" => "sesam_disconnect", 
	"version" => "PHP3 CVS only", 
	"method" => "bool sesam_disconnect ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Detach from SESAM connection", 
	"docurl" => "function.sesam-disconnect.html" 
),
"sesam_errormsg" => array( 
	"methodname" => "sesam_errormsg", 
	"version" => "PHP3 CVS only", 
	"method" => "string sesam_errormsg ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns error message of last SESAM call", 
	"docurl" => "function.sesam-errormsg.html" 
),
"sesam_execimm" => array( 
	"methodname" => "sesam_execimm", 
	"version" => "PHP3 CVS only", 
	"method" => "string sesam_execimm ( string query )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Execute an \"immediate\" SQL-statement", 
	"docurl" => "function.sesam-execimm.html" 
),
"sesam_fetch_array" => array( 
	"methodname" => "sesam_fetch_array", 
	"version" => "PHP3 CVS only", 
	"method" => "array sesam_fetch_array ( string result_id [, int whence [, int offset]] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Fetch one row as an associative array", 
	"docurl" => "function.sesam-fetch-array.html" 
),
"sesam_fetch_result" => array( 
	"methodname" => "sesam_fetch_result", 
	"version" => "PHP3 CVS only", 
	"method" => "mixed sesam_fetch_result ( string result_id [, int max_rows] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Return all or part of a query result", 
	"docurl" => "function.sesam-fetch-result.html" 
),
"sesam_fetch_row" => array( 
	"methodname" => "sesam_fetch_row", 
	"version" => "PHP3 CVS only", 
	"method" => "array sesam_fetch_row ( string result_id [, int whence [, int offset]] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Fetch one row as an array", 
	"docurl" => "function.sesam-fetch-row.html" 
),
"sesam_field_array" => array( 
	"methodname" => "sesam_field_array", 
	"version" => "PHP3 CVS only", 
	"method" => "array sesam_field_array ( string result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Return meta information about individual columns in a result", 
	"docurl" => "function.sesam-field-array.html" 
),
"sesam_field_name" => array( 
	"methodname" => "sesam_field_name", 
	"version" => "PHP3 CVS only", 
	"method" => "int sesam_field_name ( string result_id, int index )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$index} )", 
	"desc" => "Return one column name of the result set", 
	"docurl" => "function.sesam-field-name.html" 
),
"sesam_free_result" => array( 
	"methodname" => "sesam_free_result", 
	"version" => "PHP3 CVS only", 
	"method" => "int sesam_free_result ( string result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Releases resources for the query", 
	"docurl" => "function.sesam-free-result.html" 
),
"sesam_num_fields" => array( 
	"methodname" => "sesam_num_fields", 
	"version" => "PHP3 CVS only", 
	"method" => "int sesam_num_fields ( string result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Return the number of fields/columns in a result set", 
	"docurl" => "function.sesam-num-fields.html" 
),
"sesam_query" => array( 
	"methodname" => "sesam_query", 
	"version" => "PHP3 CVS only", 
	"method" => "string sesam_query ( string query [, bool scrollable] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Perform a SESAM SQL query and prepare the result", 
	"docurl" => "function.sesam-query.html" 
),
"sesam_rollback" => array( 
	"methodname" => "sesam_rollback", 
	"version" => "PHP3 CVS only", 
	"method" => "bool sesam_rollback ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Discard any pending updates to the SESAM database", 
	"docurl" => "function.sesam-rollback.html" 
),
"sesam_seek_row" => array( 
	"methodname" => "sesam_seek_row", 
	"version" => "PHP3 CVS only", 
	"method" => "bool sesam_seek_row ( string result_id, int whence [, int offset] )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$whence} )", 
	"desc" => "Set scrollable cursor mode for subsequent fetches", 
	"docurl" => "function.sesam-seek-row.html" 
),
"sesam_settransaction" => array( 
	"methodname" => "sesam_settransaction", 
	"version" => "PHP3 CVS only", 
	"method" => "bool sesam_settransaction ( int isolation_level, int read_only )", 
	"snippet" => "( \${1:\$isolation_level}, \${2:\$read_only} )", 
	"desc" => "Set SESAM transaction parameters", 
	"docurl" => "function.sesam-settransaction.html" 
),
"session_cache_expire" => array( 
	"methodname" => "session_cache_expire", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int session_cache_expire ( [int new_cache_expire] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Return current cache expire", 
	"docurl" => "function.session-cache-expire.html" 
),
"session_cache_limiter" => array( 
	"methodname" => "session_cache_limiter", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "string session_cache_limiter ( [string cache_limiter] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get and/or set the current cache limiter", 
	"docurl" => "function.session-cache-limiter.html" 
),
"session_commit" => array( 
	"methodname" => "session_commit", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "void session_write_close ( void )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of session_write_close()\nWrite session data and end session", 
	"docurl" => "function.session-commit.html" 
),
"session_decode" => array( 
	"methodname" => "session_decode", 
	"version" => "PHP4, PHP5", 
	"method" => "bool session_decode ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Decodes session data from a string", 
	"docurl" => "function.session-decode.html" 
),
"session_destroy" => array( 
	"methodname" => "session_destroy", 
	"version" => "PHP4, PHP5", 
	"method" => "bool session_destroy ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Destroys all data registered to a session", 
	"docurl" => "function.session-destroy.html" 
),
"session_encode" => array( 
	"methodname" => "session_encode", 
	"version" => "PHP4, PHP5", 
	"method" => "string session_encode ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Encodes the current session data as a string", 
	"docurl" => "function.session-encode.html" 
),
"session_get_cookie_params" => array( 
	"methodname" => "session_get_cookie_params", 
	"version" => "PHP4, PHP5", 
	"method" => "array session_get_cookie_params ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get the session cookie parameters", 
	"docurl" => "function.session-get-cookie-params.html" 
),
"session_id" => array( 
	"methodname" => "session_id", 
	"version" => "PHP4, PHP5", 
	"method" => "string session_id ( [string id] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get and/or set the current session id", 
	"docurl" => "function.session-id.html" 
),
"session_is_registered" => array( 
	"methodname" => "session_is_registered", 
	"version" => "PHP4, PHP5", 
	"method" => "bool session_is_registered ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Find out whether a global variable is registered in a session", 
	"docurl" => "function.session-is-registered.html" 
),
"session_module_name" => array( 
	"methodname" => "session_module_name", 
	"version" => "PHP4, PHP5", 
	"method" => "string session_module_name ( [string module] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get and/or set the current session module", 
	"docurl" => "function.session-module-name.html" 
),
"session_name" => array( 
	"methodname" => "session_name", 
	"version" => "PHP4, PHP5", 
	"method" => "string session_name ( [string name] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get and/or set the current session name", 
	"docurl" => "function.session-name.html" 
),
"session_regenerate_id" => array( 
	"methodname" => "session_regenerate_id", 
	"version" => "PHP4 >= 4.3.2, PHP5", 
	"method" => "bool session_regenerate_id ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Update the current session id with a newly generated one", 
	"docurl" => "function.session-regenerate-id.html" 
),
"session_register" => array( 
	"methodname" => "session_register", 
	"version" => "PHP4, PHP5", 
	"method" => "bool session_register ( mixed name [, mixed ...] )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Register one or more global variables with the current session", 
	"docurl" => "function.session-register.html" 
),
"session_save_path" => array( 
	"methodname" => "session_save_path", 
	"version" => "PHP4, PHP5", 
	"method" => "string session_save_path ( [string path] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get and/or set the current session save path", 
	"docurl" => "function.session-save-path.html" 
),
"session_set_cookie_params" => array( 
	"methodname" => "session_set_cookie_params", 
	"version" => "PHP4, PHP5", 
	"method" => "void session_set_cookie_params ( int lifetime [, string path [, string domain [, bool secure]]] )", 
	"snippet" => "( \${1:\$lifetime} )", 
	"desc" => "Set the session cookie parameters", 
	"docurl" => "function.session-set-cookie-params.html" 
),
"session_set_save_handler" => array( 
	"methodname" => "session_set_save_handler", 
	"version" => "PHP4, PHP5", 
	"method" => "bool session_set_save_handler ( string open, string close, string read, string write, string destroy, string gc )", 
	"snippet" => "( \${1:\$open}, \${2:\$close}, \${3:\$read}, \${4:\$write}, \${5:\$destroy}, \${6:\$gc} )", 
	"desc" => "Sets user-level session storage functions", 
	"docurl" => "function.session-set-save-handler.html" 
),
"session_start" => array( 
	"methodname" => "session_start", 
	"version" => "PHP4, PHP5", 
	"method" => "bool session_start ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Initialize session data", 
	"docurl" => "function.session-start.html" 
),
"session_unregister" => array( 
	"methodname" => "session_unregister", 
	"version" => "PHP4, PHP5", 
	"method" => "bool session_unregister ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Unregister a global variable from the current session", 
	"docurl" => "function.session-unregister.html" 
),
"session_unset" => array( 
	"methodname" => "session_unset", 
	"version" => "PHP4, PHP5", 
	"method" => "void session_unset ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Free all session variables", 
	"docurl" => "function.session-unset.html" 
),
"session_write_close" => array( 
	"methodname" => "session_write_close", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "void session_write_close ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Write session data and end session", 
	"docurl" => "function.session-write-close.html" 
),
"set_error_handler" => array( 
	"methodname" => "set_error_handler", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "mixed set_error_handler ( callback error_handler [, int error_types] )", 
	"snippet" => "( \${1:\$error_handler} )", 
	"desc" => "Sets a user-defined error handler function", 
	"docurl" => "function.set-error-handler.html" 
),
"set_exception_handler" => array( 
	"methodname" => "set_exception_handler", 
	"version" => "PHP5", 
	"method" => "string set_exception_handler ( callback exception_handler )", 
	"snippet" => "( \${1:\$exception_handler} )", 
	"desc" => "Sets a user-defined exception handler function", 
	"docurl" => "function.set-exception-handler.html" 
),
"set_file_buffer" => array( 
	"methodname" => "set_file_buffer", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int stream_set_write_buffer ( resource stream, int buffer )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of stream_set_write_buffer()\nSets file buffering on the given stream", 
	"docurl" => "function.set-file-buffer.html" 
),
"set_include_path" => array( 
	"methodname" => "set_include_path", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string set_include_path ( string new_include_path )", 
	"snippet" => "( \${1:\$new_include_path} )", 
	"desc" => "Sets the include_path configuration option", 
	"docurl" => "function.set-include-path.html" 
),
"set_magic_quotes_runtime" => array( 
	"methodname" => "set_magic_quotes_runtime", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool set_magic_quotes_runtime ( int new_setting )", 
	"snippet" => "( \${1:\$new_setting} )", 
	"desc" => "Sets the current active configuration setting of   magic_quotes_runtime", 
	"docurl" => "function.set-magic-quotes-runtime.html" 
),
"set_time_limit" => array( 
	"methodname" => "set_time_limit", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void set_time_limit ( int seconds )", 
	"snippet" => "( \${1:\$seconds} )", 
	"desc" => "Limits the maximum execution time", 
	"docurl" => "function.set-time-limit.html" 
),
"setcookie" => array( 
	"methodname" => "setcookie", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool setcookie ( string name [, string value [, int expire [, string path [, string domain [, bool secure]]]]] )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Send a cookie", 
	"docurl" => "function.setcookie.html" 
),
"setlocale" => array( 
	"methodname" => "setlocale", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string setlocale ( mixed category, string locale [, string ...] )", 
	"snippet" => "( \${1:\$category}, \${2:\$locale} )", 
	"desc" => "Set locale information", 
	"docurl" => "function.setlocale.html" 
),
"setrawcookie" => array( 
	"methodname" => "setrawcookie", 
	"version" => "PHP5", 
	"method" => "bool setrawcookie ( string name [, string value [, int expire [, string path [, string domain [, bool secure]]]]] )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Send a cookie without urlencoding the cookie value", 
	"docurl" => "function.setrawcookie.html" 
),
"settype" => array( 
	"methodname" => "settype", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool settype ( mixed &var, string type )", 
	"snippet" => "( \${1:\$var}, \${2:\$type} )", 
	"desc" => "Set the type of a variable", 
	"docurl" => "function.settype.html" 
),
"sha1_file" => array( 
	"methodname" => "sha1_file", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string sha1_file ( string filename [, bool raw_output] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Calculate the sha1 hash of a file", 
	"docurl" => "function.sha1-file.html" 
),
"sha1" => array( 
	"methodname" => "sha1", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string sha1 ( string str [, bool raw_output] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Calculate the sha1 hash of a string", 
	"docurl" => "function.sha1.html" 
),
"shell_exec" => array( 
	"methodname" => "shell_exec", 
	"version" => "PHP4, PHP5", 
	"method" => "string shell_exec ( string cmd )", 
	"snippet" => "( \${1:\$cmd} )", 
	"desc" => "Execute command via shell and return the complete output as a string", 
	"docurl" => "function.shell-exec.html" 
),
"shm_attach" => array( 
	"methodname" => "shm_attach", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int shm_attach ( int key [, int memsize [, int perm]] )", 
	"snippet" => "( \${1:\$key} )", 
	"desc" => "Creates or open a shared memory segment", 
	"docurl" => "function.shm-attach.html" 
),
"shm_detach" => array( 
	"methodname" => "shm_detach", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool shm_detach ( int shm_identifier )", 
	"snippet" => "( \${1:\$shm_identifier} )", 
	"desc" => "Disconnects from shared memory segment", 
	"docurl" => "function.shm-detach.html" 
),
"shm_get_var" => array( 
	"methodname" => "shm_get_var", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "mixed shm_get_var ( int shm_identifier, int variable_key )", 
	"snippet" => "( \${1:\$shm_identifier}, \${2:\$variable_key} )", 
	"desc" => "Returns a variable from shared memory", 
	"docurl" => "function.shm-get-var.html" 
),
"shm_put_var" => array( 
	"methodname" => "shm_put_var", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool shm_put_var ( int shm_identifier, int variable_key, mixed variable )", 
	"snippet" => "( \${1:\$shm_identifier}, \${2:\$variable_key}, \${3:\$variable} )", 
	"desc" => "Inserts or updates a variable in shared memory", 
	"docurl" => "function.shm-put-var.html" 
),
"shm_remove_var" => array( 
	"methodname" => "shm_remove_var", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int shm_remove_var ( int shm_identifier, int variable_key )", 
	"snippet" => "( \${1:\$shm_identifier}, \${2:\$variable_key} )", 
	"desc" => "Removes a variable from shared memory", 
	"docurl" => "function.shm-remove-var.html" 
),
"shm_remove" => array( 
	"methodname" => "shm_remove", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int shm_remove ( int shm_identifier )", 
	"snippet" => "( \${1:\$shm_identifier} )", 
	"desc" => "Removes shared memory from Unix systems", 
	"docurl" => "function.shm-remove.html" 
),
"shmop_close" => array( 
	"methodname" => "shmop_close", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int shmop_close ( int shmid )", 
	"snippet" => "( \${1:\$shmid} )", 
	"desc" => "Close shared memory block", 
	"docurl" => "function.shmop-close.html" 
),
"shmop_delete" => array( 
	"methodname" => "shmop_delete", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int shmop_delete ( int shmid )", 
	"snippet" => "( \${1:\$shmid} )", 
	"desc" => "Delete shared memory block", 
	"docurl" => "function.shmop-delete.html" 
),
"shmop_open" => array( 
	"methodname" => "shmop_open", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int shmop_open ( int key, string flags, int mode, int size )", 
	"snippet" => "( \${1:\$key}, \${2:\$flags}, \${3:\$mode}, \${4:\$size} )", 
	"desc" => "Create or open shared memory block", 
	"docurl" => "function.shmop-open.html" 
),
"shmop_read" => array( 
	"methodname" => "shmop_read", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string shmop_read ( int shmid, int start, int count )", 
	"snippet" => "( \${1:\$shmid}, \${2:\$start}, \${3:\$count} )", 
	"desc" => "Read data from shared memory block", 
	"docurl" => "function.shmop-read.html" 
),
"shmop_size" => array( 
	"methodname" => "shmop_size", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int shmop_size ( int shmid )", 
	"snippet" => "( \${1:\$shmid} )", 
	"desc" => "Get size of shared memory block", 
	"docurl" => "function.shmop-size.html" 
),
"shmop_write" => array( 
	"methodname" => "shmop_write", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int shmop_write ( int shmid, string data, int offset )", 
	"snippet" => "( \${1:\$shmid}, \${2:\$data}, \${3:\$offset} )", 
	"desc" => "Write data into shared memory block", 
	"docurl" => "function.shmop-write.html" 
),
"show_source" => array( 
	"methodname" => "show_source", 
	"version" => "undefined", 
	"method" => "mixed highlight_file ( string filename [, bool return] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of highlight_file()\nSyntax highlighting of a file", 
	"docurl" => "function.show-source.html" 
),
"shuffle" => array( 
	"methodname" => "shuffle", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool shuffle ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Shuffle an array", 
	"docurl" => "function.shuffle.html" 
),
"similar_text" => array( 
	"methodname" => "similar_text", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int similar_text ( string first, string second [, float &percent] )", 
	"snippet" => "( \${1:\$first}, \${2:\$second} )", 
	"desc" => "Calculate the similarity between two strings", 
	"docurl" => "function.similar-text.html" 
),
"simplexml_element_asxml" => array( 
	"methodname" => "simplexml_element_asxml", 
	"version" => "undefined", 
	"method" => "string SimpleXMLElement-&#62;asXML ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.simplexml-element-asxml.html" 
),
"simplexml_element_attributes" => array( 
	"methodname" => "simplexml_element_attributes", 
	"version" => "undefined", 
	"method" => "SimpleXMLElement simplexml_element-&#62;attributes ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "", 
	"docurl" => "function.simplexml-element-attributes.html" 
),
"simplexml_element_children" => array( 
	"methodname" => "simplexml_element_children", 
	"version" => "undefined", 
	"method" => "SimpleXMLElement simplexml_element-&#62;children ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.simplexml-element-children.html" 
),
"simplexml_element_xpath" => array( 
	"methodname" => "simplexml_element_xpath", 
	"version" => "undefined", 
	"method" => "array SimpleXMLElement-&#62;xpath ( string path )", 
	"snippet" => "( \${1:\$path} )", 
	"desc" => "", 
	"docurl" => "function.simplexml-element-xpath.html" 
),
"simplexml_import_dom" => array( 
	"methodname" => "simplexml_import_dom", 
	"version" => "PHP5", 
	"method" => "SimpleXMLElement simplexml_import_dom ( DOMNode node [, string class_name] )", 
	"snippet" => "( \${1:\$node} )", 
	"desc" => "Get a SimpleXMLElement object from a   DOM node.", 
	"docurl" => "function.simplexml-import-dom.html" 
),
"simplexml_load_file" => array( 
	"methodname" => "simplexml_load_file", 
	"version" => "PHP5", 
	"method" => "object simplexml_load_file ( string filename [, string class_name [, int options]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Interprets an XML file into an object", 
	"docurl" => "function.simplexml-load-file.html" 
),
"simplexml_load_string" => array( 
	"methodname" => "simplexml_load_string", 
	"version" => "PHP5", 
	"method" => "object simplexml_load_string ( string data [, string class_name [, int options]] )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Interprets a string of XML into an object", 
	"docurl" => "function.simplexml-load-string.html" 
),
"sin" => array( 
	"methodname" => "sin", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float sin ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Sine", 
	"docurl" => "function.sin.html" 
),
"sinh" => array( 
	"methodname" => "sinh", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float sinh ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Hyperbolic sine", 
	"docurl" => "function.sinh.html" 
),
"sizeof" => array( 
	"methodname" => "sizeof", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int count ( mixed var [, int mode] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of count()\nCount elements in an array, or properties in an object", 
	"docurl" => "function.sizeof.html" 
),
"sleep" => array( 
	"methodname" => "sleep", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void sleep ( int seconds )", 
	"snippet" => "( \${1:\$seconds} )", 
	"desc" => "Delay execution", 
	"docurl" => "function.sleep.html" 
),
"snmp_get_quick_print" => array( 
	"methodname" => "snmp_get_quick_print", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool snmp_get_quick_print ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Fetches the current value of the UCD library\'s quick_print setting", 
	"docurl" => "function.snmp-get-quick-print.html" 
),
"snmp_get_valueretrieval" => array( 
	"methodname" => "snmp_get_valueretrieval", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "int snmp_get_valueretrieval ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the method how the SNMP values will be returned", 
	"docurl" => "function.snmp-get-valueretrieval.html" 
),
"snmp_read_mib" => array( 
	"methodname" => "snmp_read_mib", 
	"version" => "PHP5", 
	"method" => "int snmp_read_mib ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Reads and parses a MIB file into the active MIB tree", 
	"docurl" => "function.snmp-read-mib.html" 
),
"snmp_set_enum_print" => array( 
	"methodname" => "snmp_set_enum_print", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "void snmp_set_enum_print ( int enum_print )", 
	"snippet" => "( \${1:\$enum_print} )", 
	"desc" => "Return all values that are enums with their enum value instead of the raw integer", 
	"docurl" => "function.snmp-set-enum-print.html" 
),
"snmp_set_oid_numeric_print" => array( 
	"methodname" => "snmp_set_oid_numeric_print", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "void snmp_set_oid_numeric_print ( int oid_numeric_print )", 
	"snippet" => "( \${1:\$oid_numeric_print} )", 
	"desc" => "Return all objects including their respective object id within the specified one", 
	"docurl" => "function.snmp-set-oid-numeric-print.html" 
),
"snmp_set_quick_print" => array( 
	"methodname" => "snmp_set_quick_print", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "void snmp_set_quick_print ( bool quick_print )", 
	"snippet" => "( \${1:\$quick_print} )", 
	"desc" => "Set the value of quick_print within the UCD SNMP library", 
	"docurl" => "function.snmp-set-quick-print.html" 
),
"snmp_set_valueretrieval" => array( 
	"methodname" => "snmp_set_valueretrieval", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "int snmp_set_valueretrieval ( int method )", 
	"snippet" => "( \${1:\$method} )", 
	"desc" => "Specify the method how the SNMP values will be returned", 
	"docurl" => "function.snmp-set-valueretrieval.html" 
),
"snmpget" => array( 
	"methodname" => "snmpget", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string snmpget ( string hostname, string community, string object_id [, int timeout [, int retries]] )", 
	"snippet" => "( \${1:\$hostname}, \${2:\$community}, \${3:\$object_id} )", 
	"desc" => "Fetch an SNMP object", 
	"docurl" => "function.snmpget.html" 
),
"snmpgetnext" => array( 
	"methodname" => "snmpgetnext", 
	"version" => "PHP5", 
	"method" => "string snmpgetnext ( string host, string community, string object_id [, int timeout [, int retries]] )", 
	"snippet" => "( \${1:\$host}, \${2:\$community}, \${3:\$object_id} )", 
	"desc" => "Fetch a SNMP object", 
	"docurl" => "function.snmpgetnext.html" 
),
"snmprealwalk" => array( 
	"methodname" => "snmprealwalk", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "array snmprealwalk ( string host, string community, string object_id [, int timeout [, int retries]] )", 
	"snippet" => "( \${1:\$host}, \${2:\$community}, \${3:\$object_id} )", 
	"desc" => "Return all objects including their respective object ID within the specified one", 
	"docurl" => "function.snmprealwalk.html" 
),
"snmpset" => array( 
	"methodname" => "snmpset", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "bool snmpset ( string hostname, string community, string object_id, string type, mixed value [, int timeout [, int retries]] )", 
	"snippet" => "( \${1:\$hostname}, \${2:\$community}, \${3:\$object_id}, \${4:\$type}, \${5:\$value} )", 
	"desc" => "Set an SNMP object", 
	"docurl" => "function.snmpset.html" 
),
"snmpwalk" => array( 
	"methodname" => "snmpwalk", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array snmpwalk ( string hostname, string community, string object_id [, int timeout [, int retries]] )", 
	"snippet" => "( \${1:\$hostname}, \${2:\$community}, \${3:\$object_id} )", 
	"desc" => "Fetch all the SNMP objects from an agent", 
	"docurl" => "function.snmpwalk.html" 
),
"snmpwalkoid" => array( 
	"methodname" => "snmpwalkoid", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "array snmpwalkoid ( string hostname, string community, string object_id [, int timeout [, int retries]] )", 
	"snippet" => "( \${1:\$hostname}, \${2:\$community}, \${3:\$object_id} )", 
	"desc" => "Query for a tree of information about a network entity", 
	"docurl" => "function.snmpwalkoid.html" 
),
"soap_soapclient_call" => array( 
	"methodname" => "soap_soapclient_call", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-call.html" 
),
"soap_soapclient_construct" => array( 
	"methodname" => "soap_soapclient_construct", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-construct.html" 
),
"soap_soapclient_dorequest" => array( 
	"methodname" => "soap_soapclient_dorequest", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-dorequest.html" 
),
"soap_soapclient_getfunctions" => array( 
	"methodname" => "soap_soapclient_getfunctions", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-getfunctions.html" 
),
"soap_soapclient_getlastrequest" => array( 
	"methodname" => "soap_soapclient_getlastrequest", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-getlastrequest.html" 
),
"soap_soapclient_getlastrequestheaders" => array( 
	"methodname" => "soap_soapclient_getlastrequestheaders", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-getlastrequestheaders.html" 
),
"soap_soapclient_getlastresponse" => array( 
	"methodname" => "soap_soapclient_getlastresponse", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-getlastresponse.html" 
),
"soap_soapclient_getlastresponseheaders" => array( 
	"methodname" => "soap_soapclient_getlastresponseheaders", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-getlastresponseheaders.html" 
),
"soap_soapclient_gettypes" => array( 
	"methodname" => "soap_soapclient_gettypes", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-gettypes.html" 
),
"soap_soapclient_setcookie" => array( 
	"methodname" => "soap_soapclient_setcookie", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-setcookie.html" 
),
"soap_soapclient_soapcall" => array( 
	"methodname" => "soap_soapclient_soapcall", 
	"version" => "undefined", 
	"method" => "class SoapClient { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapclient-soapcall.html" 
),
"soap_soapfault_construct" => array( 
	"methodname" => "soap_soapfault_construct", 
	"version" => "undefined", 
	"method" => "class SoapFault { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapfault-construct.html" 
),
"soap_soapheader_construct" => array( 
	"methodname" => "soap_soapheader_construct", 
	"version" => "undefined", 
	"method" => "class SoapHeader { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapheader-construct.html" 
),
"soap_soapparam_construct" => array( 
	"methodname" => "soap_soapparam_construct", 
	"version" => "undefined", 
	"method" => "class SoapParam { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapparam-construct.html" 
),
"soap_soapserver_addfunction" => array( 
	"methodname" => "soap_soapserver_addfunction", 
	"version" => "undefined", 
	"method" => "class SoapServer { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapserver-addfunction.html" 
),
"soap_soapserver_construct" => array( 
	"methodname" => "soap_soapserver_construct", 
	"version" => "undefined", 
	"method" => "class SoapServer { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapserver-construct.html" 
),
"soap_soapserver_fault" => array( 
	"methodname" => "soap_soapserver_fault", 
	"version" => "undefined", 
	"method" => "class SoapServer { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapserver-fault.html" 
),
"soap_soapserver_getfunctions" => array( 
	"methodname" => "soap_soapserver_getfunctions", 
	"version" => "undefined", 
	"method" => "class SoapServer { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapserver-getfunctions.html" 
),
"soap_soapserver_handle" => array( 
	"methodname" => "soap_soapserver_handle", 
	"version" => "undefined", 
	"method" => "class SoapServer { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapserver-handle.html" 
),
"soap_soapserver_setclass" => array( 
	"methodname" => "soap_soapserver_setclass", 
	"version" => "undefined", 
	"method" => "class SoapServer { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapserver-setclass.html" 
),
"soap_soapserver_setpersistence" => array( 
	"methodname" => "soap_soapserver_setpersistence", 
	"version" => "undefined", 
	"method" => "class SoapServer { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapserver-setpersistence.html" 
),
"soap_soapvar_construct" => array( 
	"methodname" => "soap_soapvar_construct", 
	"version" => "undefined", 
	"method" => "class SoapVar { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.soap-soapvar-construct.html" 
),
"socket_accept" => array( 
	"methodname" => "socket_accept", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "resource socket_accept ( resource socket )", 
	"snippet" => "( \${1:\$socket} )", 
	"desc" => "Accepts a connection on a socket", 
	"docurl" => "function.socket-accept.html" 
),
"socket_bind" => array( 
	"methodname" => "socket_bind", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool socket_bind ( resource socket, string address [, int port] )", 
	"snippet" => "( \${1:\$socket}, \${2:\$address} )", 
	"desc" => "Binds a name to a socket", 
	"docurl" => "function.socket-bind.html" 
),
"socket_clear_error" => array( 
	"methodname" => "socket_clear_error", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void socket_clear_error ( [resource socket] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Clears the error on the socket or the last error code", 
	"docurl" => "function.socket-clear-error.html" 
),
"socket_close" => array( 
	"methodname" => "socket_close", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "void socket_close ( resource socket )", 
	"snippet" => "( \${1:\$socket} )", 
	"desc" => "Closes a socket resource", 
	"docurl" => "function.socket-close.html" 
),
"socket_connect" => array( 
	"methodname" => "socket_connect", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool socket_connect ( resource socket, string address [, int port] )", 
	"snippet" => "( \${1:\$socket}, \${2:\$address} )", 
	"desc" => "Initiates a connection on a socket", 
	"docurl" => "function.socket-connect.html" 
),
"socket_create_listen" => array( 
	"methodname" => "socket_create_listen", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "resource socket_create_listen ( int port [, int backlog] )", 
	"snippet" => "( \${1:\$port} )", 
	"desc" => "Opens a socket on port to accept connections", 
	"docurl" => "function.socket-create-listen.html" 
),
"socket_create_pair" => array( 
	"methodname" => "socket_create_pair", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool socket_create_pair ( int domain, int type, int protocol, array &fd )", 
	"snippet" => "( \${1:\$domain}, \${2:\$type}, \${3:\$protocol}, \${4:\$fd} )", 
	"desc" => "Creates a pair of indistinguishable sockets and stores them in an array", 
	"docurl" => "function.socket-create-pair.html" 
),
"socket_create" => array( 
	"methodname" => "socket_create", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "resource socket_create ( int domain, int type, int protocol )", 
	"snippet" => "( \${1:\$domain}, \${2:\$type}, \${3:\$protocol} )", 
	"desc" => "Create a socket (endpoint for communication)", 
	"docurl" => "function.socket-create.html" 
),
"socket_get_option" => array( 
	"methodname" => "socket_get_option", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "mixed socket_get_option ( resource socket, int level, int optname )", 
	"snippet" => "( \${1:\$socket}, \${2:\$level}, \${3:\$optname} )", 
	"desc" => "Gets socket options for the socket", 
	"docurl" => "function.socket-get-option.html" 
),
"socket_get_status" => array( 
	"methodname" => "socket_get_status", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.socket-get-status.html" 
),
"socket_getpeername" => array( 
	"methodname" => "socket_getpeername", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool socket_getpeername ( resource socket, string &addr [, int &port] )", 
	"snippet" => "( \${1:\$socket}, \${2:\$addr} )", 
	"desc" => "Queries the remote side of the given socket which may either result in host/port   or in a Unix filesystem path, dependent on its type", 
	"docurl" => "function.socket-getpeername.html" 
),
"socket_getsockname" => array( 
	"methodname" => "socket_getsockname", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool socket_getsockname ( resource socket, string &addr [, int &port] )", 
	"snippet" => "( \${1:\$socket}, \${2:\$addr} )", 
	"desc" => "Queries the local side of the given socket which may either result in host/port   or in a Unix filesystem path, dependent on its type", 
	"docurl" => "function.socket-getsockname.html" 
),
"socket_last_error" => array( 
	"methodname" => "socket_last_error", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int socket_last_error ( [resource socket] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns the last error on the socket", 
	"docurl" => "function.socket-last-error.html" 
),
"socket_listen" => array( 
	"methodname" => "socket_listen", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool socket_listen ( resource socket [, int backlog] )", 
	"snippet" => "( \${1:\$socket} )", 
	"desc" => "Listens for a connection on a socket", 
	"docurl" => "function.socket-listen.html" 
),
"socket_read" => array( 
	"methodname" => "socket_read", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string socket_read ( resource socket, int length [, int type] )", 
	"snippet" => "( \${1:\$socket}, \${2:\$length} )", 
	"desc" => "Reads a maximum of length bytes from a socket", 
	"docurl" => "function.socket-read.html" 
),
"socket_recv" => array( 
	"methodname" => "socket_recv", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int socket_recv ( resource socket, string &buf, int len, int flags )", 
	"snippet" => "( \${1:\$socket}, \${2:\$buf}, \${3:\$len}, \${4:\$flags} )", 
	"desc" => "Receives data from a connected socket", 
	"docurl" => "function.socket-recv.html" 
),
"socket_recvfrom" => array( 
	"methodname" => "socket_recvfrom", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int socket_recvfrom ( resource socket, string &buf, int len, int flags, string &name [, int &port] )", 
	"snippet" => "( \${1:\$socket}, \${2:\$buf}, \${3:\$len}, \${4:\$flags}, \${5:\$name} )", 
	"desc" => "Receives data from a socket, connected or not", 
	"docurl" => "function.socket-recvfrom.html" 
),
"socket_select" => array( 
	"methodname" => "socket_select", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int socket_select ( array &read, array &write, array &except, int tv_sec [, int tv_usec] )", 
	"snippet" => "( \${1:\$read}, \${2:\$write}, \${3:\$except}, \${4:\$tv_sec} )", 
	"desc" => "Runs the select() system call on the given arrays of sockets    with a specified timeout", 
	"docurl" => "function.socket-select.html" 
),
"socket_send" => array( 
	"methodname" => "socket_send", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int socket_send ( resource socket, string buf, int len, int flags )", 
	"snippet" => "( \${1:\$socket}, \${2:\$buf}, \${3:\$len}, \${4:\$flags} )", 
	"desc" => "Sends data to a connected socket", 
	"docurl" => "function.socket-send.html" 
),
"socket_sendto" => array( 
	"methodname" => "socket_sendto", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int socket_sendto ( resource socket, string buf, int len, int flags, string addr [, int port] )", 
	"snippet" => "( \${1:\$socket}, \${2:\$buf}, \${3:\$len}, \${4:\$flags}, \${5:\$addr} )", 
	"desc" => "Sends a message to a socket, whether it is connected or not", 
	"docurl" => "function.socket-sendto.html" 
),
"socket_set_block" => array( 
	"methodname" => "socket_set_block", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool socket_set_block ( resource socket )", 
	"snippet" => "( \${1:\$socket} )", 
	"desc" => "Sets blocking mode on a socket resource", 
	"docurl" => "function.socket-set-block.html" 
),
"socket_set_blocking" => array( 
	"methodname" => "socket_set_blocking", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.socket-set-blocking.html" 
),
"socket_set_nonblock" => array( 
	"methodname" => "socket_set_nonblock", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool socket_set_nonblock ( resource socket )", 
	"snippet" => "( \${1:\$socket} )", 
	"desc" => "Sets nonblocking mode for file descriptor fd", 
	"docurl" => "function.socket-set-nonblock.html" 
),
"socket_set_option" => array( 
	"methodname" => "socket_set_option", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool socket_set_option ( resource socket, int level, int optname, mixed optval )", 
	"snippet" => "( \${1:\$socket}, \${2:\$level}, \${3:\$optname}, \${4:\$optval} )", 
	"desc" => "Sets socket options for the socket", 
	"docurl" => "function.socket-set-option.html" 
),
"socket_set_timeout" => array( 
	"methodname" => "socket_set_timeout", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.socket-set-timeout.html" 
),
"socket_shutdown" => array( 
	"methodname" => "socket_shutdown", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool socket_shutdown ( resource socket [, int how] )", 
	"snippet" => "( \${1:\$socket} )", 
	"desc" => "Shuts down a socket for receiving, sending, or both", 
	"docurl" => "function.socket-shutdown.html" 
),
"socket_strerror" => array( 
	"methodname" => "socket_strerror", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string socket_strerror ( int errno )", 
	"snippet" => "( \${1:\$errno} )", 
	"desc" => "Return a string describing a socket error", 
	"docurl" => "function.socket-strerror.html" 
),
"socket_write" => array( 
	"methodname" => "socket_write", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int socket_write ( resource socket, string buffer [, int length] )", 
	"snippet" => "( \${1:\$socket}, \${2:\$buffer} )", 
	"desc" => "Write to a socket", 
	"docurl" => "function.socket-write.html" 
),
"sort" => array( 
	"methodname" => "sort", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool sort ( array &array [, int sort_flags] )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Sort an array", 
	"docurl" => "function.sort.html" 
),
"soundex" => array( 
	"methodname" => "soundex", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string soundex ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Calculate the soundex key of a string", 
	"docurl" => "function.soundex.html" 
),
"spl_classes" => array( 
	"methodname" => "spl_classes", 
	"version" => "PHP5", 
	"method" => "array spl_classes ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return available SPL classes", 
	"docurl" => "function.spl-classes.html" 
),
"split" => array( 
	"methodname" => "split", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array split ( string pattern, string string [, int limit] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$string} )", 
	"desc" => "Split string into array by regular expression", 
	"docurl" => "function.split.html" 
),
"spliti" => array( 
	"methodname" => "spliti", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "array spliti ( string pattern, string string [, int limit] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$string} )", 
	"desc" => "Split string into array by regular expression case insensitive", 
	"docurl" => "function.spliti.html" 
),
"sprintf" => array( 
	"methodname" => "sprintf", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string sprintf ( string format [, mixed args [, mixed ...]] )", 
	"snippet" => "( \${1:\$format} )", 
	"desc" => "Return a formatted string", 
	"docurl" => "function.sprintf.html" 
),
"sql_regcase" => array( 
	"methodname" => "sql_regcase", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string sql_regcase ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Make regular expression for case insensitive match", 
	"docurl" => "function.sql-regcase.html" 
),
"sqlite_array_query" => array( 
	"methodname" => "sqlite_array_query", 
	"version" => "PHP5", 
	"method" => "array sqlite_array_query ( resource dbhandle, string query [, int result_type [, bool decode_binary]] )", 
	"snippet" => "( \${1:\$dbhandle}, \${2:\$query} )", 
	"desc" => "Execute a query against a given database and returns an array", 
	"docurl" => "function.sqlite-array-query.html" 
),
"sqlite_busy_timeout" => array( 
	"methodname" => "sqlite_busy_timeout", 
	"version" => "PHP5", 
	"method" => "void sqlite_busy_timeout ( resource dbhandle, int milliseconds )", 
	"snippet" => "( \${1:\$dbhandle}, \${2:\$milliseconds} )", 
	"desc" => "Set busy timeout duration, or disable busy handlers", 
	"docurl" => "function.sqlite-busy-timeout.html" 
),
"sqlite_changes" => array( 
	"methodname" => "sqlite_changes", 
	"version" => "PHP5", 
	"method" => "int sqlite_changes ( resource dbhandle )", 
	"snippet" => "( \${1:\$dbhandle} )", 
	"desc" => "Returns the number of rows that were changed by the most  recent SQL statement", 
	"docurl" => "function.sqlite-changes.html" 
),
"sqlite_close" => array( 
	"methodname" => "sqlite_close", 
	"version" => "PHP5", 
	"method" => "void sqlite_close ( resource dbhandle )", 
	"snippet" => "( \${1:\$dbhandle} )", 
	"desc" => "Closes an open SQLite database", 
	"docurl" => "function.sqlite-close.html" 
),
"sqlite_column" => array( 
	"methodname" => "sqlite_column", 
	"version" => "PHP5", 
	"method" => "mixed sqlite_column ( resource result, mixed index_or_name [, bool decode_binary] )", 
	"snippet" => "( \${1:\$result}, \${2:\$index_or_name} )", 
	"desc" => "Fetches a column from the current row of a result set", 
	"docurl" => "function.sqlite-column.html" 
),
"sqlite_create_aggregate" => array( 
	"methodname" => "sqlite_create_aggregate", 
	"version" => "PHP5", 
	"method" => "bool sqlite_create_aggregate ( resource dbhandle, string function_name, callback step_func, callback finalize_func [, int num_args] )", 
	"snippet" => "( \${1:\$dbhandle}, \${2:\$function_name}, \${3:\$step_func}, \${4:\$finalize_func} )", 
	"desc" => "Register an aggregating UDF for use in SQL statements", 
	"docurl" => "function.sqlite-create-aggregate.html" 
),
"sqlite_create_function" => array( 
	"methodname" => "sqlite_create_function", 
	"version" => "PHP5", 
	"method" => "bool sqlite_create_function ( resource dbhandle, string function_name, callback callback [, int num_args] )", 
	"snippet" => "( \${1:\$dbhandle}, \${2:\$function_name}, \${3:\$callback} )", 
	"desc" => "Registers a \"regular\" User Defined Function for use in SQL statements", 
	"docurl" => "function.sqlite-create-function.html" 
),
"sqlite_current" => array( 
	"methodname" => "sqlite_current", 
	"version" => "PHP5", 
	"method" => "array sqlite_current ( resource result [, int result_type [, bool decode_binary]] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetches the current row from a result set as an array", 
	"docurl" => "function.sqlite-current.html" 
),
"sqlite_error_string" => array( 
	"methodname" => "sqlite_error_string", 
	"version" => "PHP5", 
	"method" => "string sqlite_error_string ( int error_code )", 
	"snippet" => "( \${1:\$error_code} )", 
	"desc" => "Returns the textual description of an error code", 
	"docurl" => "function.sqlite-error-string.html" 
),
"sqlite_escape_string" => array( 
	"methodname" => "sqlite_escape_string", 
	"version" => "PHP5", 
	"method" => "string sqlite_escape_string ( string item )", 
	"snippet" => "( \${1:\$item} )", 
	"desc" => "Escapes a string for use as a query parameter", 
	"docurl" => "function.sqlite-escape-string.html" 
),
"sqlite_exec" => array( 
	"methodname" => "sqlite_exec", 
	"version" => "undefined", 
	"method" => "bool sqlite_exec ( resource dbhandle, string query )", 
	"snippet" => "( \${1:\$dbhandle}, \${2:\$query} )", 
	"desc" => "", 
	"docurl" => "function.sqlite-exec.html" 
),
"sqlite_factory" => array( 
	"methodname" => "sqlite_factory", 
	"version" => "PHP5", 
	"method" => "SQLiteDatabase sqlite_factory ( string filename [, int mode [, string &error_message]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Opens a SQLite database and returns a SQLiteDatabase object", 
	"docurl" => "function.sqlite-factory.html" 
),
"sqlite_fetch_all" => array( 
	"methodname" => "sqlite_fetch_all", 
	"version" => "PHP5", 
	"method" => "array sqlite_fetch_all ( resource result [, int result_type [, bool decode_binary]] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetches all rows from a result set as an array of arrays", 
	"docurl" => "function.sqlite-fetch-all.html" 
),
"sqlite_fetch_array" => array( 
	"methodname" => "sqlite_fetch_array", 
	"version" => "PHP5", 
	"method" => "array sqlite_fetch_array ( resource result [, int result_type [, bool decode_binary]] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetches the next row from a result set as an array", 
	"docurl" => "function.sqlite-fetch-array.html" 
),
"sqlite_fetch_column_types" => array( 
	"methodname" => "sqlite_fetch_column_types", 
	"version" => "PHP5", 
	"method" => "array sqlite_fetch_column_types ( string table_name, resource dbhandle [, int result_type] )", 
	"snippet" => "( \${1:\$table_name}, \${2:\$dbhandle} )", 
	"desc" => "Return an array of column types from a particular table", 
	"docurl" => "function.sqlite-fetch-column-types.html" 
),
"sqlite_fetch_object" => array( 
	"methodname" => "sqlite_fetch_object", 
	"version" => "PHP5", 
	"method" => "object sqlite_fetch_object ( resource result [, string class_name [, array ctor_params [, bool decode_binary]]] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetches the next row from a result set as an object", 
	"docurl" => "function.sqlite-fetch-object.html" 
),
"sqlite_fetch_single" => array( 
	"methodname" => "sqlite_fetch_single", 
	"version" => "PHP5", 
	"method" => "string sqlite_fetch_single ( resource result [, bool decode_binary] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetches the first column of a result set as a string", 
	"docurl" => "function.sqlite-fetch-single.html" 
),
"sqlite_fetch_string" => array( 
	"methodname" => "sqlite_fetch_string", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.sqlite-fetch-string.html" 
),
"sqlite_field_name" => array( 
	"methodname" => "sqlite_field_name", 
	"version" => "PHP5", 
	"method" => "string sqlite_field_name ( resource result, int field_index )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_index} )", 
	"desc" => "Returns the name of a particular field", 
	"docurl" => "function.sqlite-field-name.html" 
),
"sqlite_has_more" => array( 
	"methodname" => "sqlite_has_more", 
	"version" => "PHP5", 
	"method" => "bool sqlite_has_more ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Finds whether or not more rows are available", 
	"docurl" => "function.sqlite-has-more.html" 
),
"sqlite_has_prev" => array( 
	"methodname" => "sqlite_has_prev", 
	"version" => "PHP5", 
	"method" => "bool sqlite_has_prev ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns whether or not a previous row is available", 
	"docurl" => "function.sqlite-has-prev.html" 
),
"sqlite_key" => array( 
	"methodname" => "sqlite_key", 
	"version" => "undefined", 
	"method" => "int sqlite_key ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.sqlite-key.html" 
),
"sqlite_last_error" => array( 
	"methodname" => "sqlite_last_error", 
	"version" => "PHP5", 
	"method" => "int sqlite_last_error ( resource dbhandle )", 
	"snippet" => "( \${1:\$dbhandle} )", 
	"desc" => "Returns the error code of the last error for a database", 
	"docurl" => "function.sqlite-last-error.html" 
),
"sqlite_last_insert_rowid" => array( 
	"methodname" => "sqlite_last_insert_rowid", 
	"version" => "PHP5", 
	"method" => "int sqlite_last_insert_rowid ( resource dbhandle )", 
	"snippet" => "( \${1:\$dbhandle} )", 
	"desc" => "Returns the rowid of the most recently inserted row", 
	"docurl" => "function.sqlite-last-insert-rowid.html" 
),
"sqlite_libencoding" => array( 
	"methodname" => "sqlite_libencoding", 
	"version" => "PHP5", 
	"method" => "string sqlite_libencoding ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the encoding of the linked SQLite library", 
	"docurl" => "function.sqlite-libencoding.html" 
),
"sqlite_libversion" => array( 
	"methodname" => "sqlite_libversion", 
	"version" => "PHP5", 
	"method" => "string sqlite_libversion ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the version of the linked SQLite library", 
	"docurl" => "function.sqlite-libversion.html" 
),
"sqlite_next" => array( 
	"methodname" => "sqlite_next", 
	"version" => "PHP5", 
	"method" => "bool sqlite_next ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Seek to the next row number", 
	"docurl" => "function.sqlite-next.html" 
),
"sqlite_num_fields" => array( 
	"methodname" => "sqlite_num_fields", 
	"version" => "PHP5", 
	"method" => "int sqlite_num_fields ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns the number of fields in a result set", 
	"docurl" => "function.sqlite-num-fields.html" 
),
"sqlite_num_rows" => array( 
	"methodname" => "sqlite_num_rows", 
	"version" => "PHP5", 
	"method" => "int sqlite_num_rows ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns the number of rows in a buffered result set", 
	"docurl" => "function.sqlite-num-rows.html" 
),
"sqlite_open" => array( 
	"methodname" => "sqlite_open", 
	"version" => "PHP5", 
	"method" => "resource sqlite_open ( string filename [, int mode [, string &error_message]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Opens a SQLite database and create the database if it does not exist", 
	"docurl" => "function.sqlite-open.html" 
),
"sqlite_popen" => array( 
	"methodname" => "sqlite_popen", 
	"version" => "PHP5", 
	"method" => "resource sqlite_popen ( string filename [, int mode [, string &error_message]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Opens a persistent handle to an SQLite database and create the database if it does not exist", 
	"docurl" => "function.sqlite-popen.html" 
),
"sqlite_prev" => array( 
	"methodname" => "sqlite_prev", 
	"version" => "PHP5", 
	"method" => "bool sqlite_prev ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Seek to the previous row number of a result set", 
	"docurl" => "function.sqlite-prev.html" 
),
"sqlite_query" => array( 
	"methodname" => "sqlite_query", 
	"version" => "PHP5", 
	"method" => "resource sqlite_query ( resource dbhandle, string query )", 
	"snippet" => "( \${1:\$dbhandle}, \${2:\$query} )", 
	"desc" => "Executes a query against a given database and returns a result handle", 
	"docurl" => "function.sqlite-query.html" 
),
"sqlite_rewind" => array( 
	"methodname" => "sqlite_rewind", 
	"version" => "PHP5", 
	"method" => "bool sqlite_rewind ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Seek to the first row number", 
	"docurl" => "function.sqlite-rewind.html" 
),
"sqlite_seek" => array( 
	"methodname" => "sqlite_seek", 
	"version" => "PHP5", 
	"method" => "bool sqlite_seek ( resource result, int rownum )", 
	"snippet" => "( \${1:\$result}, \${2:\$rownum} )", 
	"desc" => "Seek to a particular row number of a buffered result set", 
	"docurl" => "function.sqlite-seek.html" 
),
"sqlite_single_query" => array( 
	"methodname" => "sqlite_single_query", 
	"version" => "PHP5", 
	"method" => "mixed sqlite_single_query ( resource db, string query [, bool first_row_only [, bool decode_binary]] )", 
	"snippet" => "( \${1:\$db}, \${2:\$query} )", 
	"desc" => "Executes a query and returns either an array for one single column or the value of the first row", 
	"docurl" => "function.sqlite-single-query.html" 
),
"sqlite_udf_decode_binary" => array( 
	"methodname" => "sqlite_udf_decode_binary", 
	"version" => "PHP5", 
	"method" => "string sqlite_udf_decode_binary ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Decode binary data passed as parameters to an UDF", 
	"docurl" => "function.sqlite-udf-decode-binary.html" 
),
"sqlite_udf_encode_binary" => array( 
	"methodname" => "sqlite_udf_encode_binary", 
	"version" => "PHP5", 
	"method" => "string sqlite_udf_encode_binary ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Encode binary data before returning it from an UDF", 
	"docurl" => "function.sqlite-udf-encode-binary.html" 
),
"sqlite_unbuffered_query" => array( 
	"methodname" => "sqlite_unbuffered_query", 
	"version" => "PHP5", 
	"method" => "resource sqlite_unbuffered_query ( resource dbhandle, string query )", 
	"snippet" => "( \${1:\$dbhandle}, \${2:\$query} )", 
	"desc" => "Execute a query that does not prefetch and buffer all data", 
	"docurl" => "function.sqlite-unbuffered-query.html" 
),
"sqlite_valid" => array( 
	"methodname" => "sqlite_valid", 
	"version" => "PHP5", 
	"method" => "bool sqlite_valid ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns whether more rows are available", 
	"docurl" => "function.sqlite-valid.html" 
),
"sqrt" => array( 
	"methodname" => "sqrt", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float sqrt ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Square root", 
	"docurl" => "function.sqrt.html" 
),
"srand" => array( 
	"methodname" => "srand", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void srand ( [int seed] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Seed the random number generator", 
	"docurl" => "function.srand.html" 
),
"sscanf" => array( 
	"methodname" => "sscanf", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "mixed sscanf ( string str, string format [, mixed &...] )", 
	"snippet" => "( \${1:\$str}, \${2:\$format} )", 
	"desc" => "Parses input from a string according to a format", 
	"docurl" => "function.sscanf.html" 
),
"ssh2_auth_hostbased_file" => array( 
	"methodname" => "ssh2_auth_hostbased_file", 
	"version" => "undefined", 
	"method" => "bool ssh2_auth_hostbased_file ( resource session, string username, string hostname, string pubkeyfile, string privkeyfile [, string passphrase [, string local_username]] )", 
	"snippet" => "( \${1:\$session}, \${2:\$username}, \${3:\$hostname}, \${4:\$pubkeyfile}, \${5:\$privkeyfile} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-auth-hostbased-file.html" 
),
"ssh2_auth_none" => array( 
	"methodname" => "ssh2_auth_none", 
	"version" => "undefined", 
	"method" => "array ssh2_auth_none ( resource session, string username )", 
	"snippet" => "( \${1:\$session}, \${2:\$username} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-auth-none.html" 
),
"ssh2_auth_password" => array( 
	"methodname" => "ssh2_auth_password", 
	"version" => "undefined", 
	"method" => "bool ssh2_auth_password ( resource session, string username, string password )", 
	"snippet" => "( \${1:\$session}, \${2:\$username}, \${3:\$password} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-auth-password.html" 
),
"ssh2_auth_pubkey_file" => array( 
	"methodname" => "ssh2_auth_pubkey_file", 
	"version" => "undefined", 
	"method" => "bool ssh2_auth_pubkey_file ( resource session, string username, string pubkeyfile, string privkeyfile [, string passphrase] )", 
	"snippet" => "( \${1:\$session}, \${2:\$username}, \${3:\$pubkeyfile}, \${4:\$privkeyfile} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-auth-pubkey-file.html" 
),
"ssh2_connect" => array( 
	"methodname" => "ssh2_connect", 
	"version" => "undefined", 
	"method" => "resource ssh2_connect ( string host [, int port [, array methods [, array callbacks]]] )", 
	"snippet" => "( \${1:\$host} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-connect.html" 
),
"ssh2_exec" => array( 
	"methodname" => "ssh2_exec", 
	"version" => "undefined", 
	"method" => "stream ssh2_exec ( resource session, string command [, array env] )", 
	"snippet" => "( \${1:\$session}, \${2:\$command} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-exec.html" 
),
"ssh2_fetch_stream" => array( 
	"methodname" => "ssh2_fetch_stream", 
	"version" => "undefined", 
	"method" => "stream ssh2_fetch_stream ( stream channel, int streamid )", 
	"snippet" => "( \${1:\$channel}, \${2:\$streamid} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-fetch-stream.html" 
),
"ssh2_fingerprint" => array( 
	"methodname" => "ssh2_fingerprint", 
	"version" => "undefined", 
	"method" => "string ssh2_fingerprint ( resource session [, int flags] )", 
	"snippet" => "( \${1:\$session} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-fingerprint.html" 
),
"ssh2_methods_negotiated" => array( 
	"methodname" => "ssh2_methods_negotiated", 
	"version" => "undefined", 
	"method" => "array ssh2_methods_negotiated ( resource session )", 
	"snippet" => "( \${1:\$session} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-methods-negotiated.html" 
),
"ssh2_scp_recv" => array( 
	"methodname" => "ssh2_scp_recv", 
	"version" => "undefined", 
	"method" => "bool ssh2_scp_recv ( resource session, string remote_file, string local_file )", 
	"snippet" => "( \${1:\$session}, \${2:\$remote_file}, \${3:\$local_file} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-scp-recv.html" 
),
"ssh2_scp_send" => array( 
	"methodname" => "ssh2_scp_send", 
	"version" => "undefined", 
	"method" => "stream ssh2_scp_send ( resource session, string local_file, string remote_file [, int create_mode] )", 
	"snippet" => "( \${1:\$session}, \${2:\$local_file}, \${3:\$remote_file} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-scp-send.html" 
),
"ssh2_sftp_lstat" => array( 
	"methodname" => "ssh2_sftp_lstat", 
	"version" => "undefined", 
	"method" => "array ssh2_sftp_lstat ( resource sftp, string path )", 
	"snippet" => "( \${1:\$sftp}, \${2:\$path} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-sftp-lstat.html" 
),
"ssh2_sftp_mkdir" => array( 
	"methodname" => "ssh2_sftp_mkdir", 
	"version" => "undefined", 
	"method" => "bool ssh2_sftp_mkdir ( resource sftp, string dirname [, int mode [, bool recursive]] )", 
	"snippet" => "( \${1:\$sftp}, \${2:\$dirname} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-sftp-mkdir.html" 
),
"ssh2_sftp_readlink" => array( 
	"methodname" => "ssh2_sftp_readlink", 
	"version" => "undefined", 
	"method" => "string ssh2_sftp_readlink ( resource sftp, string link )", 
	"snippet" => "( \${1:\$sftp}, \${2:\$link} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-sftp-readlink.html" 
),
"ssh2_sftp_realpath" => array( 
	"methodname" => "ssh2_sftp_realpath", 
	"version" => "undefined", 
	"method" => "string ssh2_sftp_realpath ( resource sftp, string filename )", 
	"snippet" => "( \${1:\$sftp}, \${2:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-sftp-realpath.html" 
),
"ssh2_sftp_rename" => array( 
	"methodname" => "ssh2_sftp_rename", 
	"version" => "undefined", 
	"method" => "bool ssh2_sftp_rename ( resource sftp, string from, string to )", 
	"snippet" => "( \${1:\$sftp}, \${2:\$from}, \${3:\$to} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-sftp-rename.html" 
),
"ssh2_sftp_rmdir" => array( 
	"methodname" => "ssh2_sftp_rmdir", 
	"version" => "undefined", 
	"method" => "bool ssh2_sftp_rmdir ( resource sftp, string dirname )", 
	"snippet" => "( \${1:\$sftp}, \${2:\$dirname} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-sftp-rmdir.html" 
),
"ssh2_sftp_stat" => array( 
	"methodname" => "ssh2_sftp_stat", 
	"version" => "undefined", 
	"method" => "array ssh2_sftp_stat ( resource sftp, string path )", 
	"snippet" => "( \${1:\$sftp}, \${2:\$path} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-sftp-stat.html" 
),
"ssh2_sftp_symlink" => array( 
	"methodname" => "ssh2_sftp_symlink", 
	"version" => "undefined", 
	"method" => "bool ssh2_sftp_symlink ( resource sftp, string target, string link )", 
	"snippet" => "( \${1:\$sftp}, \${2:\$target}, \${3:\$link} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-sftp-symlink.html" 
),
"ssh2_sftp_unlink" => array( 
	"methodname" => "ssh2_sftp_unlink", 
	"version" => "undefined", 
	"method" => "bool ssh2_sftp_unlink ( resource sftp, string filename )", 
	"snippet" => "( \${1:\$sftp}, \${2:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-sftp-unlink.html" 
),
"ssh2_sftp" => array( 
	"methodname" => "ssh2_sftp", 
	"version" => "undefined", 
	"method" => "resource ssh2_sftp ( resource session )", 
	"snippet" => "( \${1:\$session} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-sftp.html" 
),
"ssh2_shell" => array( 
	"methodname" => "ssh2_shell", 
	"version" => "undefined", 
	"method" => "stream ssh2_shell ( resource session [, string term_type [, array env [, int width [, int height [, int width_height_type]]]]] )", 
	"snippet" => "( \${1:\$session} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-shell.html" 
),
"ssh2_tunnel" => array( 
	"methodname" => "ssh2_tunnel", 
	"version" => "undefined", 
	"method" => "stream ssh2_tunnel ( resource session, string host, int port )", 
	"snippet" => "( \${1:\$session}, \${2:\$host}, \${3:\$port} )", 
	"desc" => "", 
	"docurl" => "function.ssh2-tunnel.html" 
),
"stat" => array( 
	"methodname" => "stat", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array stat ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gives information about a file", 
	"docurl" => "function.stat.html" 
),
"str_ireplace" => array( 
	"methodname" => "str_ireplace", 
	"version" => "PHP5", 
	"method" => "mixed str_ireplace ( mixed search, mixed replace, mixed subject [, int &count] )", 
	"snippet" => "( \${1:\$search}, \${2:\$replace}, \${3:\$subject} )", 
	"desc" => "Case-insensitive version of str_replace().", 
	"docurl" => "function.str-ireplace.html" 
),
"str_pad" => array( 
	"methodname" => "str_pad", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "string str_pad ( string input, int pad_length [, string pad_string [, int pad_type]] )", 
	"snippet" => "( \${1:\$input}, \${2:\$pad_length} )", 
	"desc" => "Pad a string to a certain length with another string", 
	"docurl" => "function.str-pad.html" 
),
"str_repeat" => array( 
	"methodname" => "str_repeat", 
	"version" => "PHP4, PHP5", 
	"method" => "string str_repeat ( string input, int multiplier )", 
	"snippet" => "( \${1:\$input}, \${2:\$multiplier} )", 
	"desc" => "Repeat a string", 
	"docurl" => "function.str-repeat.html" 
),
"str_replace" => array( 
	"methodname" => "str_replace", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "mixed str_replace ( mixed search, mixed replace, mixed subject [, int &count] )", 
	"snippet" => "( \${1:\$search}, \${2:\$replace}, \${3:\$subject} )", 
	"desc" => "Replace all occurrences of the search string with the replacement string", 
	"docurl" => "function.str-replace.html" 
),
"str_rot13" => array( 
	"methodname" => "str_rot13", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string str_rot13 ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Perform the rot13 transform on a string", 
	"docurl" => "function.str-rot13.html" 
),
"str_shuffle" => array( 
	"methodname" => "str_shuffle", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string str_shuffle ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Randomly shuffles a string", 
	"docurl" => "function.str-shuffle.html" 
),
"str_split" => array( 
	"methodname" => "str_split", 
	"version" => "PHP5", 
	"method" => "array str_split ( string string [, int split_length] )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Convert a string to an array", 
	"docurl" => "function.str-split.html" 
),
"str_word_count" => array( 
	"methodname" => "str_word_count", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "mixed str_word_count ( string string [, int format [, string charlist]] )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Return information about words used in a string", 
	"docurl" => "function.str-word-count.html" 
),
"strcasecmp" => array( 
	"methodname" => "strcasecmp", 
	"version" => "PHP3>= 3.0.2, PHP4, PHP5", 
	"method" => "int strcasecmp ( string str1, string str2 )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2} )", 
	"desc" => "Binary safe case-insensitive string comparison", 
	"docurl" => "function.strcasecmp.html" 
),
"strchr" => array( 
	"methodname" => "strchr", 
	"version" => "(PHP3, PHP4, PHP5)", 
	"method" => "string strchr ( string haystack, string needle )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of strstr()\nFind first occurrence of a string", 
	"docurl" => "function.strchr.html" 
),
"strcmp" => array( 
	"methodname" => "strcmp", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int strcmp ( string str1, string str2 )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2} )", 
	"desc" => "Binary safe string comparison", 
	"docurl" => "function.strcmp.html" 
),
"strcoll" => array( 
	"methodname" => "strcoll", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int strcoll ( string str1, string str2 )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2} )", 
	"desc" => "Locale based string comparison", 
	"docurl" => "function.strcoll.html" 
),
"strcspn" => array( 
	"methodname" => "strcspn", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int strcspn ( string str1, string str2 [, int start [, int length]] )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2} )", 
	"desc" => "Find length of initial segment not matching mask", 
	"docurl" => "function.strcspn.html" 
),
"stream_context_create" => array( 
	"methodname" => "stream_context_create", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource stream_context_create ( [array options] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Create a streams context", 
	"docurl" => "function.stream-context-create.html" 
),
"stream_context_get_default" => array( 
	"methodname" => "stream_context_get_default", 
	"version" => "undefined", 
	"method" => "resource stream_context_get_default ( [array options] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.stream-context-get-default.html" 
),
"stream_context_get_options" => array( 
	"methodname" => "stream_context_get_options", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array stream_context_get_options ( resource stream_or_context )", 
	"snippet" => "( \${1:\$stream_or_context} )", 
	"desc" => "Retrieve options for a stream/wrapper/context", 
	"docurl" => "function.stream-context-get-options.html" 
),
"stream_context_set_option" => array( 
	"methodname" => "stream_context_set_option", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool stream_context_set_option ( resource stream_or_context, string wrapper, string option, mixed value )", 
	"snippet" => "( \${1:\$stream_or_context}, \${2:\$wrapper}, \${3:\$option}, \${4:\$value} )", 
	"desc" => "Sets an option for a stream/wrapper/context", 
	"docurl" => "function.stream-context-set-option.html" 
),
"stream_context_set_params" => array( 
	"methodname" => "stream_context_set_params", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool stream_context_set_params ( resource stream_or_context, array params )", 
	"snippet" => "( \${1:\$stream_or_context}, \${2:\$params} )", 
	"desc" => "Set parameters for a stream/wrapper/context", 
	"docurl" => "function.stream-context-set-params.html" 
),
"stream_copy_to_stream" => array( 
	"methodname" => "stream_copy_to_stream", 
	"version" => "PHP5", 
	"method" => "int stream_copy_to_stream ( resource source, resource dest [, int maxlength] )", 
	"snippet" => "( \${1:\$source}, \${2:\$dest} )", 
	"desc" => "Copies data from one stream to another", 
	"docurl" => "function.stream-copy-to-stream.html" 
),
"stream_filter_append" => array( 
	"methodname" => "stream_filter_append", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource stream_filter_append ( resource stream, string filtername [, int read_write [, mixed params]] )", 
	"snippet" => "( \${1:\$stream}, \${2:\$filtername} )", 
	"desc" => "Attach a filter to a stream", 
	"docurl" => "function.stream-filter-append.html" 
),
"stream_filter_prepend" => array( 
	"methodname" => "stream_filter_prepend", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource stream_filter_prepend ( resource stream, string filtername [, int read_write [, mixed params]] )", 
	"snippet" => "( \${1:\$stream}, \${2:\$filtername} )", 
	"desc" => "Attach a filter to a stream", 
	"docurl" => "function.stream-filter-prepend.html" 
),
"stream_filter_register" => array( 
	"methodname" => "stream_filter_register", 
	"version" => "PHP5", 
	"method" => "bool stream_filter_register ( string filtername, string classname )", 
	"snippet" => "( \${1:\$filtername}, \${2:\$classname} )", 
	"desc" => "Register a stream filter implemented as a PHP class    derived from php_user_filter", 
	"docurl" => "function.stream-filter-register.html" 
),
"stream_filter_remove" => array( 
	"methodname" => "stream_filter_remove", 
	"version" => "undefined", 
	"method" => "bool stream_filter_remove ( resource stream_filter )", 
	"snippet" => "( \${1:\$stream_filter} )", 
	"desc" => "", 
	"docurl" => "function.stream-filter-remove.html" 
),
"stream_get_contents" => array( 
	"methodname" => "stream_get_contents", 
	"version" => "PHP5", 
	"method" => "string stream_get_contents ( resource handle [, int maxlength [, int offset]] )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Reads remainder of a stream into a string", 
	"docurl" => "function.stream-get-contents.html" 
),
"stream_get_filters" => array( 
	"methodname" => "stream_get_filters", 
	"version" => "PHP5", 
	"method" => "array stream_get_filters ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Retrieve list of registered filters", 
	"docurl" => "function.stream-get-filters.html" 
),
"stream_get_line" => array( 
	"methodname" => "stream_get_line", 
	"version" => "PHP5", 
	"method" => "string stream_get_line ( resource handle, int length [, string ending] )", 
	"snippet" => "( \${1:\$handle}, \${2:\$length} )", 
	"desc" => "Gets line from stream resource up to a given delimiter", 
	"docurl" => "function.stream-get-line.html" 
),
"stream_get_meta_data" => array( 
	"methodname" => "stream_get_meta_data", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array stream_get_meta_data ( resource stream )", 
	"snippet" => "( \${1:\$stream} )", 
	"desc" => "Retrieves header/meta data from streams/file pointers", 
	"docurl" => "function.stream-get-meta-data.html" 
),
"stream_get_transports" => array( 
	"methodname" => "stream_get_transports", 
	"version" => "PHP5", 
	"method" => "array stream_get_transports ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Retrieve list of registered socket transports", 
	"docurl" => "function.stream-get-transports.html" 
),
"stream_get_wrappers" => array( 
	"methodname" => "stream_get_wrappers", 
	"version" => "PHP5", 
	"method" => "array stream_get_wrappers ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Retrieve list of registered streams", 
	"docurl" => "function.stream-get-wrappers.html" 
),
"stream_register_wrapper" => array( 
	"methodname" => "stream_register_wrapper", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.stream-register-wrapper.html" 
),
"stream_select" => array( 
	"methodname" => "stream_select", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int stream_select ( array &read, array &write, array &except, int tv_sec [, int tv_usec] )", 
	"snippet" => "( \${1:\$read}, \${2:\$write}, \${3:\$except}, \${4:\$tv_sec} )", 
	"desc" => "Runs the equivalent of the select() system call on the given    arrays of streams with a timeout specified by tv_sec and tv_usec", 
	"docurl" => "function.stream-select.html" 
),
"stream_set_blocking" => array( 
	"methodname" => "stream_set_blocking", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool stream_set_blocking ( resource stream, int mode )", 
	"snippet" => "( \${1:\$stream}, \${2:\$mode} )", 
	"desc" => "Set blocking/non-blocking mode on a stream", 
	"docurl" => "function.stream-set-blocking.html" 
),
"stream_set_timeout" => array( 
	"methodname" => "stream_set_timeout", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool stream_set_timeout ( resource stream, int seconds [, int microseconds] )", 
	"snippet" => "( \${1:\$stream}, \${2:\$seconds} )", 
	"desc" => "Set timeout period on a stream", 
	"docurl" => "function.stream-set-timeout.html" 
),
"stream_set_write_buffer" => array( 
	"methodname" => "stream_set_write_buffer", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int stream_set_write_buffer ( resource stream, int buffer )", 
	"snippet" => "( \${1:\$stream}, \${2:\$buffer} )", 
	"desc" => "Sets file buffering on the given stream", 
	"docurl" => "function.stream-set-write-buffer.html" 
),
"stream_socket_accept" => array( 
	"methodname" => "stream_socket_accept", 
	"version" => "PHP5", 
	"method" => "resource stream_socket_accept ( resource server_socket [, float timeout [, string &peername]] )", 
	"snippet" => "( \${1:\$server_socket} )", 
	"desc" => "Accept a connection on a socket created by stream_socket_server()", 
	"docurl" => "function.stream-socket-accept.html" 
),
"stream_socket_client" => array( 
	"methodname" => "stream_socket_client", 
	"version" => "PHP5", 
	"method" => "resource stream_socket_client ( string remote_socket [, int &errno [, string &errstr [, float timeout [, int flags [, resource context]]]]] )", 
	"snippet" => "( \${1:\$remote_socket} )", 
	"desc" => "Open Internet or Unix domain socket connection", 
	"docurl" => "function.stream-socket-client.html" 
),
"stream_socket_enable_crypto" => array( 
	"methodname" => "stream_socket_enable_crypto", 
	"version" => "undefined", 
	"method" => "mixed stream_socket_enable_crypto ( resource stream, bool enable [, int crypto_type [, resource session_stream]] )", 
	"snippet" => "( \${1:\$stream}, \${2:\$enable} )", 
	"desc" => "", 
	"docurl" => "function.stream-socket-enable-crypto.html" 
),
"stream_socket_get_name" => array( 
	"methodname" => "stream_socket_get_name", 
	"version" => "PHP5", 
	"method" => "string stream_socket_get_name ( resource handle, bool want_peer )", 
	"snippet" => "( \${1:\$handle}, \${2:\$want_peer} )", 
	"desc" => "Retrieve the name of the local or remote sockets", 
	"docurl" => "function.stream-socket-get-name.html" 
),
"stream_socket_pair" => array( 
	"methodname" => "stream_socket_pair", 
	"version" => "undefined", 
	"method" => "array stream_socket_pair ( int domain, int type, int protocol )", 
	"snippet" => "( \${1:\$domain}, \${2:\$type}, \${3:\$protocol} )", 
	"desc" => "", 
	"docurl" => "function.stream-socket-pair.html" 
),
"stream_socket_recvfrom" => array( 
	"methodname" => "stream_socket_recvfrom", 
	"version" => "PHP5", 
	"method" => "string stream_socket_recvfrom ( resource socket, int length [, int flags [, string &address]] )", 
	"snippet" => "( \${1:\$socket}, \${2:\$length} )", 
	"desc" => "Receives data from a socket, connected or not", 
	"docurl" => "function.stream-socket-recvfrom.html" 
),
"stream_socket_sendto" => array( 
	"methodname" => "stream_socket_sendto", 
	"version" => "PHP5", 
	"method" => "int stream_socket_sendto ( resource socket, string data [, int flags [, string address]] )", 
	"snippet" => "( \${1:\$socket}, \${2:\$data} )", 
	"desc" => "Sends a message to a socket, whether it is connected or not", 
	"docurl" => "function.stream-socket-sendto.html" 
),
"stream_socket_server" => array( 
	"methodname" => "stream_socket_server", 
	"version" => "PHP5", 
	"method" => "resource stream_socket_server ( string local_socket [, int &errno [, string &errstr [, int flags [, resource context]]]] )", 
	"snippet" => "( \${1:\$local_socket} )", 
	"desc" => "Create an Internet or Unix domain server socket", 
	"docurl" => "function.stream-socket-server.html" 
),
"stream_wrapper_register" => array( 
	"methodname" => "stream_wrapper_register", 
	"version" => "PHP4 >= 4.3.2, PHP5", 
	"method" => "bool stream_wrapper_register ( string protocol, string classname )", 
	"snippet" => "( \${1:\$protocol}, \${2:\$classname} )", 
	"desc" => "Register a URL wrapper implemented as a PHP class", 
	"docurl" => "function.stream-wrapper-register.html" 
),
"stream_wrapper_restore" => array( 
	"methodname" => "stream_wrapper_restore", 
	"version" => "undefined", 
	"method" => "bool stream_wrapper_restore ( string protocol )", 
	"snippet" => "( \${1:\$protocol} )", 
	"desc" => "", 
	"docurl" => "function.stream-wrapper-restore.html" 
),
"stream_wrapper_unregister" => array( 
	"methodname" => "stream_wrapper_unregister", 
	"version" => "undefined", 
	"method" => "bool stream_wrapper_unregister ( string protocol )", 
	"snippet" => "( \${1:\$protocol} )", 
	"desc" => "", 
	"docurl" => "function.stream-wrapper-unregister.html" 
),
"strftime" => array( 
	"methodname" => "strftime", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string strftime ( string format [, int timestamp] )", 
	"snippet" => "( \${1:\$format} )", 
	"desc" => "Format a local time/date according to locale settings", 
	"docurl" => "function.strftime.html" 
),
"strip_tags" => array( 
	"methodname" => "strip_tags", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "string strip_tags ( string str [, string allowable_tags] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Strip HTML and PHP tags from a string", 
	"docurl" => "function.strip-tags.html" 
),
"stripcslashes" => array( 
	"methodname" => "stripcslashes", 
	"version" => "PHP4, PHP5", 
	"method" => "string stripcslashes ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Un-quote string quoted with addcslashes()", 
	"docurl" => "function.stripcslashes.html" 
),
"stripos" => array( 
	"methodname" => "stripos", 
	"version" => "PHP5", 
	"method" => "int stripos ( string haystack, string needle [, int offset] )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Find position of first occurrence of a case-insensitive string", 
	"docurl" => "function.stripos.html" 
),
"stripslashes" => array( 
	"methodname" => "stripslashes", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string stripslashes ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Un-quote string quoted with addslashes()", 
	"docurl" => "function.stripslashes.html" 
),
"stristr" => array( 
	"methodname" => "stristr", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string stristr ( string haystack, string needle )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Case-insensitive strstr()", 
	"docurl" => "function.stristr.html" 
),
"strlen" => array( 
	"methodname" => "strlen", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int strlen ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Get string length", 
	"docurl" => "function.strlen.html" 
),
"strnatcasecmp" => array( 
	"methodname" => "strnatcasecmp", 
	"version" => "PHP4, PHP5", 
	"method" => "int strnatcasecmp ( string str1, string str2 )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2} )", 
	"desc" => "Case insensitive string comparisons using a \"natural order\"   algorithm", 
	"docurl" => "function.strnatcasecmp.html" 
),
"strnatcmp" => array( 
	"methodname" => "strnatcmp", 
	"version" => "PHP4, PHP5", 
	"method" => "int strnatcmp ( string str1, string str2 )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2} )", 
	"desc" => "String comparisons using a \"natural order\" algorithm", 
	"docurl" => "function.strnatcmp.html" 
),
"strncasecmp" => array( 
	"methodname" => "strncasecmp", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int strncasecmp ( string str1, string str2, int len )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2}, \${3:\$len} )", 
	"desc" => "Binary safe case-insensitive string comparison of the first n   characters", 
	"docurl" => "function.strncasecmp.html" 
),
"strncmp" => array( 
	"methodname" => "strncmp", 
	"version" => "PHP4, PHP5", 
	"method" => "int strncmp ( string str1, string str2, int len )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2}, \${3:\$len} )", 
	"desc" => "Binary safe string comparison of the first n characters", 
	"docurl" => "function.strncmp.html" 
),
"strpbrk" => array( 
	"methodname" => "strpbrk", 
	"version" => "PHP5", 
	"method" => "string strpbrk ( string haystack, string char_list )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$char_list} )", 
	"desc" => "Search a string for any of a set of characters", 
	"docurl" => "function.strpbrk.html" 
),
"strpos" => array( 
	"methodname" => "strpos", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int strpos ( string haystack, mixed needle [, int offset] )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Find position of first occurrence of a string", 
	"docurl" => "function.strpos.html" 
),
"strptime" => array( 
	"methodname" => "strptime", 
	"version" => "undefined", 
	"method" => "array strptime ( string timestamp, string format )", 
	"snippet" => "( \${1:\$timestamp}, \${2:\$format} )", 
	"desc" => "", 
	"docurl" => "function.strptime.html" 
),
"strrchr" => array( 
	"methodname" => "strrchr", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string strrchr ( string haystack, string needle )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Find the last occurrence of a character in a string", 
	"docurl" => "function.strrchr.html" 
),
"strrev" => array( 
	"methodname" => "strrev", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string strrev ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Reverse a string", 
	"docurl" => "function.strrev.html" 
),
"strripos" => array( 
	"methodname" => "strripos", 
	"version" => "PHP5", 
	"method" => "int strripos ( string haystack, string needle [, int offset] )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Find position of last occurrence of a case-insensitive string in a string", 
	"docurl" => "function.strripos.html" 
),
"strrpos" => array( 
	"methodname" => "strrpos", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int strrpos ( string haystack, string needle [, int offset] )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Find position of last occurrence of a char in a string", 
	"docurl" => "function.strrpos.html" 
),
"strspn" => array( 
	"methodname" => "strspn", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int strspn ( string str1, string str2 [, int start [, int length]] )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2} )", 
	"desc" => "Find length of initial segment matching mask", 
	"docurl" => "function.strspn.html" 
),
"strstr" => array( 
	"methodname" => "strstr", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string strstr ( string haystack, string needle )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Find first occurrence of a string", 
	"docurl" => "function.strstr.html" 
),
"strtok" => array( 
	"methodname" => "strtok", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string strtok ( string str, string token )", 
	"snippet" => "( \${1:\$str}, \${2:\$token} )", 
	"desc" => "Tokenize string", 
	"docurl" => "function.strtok.html" 
),
"strtolower" => array( 
	"methodname" => "strtolower", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string strtolower ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Make a string lowercase", 
	"docurl" => "function.strtolower.html" 
),
"strtotime" => array( 
	"methodname" => "strtotime", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "int strtotime ( string time [, int now] )", 
	"snippet" => "( \${1:\$time} )", 
	"desc" => "Parse about any English textual datetime description into a Unix   timestamp", 
	"docurl" => "function.strtotime.html" 
),
"strtoupper" => array( 
	"methodname" => "strtoupper", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string strtoupper ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Make a string uppercase", 
	"docurl" => "function.strtoupper.html" 
),
"strtr" => array( 
	"methodname" => "strtr", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string strtr ( string str, string from, string to )", 
	"snippet" => "( \${1:\$str}, \${2:\$from}, \${3:\$to} )", 
	"desc" => "Translate certain characters", 
	"docurl" => "function.strtr.html" 
),
"strval" => array( 
	"methodname" => "strval", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string strval ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Get string value of a variable", 
	"docurl" => "function.strval.html" 
),
"substr_compare" => array( 
	"methodname" => "substr_compare", 
	"version" => "PHP5", 
	"method" => "int substr_compare ( string main_str, string str, int offset [, int length [, bool case_insensitivity]] )", 
	"snippet" => "( \${1:\$main_str}, \${2:\$str}, \${3:\$offset} )", 
	"desc" => "Binary safe optionally case insensitive comparison of 2 strings from an offset, up to length characters", 
	"docurl" => "function.substr-compare.html" 
),
"substr_count" => array( 
	"methodname" => "substr_count", 
	"version" => "PHP4, PHP5", 
	"method" => "int substr_count ( string haystack, string needle )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Count the number of substring occurrences", 
	"docurl" => "function.substr-count.html" 
),
"substr_replace" => array( 
	"methodname" => "substr_replace", 
	"version" => "PHP4, PHP5", 
	"method" => "string substr_replace ( string string, string replacement, int start [, int length] )", 
	"snippet" => "( \${1:\$string}, \${2:\$replacement}, \${3:\$start} )", 
	"desc" => "Replace text within a portion of a string", 
	"docurl" => "function.substr-replace.html" 
),
"substr" => array( 
	"methodname" => "substr", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string substr ( string string, int start [, int length] )", 
	"snippet" => "( \${1:\$string}, \${2:\$start} )", 
	"desc" => "Return part of a string", 
	"docurl" => "function.substr.html" 
),
"swf_actiongeturl" => array( 
	"methodname" => "swf_actiongeturl", 
	"version" => "PHP4", 
	"method" => "void swf_actiongeturl ( string url, string target )", 
	"snippet" => "( \${1:\$url}, \${2:\$target} )", 
	"desc" => "Get a URL from a Shockwave Flash movie", 
	"docurl" => "function.swf-actiongeturl.html" 
),
"swf_actiongotoframe" => array( 
	"methodname" => "swf_actiongotoframe", 
	"version" => "PHP4", 
	"method" => "void swf_actiongotoframe ( int framenumber )", 
	"snippet" => "( \${1:\$framenumber} )", 
	"desc" => "Play a frame and then stop", 
	"docurl" => "function.swf-actiongotoframe.html" 
),
"swf_actiongotolabel" => array( 
	"methodname" => "swf_actiongotolabel", 
	"version" => "PHP4", 
	"method" => "void swf_actiongotolabel ( string label )", 
	"snippet" => "( \${1:\$label} )", 
	"desc" => "Display a frame with the specified label", 
	"docurl" => "function.swf-actiongotolabel.html" 
),
"swf_actionnextframe" => array( 
	"methodname" => "swf_actionnextframe", 
	"version" => "PHP4", 
	"method" => "void swf_actionnextframe ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Go forward one frame", 
	"docurl" => "function.swf-actionnextframe.html" 
),
"swf_actionplay" => array( 
	"methodname" => "swf_actionplay", 
	"version" => "PHP4", 
	"method" => "void swf_actionplay ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Start playing the flash movie from the current frame", 
	"docurl" => "function.swf-actionplay.html" 
),
"swf_actionprevframe" => array( 
	"methodname" => "swf_actionprevframe", 
	"version" => "PHP4", 
	"method" => "void swf_actionprevframe ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Go backwards one frame", 
	"docurl" => "function.swf-actionprevframe.html" 
),
"swf_actionsettarget" => array( 
	"methodname" => "swf_actionsettarget", 
	"version" => "PHP4", 
	"method" => "void swf_actionsettarget ( string target )", 
	"snippet" => "( \${1:\$target} )", 
	"desc" => "Set the context for actions", 
	"docurl" => "function.swf-actionsettarget.html" 
),
"swf_actionstop" => array( 
	"methodname" => "swf_actionstop", 
	"version" => "PHP4", 
	"method" => "void swf_actionstop ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Stop playing the flash movie at the current frame", 
	"docurl" => "function.swf-actionstop.html" 
),
"swf_actiontogglequality" => array( 
	"methodname" => "swf_actiontogglequality", 
	"version" => "PHP4", 
	"method" => "void swf_actiontogglequality ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Toggle between low and high quality", 
	"docurl" => "function.swf-actiontogglequality.html" 
),
"swf_actionwaitforframe" => array( 
	"methodname" => "swf_actionwaitforframe", 
	"version" => "PHP4", 
	"method" => "void swf_actionwaitforframe ( int framenumber, int skipcount )", 
	"snippet" => "( \${1:\$framenumber}, \${2:\$skipcount} )", 
	"desc" => "Skip actions if a frame has not been loaded", 
	"docurl" => "function.swf-actionwaitforframe.html" 
),
"swf_addbuttonrecord" => array( 
	"methodname" => "swf_addbuttonrecord", 
	"version" => "PHP4", 
	"method" => "void swf_addbuttonrecord ( int states, int shapeid, int depth )", 
	"snippet" => "( \${1:\$states}, \${2:\$shapeid}, \${3:\$depth} )", 
	"desc" => "Controls location, appearance and active area of the current button", 
	"docurl" => "function.swf-addbuttonrecord.html" 
),
"swf_addcolor" => array( 
	"methodname" => "swf_addcolor", 
	"version" => "PHP4", 
	"method" => "void swf_addcolor ( float r, float g, float b, float a )", 
	"snippet" => "( \${1:\$r}, \${2:\$g}, \${3:\$b}, \${4:\$a} )", 
	"desc" => "Set the global add color to the rgba value specified", 
	"docurl" => "function.swf-addcolor.html" 
),
"swf_closefile" => array( 
	"methodname" => "swf_closefile", 
	"version" => "PHP4", 
	"method" => "void swf_closefile ( [int return_file] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Close the current Shockwave Flash file", 
	"docurl" => "function.swf-closefile.html" 
),
"swf_definebitmap" => array( 
	"methodname" => "swf_definebitmap", 
	"version" => "PHP4", 
	"method" => "void swf_definebitmap ( int objid, string image_name )", 
	"snippet" => "( \${1:\$objid}, \${2:\$image_name} )", 
	"desc" => "Define a bitmap", 
	"docurl" => "function.swf-definebitmap.html" 
),
"swf_definefont" => array( 
	"methodname" => "swf_definefont", 
	"version" => "PHP4", 
	"method" => "void swf_definefont ( int fontid, string fontname )", 
	"snippet" => "( \${1:\$fontid}, \${2:\$fontname} )", 
	"desc" => "Defines a font", 
	"docurl" => "function.swf-definefont.html" 
),
"swf_defineline" => array( 
	"methodname" => "swf_defineline", 
	"version" => "PHP4", 
	"method" => "void swf_defineline ( int objid, float x1, float y1, float x2, float y2, float width )", 
	"snippet" => "( \${1:\$objid}, \${2:\$x1}, \${3:\$y1}, \${4:\$x2}, \${5:\$y2}, \${6:\$width} )", 
	"desc" => "Define a line", 
	"docurl" => "function.swf-defineline.html" 
),
"swf_definepoly" => array( 
	"methodname" => "swf_definepoly", 
	"version" => "PHP4", 
	"method" => "void swf_definepoly ( int objid, array coords, int npoints, float width )", 
	"snippet" => "( \${1:\$objid}, \${2:\$coords}, \${3:\$npoints}, \${4:\$width} )", 
	"desc" => "Define a polygon", 
	"docurl" => "function.swf-definepoly.html" 
),
"swf_definerect" => array( 
	"methodname" => "swf_definerect", 
	"version" => "PHP4", 
	"method" => "void swf_definerect ( int objid, float x1, float y1, float x2, float y2, float width )", 
	"snippet" => "( \${1:\$objid}, \${2:\$x1}, \${3:\$y1}, \${4:\$x2}, \${5:\$y2}, \${6:\$width} )", 
	"desc" => "Define a rectangle", 
	"docurl" => "function.swf-definerect.html" 
),
"swf_definetext" => array( 
	"methodname" => "swf_definetext", 
	"version" => "PHP4", 
	"method" => "void swf_definetext ( int objid, string str, int docenter )", 
	"snippet" => "( \${1:\$objid}, \${2:\$str}, \${3:\$docenter} )", 
	"desc" => "Define a text string", 
	"docurl" => "function.swf-definetext.html" 
),
"swf_endbutton" => array( 
	"methodname" => "swf_endbutton", 
	"version" => "PHP4", 
	"method" => "void swf_endbutton ( void  )", 
	"snippet" => "(  )", 
	"desc" => "End the definition of the current button", 
	"docurl" => "function.swf-endbutton.html" 
),
"swf_enddoaction" => array( 
	"methodname" => "swf_enddoaction", 
	"version" => "PHP4", 
	"method" => "void swf_enddoaction ( void  )", 
	"snippet" => "(  )", 
	"desc" => "End the current action", 
	"docurl" => "function.swf-enddoaction.html" 
),
"swf_endshape" => array( 
	"methodname" => "swf_endshape", 
	"version" => "PHP4", 
	"method" => "void swf_endshape ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Completes the definition of the current shape", 
	"docurl" => "function.swf-endshape.html" 
),
"swf_endsymbol" => array( 
	"methodname" => "swf_endsymbol", 
	"version" => "PHP4", 
	"method" => "void swf_endsymbol ( void  )", 
	"snippet" => "(  )", 
	"desc" => "End the definition of a symbol", 
	"docurl" => "function.swf-endsymbol.html" 
),
"swf_fontsize" => array( 
	"methodname" => "swf_fontsize", 
	"version" => "PHP4", 
	"method" => "void swf_fontsize ( float size )", 
	"snippet" => "( \${1:\$size} )", 
	"desc" => "Change the font size", 
	"docurl" => "function.swf-fontsize.html" 
),
"swf_fontslant" => array( 
	"methodname" => "swf_fontslant", 
	"version" => "PHP4", 
	"method" => "void swf_fontslant ( float slant )", 
	"snippet" => "( \${1:\$slant} )", 
	"desc" => "Set the font slant", 
	"docurl" => "function.swf-fontslant.html" 
),
"swf_fonttracking" => array( 
	"methodname" => "swf_fonttracking", 
	"version" => "PHP4", 
	"method" => "void swf_fonttracking ( float tracking )", 
	"snippet" => "( \${1:\$tracking} )", 
	"desc" => "Set the current font tracking", 
	"docurl" => "function.swf-fonttracking.html" 
),
"swf_getbitmapinfo" => array( 
	"methodname" => "swf_getbitmapinfo", 
	"version" => "PHP4", 
	"method" => "array swf_getbitmapinfo ( int bitmapid )", 
	"snippet" => "( \${1:\$bitmapid} )", 
	"desc" => "Get information about a bitmap", 
	"docurl" => "function.swf-getbitmapinfo.html" 
),
"swf_getfontinfo" => array( 
	"methodname" => "swf_getfontinfo", 
	"version" => "PHP4", 
	"method" => "array swf_getfontinfo ( void  )", 
	"snippet" => "(  )", 
	"desc" => "The height in pixels of a capital A and a lowercase x", 
	"docurl" => "function.swf-getfontinfo.html" 
),
"swf_getframe" => array( 
	"methodname" => "swf_getframe", 
	"version" => "PHP4", 
	"method" => "int swf_getframe ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get the frame number of the current frame", 
	"docurl" => "function.swf-getframe.html" 
),
"swf_labelframe" => array( 
	"methodname" => "swf_labelframe", 
	"version" => "PHP4", 
	"method" => "void swf_labelframe ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Label the current frame", 
	"docurl" => "function.swf-labelframe.html" 
),
"swf_lookat" => array( 
	"methodname" => "swf_lookat", 
	"version" => "PHP4", 
	"method" => "void swf_lookat ( float view_x, float view_y, float view_z, float reference_x, float reference_y, float reference_z, float twist )", 
	"snippet" => "( \${1:\$view_x}, \${2:\$view_y}, \${3:\$view_z}, \${4:\$reference_x}, \${5:\$reference_y}, \${6:\$reference_z}, \${7:\$twist} )", 
	"desc" => "Define a viewing transformation", 
	"docurl" => "function.swf-lookat.html" 
),
"swf_modifyobject" => array( 
	"methodname" => "swf_modifyobject", 
	"version" => "PHP4", 
	"method" => "void swf_modifyobject ( int depth, int how )", 
	"snippet" => "( \${1:\$depth}, \${2:\$how} )", 
	"desc" => "Modify an object", 
	"docurl" => "function.swf-modifyobject.html" 
),
"swf_mulcolor" => array( 
	"methodname" => "swf_mulcolor", 
	"version" => "PHP4", 
	"method" => "void swf_mulcolor ( float r, float g, float b, float a )", 
	"snippet" => "( \${1:\$r}, \${2:\$g}, \${3:\$b}, \${4:\$a} )", 
	"desc" => "Sets the global multiply color to the rgba value specified", 
	"docurl" => "function.swf-mulcolor.html" 
),
"swf_nextid" => array( 
	"methodname" => "swf_nextid", 
	"version" => "PHP4", 
	"method" => "int swf_nextid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the next free object id", 
	"docurl" => "function.swf-nextid.html" 
),
"swf_oncondition" => array( 
	"methodname" => "swf_oncondition", 
	"version" => "PHP4", 
	"method" => "void swf_oncondition ( int transition )", 
	"snippet" => "( \${1:\$transition} )", 
	"desc" => "Describe a transition used to trigger an action list", 
	"docurl" => "function.swf-oncondition.html" 
),
"swf_openfile" => array( 
	"methodname" => "swf_openfile", 
	"version" => "PHP4", 
	"method" => "void swf_openfile ( string filename, float width, float height, float framerate, float r, float g, float b )", 
	"snippet" => "( \${1:\$filename}, \${2:\$width}, \${3:\$height}, \${4:\$framerate}, \${5:\$r}, \${6:\$g}, \${7:\$b} )", 
	"desc" => "Open a new Shockwave Flash file", 
	"docurl" => "function.swf-openfile.html" 
),
"swf_ortho" => array( 
	"methodname" => "swf_ortho", 
	"version" => "PHP4 >= 4.0.1", 
	"method" => "void swf_ortho ( float xmin, float xmax, float ymin, float ymax, float zmin, float zmax )", 
	"snippet" => "( \${1:\$xmin}, \${2:\$xmax}, \${3:\$ymin}, \${4:\$ymax}, \${5:\$zmin}, \${6:\$zmax} )", 
	"desc" => "Defines an orthographic mapping of user coordinates onto the   current viewport", 
	"docurl" => "function.swf-ortho.html" 
),
"swf_ortho2" => array( 
	"methodname" => "swf_ortho2", 
	"version" => "PHP4", 
	"method" => "void swf_ortho2 ( float xmin, float xmax, float ymin, float ymax )", 
	"snippet" => "( \${1:\$xmin}, \${2:\$xmax}, \${3:\$ymin}, \${4:\$ymax} )", 
	"desc" => "Defines 2D orthographic mapping of user coordinates onto the   current viewport", 
	"docurl" => "function.swf-ortho2.html" 
),
"swf_perspective" => array( 
	"methodname" => "swf_perspective", 
	"version" => "PHP4", 
	"method" => "void swf_perspective ( float fovy, float aspect, float near, float far )", 
	"snippet" => "( \${1:\$fovy}, \${2:\$aspect}, \${3:\$near}, \${4:\$far} )", 
	"desc" => "Define a perspective projection transformation", 
	"docurl" => "function.swf-perspective.html" 
),
"swf_placeobject" => array( 
	"methodname" => "swf_placeobject", 
	"version" => "PHP4", 
	"method" => "void swf_placeobject ( int objid, int depth )", 
	"snippet" => "( \${1:\$objid}, \${2:\$depth} )", 
	"desc" => "Place an object onto the screen", 
	"docurl" => "function.swf-placeobject.html" 
),
"swf_polarview" => array( 
	"methodname" => "swf_polarview", 
	"version" => "PHP4", 
	"method" => "void swf_polarview ( float dist, float azimuth, float incidence, float twist )", 
	"snippet" => "( \${1:\$dist}, \${2:\$azimuth}, \${3:\$incidence}, \${4:\$twist} )", 
	"desc" => "Define the viewer\'s position with polar coordinates", 
	"docurl" => "function.swf-polarview.html" 
),
"swf_popmatrix" => array( 
	"methodname" => "swf_popmatrix", 
	"version" => "PHP4", 
	"method" => "void swf_popmatrix ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Restore a previous transformation matrix", 
	"docurl" => "function.swf-popmatrix.html" 
),
"swf_posround" => array( 
	"methodname" => "swf_posround", 
	"version" => "PHP4", 
	"method" => "void swf_posround ( int round )", 
	"snippet" => "( \${1:\$round} )", 
	"desc" => "Enables or Disables the rounding of the translation when objects   are placed or moved", 
	"docurl" => "function.swf-posround.html" 
),
"swf_pushmatrix" => array( 
	"methodname" => "swf_pushmatrix", 
	"version" => "PHP4", 
	"method" => "void swf_pushmatrix ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Push the current transformation matrix back unto the stack", 
	"docurl" => "function.swf-pushmatrix.html" 
),
"swf_removeobject" => array( 
	"methodname" => "swf_removeobject", 
	"version" => "PHP4", 
	"method" => "void swf_removeobject ( int depth )", 
	"snippet" => "( \${1:\$depth} )", 
	"desc" => "Remove an object", 
	"docurl" => "function.swf-removeobject.html" 
),
"swf_rotate" => array( 
	"methodname" => "swf_rotate", 
	"version" => "PHP4", 
	"method" => "void swf_rotate ( float angle, string axis )", 
	"snippet" => "( \${1:\$angle}, \${2:\$axis} )", 
	"desc" => "Rotate the current transformation", 
	"docurl" => "function.swf-rotate.html" 
),
"swf_scale" => array( 
	"methodname" => "swf_scale", 
	"version" => "PHP4", 
	"method" => "void swf_scale ( float x, float y, float z )", 
	"snippet" => "( \${1:\$x}, \${2:\$y}, \${3:\$z} )", 
	"desc" => "Scale the current transformation", 
	"docurl" => "function.swf-scale.html" 
),
"swf_setfont" => array( 
	"methodname" => "swf_setfont", 
	"version" => "PHP4", 
	"method" => "void swf_setfont ( int fontid )", 
	"snippet" => "( \${1:\$fontid} )", 
	"desc" => "Change the current font", 
	"docurl" => "function.swf-setfont.html" 
),
"swf_setframe" => array( 
	"methodname" => "swf_setframe", 
	"version" => "PHP4", 
	"method" => "void swf_setframe ( int framenumber )", 
	"snippet" => "( \${1:\$framenumber} )", 
	"desc" => "Switch to a specified frame", 
	"docurl" => "function.swf-setframe.html" 
),
"swf_shapearc" => array( 
	"methodname" => "swf_shapearc", 
	"version" => "PHP4", 
	"method" => "void swf_shapearc ( float x, float y, float r, float ang1, float ang2 )", 
	"snippet" => "( \${1:\$x}, \${2:\$y}, \${3:\$r}, \${4:\$ang1}, \${5:\$ang2} )", 
	"desc" => "Draw a circular arc", 
	"docurl" => "function.swf-shapearc.html" 
),
"swf_shapecurveto" => array( 
	"methodname" => "swf_shapecurveto", 
	"version" => "PHP4", 
	"method" => "void swf_shapecurveto ( float x1, float y1, float x2, float y2 )", 
	"snippet" => "( \${1:\$x1}, \${2:\$y1}, \${3:\$x2}, \${4:\$y2} )", 
	"desc" => "Draw a quadratic bezier curve between two points", 
	"docurl" => "function.swf-shapecurveto.html" 
),
"swf_shapecurveto3" => array( 
	"methodname" => "swf_shapecurveto3", 
	"version" => "PHP4", 
	"method" => "void swf_shapecurveto3 ( float x1, float y1, float x2, float y2, float x3, float y3 )", 
	"snippet" => "( \${1:\$x1}, \${2:\$y1}, \${3:\$x2}, \${4:\$y2}, \${5:\$x3}, \${6:\$y3} )", 
	"desc" => "Draw a cubic bezier curve", 
	"docurl" => "function.swf-shapecurveto3.html" 
),
"swf_shapefillbitmapclip" => array( 
	"methodname" => "swf_shapefillbitmapclip", 
	"version" => "PHP4", 
	"method" => "void swf_shapefillbitmapclip ( int bitmapid )", 
	"snippet" => "( \${1:\$bitmapid} )", 
	"desc" => "Set current fill mode to clipped bitmap", 
	"docurl" => "function.swf-shapefillbitmapclip.html" 
),
"swf_shapefillbitmaptile" => array( 
	"methodname" => "swf_shapefillbitmaptile", 
	"version" => "PHP4", 
	"method" => "void swf_shapefillbitmaptile ( int bitmapid )", 
	"snippet" => "( \${1:\$bitmapid} )", 
	"desc" => "Set current fill mode to tiled bitmap", 
	"docurl" => "function.swf-shapefillbitmaptile.html" 
),
"swf_shapefilloff" => array( 
	"methodname" => "swf_shapefilloff", 
	"version" => "PHP4", 
	"method" => "void swf_shapefilloff ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Turns off filling", 
	"docurl" => "function.swf-shapefilloff.html" 
),
"swf_shapefillsolid" => array( 
	"methodname" => "swf_shapefillsolid", 
	"version" => "PHP4", 
	"method" => "void swf_shapefillsolid ( float r, float g, float b, float a )", 
	"snippet" => "( \${1:\$r}, \${2:\$g}, \${3:\$b}, \${4:\$a} )", 
	"desc" => "Set the current fill style to the specified color", 
	"docurl" => "function.swf-shapefillsolid.html" 
),
"swf_shapelinesolid" => array( 
	"methodname" => "swf_shapelinesolid", 
	"version" => "PHP4", 
	"method" => "void swf_shapelinesolid ( float r, float g, float b, float a, float width )", 
	"snippet" => "( \${1:\$r}, \${2:\$g}, \${3:\$b}, \${4:\$a}, \${5:\$width} )", 
	"desc" => "Set the current line style", 
	"docurl" => "function.swf-shapelinesolid.html" 
),
"swf_shapelineto" => array( 
	"methodname" => "swf_shapelineto", 
	"version" => "PHP4", 
	"method" => "void swf_shapelineto ( float x, float y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "Draw a line", 
	"docurl" => "function.swf-shapelineto.html" 
),
"swf_shapemoveto" => array( 
	"methodname" => "swf_shapemoveto", 
	"version" => "PHP4", 
	"method" => "void swf_shapemoveto ( float x, float y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "Move the current position", 
	"docurl" => "function.swf-shapemoveto.html" 
),
"swf_showframe" => array( 
	"methodname" => "swf_showframe", 
	"version" => "PHP4", 
	"method" => "void swf_showframe ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Display the current frame", 
	"docurl" => "function.swf-showframe.html" 
),
"swf_startbutton" => array( 
	"methodname" => "swf_startbutton", 
	"version" => "PHP4", 
	"method" => "void swf_startbutton ( int objid, int type )", 
	"snippet" => "( \${1:\$objid}, \${2:\$type} )", 
	"desc" => "Start the definition of a button", 
	"docurl" => "function.swf-startbutton.html" 
),
"swf_startdoaction" => array( 
	"methodname" => "swf_startdoaction", 
	"version" => "PHP4", 
	"method" => "void swf_startdoaction ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Start a description of an action list for the current frame", 
	"docurl" => "function.swf-startdoaction.html" 
),
"swf_startshape" => array( 
	"methodname" => "swf_startshape", 
	"version" => "PHP4", 
	"method" => "void swf_startshape ( int objid )", 
	"snippet" => "( \${1:\$objid} )", 
	"desc" => "Start a complex shape", 
	"docurl" => "function.swf-startshape.html" 
),
"swf_startsymbol" => array( 
	"methodname" => "swf_startsymbol", 
	"version" => "PHP4", 
	"method" => "void swf_startsymbol ( int objid )", 
	"snippet" => "( \${1:\$objid} )", 
	"desc" => "Define a symbol", 
	"docurl" => "function.swf-startsymbol.html" 
),
"swf_textwidth" => array( 
	"methodname" => "swf_textwidth", 
	"version" => "PHP4", 
	"method" => "float swf_textwidth ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Get the width of a string", 
	"docurl" => "function.swf-textwidth.html" 
),
"swf_translate" => array( 
	"methodname" => "swf_translate", 
	"version" => "PHP4", 
	"method" => "void swf_translate ( float x, float y, float z )", 
	"snippet" => "( \${1:\$x}, \${2:\$y}, \${3:\$z} )", 
	"desc" => "Translate the current transformations", 
	"docurl" => "function.swf-translate.html" 
),
"swf_viewport" => array( 
	"methodname" => "swf_viewport", 
	"version" => "PHP4", 
	"method" => "void swf_viewport ( float xmin, float xmax, float ymin, float ymax )", 
	"snippet" => "( \${1:\$xmin}, \${2:\$xmax}, \${3:\$ymin}, \${4:\$ymax} )", 
	"desc" => "Select an area for future drawing", 
	"docurl" => "function.swf-viewport.html" 
),
"swfaction" => array( 
	"methodname" => "swfaction", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFAction swfaction ( string script )", 
	"snippet" => "( \${1:\$script} )", 
	"desc" => "Creates a new Action", 
	"docurl" => "function.swfaction.html" 
),
"swfbitmap" => array( 
	"methodname" => "swfbitmap", 
	"version" => "undefined", 
	"method" => "int swfbitmap-&#62;getheight ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.swfbitmap.html" 
),
"swfbitmap" => array( 
	"methodname" => "swfbitmap", 
	"version" => "undefined", 
	"method" => "int swfbitmap-&#62;getwidth ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.swfbitmap.html" 
),
"swfbitmap" => array( 
	"methodname" => "swfbitmap", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFBitmap swfbitmap ( mixed file [, mixed alphafile] )", 
	"snippet" => "( \${1:\$file} )", 
	"desc" => "Loads Bitmap object", 
	"docurl" => "function.swfbitmap.html" 
),
"swfbutton_keypress" => array( 
	"methodname" => "swfbutton_keypress", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "int swfbutton_keypress ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Returns the action flag for keyPress(char)", 
	"docurl" => "function.swfbutton-keypress.html" 
),
"swfbutton" => array( 
	"methodname" => "swfbutton", 
	"version" => "undefined", 
	"method" => "void swfbutton-&#62;addaction ( resource action, int flags )", 
	"snippet" => "( \${1:\$action}, \${2:\$flags} )", 
	"desc" => "", 
	"docurl" => "function.swfbutton.html" 
),
"swfbutton" => array( 
	"methodname" => "swfbutton", 
	"version" => "undefined", 
	"method" => "void swfbutton-&#62;addshape ( resource shape, int flags )", 
	"snippet" => "( \${1:\$shape}, \${2:\$flags} )", 
	"desc" => "", 
	"docurl" => "function.swfbutton.html" 
),
"swfbutton" => array( 
	"methodname" => "swfbutton", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFButton swfbutton ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Creates a new Button", 
	"docurl" => "function.swfbutton.html" 
),
"swfbutton" => array( 
	"methodname" => "swfbutton", 
	"version" => "undefined", 
	"method" => "void swfbutton-&#62;setaction ( resource action )", 
	"snippet" => "( \${1:\$action} )", 
	"desc" => "", 
	"docurl" => "function.swfbutton.html" 
),
"swfbutton" => array( 
	"methodname" => "swfbutton", 
	"version" => "undefined", 
	"method" => "void swfbutton-&#62;setdown ( resource shape )", 
	"snippet" => "( \${1:\$shape} )", 
	"desc" => "", 
	"docurl" => "function.swfbutton.html" 
),
"swfbutton" => array( 
	"methodname" => "swfbutton", 
	"version" => "undefined", 
	"method" => "void swfbutton-&#62;sethit ( resource shape )", 
	"snippet" => "( \${1:\$shape} )", 
	"desc" => "", 
	"docurl" => "function.swfbutton.html" 
),
"swfbutton" => array( 
	"methodname" => "swfbutton", 
	"version" => "undefined", 
	"method" => "void swfbutton-&#62;setover ( resource shape )", 
	"snippet" => "( \${1:\$shape} )", 
	"desc" => "", 
	"docurl" => "function.swfbutton.html" 
),
"swfbutton" => array( 
	"methodname" => "swfbutton", 
	"version" => "undefined", 
	"method" => "void swfbutton-&#62;setup ( resource shape )", 
	"snippet" => "( \${1:\$shape} )", 
	"desc" => "", 
	"docurl" => "function.swfbutton.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;addcolor ( [int red [, int green [, int blue [, int a]]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "SWFDisplayItem swfdisplayitem ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;move ( int dx, int dy )", 
	"snippet" => "( \${1:\$dx}, \${2:\$dy} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;moveto ( int x, int y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;multcolor ( [int red [, int green [, int blue [, int a]]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;remove ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;rotate ( float ddegrees )", 
	"snippet" => "( \${1:\$ddegrees} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;rotateto ( float degrees )", 
	"snippet" => "( \${1:\$degrees} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;scale ( int dx, int dy )", 
	"snippet" => "( \${1:\$dx}, \${2:\$dy} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;scaleto ( int x, int y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;setdepth ( float depth )", 
	"snippet" => "( \${1:\$depth} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;setname ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;setratio ( float ratio )", 
	"snippet" => "( \${1:\$ratio} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;skewx ( float ddegrees )", 
	"snippet" => "( \${1:\$ddegrees} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;skewxto ( float degrees )", 
	"snippet" => "( \${1:\$degrees} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;skewy ( float ddegrees )", 
	"snippet" => "( \${1:\$ddegrees} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swfdisplayitem" => array( 
	"methodname" => "swfdisplayitem", 
	"version" => "undefined", 
	"method" => "void swfdisplayitem-&#62;skewyto ( float degrees )", 
	"snippet" => "( \${1:\$degrees} )", 
	"desc" => "", 
	"docurl" => "function.swfdisplayitem.html" 
),
"swffill" => array( 
	"methodname" => "swffill", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFFill swffill ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Loads SWFFill object", 
	"docurl" => "function.swffill.html" 
),
"swffill" => array( 
	"methodname" => "swffill", 
	"version" => "undefined", 
	"method" => "void swffill-&#62;moveto ( int x, int y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "", 
	"docurl" => "function.swffill.html" 
),
"swffill" => array( 
	"methodname" => "swffill", 
	"version" => "undefined", 
	"method" => "void swffill-&#62;rotateto ( float degrees )", 
	"snippet" => "( \${1:\$degrees} )", 
	"desc" => "", 
	"docurl" => "function.swffill.html" 
),
"swffill" => array( 
	"methodname" => "swffill", 
	"version" => "undefined", 
	"method" => "void swffill-&#62;scaleto ( int x, int y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "", 
	"docurl" => "function.swffill.html" 
),
"swffill" => array( 
	"methodname" => "swffill", 
	"version" => "undefined", 
	"method" => "void swffill-&#62;skewxto ( float x )", 
	"snippet" => "( \${1:\$x} )", 
	"desc" => "", 
	"docurl" => "function.swffill.html" 
),
"swffill" => array( 
	"methodname" => "swffill", 
	"version" => "undefined", 
	"method" => "void swffill-&#62;skewyto ( float y )", 
	"snippet" => "( \${1:\$y} )", 
	"desc" => "", 
	"docurl" => "function.swffill.html" 
),
"swffont" => array( 
	"methodname" => "swffont", 
	"version" => "undefined", 
	"method" => "int swffont-&#62;getwidth ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "", 
	"docurl" => "function.swffont.html" 
),
"swffont" => array( 
	"methodname" => "swffont", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFFont swffont ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Loads a font definition", 
	"docurl" => "function.swffont.html" 
),
"swfgradient" => array( 
	"methodname" => "swfgradient", 
	"version" => "undefined", 
	"method" => "void swfgradient-&#62;addentry ( float ratio, int red, int green, int blue [, int a] )", 
	"snippet" => "( \${1:\$ratio}, \${2:\$red}, \${3:\$green}, \${4:\$blue} )", 
	"desc" => "", 
	"docurl" => "function.swfgradient.html" 
),
"swfgradient" => array( 
	"methodname" => "swfgradient", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFGradient swfgradient ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Creates a gradient object", 
	"docurl" => "function.swfgradient.html" 
),
"swfmorph" => array( 
	"methodname" => "swfmorph", 
	"version" => "undefined", 
	"method" => "mixed swfmorph-&#62;getshape1 ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.swfmorph.html" 
),
"swfmorph" => array( 
	"methodname" => "swfmorph", 
	"version" => "undefined", 
	"method" => "mixed swfmorph-&#62;getshape2 ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.swfmorph.html" 
),
"swfmorph" => array( 
	"methodname" => "swfmorph", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFMorph swfmorph ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Creates a new SWFMorph object", 
	"docurl" => "function.swfmorph.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "undefined", 
	"method" => "void swfmovie-&#62;add ( resource instance )", 
	"snippet" => "( \${1:\$instance} )", 
	"desc" => "", 
	"docurl" => "function.swfmovie.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFMovie swfmovie ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Creates a new movie object, representing an SWF version 4 movie", 
	"docurl" => "function.swfmovie.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "undefined", 
	"method" => "void swfmovie-&#62;nextframe ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.swfmovie.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "undefined", 
	"method" => "int swfmovie-&#62;output ( [int compression] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.swfmovie.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "undefined", 
	"method" => "void swfmovie-&#62;remove ( resource instance )", 
	"snippet" => "( \${1:\$instance} )", 
	"desc" => "", 
	"docurl" => "function.swfmovie.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "undefined", 
	"method" => "int swfmovie-&#62;save ( string filename [, int compression] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.swfmovie.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "undefined", 
	"method" => "void swfmovie-&#62;setbackground ( int red, int green, int blue )", 
	"snippet" => "( \${1:\$red}, \${2:\$green}, \${3:\$blue} )", 
	"desc" => "", 
	"docurl" => "function.swfmovie.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "undefined", 
	"method" => "void swfmovie-&#62;setdimension ( int width, int height )", 
	"snippet" => "( \${1:\$width}, \${2:\$height} )", 
	"desc" => "", 
	"docurl" => "function.swfmovie.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "undefined", 
	"method" => "void swfmovie-&#62;setframes ( string numberofframes )", 
	"snippet" => "( \${1:\$numberofframes} )", 
	"desc" => "", 
	"docurl" => "function.swfmovie.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "undefined", 
	"method" => "void swfmovie-&#62;setrate ( int rate )", 
	"snippet" => "( \${1:\$rate} )", 
	"desc" => "", 
	"docurl" => "function.swfmovie.html" 
),
"swfmovie" => array( 
	"methodname" => "swfmovie", 
	"version" => "undefined", 
	"method" => "void swfmovie-&#62;streammp3 ( mixed mp3File )", 
	"snippet" => "( \${1:\$mp3File} )", 
	"desc" => "", 
	"docurl" => "function.swfmovie.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "undefined", 
	"method" => "SWFFill SWFShape-&#62;addFill ( int red, int green, int blue [, int a] )", 
	"snippet" => "( \${1:\$red}, \${2:\$green}, \${3:\$blue} )", 
	"desc" => "", 
	"docurl" => "function.swfshape.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "undefined", 
	"method" => "void swfshape-&#62;drawcurve ( int controldx, int controldy, int anchordx, int anchordy )", 
	"snippet" => "( \${1:\$controldx}, \${2:\$controldy}, \${3:\$anchordx}, \${4:\$anchordy} )", 
	"desc" => "", 
	"docurl" => "function.swfshape.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "undefined", 
	"method" => "void swfshape-&#62;drawcurveto ( int controlx, int controly, int anchorx, int anchory )", 
	"snippet" => "( \${1:\$controlx}, \${2:\$controly}, \${3:\$anchorx}, \${4:\$anchory} )", 
	"desc" => "", 
	"docurl" => "function.swfshape.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "undefined", 
	"method" => "void swfshape-&#62;drawline ( int dx, int dy )", 
	"snippet" => "( \${1:\$dx}, \${2:\$dy} )", 
	"desc" => "", 
	"docurl" => "function.swfshape.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "undefined", 
	"method" => "void swfshape-&#62;drawlineto ( int x, int y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "", 
	"docurl" => "function.swfshape.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFShape swfshape ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Creates a new shape object", 
	"docurl" => "function.swfshape.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "undefined", 
	"method" => "void swfshape-&#62;movepen ( int dx, int dy )", 
	"snippet" => "( \${1:\$dx}, \${2:\$dy} )", 
	"desc" => "", 
	"docurl" => "function.swfshape.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "undefined", 
	"method" => "void swfshape-&#62;movepento ( int x, int y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "", 
	"docurl" => "function.swfshape.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "undefined", 
	"method" => "void swfshape-&#62;setleftfill ( swfgradient fill )", 
	"snippet" => "( \${1:\$fill} )", 
	"desc" => "", 
	"docurl" => "function.swfshape.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "undefined", 
	"method" => "void swfshape-&#62;setline ( int width [, int red [, int green [, int blue [, int a]]]] )", 
	"snippet" => "( \${1:\$width} )", 
	"desc" => "", 
	"docurl" => "function.swfshape.html" 
),
"swfshape" => array( 
	"methodname" => "swfshape", 
	"version" => "undefined", 
	"method" => "void swfshape-&#62;setrightfill ( swfgradient fill )", 
	"snippet" => "( \${1:\$fill} )", 
	"desc" => "", 
	"docurl" => "function.swfshape.html" 
),
"swfsprite" => array( 
	"methodname" => "swfsprite", 
	"version" => "undefined", 
	"method" => "void swfsprite-&#62;add ( resource object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "", 
	"docurl" => "function.swfsprite.html" 
),
"swfsprite" => array( 
	"methodname" => "swfsprite", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFSprite swfsprite ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Creates a movie clip (a sprite)", 
	"docurl" => "function.swfsprite.html" 
),
"swfsprite" => array( 
	"methodname" => "swfsprite", 
	"version" => "undefined", 
	"method" => "void swfsprite-&#62;nextframe ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.swfsprite.html" 
),
"swfsprite" => array( 
	"methodname" => "swfsprite", 
	"version" => "undefined", 
	"method" => "void swfsprite-&#62;remove ( resource object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "", 
	"docurl" => "function.swfsprite.html" 
),
"swfsprite" => array( 
	"methodname" => "swfsprite", 
	"version" => "undefined", 
	"method" => "void swfsprite-&#62;setframes ( int numberofframes )", 
	"snippet" => "( \${1:\$numberofframes} )", 
	"desc" => "", 
	"docurl" => "function.swfsprite.html" 
),
"swftext" => array( 
	"methodname" => "swftext", 
	"version" => "undefined", 
	"method" => "void swftext-&#62;addstring ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "", 
	"docurl" => "function.swftext.html" 
),
"swftext" => array( 
	"methodname" => "swftext", 
	"version" => "undefined", 
	"method" => "void swftext-&#62;getwidth ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "", 
	"docurl" => "function.swftext.html" 
),
"swftext" => array( 
	"methodname" => "swftext", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFText swftext ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Creates a new SWFText object", 
	"docurl" => "function.swftext.html" 
),
"swftext" => array( 
	"methodname" => "swftext", 
	"version" => "undefined", 
	"method" => "void swftext-&#62;moveto ( int x, int y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "", 
	"docurl" => "function.swftext.html" 
),
"swftext" => array( 
	"methodname" => "swftext", 
	"version" => "undefined", 
	"method" => "void swftext-&#62;setcolor ( int red, int green, int blue [, int a] )", 
	"snippet" => "( \${1:\$red}, \${2:\$green}, \${3:\$blue} )", 
	"desc" => "", 
	"docurl" => "function.swftext.html" 
),
"swftext" => array( 
	"methodname" => "swftext", 
	"version" => "undefined", 
	"method" => "void swftext-&#62;setfont ( string font )", 
	"snippet" => "( \${1:\$font} )", 
	"desc" => "", 
	"docurl" => "function.swftext.html" 
),
"swftext" => array( 
	"methodname" => "swftext", 
	"version" => "undefined", 
	"method" => "void swftext-&#62;setheight ( int height )", 
	"snippet" => "( \${1:\$height} )", 
	"desc" => "", 
	"docurl" => "function.swftext.html" 
),
"swftext" => array( 
	"methodname" => "swftext", 
	"version" => "undefined", 
	"method" => "void swftext-&#62;setspacing ( float spacing )", 
	"snippet" => "( \${1:\$spacing} )", 
	"desc" => "", 
	"docurl" => "function.swftext.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;addstring ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;align ( int alignement )", 
	"snippet" => "( \${1:\$alignement} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "SWFTextField swftextfield ( [int flags] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Creates a text field object", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;setbounds ( int width, int height )", 
	"snippet" => "( \${1:\$width}, \${2:\$height} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;setcolor ( int red, int green, int blue [, int a] )", 
	"snippet" => "( \${1:\$red}, \${2:\$green}, \${3:\$blue} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;setfont ( string font )", 
	"snippet" => "( \${1:\$font} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;setheight ( int height )", 
	"snippet" => "( \${1:\$height} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;setindentation ( int width )", 
	"snippet" => "( \${1:\$width} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;setleftmargin ( int width )", 
	"snippet" => "( \${1:\$width} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;setlinespacing ( int height )", 
	"snippet" => "( \${1:\$height} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;setmargins ( int left, int right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;setname ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"swftextfield" => array( 
	"methodname" => "swftextfield", 
	"version" => "undefined", 
	"method" => "void swftextfield-&#62;setrightmargin ( int width )", 
	"snippet" => "( \${1:\$width} )", 
	"desc" => "", 
	"docurl" => "function.swftextfield.html" 
),
"sybase_affected_rows" => array( 
	"methodname" => "sybase_affected_rows", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int sybase_affected_rows ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Gets number of affected rows in last query", 
	"docurl" => "function.sybase-affected-rows.html" 
),
"sybase_close" => array( 
	"methodname" => "sybase_close", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool sybase_close ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Closes a Sybase connection", 
	"docurl" => "function.sybase-close.html" 
),
"sybase_connect" => array( 
	"methodname" => "sybase_connect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource sybase_connect ( [string servername [, string username [, string password [, string charset [, string appname]]]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Opens a Sybase server connection", 
	"docurl" => "function.sybase-connect.html" 
),
"sybase_data_seek" => array( 
	"methodname" => "sybase_data_seek", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool sybase_data_seek ( resource result_identifier, int row_number )", 
	"snippet" => "( \${1:\$result_identifier}, \${2:\$row_number} )", 
	"desc" => "Moves internal row pointer", 
	"docurl" => "function.sybase-data-seek.html" 
),
"sybase_deadlock_retry_count" => array( 
	"methodname" => "sybase_deadlock_retry_count", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "void sybase_deadlock_retry_count ( int retry_count )", 
	"snippet" => "( \${1:\$retry_count} )", 
	"desc" => "Sets the deadlock retry count", 
	"docurl" => "function.sybase-deadlock-retry-count.html" 
),
"sybase_fetch_array" => array( 
	"methodname" => "sybase_fetch_array", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array sybase_fetch_array ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch row as array", 
	"docurl" => "function.sybase-fetch-array.html" 
),
"sybase_fetch_assoc" => array( 
	"methodname" => "sybase_fetch_assoc", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array sybase_fetch_assoc ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an associative array", 
	"docurl" => "function.sybase-fetch-assoc.html" 
),
"sybase_fetch_field" => array( 
	"methodname" => "sybase_fetch_field", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object sybase_fetch_field ( resource result [, int field_offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get field information from a result", 
	"docurl" => "function.sybase-fetch-field.html" 
),
"sybase_fetch_object" => array( 
	"methodname" => "sybase_fetch_object", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object sybase_fetch_object ( resource result [, mixed object] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a row as an object", 
	"docurl" => "function.sybase-fetch-object.html" 
),
"sybase_fetch_row" => array( 
	"methodname" => "sybase_fetch_row", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array sybase_fetch_row ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get a result row as an enumerated array", 
	"docurl" => "function.sybase-fetch-row.html" 
),
"sybase_field_seek" => array( 
	"methodname" => "sybase_field_seek", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool sybase_field_seek ( resource result, int field_offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_offset} )", 
	"desc" => "Sets field offset", 
	"docurl" => "function.sybase-field-seek.html" 
),
"sybase_free_result" => array( 
	"methodname" => "sybase_free_result", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool sybase_free_result ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Frees result memory", 
	"docurl" => "function.sybase-free-result.html" 
),
"sybase_get_last_message" => array( 
	"methodname" => "sybase_get_last_message", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string sybase_get_last_message ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the last message from the server", 
	"docurl" => "function.sybase-get-last-message.html" 
),
"sybase_min_client_severity" => array( 
	"methodname" => "sybase_min_client_severity", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void sybase_min_client_severity ( int severity )", 
	"snippet" => "( \${1:\$severity} )", 
	"desc" => "Sets minimum client severity", 
	"docurl" => "function.sybase-min-client-severity.html" 
),
"sybase_min_error_severity" => array( 
	"methodname" => "sybase_min_error_severity", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void sybase_min_error_severity ( int severity )", 
	"snippet" => "( \${1:\$severity} )", 
	"desc" => "Sets minimum error severity", 
	"docurl" => "function.sybase-min-error-severity.html" 
),
"sybase_min_message_severity" => array( 
	"methodname" => "sybase_min_message_severity", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void sybase_min_message_severity ( int severity )", 
	"snippet" => "( \${1:\$severity} )", 
	"desc" => "Sets minimum message severity", 
	"docurl" => "function.sybase-min-message-severity.html" 
),
"sybase_min_server_severity" => array( 
	"methodname" => "sybase_min_server_severity", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void sybase_min_server_severity ( int severity )", 
	"snippet" => "( \${1:\$severity} )", 
	"desc" => "Sets minimum server severity", 
	"docurl" => "function.sybase-min-server-severity.html" 
),
"sybase_num_fields" => array( 
	"methodname" => "sybase_num_fields", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int sybase_num_fields ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Gets the number of fields in a result set", 
	"docurl" => "function.sybase-num-fields.html" 
),
"sybase_num_rows" => array( 
	"methodname" => "sybase_num_rows", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int sybase_num_rows ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get number of rows in a result set", 
	"docurl" => "function.sybase-num-rows.html" 
),
"sybase_pconnect" => array( 
	"methodname" => "sybase_pconnect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource sybase_pconnect ( [string servername [, string username [, string password [, string charset [, string appname]]]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open persistent Sybase connection", 
	"docurl" => "function.sybase-pconnect.html" 
),
"sybase_query" => array( 
	"methodname" => "sybase_query", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource sybase_query ( string query [, resource link_identifier] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Sends a Sybase query", 
	"docurl" => "function.sybase-query.html" 
),
"sybase_result" => array( 
	"methodname" => "sybase_result", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string sybase_result ( resource result, int row, mixed field )", 
	"snippet" => "( \${1:\$result}, \${2:\$row}, \${3:\$field} )", 
	"desc" => "Get result data", 
	"docurl" => "function.sybase-result.html" 
),
"sybase_select_db" => array( 
	"methodname" => "sybase_select_db", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool sybase_select_db ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Selects a Sybase database", 
	"docurl" => "function.sybase-select-db.html" 
),
"sybase_set_message_handler" => array( 
	"methodname" => "sybase_set_message_handler", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool sybase_set_message_handler ( callback handler [, resource connection] )", 
	"snippet" => "( \${1:\$handler} )", 
	"desc" => "Sets the handler called when a server message is raised", 
	"docurl" => "function.sybase-set-message-handler.html" 
),
"sybase_unbuffered_query" => array( 
	"methodname" => "sybase_unbuffered_query", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource sybase_unbuffered_query ( string query, resource link_identifier [, bool store_result] )", 
	"snippet" => "( \${1:\$query}, \${2:\$link_identifier} )", 
	"desc" => "Send a Sybase query and do not block", 
	"docurl" => "function.sybase-unbuffered-query.html" 
),
"symlink" => array( 
	"methodname" => "symlink", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool symlink ( string target, string link )", 
	"snippet" => "( \${1:\$target}, \${2:\$link} )", 
	"desc" => "Creates a symbolic link", 
	"docurl" => "function.symlink.html" 
),
"syslog" => array( 
	"methodname" => "syslog", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int syslog ( int priority, string message )", 
	"snippet" => "( \${1:\$priority}, \${2:\$message} )", 
	"desc" => "Generate a system log message", 
	"docurl" => "function.syslog.html" 
),
"system" => array( 
	"methodname" => "system", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string system ( string command [, int &return_var] )", 
	"snippet" => "( \${1:\$command} )", 
	"desc" => "Execute an external program and display the output", 
	"docurl" => "function.system.html" 
),

); # end of main array
?>