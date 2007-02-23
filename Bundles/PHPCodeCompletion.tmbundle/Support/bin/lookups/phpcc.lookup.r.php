<?php
$_LOOKUP = array( 
"rad2deg" => array( 
	"methodname" => "rad2deg", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "float rad2deg ( float number )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Converts the radian number to the equivalent number in degrees", 
	"docurl" => "function.rad2deg.html" 
),
"rand" => array( 
	"methodname" => "rand", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int rand ( [int min, int max] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Generate a random integer", 
	"docurl" => "function.rand.html" 
),
"range" => array( 
	"methodname" => "range", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "array range ( number low, number high [, number step] )", 
	"snippet" => "( \${1:\$low}, \${2:\$high} )", 
	"desc" => "Create an array containing a range of elements", 
	"docurl" => "function.range.html" 
),
"rar_close" => array( 
	"methodname" => "rar_close", 
	"version" => "undefined", 
	"method" => "bool rar_close ( resource rar_file )", 
	"snippet" => "( \${1:\$rar_file} )", 
	"desc" => "", 
	"docurl" => "function.rar-close.html" 
),
"rar_entry_get" => array( 
	"methodname" => "rar_entry_get", 
	"version" => "undefined", 
	"method" => "RarEntry rar_entry_get ( resource rar_file, string entry_name )", 
	"snippet" => "( \${1:\$rar_file}, \${2:\$entry_name} )", 
	"desc" => "", 
	"docurl" => "function.rar-entry-get.html" 
),
"rar_list" => array( 
	"methodname" => "rar_list", 
	"version" => "undefined", 
	"method" => "array rar_list ( resource rar_file )", 
	"snippet" => "( \${1:\$rar_file} )", 
	"desc" => "", 
	"docurl" => "function.rar-list.html" 
),
"rar_open" => array( 
	"methodname" => "rar_open", 
	"version" => "undefined", 
	"method" => "resource rar_open ( string filename [, string password] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.rar-open.html" 
),
"rawurldecode" => array( 
	"methodname" => "rawurldecode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string rawurldecode ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Decode URL-encoded strings", 
	"docurl" => "function.rawurldecode.html" 
),
"rawurlencode" => array( 
	"methodname" => "rawurlencode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string rawurlencode ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "URL-encode according to RFC 1738", 
	"docurl" => "function.rawurlencode.html" 
),
"read_exif_data" => array( 
	"methodname" => "read_exif_data", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array read_exif_data ( string filename [, string sections [, bool arrays [, bool thumbnail]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of exif_read_data()\nReads the EXIF headers from JPEG or TIFF", 
	"docurl" => "function.read-exif-data.html" 
),
"readdir" => array( 
	"methodname" => "readdir", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string readdir ( resource dir_handle )", 
	"snippet" => "( \${1:\$dir_handle} )", 
	"desc" => "Read entry from directory handle", 
	"docurl" => "function.readdir.html" 
),
"readfile" => array( 
	"methodname" => "readfile", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int readfile ( string filename [, bool use_include_path [, resource context]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Outputs a file", 
	"docurl" => "function.readfile.html" 
),
"readgzfile" => array( 
	"methodname" => "readgzfile", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int readgzfile ( string filename [, int use_include_path] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Output a gz-file", 
	"docurl" => "function.readgzfile.html" 
),
"readline_add_history" => array( 
	"methodname" => "readline_add_history", 
	"version" => "PHP4, PHP5", 
	"method" => "void readline_add_history ( string line )", 
	"snippet" => "( \${1:\$line} )", 
	"desc" => "Adds a line to the history", 
	"docurl" => "function.readline-add-history.html" 
),
"readline_callback_handler_install" => array( 
	"methodname" => "readline_callback_handler_install", 
	"version" => "undefined", 
	"method" => "bool readline_callback_handler_install ( string prompt, callback callback )", 
	"snippet" => "( \${1:\$prompt}, \${2:\$callback} )", 
	"desc" => "Initializes the readline callback interface and terminal, prints the prompt and returns immediately", 
	"docurl" => "function.readline-callback-handler-install.html" 
),
"readline_callback_handler_remove" => array( 
	"methodname" => "readline_callback_handler_remove", 
	"version" => "undefined", 
	"method" => "bool readline_callback_handler_remove ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Removes a previously installed callback handler and restores terminal settings", 
	"docurl" => "function.readline-callback-handler-remove.html" 
),
"readline_callback_read_char" => array( 
	"methodname" => "readline_callback_read_char", 
	"version" => "undefined", 
	"method" => "void readline_callback_read_char ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Reads a character and informs the readline callback interface when a line is received", 
	"docurl" => "function.readline-callback-read-char.html" 
),
"readline_clear_history" => array( 
	"methodname" => "readline_clear_history", 
	"version" => "PHP4, PHP5", 
	"method" => "bool readline_clear_history ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Clears the history", 
	"docurl" => "function.readline-clear-history.html" 
),
"readline_completion_function" => array( 
	"methodname" => "readline_completion_function", 
	"version" => "PHP4, PHP5", 
	"method" => "bool readline_completion_function ( callback function )", 
	"snippet" => "( \${1:\$function} )", 
	"desc" => "Registers a completion function", 
	"docurl" => "function.readline-completion-function.html" 
),
"readline_info" => array( 
	"methodname" => "readline_info", 
	"version" => "PHP4, PHP5", 
	"method" => "mixed readline_info ( [string varname [, string newvalue]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Gets/sets various internal readline variables", 
	"docurl" => "function.readline-info.html" 
),
"readline_list_history" => array( 
	"methodname" => "readline_list_history", 
	"version" => "PHP4, PHP5", 
	"method" => "array readline_list_history ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Lists the history", 
	"docurl" => "function.readline-list-history.html" 
),
"readline_on_new_line" => array( 
	"methodname" => "readline_on_new_line", 
	"version" => "undefined", 
	"method" => "void readline_on_new_line ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Inform readline that the cursor has moved to a new line", 
	"docurl" => "function.readline-on-new-line.html" 
),
"readline_read_history" => array( 
	"methodname" => "readline_read_history", 
	"version" => "PHP4, PHP5", 
	"method" => "bool readline_read_history ( [string filename] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Reads the history", 
	"docurl" => "function.readline-read-history.html" 
),
"readline_redisplay" => array( 
	"methodname" => "readline_redisplay", 
	"version" => "undefined", 
	"method" => "void readline_redisplay ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Ask readline to redraw the display", 
	"docurl" => "function.readline-redisplay.html" 
),
"readline_write_history" => array( 
	"methodname" => "readline_write_history", 
	"version" => "PHP4, PHP5", 
	"method" => "bool readline_write_history ( [string filename] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Writes the history", 
	"docurl" => "function.readline-write-history.html" 
),
"readline" => array( 
	"methodname" => "readline", 
	"version" => "PHP4, PHP5", 
	"method" => "string readline ( string prompt )", 
	"snippet" => "( \${1:\$prompt} )", 
	"desc" => "Reads a line", 
	"docurl" => "function.readline.html" 
),
"readlink" => array( 
	"methodname" => "readlink", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string readlink ( string path )", 
	"snippet" => "( \${1:\$path} )", 
	"desc" => "Returns the target of a symbolic link", 
	"docurl" => "function.readlink.html" 
),
"realpath" => array( 
	"methodname" => "realpath", 
	"version" => "PHP4, PHP5", 
	"method" => "string realpath ( string path )", 
	"snippet" => "( \${1:\$path} )", 
	"desc" => "Returns canonicalized absolute pathname", 
	"docurl" => "function.realpath.html" 
),
"recode_file" => array( 
	"methodname" => "recode_file", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool recode_file ( string request, resource input, resource output )", 
	"snippet" => "( \${1:\$request}, \${2:\$input}, \${3:\$output} )", 
	"desc" => "Recode from file to file according to recode request", 
	"docurl" => "function.recode-file.html" 
),
"recode_string" => array( 
	"methodname" => "recode_string", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "string recode_string ( string request, string string )", 
	"snippet" => "( \${1:\$request}, \${2:\$string} )", 
	"desc" => "Recode a string according to a recode request", 
	"docurl" => "function.recode-string.html" 
),
"recode" => array( 
	"methodname" => "recode", 
	"version" => "undefined", 
	"method" => "string recode ( string request, string string )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of recode_string()\nRecode a string according to a recode request", 
	"docurl" => "function.recode.html" 
),
"register_shutdown_function" => array( 
	"methodname" => "register_shutdown_function", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "void register_shutdown_function ( callback function [, mixed parameter [, mixed ...]] )", 
	"snippet" => "( \${1:\$function} )", 
	"desc" => "Register a function for execution on shutdown", 
	"docurl" => "function.register-shutdown-function.html" 
),
"register_tick_function" => array( 
	"methodname" => "register_tick_function", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "void register_tick_function ( callback function [, mixed arg [, mixed ...]] )", 
	"snippet" => "( \${1:\$function} )", 
	"desc" => "Register a function for execution on each tick", 
	"docurl" => "function.register-tick-function.html" 
),
"rename_function" => array( 
	"methodname" => "rename_function", 
	"version" => "undefined", 
	"method" => "bool rename_function ( string original_name, string new_name )", 
	"snippet" => "( \${1:\$original_name}, \${2:\$new_name} )", 
	"desc" => "Renames orig_name to new_name in the global function_table", 
	"docurl" => "function.rename-function.html" 
),
"rename" => array( 
	"methodname" => "rename", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool rename ( string oldname, string newname [, resource context] )", 
	"snippet" => "( \${1:\$oldname}, \${2:\$newname} )", 
	"desc" => "Renames a file or directory", 
	"docurl" => "function.rename.html" 
),
"require_once" => array( 
	"methodname" => "require_once", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "require_once( string file )", 
	"snippet" => "( \$1 )", 
	"desc" => "The require_once() statement includes and evaluates the specified file during the execution of the script. This is a behavior similar to the require() statement, with the only difference being that if the code from a file has already been included, it will not be included again.", 
	"docurl" => "function.require-once.html" 
),
"require" => array( 
	"methodname" => "require", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "require( string file )", 
	"snippet" => "( \$1 )", 
	"desc" => "The require() statement includes and evaluates the specific file.\nrequire() includes and evaluates a specific file. Detailed information on how this inclusion works is described in the documentation for include().", 
	"docurl" => "function.require.html" 
),
"reset" => array( 
	"methodname" => "reset", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed reset ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Set the internal pointer of an array to its first element", 
	"docurl" => "function.reset.html" 
),
"restore_error_handler" => array( 
	"methodname" => "restore_error_handler", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool restore_error_handler ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Restores the previous error handler function", 
	"docurl" => "function.restore-error-handler.html" 
),
"restore_exception_handler" => array( 
	"methodname" => "restore_exception_handler", 
	"version" => "PHP5", 
	"method" => "bool restore_exception_handler ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Restores the previously defined exception handler function", 
	"docurl" => "function.restore-exception-handler.html" 
),
"restore_include_path" => array( 
	"methodname" => "restore_include_path", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "void restore_include_path ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Restores the value of the include_path configuration option", 
	"docurl" => "function.restore-include-path.html" 
),
"return" => array( 
	"methodname" => "return", 
	"version" => "All", 
	"method" => "return ([string|variable|nothing])", 
	"snippet" => "( \$1 )", 
	"desc" => "If called from within a function, the return() statement immediately ends execution of the current function, and returns its argument as the value of the function call. return() will also end the execution of an eval() statement or script file.", 
	"docurl" => "function.return.html" 
),
"rewind" => array( 
	"methodname" => "rewind", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool rewind ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Rewind the position of a file pointer", 
	"docurl" => "function.rewind.html" 
),
"rewinddir" => array( 
	"methodname" => "rewinddir", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void rewinddir ( resource dir_handle )", 
	"snippet" => "( \${1:\$dir_handle} )", 
	"desc" => "Rewind directory handle", 
	"docurl" => "function.rewinddir.html" 
),
"rmdir" => array( 
	"methodname" => "rmdir", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool rmdir ( string dirname [, resource context] )", 
	"snippet" => "( \${1:\$dirname} )", 
	"desc" => "Removes directory", 
	"docurl" => "function.rmdir.html" 
),
"round" => array( 
	"methodname" => "round", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float round ( float val [, int precision] )", 
	"snippet" => "( \${1:\$val} )", 
	"desc" => "Rounds a float", 
	"docurl" => "function.round.html" 
),
"rsort" => array( 
	"methodname" => "rsort", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool rsort ( array &array [, int sort_flags] )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Sort an array in reverse order", 
	"docurl" => "function.rsort.html" 
),
"rtrim" => array( 
	"methodname" => "rtrim", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string rtrim ( string str [, string charlist] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Strip whitespace (or other characters) from the end of a string", 
	"docurl" => "function.rtrim.html" 
),

); # end of main array
?>