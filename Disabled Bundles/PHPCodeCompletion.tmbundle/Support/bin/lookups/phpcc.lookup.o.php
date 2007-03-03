<?php
$_LOOKUP = array( 
"ob_clean" => array( 
	"methodname" => "ob_clean", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void ob_clean ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Clean (erase) the output buffer", 
	"docurl" => "function.ob-clean.html" 
),
"ob_end_clean" => array( 
	"methodname" => "ob_end_clean", 
	"version" => "PHP4, PHP5", 
	"method" => "bool ob_end_clean ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Clean (erase) the output buffer and turn off output buffering", 
	"docurl" => "function.ob-end-clean.html" 
),
"ob_end_flush" => array( 
	"methodname" => "ob_end_flush", 
	"version" => "PHP4, PHP5", 
	"method" => "bool ob_end_flush ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Flush (send) the output buffer and turn off output buffering", 
	"docurl" => "function.ob-end-flush.html" 
),
"ob_flush" => array( 
	"methodname" => "ob_flush", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void ob_flush ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Flush (send) the output buffer", 
	"docurl" => "function.ob-flush.html" 
),
"ob_get_clean" => array( 
	"methodname" => "ob_get_clean", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string ob_get_clean ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get current buffer contents and delete current output buffer", 
	"docurl" => "function.ob-get-clean.html" 
),
"ob_get_contents" => array( 
	"methodname" => "ob_get_contents", 
	"version" => "PHP4, PHP5", 
	"method" => "string ob_get_contents ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the contents of the output buffer", 
	"docurl" => "function.ob-get-contents.html" 
),
"ob_get_flush" => array( 
	"methodname" => "ob_get_flush", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string ob_get_flush ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Flush the output buffer, return it as a string and turn off output buffering", 
	"docurl" => "function.ob-get-flush.html" 
),
"ob_get_length" => array( 
	"methodname" => "ob_get_length", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int ob_get_length ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the length of the output buffer", 
	"docurl" => "function.ob-get-length.html" 
),
"ob_get_level" => array( 
	"methodname" => "ob_get_level", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ob_get_level ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the nesting level of the output buffering mechanism", 
	"docurl" => "function.ob-get-level.html" 
),
"ob_get_status" => array( 
	"methodname" => "ob_get_status", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array ob_get_status ( [bool full_status] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get status of output buffers", 
	"docurl" => "function.ob-get-status.html" 
),
"ob_gzhandler" => array( 
	"methodname" => "ob_gzhandler", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string ob_gzhandler ( string buffer, int mode )", 
	"snippet" => "( \${1:\$buffer}, \${2:\$mode} )", 
	"desc" => "ob_start callback function to gzip output buffer", 
	"docurl" => "function.ob-gzhandler.html" 
),
"ob_iconv_handler" => array( 
	"methodname" => "ob_iconv_handler", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "array ob_iconv_handler ( string contents, int status )", 
	"snippet" => "( \${1:\$contents}, \${2:\$status} )", 
	"desc" => "Convert character encoding as output buffer handler", 
	"docurl" => "function.ob-iconv-handler.html" 
),
"ob_implicit_flush" => array( 
	"methodname" => "ob_implicit_flush", 
	"version" => "PHP4, PHP5", 
	"method" => "void ob_implicit_flush ( [int flag] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Turn implicit flush on/off", 
	"docurl" => "function.ob-implicit-flush.html" 
),
"ob_list_handlers" => array( 
	"methodname" => "ob_list_handlers", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array ob_list_handlers ( void  )", 
	"snippet" => "(  )", 
	"desc" => "List all output handlers in use", 
	"docurl" => "function.ob-list-handlers.html" 
),
"ob_start" => array( 
	"methodname" => "ob_start", 
	"version" => "PHP4, PHP5", 
	"method" => "bool ob_start ( [callback output_callback [, int chunk_size [, bool erase]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Turn on output buffering", 
	"docurl" => "function.ob-start.html" 
),
"ob_tidyhandler" => array( 
	"methodname" => "ob_tidyhandler", 
	"version" => "PHP5", 
	"method" => "string ob_tidyhandler ( string input [, int mode] )", 
	"snippet" => "( \${1:\$input} )", 
	"desc" => "ob_start callback function to repair the buffer", 
	"docurl" => "function.ob-tidyhandler.html" 
),
"oci_bind_by_name" => array( 
	"methodname" => "oci_bind_by_name", 
	"version" => "PHP5", 
	"method" => "bool oci_bind_by_name ( resource stmt, string ph_name, mixed &variable [, int maxlength [, int type]] )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$ph_name}, \${3:\$variable} )", 
	"desc" => "Binds the PHP variable to the Oracle placeholder", 
	"docurl" => "function.oci-bind-by-name.html" 
),
"oci_cancel" => array( 
	"methodname" => "oci_cancel", 
	"version" => "PHP5", 
	"method" => "bool oci_cancel ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Cancels reading from cursor", 
	"docurl" => "function.oci-cancel.html" 
),
"oci_close" => array( 
	"methodname" => "oci_close", 
	"version" => "PHP5", 
	"method" => "bool oci_close ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Closes Oracle connection", 
	"docurl" => "function.oci-close.html" 
),
"oci_collection_append" => array( 
	"methodname" => "oci_collection_append", 
	"version" => "undefined", 
	"method" => "bool OCI-Collection-&#62;append ( mixed value )", 
	"snippet" => "( \${1:\$value} )", 
	"desc" => "", 
	"docurl" => "function.oci-collection-append.html" 
),
"oci_collection_assign" => array( 
	"methodname" => "oci_collection_assign", 
	"version" => "undefined", 
	"method" => "bool OCI-Collection-&#62;assign ( OCI-Collection from )", 
	"snippet" => "( \${1:\$from} )", 
	"desc" => "", 
	"docurl" => "function.oci-collection-assign.html" 
),
"oci_collection_assignelem" => array( 
	"methodname" => "oci_collection_assignelem", 
	"version" => "undefined", 
	"method" => "bool OCI-Collection-&#62;assignElem ( int index, mixed value )", 
	"snippet" => "( \${1:\$index}, \${2:\$value} )", 
	"desc" => "", 
	"docurl" => "function.oci-collection-assignelem.html" 
),
"oci_collection_free" => array( 
	"methodname" => "oci_collection_free", 
	"version" => "undefined", 
	"method" => "bool OCI-Collection-&#62;free ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.oci-collection-free.html" 
),
"oci_collection_getelem" => array( 
	"methodname" => "oci_collection_getelem", 
	"version" => "undefined", 
	"method" => "mixed OCI-Collection-&#62;getElem ( int index )", 
	"snippet" => "( \${1:\$index} )", 
	"desc" => "", 
	"docurl" => "function.oci-collection-getelem.html" 
),
"oci_collection_max" => array( 
	"methodname" => "oci_collection_max", 
	"version" => "undefined", 
	"method" => "int OCI-Collection-&#62;max ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.oci-collection-max.html" 
),
"oci_collection_size" => array( 
	"methodname" => "oci_collection_size", 
	"version" => "undefined", 
	"method" => "int OCI-Collection-&#62;size ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.oci-collection-size.html" 
),
"oci_collection_trim" => array( 
	"methodname" => "oci_collection_trim", 
	"version" => "undefined", 
	"method" => "bool OCI-Collection-&#62;trim ( int num )", 
	"snippet" => "( \${1:\$num} )", 
	"desc" => "", 
	"docurl" => "function.oci-collection-trim.html" 
),
"oci_commit" => array( 
	"methodname" => "oci_commit", 
	"version" => "PHP5", 
	"method" => "bool oci_commit ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Commits outstanding statements", 
	"docurl" => "function.oci-commit.html" 
),
"oci_connect" => array( 
	"methodname" => "oci_connect", 
	"version" => "PHP5", 
	"method" => "resource oci_connect ( string username, string password [, string db [, string charset]] )", 
	"snippet" => "( \${1:\$username}, \${2:\$password} )", 
	"desc" => "Establishes a connection to Oracle server", 
	"docurl" => "function.oci-connect.html" 
),
"oci_define_by_name" => array( 
	"methodname" => "oci_define_by_name", 
	"version" => "PHP5", 
	"method" => "bool oci_define_by_name ( resource statement, string column_name, mixed &variable [, int type] )", 
	"snippet" => "( \${1:\$statement}, \${2:\$column_name}, \${3:\$variable} )", 
	"desc" => "Uses a PHP variable for the define-step during a SELECT", 
	"docurl" => "function.oci-define-by-name.html" 
),
"oci_error" => array( 
	"methodname" => "oci_error", 
	"version" => "PHP5", 
	"method" => "array oci_error ( [resource source] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns the last error found", 
	"docurl" => "function.oci-error.html" 
),
"oci_execute" => array( 
	"methodname" => "oci_execute", 
	"version" => "PHP5", 
	"method" => "bool oci_execute ( resource stmt [, int mode] )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Executes a statement", 
	"docurl" => "function.oci-execute.html" 
),
"oci_fetch_all" => array( 
	"methodname" => "oci_fetch_all", 
	"version" => "PHP5", 
	"method" => "int oci_fetch_all ( resource statement, array &output [, int skip [, int maxrows [, int flags]]] )", 
	"snippet" => "( \${1:\$statement}, \${2:\$output} )", 
	"desc" => "Fetches all rows of result data into an array", 
	"docurl" => "function.oci-fetch-all.html" 
),
"oci_fetch_array" => array( 
	"methodname" => "oci_fetch_array", 
	"version" => "PHP5", 
	"method" => "array oci_fetch_array ( resource statement [, int mode] )", 
	"snippet" => "( \${1:\$statement} )", 
	"desc" => "Returns the next row from the result data as an associative or   numeric array, or both", 
	"docurl" => "function.oci-fetch-array.html" 
),
"oci_fetch_assoc" => array( 
	"methodname" => "oci_fetch_assoc", 
	"version" => "PHP5", 
	"method" => "array oci_fetch_assoc ( resource statement )", 
	"snippet" => "( \${1:\$statement} )", 
	"desc" => "Returns the next row from the result data as an associative array", 
	"docurl" => "function.oci-fetch-assoc.html" 
),
"oci_fetch_object" => array( 
	"methodname" => "oci_fetch_object", 
	"version" => "PHP5", 
	"method" => "object oci_fetch_object ( resource statement )", 
	"snippet" => "( \${1:\$statement} )", 
	"desc" => "Returns the next row from the result data as an object", 
	"docurl" => "function.oci-fetch-object.html" 
),
"oci_fetch_row" => array( 
	"methodname" => "oci_fetch_row", 
	"version" => "PHP5", 
	"method" => "array oci_fetch_row ( resource statement )", 
	"snippet" => "( \${1:\$statement} )", 
	"desc" => "Returns the next row from the result data as a numeric array", 
	"docurl" => "function.oci-fetch-row.html" 
),
"oci_fetch" => array( 
	"methodname" => "oci_fetch", 
	"version" => "PHP5", 
	"method" => "bool oci_fetch ( resource statement )", 
	"snippet" => "( \${1:\$statement} )", 
	"desc" => "Fetches the next row into result-buffer", 
	"docurl" => "function.oci-fetch.html" 
),
"oci_field_is_null" => array( 
	"methodname" => "oci_field_is_null", 
	"version" => "PHP5", 
	"method" => "bool oci_field_is_null ( resource stmt, mixed field )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$field} )", 
	"desc" => "Checks if the field is NULL", 
	"docurl" => "function.oci-field-is-null.html" 
),
"oci_field_name" => array( 
	"methodname" => "oci_field_name", 
	"version" => "PHP5", 
	"method" => "string oci_field_name ( resource statement, int field )", 
	"snippet" => "( \${1:\$statement}, \${2:\$field} )", 
	"desc" => "Returns the name of a field from the statement", 
	"docurl" => "function.oci-field-name.html" 
),
"oci_field_precision" => array( 
	"methodname" => "oci_field_precision", 
	"version" => "PHP5", 
	"method" => "int oci_field_precision ( resource statement, int field )", 
	"snippet" => "( \${1:\$statement}, \${2:\$field} )", 
	"desc" => "Tell the precision of a field", 
	"docurl" => "function.oci-field-precision.html" 
),
"oci_field_scale" => array( 
	"methodname" => "oci_field_scale", 
	"version" => "PHP5", 
	"method" => "int oci_field_scale ( resource statement, int field )", 
	"snippet" => "( \${1:\$statement}, \${2:\$field} )", 
	"desc" => "Tell the scale of the field", 
	"docurl" => "function.oci-field-scale.html" 
),
"oci_field_size" => array( 
	"methodname" => "oci_field_size", 
	"version" => "PHP5", 
	"method" => "int oci_field_size ( resource stmt, mixed field )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$field} )", 
	"desc" => "Returns field\'s size", 
	"docurl" => "function.oci-field-size.html" 
),
"oci_field_type_raw" => array( 
	"methodname" => "oci_field_type_raw", 
	"version" => "PHP5", 
	"method" => "int oci_field_type_raw ( resource statement, int field )", 
	"snippet" => "( \${1:\$statement}, \${2:\$field} )", 
	"desc" => "Tell the raw Oracle data type of the field", 
	"docurl" => "function.oci-field-type-raw.html" 
),
"oci_field_type" => array( 
	"methodname" => "oci_field_type", 
	"version" => "PHP5", 
	"method" => "mixed oci_field_type ( resource stmt, int field )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$field} )", 
	"desc" => "Returns field\'s data type", 
	"docurl" => "function.oci-field-type.html" 
),
"oci_free_descriptor" => array( 
	"methodname" => "oci_free_descriptor", 
	"version" => "undefined", 
	"method" => "bool descriptor-&#62;free ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.oci-free-descriptor.html" 
),
"oci_free_statement" => array( 
	"methodname" => "oci_free_statement", 
	"version" => "PHP5", 
	"method" => "bool oci_free_statement ( resource statement )", 
	"snippet" => "( \${1:\$statement} )", 
	"desc" => "Frees all resources associated with statement or cursor", 
	"docurl" => "function.oci-free-statement.html" 
),
"oci_internal_debug" => array( 
	"methodname" => "oci_internal_debug", 
	"version" => "PHP5", 
	"method" => "void oci_internal_debug ( int onoff )", 
	"snippet" => "( \${1:\$onoff} )", 
	"desc" => "Enables or disables internal debug output", 
	"docurl" => "function.oci-internal-debug.html" 
),
"oci_lob_append" => array( 
	"methodname" => "oci_lob_append", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;append ( OCI-Lob lob_from )", 
	"snippet" => "( \${1:\$lob_from} )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-append.html" 
),
"oci_lob_close" => array( 
	"methodname" => "oci_lob_close", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;close ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-close.html" 
),
"oci_lob_copy" => array( 
	"methodname" => "oci_lob_copy", 
	"version" => "PHP5", 
	"method" => "bool oci_lob_copy ( OCI-Lob lob_to, OCI-Lob lob_from [, int length] )", 
	"snippet" => "( \${1:\$lob_to}, \${2:\$lob_from} )", 
	"desc" => "Copies large object", 
	"docurl" => "function.oci-lob-copy.html" 
),
"oci_lob_eof" => array( 
	"methodname" => "oci_lob_eof", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;eof ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-eof.html" 
),
"oci_lob_erase" => array( 
	"methodname" => "oci_lob_erase", 
	"version" => "undefined", 
	"method" => "int lob-&#62;erase ( [int offset [, int length]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-erase.html" 
),
"oci_lob_export" => array( 
	"methodname" => "oci_lob_export", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;export ( string filename [, int start [, int length]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-export.html" 
),
"oci_lob_flush" => array( 
	"methodname" => "oci_lob_flush", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;flush ( [int flag] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-flush.html" 
),
"oci_lob_import" => array( 
	"methodname" => "oci_lob_import", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;import ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-import.html" 
),
"oci_lob_is_equal" => array( 
	"methodname" => "oci_lob_is_equal", 
	"version" => "PHP5", 
	"method" => "bool oci_lob_is_equal ( OCI-Lob lob1, OCI-Lob lob2 )", 
	"snippet" => "( \${1:\$lob1}, \${2:\$lob2} )", 
	"desc" => "Compares two LOB/FILE locators for equality", 
	"docurl" => "function.oci-lob-is-equal.html" 
),
"oci_lob_load" => array( 
	"methodname" => "oci_lob_load", 
	"version" => "undefined", 
	"method" => "string lob-&#62;load ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-load.html" 
),
"oci_lob_read" => array( 
	"methodname" => "oci_lob_read", 
	"version" => "undefined", 
	"method" => "string lob-&#62;read ( int length )", 
	"snippet" => "( \${1:\$length} )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-read.html" 
),
"oci_lob_rewind" => array( 
	"methodname" => "oci_lob_rewind", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;rewind ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-rewind.html" 
),
"oci_lob_save" => array( 
	"methodname" => "oci_lob_save", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;save ( string data [, int offset] )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-save.html" 
),
"oci_lob_seek" => array( 
	"methodname" => "oci_lob_seek", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;seek ( int offset [, int whence] )", 
	"snippet" => "( \${1:\$offset} )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-seek.html" 
),
"oci_lob_size" => array( 
	"methodname" => "oci_lob_size", 
	"version" => "undefined", 
	"method" => "int lob-&#62;size ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-size.html" 
),
"oci_lob_tell" => array( 
	"methodname" => "oci_lob_tell", 
	"version" => "undefined", 
	"method" => "int lob-&#62;tell ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-tell.html" 
),
"oci_lob_truncate" => array( 
	"methodname" => "oci_lob_truncate", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;truncate ( [int length] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-truncate.html" 
),
"oci_lob_write_temporary" => array( 
	"methodname" => "oci_lob_write_temporary", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;writeTemporary ( string data [, int lob_type] )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-write-temporary.html" 
),
"oci_lob_write" => array( 
	"methodname" => "oci_lob_write", 
	"version" => "undefined", 
	"method" => "int lob-&#62;write ( string data [, int length] )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "", 
	"docurl" => "function.oci-lob-write.html" 
),
"oci_new_collection" => array( 
	"methodname" => "oci_new_collection", 
	"version" => "PHP5", 
	"method" => "OCI-Collection oci_new_collection ( resource connection, string tdo [, string schema] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$tdo} )", 
	"desc" => "Allocates new collection object", 
	"docurl" => "function.oci-new-collection.html" 
),
"oci_new_connect" => array( 
	"methodname" => "oci_new_connect", 
	"version" => "PHP5", 
	"method" => "resource oci_new_connect ( string username, string password [, string db [, string charset]] )", 
	"snippet" => "( \${1:\$username}, \${2:\$password} )", 
	"desc" => "Establishes a new connection to the Oracle server", 
	"docurl" => "function.oci-new-connect.html" 
),
"oci_new_cursor" => array( 
	"methodname" => "oci_new_cursor", 
	"version" => "PHP5", 
	"method" => "resource oci_new_cursor ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Allocates and returns a new cursor (statement handle)", 
	"docurl" => "function.oci-new-cursor.html" 
),
"oci_new_descriptor" => array( 
	"methodname" => "oci_new_descriptor", 
	"version" => "PHP5", 
	"method" => "OCI-Lob oci_new_descriptor ( resource connection [, int type] )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Initializes a new empty LOB or FILE descriptor", 
	"docurl" => "function.oci-new-descriptor.html" 
),
"oci_num_fields" => array( 
	"methodname" => "oci_num_fields", 
	"version" => "PHP5", 
	"method" => "int oci_num_fields ( resource statement )", 
	"snippet" => "( \${1:\$statement} )", 
	"desc" => "Returns the number of result columns in a statement", 
	"docurl" => "function.oci-num-fields.html" 
),
"oci_num_rows" => array( 
	"methodname" => "oci_num_rows", 
	"version" => "PHP5", 
	"method" => "int oci_num_rows ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Returns number of rows affected during statement execution", 
	"docurl" => "function.oci-num-rows.html" 
),
"oci_parse" => array( 
	"methodname" => "oci_parse", 
	"version" => "PHP5", 
	"method" => "resource oci_parse ( resource connection, string query )", 
	"snippet" => "( \${1:\$connection}, \${2:\$query} )", 
	"desc" => "Prepares Oracle statement for execution", 
	"docurl" => "function.oci-parse.html" 
),
"oci_password_change" => array( 
	"methodname" => "oci_password_change", 
	"version" => "PHP5", 
	"method" => "bool oci_password_change ( resource connection, string username, string old_password, string new_password )", 
	"snippet" => "( \${1:\$connection}, \${2:\$username}, \${3:\$old_password}, \${4:\$new_password} )", 
	"desc" => "Changes password of Oracle\'s user", 
	"docurl" => "function.oci-password-change.html" 
),
"oci_pconnect" => array( 
	"methodname" => "oci_pconnect", 
	"version" => "PHP5", 
	"method" => "resource oci_pconnect ( string username, string password [, string db [, string charset]] )", 
	"snippet" => "( \${1:\$username}, \${2:\$password} )", 
	"desc" => "Connect to an Oracle database using a persistent connection", 
	"docurl" => "function.oci-pconnect.html" 
),
"oci_result" => array( 
	"methodname" => "oci_result", 
	"version" => "PHP5", 
	"method" => "mixed oci_result ( resource statement, mixed field )", 
	"snippet" => "( \${1:\$statement}, \${2:\$field} )", 
	"desc" => "Returns field\'s value from the fetched row", 
	"docurl" => "function.oci-result.html" 
),
"oci_rollback" => array( 
	"methodname" => "oci_rollback", 
	"version" => "PHP5", 
	"method" => "bool oci_rollback ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Rolls back outstanding transaction", 
	"docurl" => "function.oci-rollback.html" 
),
"oci_server_version" => array( 
	"methodname" => "oci_server_version", 
	"version" => "PHP5", 
	"method" => "string oci_server_version ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Returns server version", 
	"docurl" => "function.oci-server-version.html" 
),
"oci_set_prefetch" => array( 
	"methodname" => "oci_set_prefetch", 
	"version" => "PHP5", 
	"method" => "bool oci_set_prefetch ( resource statement [, int rows] )", 
	"snippet" => "( \${1:\$statement} )", 
	"desc" => "Sets number of rows to be prefetched", 
	"docurl" => "function.oci-set-prefetch.html" 
),
"oci_statement_type" => array( 
	"methodname" => "oci_statement_type", 
	"version" => "PHP5", 
	"method" => "string oci_statement_type ( resource statement )", 
	"snippet" => "( \${1:\$statement} )", 
	"desc" => "Returns the type of an OCI statement", 
	"docurl" => "function.oci-statement-type.html" 
),
"ocibindbyname" => array( 
	"methodname" => "ocibindbyname", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "bool ocibindbyname ( resource stmt, string ph_name, mixed &variable [, int maxlength [, int type]] )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$ph_name}, \${3:\$variable} )", 
	"desc" => "Bind a PHP variable to an Oracle Placeholder", 
	"docurl" => "function.ocibindbyname.html" 
),
"ocicancel" => array( 
	"methodname" => "ocicancel", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool ocicancel ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Cancel reading from cursor", 
	"docurl" => "function.ocicancel.html" 
),
"ocicloselob" => array( 
	"methodname" => "ocicloselob", 
	"version" => "undefined", 
	"method" => "bool ocicloselob ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.ocicloselob.html" 
),
"ocicollappend" => array( 
	"methodname" => "ocicollappend", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool ocicollappend ( string value )", 
	"snippet" => "( \${1:\$value} )", 
	"desc" => "Append an object to the collection", 
	"docurl" => "function.ocicollappend.html" 
),
"ocicollassign" => array( 
	"methodname" => "ocicollassign", 
	"version" => "PHP4 >= 4.0.6", 
	"method" => "bool ocicollassign ( OCI-Collection from )", 
	"snippet" => "( \${1:\$from} )", 
	"desc" => "Assign a collection from another existing collection", 
	"docurl" => "function.ocicollassign.html" 
),
"ocicollassignelem" => array( 
	"methodname" => "ocicollassignelem", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool ocicollassignelem ( int ndx, string val )", 
	"snippet" => "( \${1:\$ndx}, \${2:\$val} )", 
	"desc" => "Assign element val to collection at index ndx", 
	"docurl" => "function.ocicollassignelem.html" 
),
"ocicollgetelem" => array( 
	"methodname" => "ocicollgetelem", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string ocicollgetelem ( int ndx )", 
	"snippet" => "( \${1:\$ndx} )", 
	"desc" => "Retrieve the value at collection index ndx", 
	"docurl" => "function.ocicollgetelem.html" 
),
"ocicollmax" => array( 
	"methodname" => "ocicollmax", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int ocicollmax ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets the maximum number of elements in the collection", 
	"docurl" => "function.ocicollmax.html" 
),
"ocicollsize" => array( 
	"methodname" => "ocicollsize", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int ocicollsize ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the size of a collection", 
	"docurl" => "function.ocicollsize.html" 
),
"ocicolltrim" => array( 
	"methodname" => "ocicolltrim", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool ocicolltrim ( int num )", 
	"snippet" => "( \${1:\$num} )", 
	"desc" => "Trim num elements from the end of a collection", 
	"docurl" => "function.ocicolltrim.html" 
),
"ocicolumnisnull" => array( 
	"methodname" => "ocicolumnisnull", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "bool ocicolumnisnull ( resource stmt, mixed col )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$col} )", 
	"desc" => "Test whether a result column is NULL", 
	"docurl" => "function.ocicolumnisnull.html" 
),
"ocicolumnname" => array( 
	"methodname" => "ocicolumnname", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "string ocicolumnname ( resource stmt, int col )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$col} )", 
	"desc" => "Returns the name of a column", 
	"docurl" => "function.ocicolumnname.html" 
),
"ocicolumnprecision" => array( 
	"methodname" => "ocicolumnprecision", 
	"version" => "PHP4, PHP5", 
	"method" => "int ocicolumnprecision ( resource stmt, int col )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$col} )", 
	"desc" => "Tell the precision of a column", 
	"docurl" => "function.ocicolumnprecision.html" 
),
"ocicolumnscale" => array( 
	"methodname" => "ocicolumnscale", 
	"version" => "PHP4, PHP5", 
	"method" => "int ocicolumnscale ( resource stmt, int col )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$col} )", 
	"desc" => "Tell the scale of a column", 
	"docurl" => "function.ocicolumnscale.html" 
),
"ocicolumnsize" => array( 
	"methodname" => "ocicolumnsize", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ocicolumnsize ( resource stmt, mixed column )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$column} )", 
	"desc" => "Return result column size", 
	"docurl" => "function.ocicolumnsize.html" 
),
"ocicolumntype" => array( 
	"methodname" => "ocicolumntype", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "mixed ocicolumntype ( resource stmt, int col )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$col} )", 
	"desc" => "Returns the data type of a column", 
	"docurl" => "function.ocicolumntype.html" 
),
"ocicolumntyperaw" => array( 
	"methodname" => "ocicolumntyperaw", 
	"version" => "PHP4, PHP5", 
	"method" => "int ocicolumntyperaw ( resource stmt, int col )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$col} )", 
	"desc" => "Tell the raw oracle data type of a column", 
	"docurl" => "function.ocicolumntyperaw.html" 
),
"ocicommit" => array( 
	"methodname" => "ocicommit", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool ocicommit ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Commits outstanding transactions", 
	"docurl" => "function.ocicommit.html" 
),
"ocidefinebyname" => array( 
	"methodname" => "ocidefinebyname", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool ocidefinebyname ( resource stmt, string column_name, mixed &variable [, int type] )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$column_name}, \${3:\$variable} )", 
	"desc" => "Use a PHP variable for the define-step during a SELECT", 
	"docurl" => "function.ocidefinebyname.html" 
),
"ocierror" => array( 
	"methodname" => "ocierror", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "array ocierror ( [resource stmt_or_conn_or_global] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Return the last error of stmt|conn|global", 
	"docurl" => "function.ocierror.html" 
),
"ociexecute" => array( 
	"methodname" => "ociexecute", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "bool ociexecute ( resource stmt [, int mode] )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Execute a statement", 
	"docurl" => "function.ociexecute.html" 
),
"ocifetch" => array( 
	"methodname" => "ocifetch", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "bool ocifetch ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Fetches the next row into result-buffer", 
	"docurl" => "function.ocifetch.html" 
),
"ocifetchinto" => array( 
	"methodname" => "ocifetchinto", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ocifetchinto ( resource statement, array &result [, int mode] )", 
	"snippet" => "( \${1:\$statement}, \${2:\$result} )", 
	"desc" => "Fetches the next row into an array", 
	"docurl" => "function.ocifetchinto.html" 
),
"ocifetchstatement" => array( 
	"methodname" => "ocifetchstatement", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "int ocifetchstatement ( resource stmt, array &output [, int skip [, int maxrows [, int flags]]] )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$output} )", 
	"desc" => "Fetch all rows of result data into an array", 
	"docurl" => "function.ocifetchstatement.html" 
),
"ocifreecollection" => array( 
	"methodname" => "ocifreecollection", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool ocifreecollection ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Deletes collection object", 
	"docurl" => "function.ocifreecollection.html" 
),
"ocifreecursor" => array( 
	"methodname" => "ocifreecursor", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool ocifreecursor ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Free all resources associated with a cursor", 
	"docurl" => "function.ocifreecursor.html" 
),
"ocifreedesc" => array( 
	"methodname" => "ocifreedesc", 
	"version" => "PHP4, PHP5", 
	"method" => "bool ocifreedesc ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Deletes a large object descriptor", 
	"docurl" => "function.ocifreedesc.html" 
),
"ocifreestatement" => array( 
	"methodname" => "ocifreestatement", 
	"version" => "PHP3>= 3.0.5, PHP4, PHP5", 
	"method" => "bool ocifreestatement ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Free all resources associated with a statement", 
	"docurl" => "function.ocifreestatement.html" 
),
"ocigetbufferinglob" => array( 
	"methodname" => "ocigetbufferinglob", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;getBuffering ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.ocigetbufferinglob.html" 
),
"ociinternaldebug" => array( 
	"methodname" => "ociinternaldebug", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "void ociinternaldebug ( int onoff )", 
	"snippet" => "( \${1:\$onoff} )", 
	"desc" => "Enables or disables internal debug output", 
	"docurl" => "function.ociinternaldebug.html" 
),
"ociloadlob" => array( 
	"methodname" => "ociloadlob", 
	"version" => "PHP4, PHP5", 
	"method" => "string ociloadlob ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Loads a large object", 
	"docurl" => "function.ociloadlob.html" 
),
"ocilogoff" => array( 
	"methodname" => "ocilogoff", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "bool ocilogoff ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Disconnects from Oracle server", 
	"docurl" => "function.ocilogoff.html" 
),
"ocilogon" => array( 
	"methodname" => "ocilogon", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "resource ocilogon ( string username, string password [, string db [, string charset]] )", 
	"snippet" => "( \${1:\$username}, \${2:\$password} )", 
	"desc" => "Establishes a connection to Oracle", 
	"docurl" => "function.ocilogon.html" 
),
"ocinewcollection" => array( 
	"methodname" => "ocinewcollection", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "OCI-Collection ocinewcollection ( resource connection, string tdo [, string schema] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$tdo} )", 
	"desc" => "Initialize a new collection", 
	"docurl" => "function.ocinewcollection.html" 
),
"ocinewcursor" => array( 
	"methodname" => "ocinewcursor", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "resource ocinewcursor ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Return a new cursor (Statement-Handle)", 
	"docurl" => "function.ocinewcursor.html" 
),
"ocinewdescriptor" => array( 
	"methodname" => "ocinewdescriptor", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "OCI-Lob ocinewdescriptor ( resource connection [, int type] )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Initialize a new empty LOB or FILE descriptor", 
	"docurl" => "function.ocinewdescriptor.html" 
),
"ocinlogon" => array( 
	"methodname" => "ocinlogon", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "resource ocinlogon ( string username, string password [, string db [, string charset]] )", 
	"snippet" => "( \${1:\$username}, \${2:\$password} )", 
	"desc" => "Establishes a new connection to Oracle", 
	"docurl" => "function.ocinlogon.html" 
),
"ocinumcols" => array( 
	"methodname" => "ocinumcols", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ocinumcols ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Return the number of result columns in a statement", 
	"docurl" => "function.ocinumcols.html" 
),
"ociparse" => array( 
	"methodname" => "ociparse", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "resource ociparse ( resource conn, string query )", 
	"snippet" => "( \${1:\$conn}, \${2:\$query} )", 
	"desc" => "Parse a query and return an Oracle statement", 
	"docurl" => "function.ociparse.html" 
),
"ociplogon" => array( 
	"methodname" => "ociplogon", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "resource ociplogon ( string username, string password [, string db [, string charset]] )", 
	"snippet" => "( \${1:\$username}, \${2:\$password} )", 
	"desc" => "Connect to an Oracle database using a persistent connection", 
	"docurl" => "function.ociplogon.html" 
),
"ociresult" => array( 
	"methodname" => "ociresult", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "mixed ociresult ( resource statement, mixed col )", 
	"snippet" => "( \${1:\$statement}, \${2:\$col} )", 
	"desc" => "Returns column value for fetched row", 
	"docurl" => "function.ociresult.html" 
),
"ocirollback" => array( 
	"methodname" => "ocirollback", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool ocirollback ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Rolls back outstanding transactions", 
	"docurl" => "function.ocirollback.html" 
),
"ocirowcount" => array( 
	"methodname" => "ocirowcount", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int ocirowcount ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Gets the number of affected rows", 
	"docurl" => "function.ocirowcount.html" 
),
"ocisavelob" => array( 
	"methodname" => "ocisavelob", 
	"version" => "PHP4, PHP5", 
	"method" => "bool ocisavelob ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Saves a large object", 
	"docurl" => "function.ocisavelob.html" 
),
"ocisavelobfile" => array( 
	"methodname" => "ocisavelobfile", 
	"version" => "PHP4, PHP5", 
	"method" => "bool ocisavelobfile ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Saves a large object file", 
	"docurl" => "function.ocisavelobfile.html" 
),
"ociserverversion" => array( 
	"methodname" => "ociserverversion", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "string ociserverversion ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Return a string containing server version   information", 
	"docurl" => "function.ociserverversion.html" 
),
"ocisetbufferinglob" => array( 
	"methodname" => "ocisetbufferinglob", 
	"version" => "undefined", 
	"method" => "bool lob-&#62;setBuffering ( bool on_off )", 
	"snippet" => "( \${1:\$on_off} )", 
	"desc" => "", 
	"docurl" => "function.ocisetbufferinglob.html" 
),
"ocisetprefetch" => array( 
	"methodname" => "ocisetprefetch", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "bool ocisetprefetch ( resource stmt, int rows )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$rows} )", 
	"desc" => "Sets number of rows to be prefetched", 
	"docurl" => "function.ocisetprefetch.html" 
),
"ocistatementtype" => array( 
	"methodname" => "ocistatementtype", 
	"version" => "PHP3>= 3.0.5, PHP4, PHP5", 
	"method" => "string ocistatementtype ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Return the type of an OCI statement", 
	"docurl" => "function.ocistatementtype.html" 
),
"ociwritelobtofile" => array( 
	"methodname" => "ociwritelobtofile", 
	"version" => "PHP4, PHP5", 
	"method" => "bool ociwritelobtofile ( [string filename [, int start [, int length]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Saves a large object file", 
	"docurl" => "function.ociwritelobtofile.html" 
),
"ociwritetemporarylob" => array( 
	"methodname" => "ociwritetemporarylob", 
	"version" => "undefined", 
	"method" => "bool ociwritetemporarylob ( string var [, int lob_type] )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "", 
	"docurl" => "function.ociwritetemporarylob.html" 
),
"octdec" => array( 
	"methodname" => "octdec", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "number octdec ( string octal_string )", 
	"snippet" => "( \${1:\$octal_string} )", 
	"desc" => "Octal to decimal", 
	"docurl" => "function.octdec.html" 
),
"odbc_autocommit" => array( 
	"methodname" => "odbc_autocommit", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool odbc_autocommit ( resource connection_id [, bool OnOff] )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Toggle autocommit behaviour", 
	"docurl" => "function.odbc-autocommit.html" 
),
"odbc_binmode" => array( 
	"methodname" => "odbc_binmode", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool odbc_binmode ( resource result_id, int mode )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$mode} )", 
	"desc" => "Handling of binary column data", 
	"docurl" => "function.odbc-binmode.html" 
),
"odbc_close_all" => array( 
	"methodname" => "odbc_close_all", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "void odbc_close_all ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Close all ODBC connections", 
	"docurl" => "function.odbc-close-all.html" 
),
"odbc_close" => array( 
	"methodname" => "odbc_close", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "void odbc_close ( resource connection_id )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Close an ODBC connection", 
	"docurl" => "function.odbc-close.html" 
),
"odbc_columnprivileges" => array( 
	"methodname" => "odbc_columnprivileges", 
	"version" => "PHP4, PHP5", 
	"method" => "resource odbc_columnprivileges ( resource connection_id, string qualifier, string owner, string table_name, string column_name )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$qualifier}, \${3:\$owner}, \${4:\$table_name}, \${5:\$column_name} )", 
	"desc" => "Returns a result identifier that can be used to fetch a list of   columns and associated privileges", 
	"docurl" => "function.odbc-columnprivileges.html" 
),
"odbc_columns" => array( 
	"methodname" => "odbc_columns", 
	"version" => "PHP4, PHP5", 
	"method" => "resource odbc_columns ( resource connection_id [, string qualifier [, string schema [, string table_name [, string column_name]]]] )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Lists the column names in specified tables", 
	"docurl" => "function.odbc-columns.html" 
),
"odbc_commit" => array( 
	"methodname" => "odbc_commit", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool odbc_commit ( resource connection_id )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Commit an ODBC transaction", 
	"docurl" => "function.odbc-commit.html" 
),
"odbc_connect" => array( 
	"methodname" => "odbc_connect", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource odbc_connect ( string dsn, string user, string password [, int cursor_type] )", 
	"snippet" => "( \${1:\$dsn}, \${2:\$user}, \${3:\$password} )", 
	"desc" => "Connect to a datasource", 
	"docurl" => "function.odbc-connect.html" 
),
"odbc_cursor" => array( 
	"methodname" => "odbc_cursor", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string odbc_cursor ( resource result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Get cursorname", 
	"docurl" => "function.odbc-cursor.html" 
),
"odbc_data_source" => array( 
	"methodname" => "odbc_data_source", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array odbc_data_source ( resource connection_id, int fetch_type )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$fetch_type} )", 
	"desc" => "Returns information about a current connection", 
	"docurl" => "function.odbc-data-source.html" 
),
"odbc_do" => array( 
	"methodname" => "odbc_do", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource odbc_do ( resource conn_id, string query )", 
	"snippet" => "( \${1:\$conn_id}, \${2:\$query} )", 
	"desc" => "Synonym for odbc_exec()", 
	"docurl" => "function.odbc-do.html" 
),
"odbc_error" => array( 
	"methodname" => "odbc_error", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string odbc_error ( [resource connection_id] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get the last error code", 
	"docurl" => "function.odbc-error.html" 
),
"odbc_errormsg" => array( 
	"methodname" => "odbc_errormsg", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string odbc_errormsg ( [resource connection_id] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get the last error message", 
	"docurl" => "function.odbc-errormsg.html" 
),
"odbc_exec" => array( 
	"methodname" => "odbc_exec", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource odbc_exec ( resource connection_id, string query_string [, int flags] )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$query_string} )", 
	"desc" => "Prepare and execute a SQL statement", 
	"docurl" => "function.odbc-exec.html" 
),
"odbc_execute" => array( 
	"methodname" => "odbc_execute", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool odbc_execute ( resource result_id [, array parameters_array] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Execute a prepared statement", 
	"docurl" => "function.odbc-execute.html" 
),
"odbc_fetch_array" => array( 
	"methodname" => "odbc_fetch_array", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "array odbc_fetch_array ( resource result [, int rownumber] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an associative array", 
	"docurl" => "function.odbc-fetch-array.html" 
),
"odbc_fetch_into" => array( 
	"methodname" => "odbc_fetch_into", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int odbc_fetch_into ( resource result_id, array &result_array [, int rownumber] )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$result_array} )", 
	"desc" => "Fetch one result row into array", 
	"docurl" => "function.odbc-fetch-into.html" 
),
"odbc_fetch_object" => array( 
	"methodname" => "odbc_fetch_object", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "object odbc_fetch_object ( resource result [, int rownumber] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an object", 
	"docurl" => "function.odbc-fetch-object.html" 
),
"odbc_fetch_row" => array( 
	"methodname" => "odbc_fetch_row", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool odbc_fetch_row ( resource result_id [, int row_number] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Fetch a row", 
	"docurl" => "function.odbc-fetch-row.html" 
),
"odbc_field_len" => array( 
	"methodname" => "odbc_field_len", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int odbc_field_len ( resource result_id, int field_number )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field_number} )", 
	"desc" => "Get the length (precision) of a field", 
	"docurl" => "function.odbc-field-len.html" 
),
"odbc_field_name" => array( 
	"methodname" => "odbc_field_name", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string odbc_field_name ( resource result_id, int field_number )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field_number} )", 
	"desc" => "Get the columnname", 
	"docurl" => "function.odbc-field-name.html" 
),
"odbc_field_num" => array( 
	"methodname" => "odbc_field_num", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int odbc_field_num ( resource result_id, string field_name )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field_name} )", 
	"desc" => "Return column number", 
	"docurl" => "function.odbc-field-num.html" 
),
"odbc_field_precision" => array( 
	"methodname" => "odbc_field_precision", 
	"version" => "PHP4, PHP5", 
	"method" => "int odbc_field_precision ( resource result_id, int field_number )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field_number} )", 
	"desc" => "Synonym for odbc_field_len()", 
	"docurl" => "function.odbc-field-precision.html" 
),
"odbc_field_scale" => array( 
	"methodname" => "odbc_field_scale", 
	"version" => "PHP4, PHP5", 
	"method" => "int odbc_field_scale ( resource result_id, int field_number )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field_number} )", 
	"desc" => "Get the scale of a field", 
	"docurl" => "function.odbc-field-scale.html" 
),
"odbc_field_type" => array( 
	"methodname" => "odbc_field_type", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string odbc_field_type ( resource result_id, int field_number )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field_number} )", 
	"desc" => "Datatype of a field", 
	"docurl" => "function.odbc-field-type.html" 
),
"odbc_foreignkeys" => array( 
	"methodname" => "odbc_foreignkeys", 
	"version" => "PHP4, PHP5", 
	"method" => "resource odbc_foreignkeys ( resource connection_id, string pk_qualifier, string pk_owner, string pk_table, string fk_qualifier, string fk_owner, string fk_table )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$pk_qualifier}, \${3:\$pk_owner}, \${4:\$pk_table}, \${5:\$fk_qualifier}, \${6:\$fk_owner}, \${7:\$fk_table} )", 
	"desc" => "Returns a list of foreign keys in the specified table or a list   of foreign keys in other tables that refer to the primary key in   the specified table", 
	"docurl" => "function.odbc-foreignkeys.html" 
),
"odbc_free_result" => array( 
	"methodname" => "odbc_free_result", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool odbc_free_result ( resource result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Free resources associated with a result", 
	"docurl" => "function.odbc-free-result.html" 
),
"odbc_gettypeinfo" => array( 
	"methodname" => "odbc_gettypeinfo", 
	"version" => "PHP4, PHP5", 
	"method" => "resource odbc_gettypeinfo ( resource connection_id [, int data_type] )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Returns a result identifier containing information about data   types supported by the data source", 
	"docurl" => "function.odbc-gettypeinfo.html" 
),
"odbc_longreadlen" => array( 
	"methodname" => "odbc_longreadlen", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool odbc_longreadlen ( resource result_id, int length )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$length} )", 
	"desc" => "Handling of LONG columns", 
	"docurl" => "function.odbc-longreadlen.html" 
),
"odbc_next_result" => array( 
	"methodname" => "odbc_next_result", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool odbc_next_result ( resource result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Checks if multiple results are available", 
	"docurl" => "function.odbc-next-result.html" 
),
"odbc_num_fields" => array( 
	"methodname" => "odbc_num_fields", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int odbc_num_fields ( resource result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Number of columns in a result", 
	"docurl" => "function.odbc-num-fields.html" 
),
"odbc_num_rows" => array( 
	"methodname" => "odbc_num_rows", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int odbc_num_rows ( resource result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Number of rows in a result", 
	"docurl" => "function.odbc-num-rows.html" 
),
"odbc_pconnect" => array( 
	"methodname" => "odbc_pconnect", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource odbc_pconnect ( string dsn, string user, string password [, int cursor_type] )", 
	"snippet" => "( \${1:\$dsn}, \${2:\$user}, \${3:\$password} )", 
	"desc" => "Open a persistent database connection", 
	"docurl" => "function.odbc-pconnect.html" 
),
"odbc_prepare" => array( 
	"methodname" => "odbc_prepare", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource odbc_prepare ( resource connection_id, string query_string )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$query_string} )", 
	"desc" => "Prepares a statement for execution", 
	"docurl" => "function.odbc-prepare.html" 
),
"odbc_primarykeys" => array( 
	"methodname" => "odbc_primarykeys", 
	"version" => "PHP4, PHP5", 
	"method" => "resource odbc_primarykeys ( resource connection_id, string qualifier, string owner, string table )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$qualifier}, \${3:\$owner}, \${4:\$table} )", 
	"desc" => "Returns a result identifier that can be used to fetch the column   names that comprise the primary key for a table", 
	"docurl" => "function.odbc-primarykeys.html" 
),
"odbc_procedurecolumns" => array( 
	"methodname" => "odbc_procedurecolumns", 
	"version" => "PHP4, PHP5", 
	"method" => "resource odbc_procedurecolumns ( resource connection_id [, string qualifier, string owner, string proc, string column] )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Retrieve information about parameters to procedures", 
	"docurl" => "function.odbc-procedurecolumns.html" 
),
"odbc_procedures" => array( 
	"methodname" => "odbc_procedures", 
	"version" => "PHP4, PHP5", 
	"method" => "resource odbc_procedures ( resource connection_id [, string qualifier, string owner, string name] )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Get the list of procedures stored in a specific data source", 
	"docurl" => "function.odbc-procedures.html" 
),
"odbc_result_all" => array( 
	"methodname" => "odbc_result_all", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int odbc_result_all ( resource result_id [, string format] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Print result as HTML table", 
	"docurl" => "function.odbc-result-all.html" 
),
"odbc_result" => array( 
	"methodname" => "odbc_result", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string odbc_result ( resource result_id, mixed field )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field} )", 
	"desc" => "Get result data", 
	"docurl" => "function.odbc-result.html" 
),
"odbc_rollback" => array( 
	"methodname" => "odbc_rollback", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool odbc_rollback ( resource connection_id )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Rollback a transaction", 
	"docurl" => "function.odbc-rollback.html" 
),
"odbc_setoption" => array( 
	"methodname" => "odbc_setoption", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool odbc_setoption ( resource id, int function, int option, int param )", 
	"snippet" => "( \${1:\$id}, \${2:\$function}, \${3:\$option}, \${4:\$param} )", 
	"desc" => "Adjust ODBC settings", 
	"docurl" => "function.odbc-setoption.html" 
),
"odbc_specialcolumns" => array( 
	"methodname" => "odbc_specialcolumns", 
	"version" => "PHP4, PHP5", 
	"method" => "resource odbc_specialcolumns ( resource connection_id, int type, string qualifier, string owner, string table, int scope, int nullable )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$type}, \${3:\$qualifier}, \${4:\$owner}, \${5:\$table}, \${6:\$scope}, \${7:\$nullable} )", 
	"desc" => "Returns either the optimal set of columns that uniquely   identifies a row in the table or columns that are automatically   updated when any value in the row is updated by a transaction", 
	"docurl" => "function.odbc-specialcolumns.html" 
),
"odbc_statistics" => array( 
	"methodname" => "odbc_statistics", 
	"version" => "PHP4, PHP5", 
	"method" => "resource odbc_statistics ( resource connection_id, string qualifier, string owner, string table_name, int unique, int accuracy )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$qualifier}, \${3:\$owner}, \${4:\$table_name}, \${5:\$unique}, \${6:\$accuracy} )", 
	"desc" => "Retrieve statistics about a table", 
	"docurl" => "function.odbc-statistics.html" 
),
"odbc_tableprivileges" => array( 
	"methodname" => "odbc_tableprivileges", 
	"version" => "PHP4, PHP5", 
	"method" => "resource odbc_tableprivileges ( resource connection_id, string qualifier, string owner, string name )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$qualifier}, \${3:\$owner}, \${4:\$name} )", 
	"desc" => "Lists tables and the privileges associated with each table", 
	"docurl" => "function.odbc-tableprivileges.html" 
),
"odbc_tables" => array( 
	"methodname" => "odbc_tables", 
	"version" => "PHP3>= 3.0.17, PHP4, PHP5", 
	"method" => "resource odbc_tables ( resource connection_id [, string qualifier [, string owner [, string name [, string types]]]] )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Get the list of table names stored in a specific data source", 
	"docurl" => "function.odbc-tables.html" 
),
"openal_buffer_create" => array( 
	"methodname" => "openal_buffer_create", 
	"version" => "undefined", 
	"method" => "resource openal_buffer_create ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.openal-buffer-create.html" 
),
"openal_buffer_data" => array( 
	"methodname" => "openal_buffer_data", 
	"version" => "undefined", 
	"method" => "bool openal_buffer_data ( resource buffer, int format, string data, int freq )", 
	"snippet" => "( \${1:\$buffer}, \${2:\$format}, \${3:\$data}, \${4:\$freq} )", 
	"desc" => "", 
	"docurl" => "function.openal-buffer-data.html" 
),
"openal_buffer_destroy" => array( 
	"methodname" => "openal_buffer_destroy", 
	"version" => "undefined", 
	"method" => "bool openal_buffer_destroy ( resource buffer )", 
	"snippet" => "( \${1:\$buffer} )", 
	"desc" => "", 
	"docurl" => "function.openal-buffer-destroy.html" 
),
"openal_buffer_get" => array( 
	"methodname" => "openal_buffer_get", 
	"version" => "undefined", 
	"method" => "int openal_buffer_get ( resource buffer, int property )", 
	"snippet" => "( \${1:\$buffer}, \${2:\$property} )", 
	"desc" => "", 
	"docurl" => "function.openal-buffer-get.html" 
),
"openal_buffer_loadwav" => array( 
	"methodname" => "openal_buffer_loadwav", 
	"version" => "undefined", 
	"method" => "bool openal_buffer_loadwav ( resource buffer, string wavfile )", 
	"snippet" => "( \${1:\$buffer}, \${2:\$wavfile} )", 
	"desc" => "", 
	"docurl" => "function.openal-buffer-loadwav.html" 
),
"openal_context_create" => array( 
	"methodname" => "openal_context_create", 
	"version" => "undefined", 
	"method" => "resource openal_context_create ( resource device )", 
	"snippet" => "( \${1:\$device} )", 
	"desc" => "", 
	"docurl" => "function.openal-context-create.html" 
),
"openal_context_current" => array( 
	"methodname" => "openal_context_current", 
	"version" => "undefined", 
	"method" => "bool openal_context_current ( resource context )", 
	"snippet" => "( \${1:\$context} )", 
	"desc" => "", 
	"docurl" => "function.openal-context-current.html" 
),
"openal_context_destroy" => array( 
	"methodname" => "openal_context_destroy", 
	"version" => "undefined", 
	"method" => "bool openal_context_destroy ( resource context )", 
	"snippet" => "( \${1:\$context} )", 
	"desc" => "", 
	"docurl" => "function.openal-context-destroy.html" 
),
"openal_context_process" => array( 
	"methodname" => "openal_context_process", 
	"version" => "undefined", 
	"method" => "bool openal_context_process ( resource context )", 
	"snippet" => "( \${1:\$context} )", 
	"desc" => "", 
	"docurl" => "function.openal-context-process.html" 
),
"openal_context_suspend" => array( 
	"methodname" => "openal_context_suspend", 
	"version" => "undefined", 
	"method" => "bool openal_context_suspend ( resource context )", 
	"snippet" => "( \${1:\$context} )", 
	"desc" => "", 
	"docurl" => "function.openal-context-suspend.html" 
),
"openal_device_close" => array( 
	"methodname" => "openal_device_close", 
	"version" => "undefined", 
	"method" => "bool openal_device_close ( resource device )", 
	"snippet" => "( \${1:\$device} )", 
	"desc" => "", 
	"docurl" => "function.openal-device-close.html" 
),
"openal_device_open" => array( 
	"methodname" => "openal_device_open", 
	"version" => "undefined", 
	"method" => "resource openal_device_open ( [string device_desc] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.openal-device-open.html" 
),
"openal_listener_get" => array( 
	"methodname" => "openal_listener_get", 
	"version" => "undefined", 
	"method" => "mixed openal_listener_get ( int property )", 
	"snippet" => "( \${1:\$property} )", 
	"desc" => "", 
	"docurl" => "function.openal-listener-get.html" 
),
"openal_listener_set" => array( 
	"methodname" => "openal_listener_set", 
	"version" => "undefined", 
	"method" => "bool openal_listener_set ( int property, mixed setting )", 
	"snippet" => "( \${1:\$property}, \${2:\$setting} )", 
	"desc" => "", 
	"docurl" => "function.openal-listener-set.html" 
),
"openal_source_create" => array( 
	"methodname" => "openal_source_create", 
	"version" => "undefined", 
	"method" => "resource openal_source_create ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.openal-source-create.html" 
),
"openal_source_destroy" => array( 
	"methodname" => "openal_source_destroy", 
	"version" => "undefined", 
	"method" => "resource openal_source_destroy ( resource source )", 
	"snippet" => "( \${1:\$source} )", 
	"desc" => "", 
	"docurl" => "function.openal-source-destroy.html" 
),
"openal_source_get" => array( 
	"methodname" => "openal_source_get", 
	"version" => "undefined", 
	"method" => "mixed openal_source_get ( resource source, int property )", 
	"snippet" => "( \${1:\$source}, \${2:\$property} )", 
	"desc" => "", 
	"docurl" => "function.openal-source-get.html" 
),
"openal_source_pause" => array( 
	"methodname" => "openal_source_pause", 
	"version" => "undefined", 
	"method" => "bool openal_source_pause ( resource source )", 
	"snippet" => "( \${1:\$source} )", 
	"desc" => "", 
	"docurl" => "function.openal-source-pause.html" 
),
"openal_source_play" => array( 
	"methodname" => "openal_source_play", 
	"version" => "undefined", 
	"method" => "bool openal_source_play ( resource source )", 
	"snippet" => "( \${1:\$source} )", 
	"desc" => "", 
	"docurl" => "function.openal-source-play.html" 
),
"openal_source_rewind" => array( 
	"methodname" => "openal_source_rewind", 
	"version" => "undefined", 
	"method" => "bool openal_source_rewind ( resource source )", 
	"snippet" => "( \${1:\$source} )", 
	"desc" => "", 
	"docurl" => "function.openal-source-rewind.html" 
),
"openal_source_set" => array( 
	"methodname" => "openal_source_set", 
	"version" => "undefined", 
	"method" => "bool openal_source_set ( resource source, int property, mixed setting )", 
	"snippet" => "( \${1:\$source}, \${2:\$property}, \${3:\$setting} )", 
	"desc" => "", 
	"docurl" => "function.openal-source-set.html" 
),
"openal_source_stop" => array( 
	"methodname" => "openal_source_stop", 
	"version" => "undefined", 
	"method" => "bool openal_source_stop ( resource source )", 
	"snippet" => "( \${1:\$source} )", 
	"desc" => "", 
	"docurl" => "function.openal-source-stop.html" 
),
"openal_stream" => array( 
	"methodname" => "openal_stream", 
	"version" => "undefined", 
	"method" => "resource openal_stream ( resource source, int format, int rate )", 
	"snippet" => "( \${1:\$source}, \${2:\$format}, \${3:\$rate} )", 
	"desc" => "", 
	"docurl" => "function.openal-stream.html" 
),
"opendir" => array( 
	"methodname" => "opendir", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource opendir ( string path )", 
	"snippet" => "( \${1:\$path} )", 
	"desc" => "Open directory handle", 
	"docurl" => "function.opendir.html" 
),
"openlog" => array( 
	"methodname" => "openlog", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int openlog ( string ident, int option, int facility )", 
	"snippet" => "( \${1:\$ident}, \${2:\$option}, \${3:\$facility} )", 
	"desc" => "Open connection to system logger", 
	"docurl" => "function.openlog.html" 
),
"openssl_csr_export_to_file" => array( 
	"methodname" => "openssl_csr_export_to_file", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool openssl_csr_export_to_file ( resource csr, string outfilename [, bool notext] )", 
	"snippet" => "( \${1:\$csr}, \${2:\$outfilename} )", 
	"desc" => "Exports a CSR to a file", 
	"docurl" => "function.openssl-csr-export-to-file.html" 
),
"openssl_csr_export" => array( 
	"methodname" => "openssl_csr_export", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool openssl_csr_export ( resource csr, string &out [, bool notext] )", 
	"snippet" => "( \${1:\$csr}, \${2:\$out} )", 
	"desc" => "Exports a CSR as a string", 
	"docurl" => "function.openssl-csr-export.html" 
),
"openssl_csr_new" => array( 
	"methodname" => "openssl_csr_new", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool openssl_csr_new ( array dn, resource &privkey [, array configargs [, array extraattribs]] )", 
	"snippet" => "( \${1:\$dn}, \${2:\$privkey} )", 
	"desc" => "Generates a CSR", 
	"docurl" => "function.openssl-csr-new.html" 
),
"openssl_csr_sign" => array( 
	"methodname" => "openssl_csr_sign", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "resource openssl_csr_sign ( mixed csr, mixed cacert, mixed priv_key, int days [, array configargs [, int serial]] )", 
	"snippet" => "( \${1:\$csr}, \${2:\$cacert}, \${3:\$priv_key}, \${4:\$days} )", 
	"desc" => "Sign a CSR with another certificate (or itself) and generate a certificate", 
	"docurl" => "function.openssl-csr-sign.html" 
),
"openssl_error_string" => array( 
	"methodname" => "openssl_error_string", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "mixed openssl_error_string ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return openSSL error message", 
	"docurl" => "function.openssl-error-string.html" 
),
"openssl_free_key" => array( 
	"methodname" => "openssl_free_key", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "void openssl_free_key ( resource key_identifier )", 
	"snippet" => "( \${1:\$key_identifier} )", 
	"desc" => "Free key resource", 
	"docurl" => "function.openssl-free-key.html" 
),
"openssl_get_privatekey" => array( 
	"methodname" => "openssl_get_privatekey", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource openssl_get_privatekey ( mixed key [, string passphrase] )", 
	"snippet" => "( \${1:\$key} )", 
	"desc" => "Get a private key", 
	"docurl" => "function.openssl-get-privatekey.html" 
),
"openssl_get_publickey" => array( 
	"methodname" => "openssl_get_publickey", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource openssl_get_publickey ( mixed certificate )", 
	"snippet" => "( \${1:\$certificate} )", 
	"desc" => "Extract public key from certificate and prepare it for use", 
	"docurl" => "function.openssl-get-publickey.html" 
),
"openssl_open" => array( 
	"methodname" => "openssl_open", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool openssl_open ( string sealed_data, string &open_data, string env_key, mixed priv_key_id )", 
	"snippet" => "( \${1:\$sealed_data}, \${2:\$open_data}, \${3:\$env_key}, \${4:\$priv_key_id} )", 
	"desc" => "Open sealed data", 
	"docurl" => "function.openssl-open.html" 
),
"openssl_pkcs7_decrypt" => array( 
	"methodname" => "openssl_pkcs7_decrypt", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool openssl_pkcs7_decrypt ( string infilename, string outfilename, mixed recipcert [, mixed recipkey] )", 
	"snippet" => "( \${1:\$infilename}, \${2:\$outfilename}, \${3:\$recipcert} )", 
	"desc" => "Decrypts an S/MIME encrypted message", 
	"docurl" => "function.openssl-pkcs7-decrypt.html" 
),
"openssl_pkcs7_encrypt" => array( 
	"methodname" => "openssl_pkcs7_encrypt", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool openssl_pkcs7_encrypt ( string infile, string outfile, mixed recipcerts, array headers [, int flags [, int cipherid]] )", 
	"snippet" => "( \${1:\$infile}, \${2:\$outfile}, \${3:\$recipcerts}, \${4:\$headers} )", 
	"desc" => "Encrypt an S/MIME message", 
	"docurl" => "function.openssl-pkcs7-encrypt.html" 
),
"openssl_pkcs7_sign" => array( 
	"methodname" => "openssl_pkcs7_sign", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool openssl_pkcs7_sign ( string infilename, string outfilename, mixed signcert, mixed privkey, array headers [, int flags [, string extracerts]] )", 
	"snippet" => "( \${1:\$infilename}, \${2:\$outfilename}, \${3:\$signcert}, \${4:\$privkey}, \${5:\$headers} )", 
	"desc" => "Sign an S/MIME message", 
	"docurl" => "function.openssl-pkcs7-sign.html" 
),
"openssl_pkcs7_verify" => array( 
	"methodname" => "openssl_pkcs7_verify", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool openssl_pkcs7_verify ( string filename, int flags [, string outfilename [, array cainfo [, string extracerts]]] )", 
	"snippet" => "( \${1:\$filename}, \${2:\$flags} )", 
	"desc" => "Verifies the signature of an S/MIME signed message", 
	"docurl" => "function.openssl-pkcs7-verify.html" 
),
"openssl_pkey_export_to_file" => array( 
	"methodname" => "openssl_pkey_export_to_file", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool openssl_pkey_export_to_file ( mixed key, string outfilename [, string passphrase [, array configargs]] )", 
	"snippet" => "( \${1:\$key}, \${2:\$outfilename} )", 
	"desc" => "Gets an exportable representation of a key into a file", 
	"docurl" => "function.openssl-pkey-export-to-file.html" 
),
"openssl_pkey_export" => array( 
	"methodname" => "openssl_pkey_export", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool openssl_pkey_export ( mixed key, string &out [, string passphrase [, array configargs]] )", 
	"snippet" => "( \${1:\$key}, \${2:\$out} )", 
	"desc" => "Gets an exportable representation of a key into a string", 
	"docurl" => "function.openssl-pkey-export.html" 
),
"openssl_pkey_get_private" => array( 
	"methodname" => "openssl_pkey_get_private", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "resource openssl_pkey_get_private ( mixed key [, string passphrase] )", 
	"snippet" => "( \${1:\$key} )", 
	"desc" => "Get a private key", 
	"docurl" => "function.openssl-pkey-get-private.html" 
),
"openssl_pkey_get_public" => array( 
	"methodname" => "openssl_pkey_get_public", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "resource openssl_pkey_get_public ( mixed certificate )", 
	"snippet" => "( \${1:\$certificate} )", 
	"desc" => "Extract public key from certificate and prepare it for use", 
	"docurl" => "function.openssl-pkey-get-public.html" 
),
"openssl_pkey_new" => array( 
	"methodname" => "openssl_pkey_new", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "resource openssl_pkey_new ( [array configargs] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Generates a new private key", 
	"docurl" => "function.openssl-pkey-new.html" 
),
"openssl_private_decrypt" => array( 
	"methodname" => "openssl_private_decrypt", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool openssl_private_decrypt ( string data, string &decrypted, mixed key [, int padding] )", 
	"snippet" => "( \${1:\$data}, \${2:\$decrypted}, \${3:\$key} )", 
	"desc" => "Decrypts data with private key", 
	"docurl" => "function.openssl-private-decrypt.html" 
),
"openssl_private_encrypt" => array( 
	"methodname" => "openssl_private_encrypt", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool openssl_private_encrypt ( string data, string &crypted, mixed key [, int padding] )", 
	"snippet" => "( \${1:\$data}, \${2:\$crypted}, \${3:\$key} )", 
	"desc" => "Encrypts data with private key", 
	"docurl" => "function.openssl-private-encrypt.html" 
),
"openssl_public_decrypt" => array( 
	"methodname" => "openssl_public_decrypt", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool openssl_public_decrypt ( string data, string &decrypted, mixed key [, int padding] )", 
	"snippet" => "( \${1:\$data}, \${2:\$decrypted}, \${3:\$key} )", 
	"desc" => "Decrypts data with public key", 
	"docurl" => "function.openssl-public-decrypt.html" 
),
"openssl_public_encrypt" => array( 
	"methodname" => "openssl_public_encrypt", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool openssl_public_encrypt ( string data, string &crypted, mixed key [, int padding] )", 
	"snippet" => "( \${1:\$data}, \${2:\$crypted}, \${3:\$key} )", 
	"desc" => "Encrypts data with public key", 
	"docurl" => "function.openssl-public-encrypt.html" 
),
"openssl_seal" => array( 
	"methodname" => "openssl_seal", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int openssl_seal ( string data, string &sealed_data, array &env_keys, array pub_key_ids )", 
	"snippet" => "( \${1:\$data}, \${2:\$sealed_data}, \${3:\$env_keys}, \${4:\$pub_key_ids} )", 
	"desc" => "Seal (encrypt) data", 
	"docurl" => "function.openssl-seal.html" 
),
"openssl_sign" => array( 
	"methodname" => "openssl_sign", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool openssl_sign ( string data, string &signature, mixed priv_key_id [, int signature_alg] )", 
	"snippet" => "( \${1:\$data}, \${2:\$signature}, \${3:\$priv_key_id} )", 
	"desc" => "Generate signature", 
	"docurl" => "function.openssl-sign.html" 
),
"openssl_verify" => array( 
	"methodname" => "openssl_verify", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int openssl_verify ( string data, string signature, mixed pub_key_id )", 
	"snippet" => "( \${1:\$data}, \${2:\$signature}, \${3:\$pub_key_id} )", 
	"desc" => "Verify signature", 
	"docurl" => "function.openssl-verify.html" 
),
"openssl_x509_check_private_key" => array( 
	"methodname" => "openssl_x509_check_private_key", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool openssl_x509_check_private_key ( mixed cert, mixed key )", 
	"snippet" => "( \${1:\$cert}, \${2:\$key} )", 
	"desc" => "Checks if a private key corresponds to a certificate", 
	"docurl" => "function.openssl-x509-check-private-key.html" 
),
"openssl_x509_checkpurpose" => array( 
	"methodname" => "openssl_x509_checkpurpose", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool openssl_x509_checkpurpose ( mixed x509cert, int purpose [, array cainfo [, string untrustedfile]] )", 
	"snippet" => "( \${1:\$x509cert}, \${2:\$purpose} )", 
	"desc" => "Verifies if a certificate can be used for a particular  purpose", 
	"docurl" => "function.openssl-x509-checkpurpose.html" 
),
"openssl_x509_export_to_file" => array( 
	"methodname" => "openssl_x509_export_to_file", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool openssl_x509_export_to_file ( mixed x509, string outfilename [, bool notext] )", 
	"snippet" => "( \${1:\$x509}, \${2:\$outfilename} )", 
	"desc" => "Exports a certificate to file", 
	"docurl" => "function.openssl-x509-export-to-file.html" 
),
"openssl_x509_export" => array( 
	"methodname" => "openssl_x509_export", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool openssl_x509_export ( mixed x509, string &output [, bool notext] )", 
	"snippet" => "( \${1:\$x509}, \${2:\$output} )", 
	"desc" => "Exports a certificate as a string", 
	"docurl" => "function.openssl-x509-export.html" 
),
"openssl_x509_free" => array( 
	"methodname" => "openssl_x509_free", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "void openssl_x509_free ( resource x509cert )", 
	"snippet" => "( \${1:\$x509cert} )", 
	"desc" => "Free certificate resource", 
	"docurl" => "function.openssl-x509-free.html" 
),
"openssl_x509_parse" => array( 
	"methodname" => "openssl_x509_parse", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array openssl_x509_parse ( mixed x509cert [, bool shortnames] )", 
	"snippet" => "( \${1:\$x509cert} )", 
	"desc" => "Parse an X509 certificate and return the information as an  array", 
	"docurl" => "function.openssl-x509-parse.html" 
),
"openssl_x509_read" => array( 
	"methodname" => "openssl_x509_read", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "resource openssl_x509_read ( mixed x509certdata )", 
	"snippet" => "( \${1:\$x509certdata} )", 
	"desc" => "Parse an X.509 certificate and return a resource identifier for  it", 
	"docurl" => "function.openssl-x509-read.html" 
),
"ora_bind" => array( 
	"methodname" => "ora_bind", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ora_bind ( resource cursor, string PHP_variable_name, string SQL_parameter_name, int length [, int type] )", 
	"snippet" => "( \${1:\$cursor}, \${2:\$PHP_variable_name}, \${3:\$SQL_parameter_name}, \${4:\$length} )", 
	"desc" => "Binds a PHP variable to an Oracle parameter", 
	"docurl" => "function.ora-bind.html" 
),
"ora_close" => array( 
	"methodname" => "ora_close", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ora_close ( resource cursor )", 
	"snippet" => "( \${1:\$cursor} )", 
	"desc" => "Closes an Oracle cursor", 
	"docurl" => "function.ora-close.html" 
),
"ora_columnname" => array( 
	"methodname" => "ora_columnname", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string ora_columnname ( resource cursor, int column )", 
	"snippet" => "( \${1:\$cursor}, \${2:\$column} )", 
	"desc" => "Gets the name of an Oracle result column", 
	"docurl" => "function.ora-columnname.html" 
),
"ora_columnsize" => array( 
	"methodname" => "ora_columnsize", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int ora_columnsize ( resource cursor, int column )", 
	"snippet" => "( \${1:\$cursor}, \${2:\$column} )", 
	"desc" => "Returns the size of an Oracle result column", 
	"docurl" => "function.ora-columnsize.html" 
),
"ora_columntype" => array( 
	"methodname" => "ora_columntype", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string ora_columntype ( resource cursor, int column )", 
	"snippet" => "( \${1:\$cursor}, \${2:\$column} )", 
	"desc" => "Gets the type of an Oracle result column", 
	"docurl" => "function.ora-columntype.html" 
),
"ora_commit" => array( 
	"methodname" => "ora_commit", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ora_commit ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Commit an Oracle transaction", 
	"docurl" => "function.ora-commit.html" 
),
"ora_commitoff" => array( 
	"methodname" => "ora_commitoff", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ora_commitoff ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Disable automatic commit", 
	"docurl" => "function.ora-commitoff.html" 
),
"ora_commiton" => array( 
	"methodname" => "ora_commiton", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ora_commiton ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Enable automatic commit", 
	"docurl" => "function.ora-commiton.html" 
),
"ora_do" => array( 
	"methodname" => "ora_do", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource ora_do ( resource conn, string query )", 
	"snippet" => "( \${1:\$conn}, \${2:\$query} )", 
	"desc" => "Parse, Exec, Fetch", 
	"docurl" => "function.ora-do.html" 
),
"ora_error" => array( 
	"methodname" => "ora_error", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string ora_error ( [resource cursor_or_connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Gets an Oracle error message", 
	"docurl" => "function.ora-error.html" 
),
"ora_errorcode" => array( 
	"methodname" => "ora_errorcode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int ora_errorcode ( [resource cursor_or_connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Gets an Oracle error code", 
	"docurl" => "function.ora-errorcode.html" 
),
"ora_exec" => array( 
	"methodname" => "ora_exec", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ora_exec ( resource cursor )", 
	"snippet" => "( \${1:\$cursor} )", 
	"desc" => "Execute a parsed statement on an Oracle cursor", 
	"docurl" => "function.ora-exec.html" 
),
"ora_fetch_into" => array( 
	"methodname" => "ora_fetch_into", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int ora_fetch_into ( resource cursor, array &result [, int flags] )", 
	"snippet" => "( \${1:\$cursor}, \${2:\$result} )", 
	"desc" => "Fetch a row into the specified result array", 
	"docurl" => "function.ora-fetch-into.html" 
),
"ora_fetch" => array( 
	"methodname" => "ora_fetch", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ora_fetch ( resource cursor )", 
	"snippet" => "( \${1:\$cursor} )", 
	"desc" => "Fetch a row of data from a cursor", 
	"docurl" => "function.ora-fetch.html" 
),
"ora_getcolumn" => array( 
	"methodname" => "ora_getcolumn", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed ora_getcolumn ( resource cursor, int column )", 
	"snippet" => "( \${1:\$cursor}, \${2:\$column} )", 
	"desc" => "Get data from a fetched column", 
	"docurl" => "function.ora-getcolumn.html" 
),
"ora_logoff" => array( 
	"methodname" => "ora_logoff", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ora_logoff ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Close an Oracle connection", 
	"docurl" => "function.ora-logoff.html" 
),
"ora_logon" => array( 
	"methodname" => "ora_logon", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource ora_logon ( string user, string password )", 
	"snippet" => "( \${1:\$user}, \${2:\$password} )", 
	"desc" => "Open an Oracle connection", 
	"docurl" => "function.ora-logon.html" 
),
"ora_numcols" => array( 
	"methodname" => "ora_numcols", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int ora_numcols ( resource cursor )", 
	"snippet" => "( \${1:\$cursor} )", 
	"desc" => "Returns the number of columns", 
	"docurl" => "function.ora-numcols.html" 
),
"ora_numrows" => array( 
	"methodname" => "ora_numrows", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int ora_numrows ( resource cursor )", 
	"snippet" => "( \${1:\$cursor} )", 
	"desc" => "Returns the number of rows", 
	"docurl" => "function.ora-numrows.html" 
),
"ora_open" => array( 
	"methodname" => "ora_open", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource ora_open ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Opens an Oracle cursor", 
	"docurl" => "function.ora-open.html" 
),
"ora_parse" => array( 
	"methodname" => "ora_parse", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ora_parse ( resource cursor, string sql_statement [, int defer] )", 
	"snippet" => "( \${1:\$cursor}, \${2:\$sql_statement} )", 
	"desc" => "Parse an SQL statement with Oracle", 
	"docurl" => "function.ora-parse.html" 
),
"ora_plogon" => array( 
	"methodname" => "ora_plogon", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource ora_plogon ( string user, string password )", 
	"snippet" => "( \${1:\$user}, \${2:\$password} )", 
	"desc" => "Open a persistent Oracle connection", 
	"docurl" => "function.ora-plogon.html" 
),
"ora_rollback" => array( 
	"methodname" => "ora_rollback", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ora_rollback ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Rolls back a transaction", 
	"docurl" => "function.ora-rollback.html" 
),
"ord" => array( 
	"methodname" => "ord", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int ord ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Return ASCII value of character", 
	"docurl" => "function.ord.html" 
),
"output_add_rewrite_var" => array( 
	"methodname" => "output_add_rewrite_var", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool output_add_rewrite_var ( string name, string value )", 
	"snippet" => "( \${1:\$name}, \${2:\$value} )", 
	"desc" => "Add URL rewriter values", 
	"docurl" => "function.output-add-rewrite-var.html" 
),
"output_reset_rewrite_vars" => array( 
	"methodname" => "output_reset_rewrite_vars", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool output_reset_rewrite_vars ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Reset URL rewriter values", 
	"docurl" => "function.output-reset-rewrite-vars.html" 
),
"overload" => array( 
	"methodname" => "overload", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "void overload ( [string class_name] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Enable property and method call overloading for a class", 
	"docurl" => "function.overload.html" 
),
"override_function" => array( 
	"methodname" => "override_function", 
	"version" => "undefined", 
	"method" => "bool override_function ( string function_name, string function_args, string function_code )", 
	"snippet" => "( \${1:\$function_name}, \${2:\$function_args}, \${3:\$function_code} )", 
	"desc" => "", 
	"docurl" => "function.override-function.html" 
),
"ovrimos_close" => array( 
	"methodname" => "ovrimos_close", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "void ovrimos_close ( int connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Closes the connection to ovrimos", 
	"docurl" => "function.ovrimos-close.html" 
),
"ovrimos_commit" => array( 
	"methodname" => "ovrimos_commit", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool ovrimos_commit ( int connection_id )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Commits the transaction", 
	"docurl" => "function.ovrimos-commit.html" 
),
"ovrimos_connect" => array( 
	"methodname" => "ovrimos_connect", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "int ovrimos_connect ( string host, string db, string user, string password )", 
	"snippet" => "( \${1:\$host}, \${2:\$db}, \${3:\$user}, \${4:\$password} )", 
	"desc" => "Connect to the specified database", 
	"docurl" => "function.ovrimos-connect.html" 
),
"ovrimos_cursor" => array( 
	"methodname" => "ovrimos_cursor", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "string ovrimos_cursor ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Returns the name of the cursor", 
	"docurl" => "function.ovrimos-cursor.html" 
),
"ovrimos_exec" => array( 
	"methodname" => "ovrimos_exec", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "int ovrimos_exec ( int connection_id, string query )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$query} )", 
	"desc" => "Executes an SQL statement", 
	"docurl" => "function.ovrimos-exec.html" 
),
"ovrimos_execute" => array( 
	"methodname" => "ovrimos_execute", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool ovrimos_execute ( int result_id [, array parameters_array] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Executes a prepared SQL statement", 
	"docurl" => "function.ovrimos-execute.html" 
),
"ovrimos_fetch_into" => array( 
	"methodname" => "ovrimos_fetch_into", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool ovrimos_fetch_into ( int result_id, array &result_array [, string how [, int rownumber]] )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$result_array} )", 
	"desc" => "Fetches a row from the result set", 
	"docurl" => "function.ovrimos-fetch-into.html" 
),
"ovrimos_fetch_row" => array( 
	"methodname" => "ovrimos_fetch_row", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool ovrimos_fetch_row ( int result_id [, int how [, int row_number]] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Fetches a row from the result set", 
	"docurl" => "function.ovrimos-fetch-row.html" 
),
"ovrimos_field_len" => array( 
	"methodname" => "ovrimos_field_len", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "int ovrimos_field_len ( int result_id, int field_number )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field_number} )", 
	"desc" => "Returns the length of the output column", 
	"docurl" => "function.ovrimos-field-len.html" 
),
"ovrimos_field_name" => array( 
	"methodname" => "ovrimos_field_name", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "string ovrimos_field_name ( int result_id, int field_number )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field_number} )", 
	"desc" => "Returns the output column name", 
	"docurl" => "function.ovrimos-field-name.html" 
),
"ovrimos_field_num" => array( 
	"methodname" => "ovrimos_field_num", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "int ovrimos_field_num ( int result_id, string field_name )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field_name} )", 
	"desc" => "Returns the (1-based) index of the output column", 
	"docurl" => "function.ovrimos-field-num.html" 
),
"ovrimos_field_type" => array( 
	"methodname" => "ovrimos_field_type", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "int ovrimos_field_type ( int result_id, int field_number )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field_number} )", 
	"desc" => "Returns the (numeric) type of the output column", 
	"docurl" => "function.ovrimos-field-type.html" 
),
"ovrimos_free_result" => array( 
	"methodname" => "ovrimos_free_result", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool ovrimos_free_result ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Frees the specified result_id", 
	"docurl" => "function.ovrimos-free-result.html" 
),
"ovrimos_longreadlen" => array( 
	"methodname" => "ovrimos_longreadlen", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool ovrimos_longreadlen ( int result_id, int length )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$length} )", 
	"desc" => "Specifies how many bytes are to be retrieved from long datatypes", 
	"docurl" => "function.ovrimos-longreadlen.html" 
),
"ovrimos_num_fields" => array( 
	"methodname" => "ovrimos_num_fields", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "int ovrimos_num_fields ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Returns the number of columns", 
	"docurl" => "function.ovrimos-num-fields.html" 
),
"ovrimos_num_rows" => array( 
	"methodname" => "ovrimos_num_rows", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "int ovrimos_num_rows ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Returns the number of rows affected by update operations", 
	"docurl" => "function.ovrimos-num-rows.html" 
),
"ovrimos_prepare" => array( 
	"methodname" => "ovrimos_prepare", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "int ovrimos_prepare ( int connection_id, string query )", 
	"snippet" => "( \${1:\$connection_id}, \${2:\$query} )", 
	"desc" => "Prepares an SQL statement", 
	"docurl" => "function.ovrimos-prepare.html" 
),
"ovrimos_result_all" => array( 
	"methodname" => "ovrimos_result_all", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "int ovrimos_result_all ( int result_id [, string format] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Prints the whole result set as an HTML table", 
	"docurl" => "function.ovrimos-result-all.html" 
),
"ovrimos_result" => array( 
	"methodname" => "ovrimos_result", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "string ovrimos_result ( int result_id, mixed field )", 
	"snippet" => "( \${1:\$result_id}, \${2:\$field} )", 
	"desc" => "Retrieves the output column", 
	"docurl" => "function.ovrimos-result.html" 
),
"ovrimos_rollback" => array( 
	"methodname" => "ovrimos_rollback", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool ovrimos_rollback ( int connection_id )", 
	"snippet" => "( \${1:\$connection_id} )", 
	"desc" => "Rolls back the transaction", 
	"docurl" => "function.ovrimos-rollback.html" 
),

); # end of main array
?>