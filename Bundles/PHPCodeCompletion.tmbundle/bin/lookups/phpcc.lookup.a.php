<?php
$_LOOKUP = array( 
"abs" => array( 
	"methodname" => "abs", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "number abs ( mixed number )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Absolute value", 
	"docurl" => "function.abs.html" 
),
"acos" => array( 
	"methodname" => "acos", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float acos ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Arc cosine", 
	"docurl" => "function.acos.html" 
),
"acosh" => array( 	
	"methodname" => "acosh", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float acosh ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Inverse hyperbolic cosine", 
	"docurl" => "function.acosh.html" 
),
"addcslashes" => array( 	
	"methodname" => "addcslashes", 
	"version" => "PHP4, PHP5", 
	"method" => "string addcslashes ( string str, string charlist )", 
	"snippet" => "( \${1:\$str}, \${2:\$charlist} )", 
	"desc" => "Quote string with slashes in a C style", 
	"docurl" => "function.addcslashes.html" 
),
"addslashes" => array( 
	"methodname" => "addslashes", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string addslashes ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Quote string with slashes", 
	"docurl" => "function.addslashes.html" 
),
"aggregate_info" => array( 
	"methodname" => "aggregate_info", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array aggregate_info ( object object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Returns an associative array of the methods and properties from each class that has been aggregated to the object", 
	"docurl" => "function.aggregate-info.html" 
),
"aggregate_methods_by_list" => array( 
	"methodname" => "aggregate_methods_by_list", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "void aggregate_methods_by_list ( object object, string class_name, array methods_list [, bool exclude] )", 
	"snippet" => "( \${1:\$object}, \${2:\$class_name}, \${3:\$methods_list} )", 
	"desc" => "Selective dynamic class methods aggregation to an object", 
	"docurl" => "function.aggregate-methods-by-list.html" 
),
"aggregate_methods_by_regexp" => array( 
	"methodname" => "aggregate_methods_by_regexp", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "void aggregate_methods_by_regexp ( object object, string class_name, string regexp [, bool exclude] )", 
	"snippet" => "( \${1:\$object}, \${2:\$class_name}, \${3:\$regexp} )", 
	"desc" => "Selective class methods aggregation to an object using a regular   expression", 
	"docurl" => "function.aggregate-methods-by-regexp.html" 
),
"aggregate_methods" => array( 
	"methodname" => "aggregate_methods", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "void aggregate_methods ( object object, string class_name )", 
	"snippet" => "( \${1:\$object}, \${2:\$class_name} )", 
	"desc" => "Dynamic class and object aggregation of methods", 
	"docurl" => "function.aggregate-methods.html" 
),
"aggregate_properties_by_list" => array( 
	"methodname" => "aggregate_properties_by_list", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "void aggregate_properties_by_list ( object object, string class_name, array properties_list [, bool exclude] )", 
	"snippet" => "( \${1:\$object}, \${2:\$class_name}, \${3:\$properties_list} )", 
	"desc" => "Selective dynamic class properties aggregation to an object", 
	"docurl" => "function.aggregate-properties-by-list.html" 
),
"aggregate_properties_by_regexp" => array( 
	"methodname" => "aggregate_properties_by_regexp", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "void aggregate_properties_by_regexp ( object object, string class_name, string regexp [, bool exclude] )", 
	"snippet" => "( \${1:\$object}, \${2:\$class_name}, \${3:\$regexp} )", 
	"desc" => "Selective class properties aggregation to an object using a regular   expression", 
	"docurl" => "function.aggregate-properties-by-regexp.html" 
),
"aggregate_properties" => array( 
	"methodname" => "aggregate_properties", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "void aggregate_properties ( object object, string class_name )", 
	"snippet" => "( \${1:\$object}, \${2:\$class_name} )", 
	"desc" => "Dynamic aggregation of class properties to an object", 
	"docurl" => "function.aggregate-properties.html" 
),
"aggregate" => array( 
	"methodname" => "aggregate", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "void aggregate ( object object, string class_name )", 
	"snippet" => "( \${1:\$object}, \${2:\$class_name} )", 
	"desc" => "Dynamic class and object aggregation of methods and properties", 
	"docurl" => "function.aggregate.html" 
),
"aggregation_info" => array( 
	"methodname" => "aggregation_info", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "Alias of aggregate_info()", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of aggregate_info()\nReturns an associative array of the methods and properties from each class that has been aggregated to the object", 
	"docurl" => "function.aggregation-info.html" 
),
"apache_child_terminate" => array( 
	"methodname" => "apache_child_terminate", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool apache_child_terminate ( void  )", 
	"snippet" => "( )", 
	"desc" => "Terminate apache process after this request", 
	"docurl" => "function.apache-child-terminate.html" 
),
"apache_get_modules" => array( 
	"methodname" => "apache_get_modules", 
	"version" => "PHP4 >= 4.3.2, PHP5", 
	"method" => "array apache_get_modules ( void  )", 
	"snippet" => "( )", 
	"desc" => "Get a list of loaded Apache modules", 
	"docurl" => "function.apache-get-modules.html" 
),
"apache_get_version" => array( 
	"methodname" => "apache_get_version", 
	"version" => "PHP4 >= 4.3.2, PHP5", 
	"method" => "string apache_get_version ( void  )", 
	"snippet" => "( )", 
	"desc" => "Fetch Apache version", 
	"docurl" => "function.apache-get-version.html" 
),
"apache_getenv" => array( 
	"methodname" => "apache_getenv", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string apache_getenv ( string variable [, bool walk_to_top] )", 
	"snippet" => "( \${1:\$variable} )", 
	"desc" => "Get an Apache subprocess_env variable", 
	"docurl" => "function.apache-getenv.html" 
),
"apache_lookup_uri" => array( 
	"methodname" => "apache_lookup_uri", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "object apache_lookup_uri ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Perform a partial request for the specified URI and return all   info about it", 
	"docurl" => "function.apache-lookup-uri.html" 
),
"apache_note" => array( 
	"methodname" => "apache_note", 
	"version" => "PHP3>= 3.0.2, PHP4, PHP5", 
	"method" => "string apache_note ( string note_name [, string note_value] )", 
	"snippet" => "( \${1:\$note_name} )", 
	"desc" => "Get and set apache request notes", 
	"docurl" => "function.apache-note.html" 
),
"apache_request_headers" => array( 
	"methodname" => "apache_request_headers", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array apache_request_headers ( void  )", 
	"snippet" => "( )", 
	"desc" => "Fetch all HTTP request headers", 
	"docurl" => "function.apache-request-headers.html" 
),
"apache_reset_timeout" => array( 
	"methodname" => "apache_reset_timeout", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool apache_reset_timeout ( void  )", 
	"snippet" => "( )", 
	"desc" => "Reset the Apache write timer", 
	"docurl" => "function.apache-reset-timeout.html" 
),
"apache_response_headers" => array( 
	"methodname" => "apache_response_headers", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array apache_response_headers ( void  )", 
	"snippet" => "( )", 
	"desc" => "Fetch all HTTP response headers", 
	"docurl" => "function.apache-response-headers.html" 
),
"apache_setenv" => array( 
	"methodname" => "apache_setenv", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int apache_setenv ( string variable, string value [, bool walk_to_top] )", 
	"snippet" => "( \${1:\$variable}, \${2:\$value} )", 
	"desc" => "Set an Apache subprocess_env variable", 
	"docurl" => "function.apache-setenv.html" 
),
"apd_breakpoint" => array( 
	"methodname" => "apd_breakpoint", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "void apd_breakpoint ( int debug_level )", 
	"snippet" => "( \${1:\$debug_level} )", 
	"desc" => "Stops the interpreter and waits on a CR from the socket", 
	"docurl" => "function.apd-breakpoint.html" 
),
"apd_callstack" => array( 
	"methodname" => "apd_callstack", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array apd_callstack ( void  )", 
	"snippet" => "( )", 
	"desc" => "Returns the current call stack as an array", 
	"docurl" => "function.apd-callstack.html" 
),
"apd_clunk" => array( 
	"methodname" => "apd_clunk", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "void apd_clunk ( string warning [, string delimiter] )", 
	"snippet" => "( \${1:\$warning} )", 
	"desc" => "Throw a warning and a callstack", 
	"docurl" => "function.apd-clunk.html" 
),
"apd_continue" => array( 
	"methodname" => "apd_continue", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "void apd_continue ( int debug_level )", 
	"snippet" => "( \${1:\$debug_level} )", 
	"desc" => "Restarts the interpreter", 
	"docurl" => "function.apd-continue.html" 
),
"apd_croak" => array( 
	"methodname" => "apd_croak", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "void apd_croak ( string warning [, string delimiter] )", 
	"snippet" => "( \${1:\$warning} )", 
	"desc" => "Throw an error, a callstack and then exit", 
	"docurl" => "function.apd-croak.html" 
),
"apd_dump_function_table" => array( 
	"methodname" => "apd_dump_function_table", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "void apd_dump_function_table ( void  )", 
	"snippet" => "( )", 
	"desc" => "Outputs the current function table", 
	"docurl" => "function.apd-dump-function-table.html" 
),
"apd_dump_persistent_resources" => array( 
	"methodname" => "apd_dump_persistent_resources", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array apd_dump_persistent_resources ( void  )", 
	"snippet" => "( )", 
	"desc" => "Return all persistent resources as an array", 
	"docurl" => "function.apd-dump-persistent-resources.html" 
),
"apd_dump_regular_resources" => array( 
	"methodname" => "apd_dump_regular_resources", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array apd_dump_regular_resources ( void  )", 
	"snippet" => "( )", 
	"desc" => "Return all current regular resources as an array", 
	"docurl" => "function.apd-dump-regular-resources.html" 
),
"apd_echo" => array( 
	"methodname" => "apd_echo", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "void apd_echo ( string output )", 
	"snippet" => "( \${1:\$output} )", 
	"desc" => "Echo to the debugging socket", 
	"docurl" => "function.apd-echo.html" 
),
"apd_get_active_symbols" => array( 
	"methodname" => "apd_get_active_symbols", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array apd_get_active_symbols (  )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get an array of the current variables names in the local scope", 
	"docurl" => "function.apd-get-active-symbols.html" 
),
"apd_set_pprof_trace" => array( 
	"methodname" => "apd_set_pprof_trace", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "void apd_set_pprof_trace ( [string dump_directory] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Starts the session debugging", 
	"docurl" => "function.apd-set-pprof-trace.html" 
),
"apd_set_session_trace" => array( 
	"methodname" => "apd_set_session_trace", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "void apd_set_session_trace ( int debug_level [, string dump_directory] )", 
	"snippet" => "( \${1:\$debug_level} )", 
	"desc" => "Starts the session debugging", 
	"docurl" => "function.apd-set-session-trace.html" 
),
"apd_set_session" => array( 
	"methodname" => "apd_set_session", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "void apd_set_session ( int debug_level )", 
	"snippet" => "( \${1:\$debug_level} )", 
	"desc" => "Changes or sets the current debugging level", 
	"docurl" => "function.apd-set-session.html" 
),
"apd_set_socket_session_trace" => array( 
	"methodname" => "apd_set_socket_session_trace", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool apd_set_socket_session_trace ( string ip_address_or_unix_socket_file, int socket_type, int port, int debug_level )", 
	"snippet" => "( \${1:\$ip_address_or_unix_socket_file}, \${2:\$socket_type}, \${3:\$port}, \${4:\$debug_level} )", 
	"desc" => "Starts the remote session debugging", 
	"docurl" => "function.apd-set-socket-session-trace.html" 
),
"array_change_key_case" => array( 
	"methodname" => "array_change_key_case", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array array_change_key_case ( array input [, int case] )", 
	"snippet" => "( \${1:\$input} )", 
	"desc" => "Returns an array with all string keys lowercased or uppercased", 
	"docurl" => "function.array-change-key-case.html" 
),
"array_chunk" => array( 
	"methodname" => "array_chunk", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array array_chunk ( array input, int size [, bool preserve_keys] )", 
	"snippet" => "( \${1:\$input}, \${2:\$size} )", 
	"desc" => "Split an array into chunks", 
	"docurl" => "function.array-chunk.html" 
),
"array_combine" => array( 
	"methodname" => "array_combine", 
	"version" => "PHP5", 
	"method" => "array array_combine ( array keys, array values )", 
	"snippet" => "( \${1:\$keys}, \${2:\$values} )", 
	"desc" => "Creates an array by using one array for keys and another for its values", 
	"docurl" => "function.array-combine.html" 
),
"array_count_values" => array( 
	"methodname" => "array_count_values", 
	"version" => "PHP4, PHP5", 
	"method" => "array array_count_values ( array input )", 
	"snippet" => "( \${1:\$input} )", 
	"desc" => "Counts all the values of an array", 
	"docurl" => "function.array-count-values.html" 
),
"array_diff_assoc" => array( 
	"methodname" => "array_diff_assoc", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array array_diff_assoc ( array array1, array array2 [, array ...] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the difference of arrays with additional index check", 
	"docurl" => "function.array-diff-assoc.html" 
),
"array_diff_key" => array( 
	"methodname" => "array_diff_key", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array array_diff_key ( array array1, array array2 [, array ...] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the difference of arrays using keys for comparison", 
	"docurl" => "function.array-diff-key.html" 
),
"array_diff_uassoc" => array( 
	"methodname" => "array_diff_uassoc", 
	"version" => "PHP5", 
	"method" => "array array_diff_uassoc ( array array1, array array2 [, array ..., callback key_compare_func] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the difference of arrays with additional index check   which is performed by a user supplied callback function", 
	"docurl" => "function.array-diff-uassoc.html" 
),
"array_diff_ukey" => array( 
	"methodname" => "array_diff_ukey", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array array_diff_ukey ( array array1, array array2 [, array ..., callback key_compare_func] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the difference of arrays using a callback function on the keys for comparison", 
	"docurl" => "function.array-diff-ukey.html" 
),
"array_diff" => array( 
	"methodname" => "array_diff", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "array array_diff ( array array1, array array2 [, array ...] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the difference of arrays", 
	"docurl" => "function.array-diff.html" 
),
"array_fill" => array( 
	"methodname" => "array_fill", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array array_fill ( int start_index, int num, mixed value )", 
	"snippet" => "( \${1:\$start_index}, \${2:\$num}, \${3:\$value} )", 
	"desc" => "Fill an array with values", 
	"docurl" => "function.array-fill.html" 
),
"array_filter" => array( 
	"methodname" => "array_filter", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array array_filter ( array input [, callback callback] )", 
	"snippet" => "( \${1:\$input} )", 
	"desc" => "Filters elements of an array using a callback function", 
	"docurl" => "function.array-filter.html" 
),
"array_flip" => array( 
	"methodname" => "array_flip", 
	"version" => "PHP4, PHP5", 
	"method" => "array array_flip ( array trans )", 
	"snippet" => "( \${1:\$trans} )", 
	"desc" => "Exchanges all keys with their associated values in an array", 
	"docurl" => "function.array-flip.html" 
),
"array_intersect_assoc" => array( 
	"methodname" => "array_intersect_assoc", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array array_intersect_assoc ( array array1, array array2 [, array ...] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the intersection of arrays with additional index check", 
	"docurl" => "function.array-intersect-assoc.html" 
),
"array_intersect_key" => array( 
	"methodname" => "array_intersect_key", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array array_intersect_key ( array array1, array array2 [, array ...] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the intersection of arrays using keys for comparison", 
	"docurl" => "function.array-intersect-key.html" 
),
"array_intersect_uassoc" => array( 
	"methodname" => "array_intersect_uassoc", 
	"version" => "PHP5", 
	"method" => "array array_intersect_uassoc ( array array1, array array2 [, array ..., callback key_compare_func] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the intersection of arrays with additional index check, compares indexes by a callback function", 
	"docurl" => "function.array-intersect-uassoc.html" 
),
"array_intersect_ukey" => array( 
	"methodname" => "array_intersect_ukey", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array array_intersect_ukey ( array array1, array array2 [, array ..., callback key_compare_func] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the intersection of arrays using a callback function on the keys for comparison", 
	"docurl" => "function.array-intersect-ukey.html" 
),
"array_intersect" => array( 
	"methodname" => "array_intersect", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "array array_intersect ( array array1, array array2 [, array ...] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the intersection of arrays", 
	"docurl" => "function.array-intersect.html" 
),
"array_key_exists" => array( 
	"methodname" => "array_key_exists", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool array_key_exists ( mixed key, array search )", 
	"snippet" => "( \${1:\$key}, \${2:\$search} )", 
	"desc" => "Checks if the given key or index exists in the array", 
	"docurl" => "function.array-key-exists.html" 
),
"array_keys" => array( 
	"methodname" => "array_keys", 
	"version" => "PHP4, PHP5", 
	"method" => "array array_keys ( array input [, mixed search_value [, bool strict]] )", 
	"snippet" => "( \${1:\$input} )", 
	"desc" => "Return all the keys of an array", 
	"docurl" => "function.array-keys.html" 
),
"array_map" => array( 
	"methodname" => "array_map", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array array_map ( callback callback, array arr1 [, array ...] )", 
	"snippet" => "( \${1:\$callback}, \${2:\$arr1} )", 
	"desc" => "Applies the callback to the elements of the given arrays", 
	"docurl" => "function.array-map.html" 
),
"array_merge_recursive" => array( 
	"methodname" => "array_merge_recursive", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "array array_merge_recursive ( array array1, array array2 [, array ...] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Merge two or more arrays recursively", 
	"docurl" => "function.array-merge-recursive.html" 
),
"array_merge" => array( 
	"methodname" => "array_merge", 
	"version" => "PHP4, PHP5", 
	"method" => "array array_merge ( array array1 [, array array2 [, array ...]] )", 
	"snippet" => "( \${1:\$array1} )", 
	"desc" => "Merge one or more arrays", 
	"docurl" => "function.array-merge.html" 
),
"array_multisort" => array( 
	"methodname" => "array_multisort", 
	"version" => "PHP4, PHP5", 
	"method" => "bool array_multisort ( array ar1 [, mixed arg [, mixed ... [, array ...]]] )", 
	"snippet" => "( \${1:\$ar1} )", 
	"desc" => "Sort multiple or multi-dimensional arrays", 
	"docurl" => "function.array-multisort.html" 
),
"array_pad" => array( 
	"methodname" => "array_pad", 
	"version" => "PHP4, PHP5", 
	"method" => "array array_pad ( array input, int pad_size, mixed pad_value )", 
	"snippet" => "( \${1:\$input}, \${2:\$pad_size}, \${3:\$pad_value} )", 
	"desc" => "Pad array to the specified length with a value", 
	"docurl" => "function.array-pad.html" 
),
"array_pop" => array( 
	"methodname" => "array_pop", 
	"version" => "PHP4, PHP5", 
	"method" => "mixed array_pop ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Pop the element off the end of array", 
	"docurl" => "function.array-pop.html" 
),
"array_push" => array( 
	"methodname" => "array_push", 
	"version" => "PHP4, PHP5", 
	"method" => "int array_push ( array &array, mixed var [, mixed ...] )", 
	"snippet" => "( \${1:\$array}, \${2:\$var} )", 
	"desc" => "Push one or more elements onto the end of array", 
	"docurl" => "function.array-push.html" 
),
"array_rand" => array( 
	"methodname" => "array_rand", 
	"version" => "PHP4, PHP5", 
	"method" => "mixed array_rand ( array input [, int num_req] )", 
	"snippet" => "( \${1:\$input} )", 
	"desc" => "Pick one or more random entries out of an array", 
	"docurl" => "function.array-rand.html" 
),
"array_reduce" => array( 
	"methodname" => "array_reduce", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "mixed array_reduce ( array input, callback function [, int initial] )", 
	"snippet" => "( \${1:\$input}, \${2:\$function} )", 
	"desc" => "Iteratively reduce the array to a single value using a callback   function", 
	"docurl" => "function.array-reduce.html" 
),
"array_reverse" => array( 
	"methodname" => "array_reverse", 
	"version" => "PHP4, PHP5", 
	"method" => "array array_reverse ( array array [, bool preserve_keys] )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Return an array with elements in reverse order", 
	"docurl" => "function.array-reverse.html" 
),
"array_search" => array( 
	"methodname" => "array_search", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "mixed array_search ( mixed needle, array haystack [, bool strict] )", 
	"snippet" => "( \${1:\$needle}, \${2:\$haystack} )", 
	"desc" => "Searches the array for a given value and returns the   corresponding key if successful", 
	"docurl" => "function.array-search.html" 
),
"array_shift" => array( 
	"methodname" => "array_shift", 
	"version" => "PHP4, PHP5", 
	"method" => "mixed array_shift ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Shift an element off the beginning of array", 
	"docurl" => "function.array-shift.html" 
),
"array_slice" => array( 
	"methodname" => "array_slice", 
	"version" => "PHP4, PHP5", 
	"method" => "array array_slice ( array array, int offset [, int length [, bool preserve_keys]] )", 
	"snippet" => "( \${1:\$array}, \${2:\$offset} )", 
	"desc" => "Extract a slice of the array", 
	"docurl" => "function.array-slice.html" 
),
"array_splice" => array( 
	"methodname" => "array_splice", 
	"version" => "PHP4, PHP5", 
	"method" => "array array_splice ( array &input, int offset [, int length [, array replacement]] )", 
	"snippet" => "( \${1:\$input}, \${2:\$offset} )", 
	"desc" => "Remove a portion of the array and replace it with something   else", 
	"docurl" => "function.array-splice.html" 
),
"array_sum" => array( 
	"methodname" => "array_sum", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "number array_sum ( array array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Calculate the sum of values in an array", 
	"docurl" => "function.array-sum.html" 
),
"array_udiff_assoc" => array( 
	"methodname" => "array_udiff_assoc", 
	"version" => "PHP5", 
	"method" => "array array_udiff_assoc ( array array1, array array2 [, array ..., callback data_compare_func] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the difference of arrays with additional index check, compares data by a callback function", 
	"docurl" => "function.array-udiff-assoc.html" 
),
"array_udiff_uassoc" => array( 
	"methodname" => "array_udiff_uassoc", 
	"version" => "PHP5", 
	"method" => "array array_udiff_uassoc ( array array1, array array2 [, array ..., callback data_compare_func, callback key_compare_func] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the difference of arrays with additional index check, compares data and indexes by a callback function", 
	"docurl" => "function.array-udiff-uassoc.html" 
),
"array_udiff" => array( 
	"methodname" => "array_udiff", 
	"version" => "PHP5", 
	"method" => "array array_udiff ( array array1, array array2 [, array ..., callback data_compare_func] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the difference of arrays by using a callback function for data comparison", 
	"docurl" => "function.array-udiff.html" 
),
"array_uintersect_assoc" => array( 
	"methodname" => "array_uintersect_assoc", 
	"version" => "PHP5", 
	"method" => "array array_uintersect_assoc ( array array1, array array2 [, array ..., callback data_compare_func] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the intersection of arrays with additional index check, compares data by a callback function", 
	"docurl" => "function.array-uintersect-assoc.html" 
),
"array_uintersect_uassoc" => array( 
	"methodname" => "array_uintersect_uassoc", 
	"version" => "PHP5", 
	"method" => "array array_uintersect_uassoc ( array array1, array array2 [, array ..., callback data_compare_func, callback key_compare_func] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the intersection of arrays with additional index check, compares data and indexes by a callback functions", 
	"docurl" => "function.array-uintersect-uassoc.html" 
),
"array_uintersect" => array( 
	"methodname" => "array_uintersect", 
	"version" => "PHP5", 
	"method" => "array array_uintersect ( array array1, array array2 [, array ..., callback data_compare_func] )", 
	"snippet" => "( \${1:\$array1}, \${2:\$array2} )", 
	"desc" => "Computes the intersection of arrays, compares data by a callback function", 
	"docurl" => "function.array-uintersect.html" 
),
"array_unique" => array( 
	"methodname" => "array_unique", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "array array_unique ( array array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Removes duplicate values from an array", 
	"docurl" => "function.array-unique.html" 
),
"array_unshift" => array( 
	"methodname" => "array_unshift", 
	"version" => "PHP4, PHP5", 
	"method" => "int array_unshift ( array &array, mixed var [, mixed ...] )", 
	"snippet" => "( \${1:\$array}, \${2:\$var} )", 
	"desc" => "Prepend one or more elements to the beginning of an array", 
	"docurl" => "function.array-unshift.html" 
),
"array_values" => array( 
	"methodname" => "array_values", 
	"version" => "PHP4, PHP5", 
	"method" => "array array_values ( array input )", 
	"snippet" => "( \${1:\$input} )", 
	"desc" => "Return all the values of an array", 
	"docurl" => "function.array-values.html" 
),
"array_walk_recursive" => array( 
	"methodname" => "array_walk_recursive", 
	"version" => "PHP5", 
	"method" => "bool array_walk_recursive ( array &input, callback funcname [, mixed userdata] )", 
	"snippet" => "( \${1:\$input}, \${2:\$funcname} )", 
	"desc" => "Apply a user function recursively to every member of an array", 
	"docurl" => "function.array-walk-recursive.html" 
),
"array_walk" => array( 
	"methodname" => "array_walk", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "bool array_walk ( array &array, callback funcname [, mixed userdata] )", 
	"snippet" => "( \${1:\$array}, \${2:\$funcname} )", 
	"desc" => "Apply a user function to every member of an array", 
	"docurl" => "function.array-walk.html" 
),
"array" => array( 
	"methodname" => "array", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array array ( [mixed ...] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Create an array", 
	"docurl" => "function.array.html" 
),
"arsort" => array( 
	"methodname" => "arsort", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool arsort ( array &array [, int sort_flags] )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Sort an array in reverse order and maintain index association", 
	"docurl" => "function.arsort.html" 
),
"ascii2ebcdic" => array( 
	"methodname" => "ascii2ebcdic", 
	"version" => "PHP3>= 3.0.17", 
	"method" => "int ascii2ebcdic ( string ascii_str )", 
	"snippet" => "( \${1:\$ascii_str} )", 
	"desc" => "Translate string from ASCII to EBCDIC", 
	"docurl" => "function.ascii2ebcdic.html" 
),
"asin" => array( 
	"methodname" => "asin", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float asin ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Arc sine", 
	"docurl" => "function.asin.html" 
),
"asinh" => array( 
	"methodname" => "asinh", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float asinh ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Inverse hyperbolic sine", 
	"docurl" => "function.asinh.html" 
),
"asort" => array( 
	"methodname" => "asort", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool asort ( array &array [, int sort_flags] )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Sort an array and maintain index association", 
	"docurl" => "function.asort.html" 
),
"aspell_check_raw" => array( 
	"methodname" => "aspell_check_raw", 
	"version" => "PHP3>= 3.0.7, PHP4  <= 4.2.3", 
	"method" => "bool aspell_check_raw ( int dictionary_link, string word )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$word} )", 
	"desc" => "Check a word without changing its case or trying to trim it [deprecated]", 
	"docurl" => "function.aspell-check-raw.html" 
),
"aspell_check" => array( 
	"methodname" => "aspell_check", 
	"version" => "PHP3>= 3.0.7, PHP4  <= 4.2.3", 
	"method" => "bool aspell_check ( int dictionary_link, string word )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$word} )", 
	"desc" => "Check a word [deprecated]", 
	"docurl" => "function.aspell-check.html" 
),
"aspell_new" => array( 
	"methodname" => "aspell_new", 
	"version" => "PHP3>= 3.0.7, PHP4  <= 4.2.3", 
	"method" => "int aspell_new ( string master [, string personal] )", 
	"snippet" => "( \${1:\$master} )", 
	"desc" => "Load a new dictionary [deprecated]", 
	"docurl" => "function.aspell-new.html" 
),
"aspell_suggest" => array( 
	"methodname" => "aspell_suggest", 
	"version" => "PHP3>= 3.0.7, PHP4  <= 4.2.3", 
	"method" => "array aspell_suggest ( int dictionary_link, string word )", 
	"snippet" => "( \${1:\$dictionary_link}, \${2:\$word} )", 
	"desc" => "Suggest spellings of a word [deprecated]", 
	"docurl" => "function.aspell-suggest.html" 
),
"assert_options" => array( 
	"methodname" => "assert_options", 
	"version" => "PHP4, PHP5", 
	"method" => "mixed assert_options ( int what [, mixed value] )", 
	"snippet" => "( \${1:\$what} )", 
	"desc" => "Set/get the various assert flags", 
	"docurl" => "function.assert-options.html" 
),
"assert" => array( 
	"methodname" => "assert", 
	"version" => "PHP4, PHP5", 
	"method" => "int assert ( mixed assertion )", 
	"snippet" => "( \${1:\$assertion} )", 
	"desc" => "Checks if assertion is FALSE", 
	"docurl" => "function.assert.html" 
),
"atan" => array( 
	"methodname" => "atan", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float atan ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Arc tangent", 
	"docurl" => "function.atan.html" 
),
"atan2" => array( 
	"methodname" => "atan2", 
	"version" => "PHP3>= 3.0.5, PHP4, PHP5", 
	"method" => "float atan2 ( float y, float x )", 
	"snippet" => "( \${1:\$y}, \${2:\$x} )", 
	"desc" => "Arc tangent of two variables", 
	"docurl" => "function.atan2.html" 
),
"atanh" => array( 
	"methodname" => "atanh", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float atanh ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Inverse hyperbolic tangent", 
	"docurl" => "function.atanh.html"
)
); # end of main array
?>