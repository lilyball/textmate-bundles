<?php
$_LOOKUP = array( 
"fam_cancel_monitor" => array( 
	"methodname" => "fam_cancel_monitor", 
	"version" => "PHP5", 
	"method" => "bool fam_cancel_monitor ( resource fam, resource fam_monitor )", 
	"snippet" => "( \${1:\$fam}, \${2:\$fam_monitor} )", 
	"desc" => "Terminate monitoring", 
	"docurl" => "function.fam-cancel-monitor.html" 
),
"fam_close" => array( 
	"methodname" => "fam_close", 
	"version" => "PHP5", 
	"method" => "void fam_close ( resource fam )", 
	"snippet" => "( \${1:\$fam} )", 
	"desc" => "Close FAM connection", 
	"docurl" => "function.fam-close.html" 
),
"fam_monitor_collection" => array( 
	"methodname" => "fam_monitor_collection", 
	"version" => "PHP5", 
	"method" => "resource fam_monitor_collection ( resource fam, string dirname, int depth, string mask )", 
	"snippet" => "( \${1:\$fam}, \${2:\$dirname}, \${3:\$depth}, \${4:\$mask} )", 
	"desc" => "Monitor a collection of files in a directory for changes", 
	"docurl" => "function.fam-monitor-collection.html" 
),
"fam_monitor_directory" => array( 
	"methodname" => "fam_monitor_directory", 
	"version" => "PHP5", 
	"method" => "resource fam_monitor_directory ( resource fam, string dirname )", 
	"snippet" => "( \${1:\$fam}, \${2:\$dirname} )", 
	"desc" => "Monitor a directory for changes", 
	"docurl" => "function.fam-monitor-directory.html" 
),
"fam_monitor_file" => array( 
	"methodname" => "fam_monitor_file", 
	"version" => "PHP5", 
	"method" => "resource fam_monitor_file ( resource fam, string filename )", 
	"snippet" => "( \${1:\$fam}, \${2:\$filename} )", 
	"desc" => "Monitor a regular file for changes", 
	"docurl" => "function.fam-monitor-file.html" 
),
"fam_next_event" => array( 
	"methodname" => "fam_next_event", 
	"version" => "PHP5", 
	"method" => "array fam_next_event ( resource fam )", 
	"snippet" => "( \${1:\$fam} )", 
	"desc" => "Get next pending FAM event", 
	"docurl" => "function.fam-next-event.html" 
),
"fam_open" => array( 
	"methodname" => "fam_open", 
	"version" => "PHP5", 
	"method" => "resource fam_open ( [string appname] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open connection to FAM daemon", 
	"docurl" => "function.fam-open.html" 
),
"fam_pending" => array( 
	"methodname" => "fam_pending", 
	"version" => "PHP5", 
	"method" => "bool fam_pending ( resource fam )", 
	"snippet" => "( \${1:\$fam} )", 
	"desc" => "Check for pending FAM events", 
	"docurl" => "function.fam-pending.html" 
),
"fam_resume_monitor" => array( 
	"methodname" => "fam_resume_monitor", 
	"version" => "PHP5", 
	"method" => "bool fam_resume_monitor ( resource fam, resource fam_monitor )", 
	"snippet" => "( \${1:\$fam}, \${2:\$fam_monitor} )", 
	"desc" => "Resume suspended monitoring", 
	"docurl" => "function.fam-resume-monitor.html" 
),
"fam_suspend_monitor" => array( 
	"methodname" => "fam_suspend_monitor", 
	"version" => "PHP5", 
	"method" => "bool fam_suspend_monitor ( resource fam, resource fam_monitor )", 
	"snippet" => "( \${1:\$fam}, \${2:\$fam_monitor} )", 
	"desc" => "Temporarily suspend monitoring", 
	"docurl" => "function.fam-suspend-monitor.html" 
),
"fbsql_affected_rows" => array( 
	"methodname" => "fbsql_affected_rows", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int fbsql_affected_rows ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get number of affected rows in previous FrontBase operation", 
	"docurl" => "function.fbsql-affected-rows.html" 
),
"fbsql_autocommit" => array( 
	"methodname" => "fbsql_autocommit", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_autocommit ( resource link_identifier [, bool OnOff] )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Enable or disable autocommit", 
	"docurl" => "function.fbsql-autocommit.html" 
),
"fbsql_blob_size" => array( 
	"methodname" => "fbsql_blob_size", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int fbsql_blob_size ( string blob_handle [, resource link_identifier] )", 
	"snippet" => "( \${1:\$blob_handle} )", 
	"desc" => "Get the size of a BLOB", 
	"docurl" => "function.fbsql-blob-size.html" 
),
"fbsql_change_user" => array( 
	"methodname" => "fbsql_change_user", 
	"version" => "undefined", 
	"method" => "resource fbsql_change_user ( string user, string password [, string database [, resource link_identifier]] )", 
	"snippet" => "( \${1:\$user}, \${2:\$password} )", 
	"desc" => "Change logged in user of the active connection", 
	"docurl" => "function.fbsql-change-user.html" 
),
"fbsql_clob_size" => array( 
	"methodname" => "fbsql_clob_size", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int fbsql_clob_size ( string clob_handle [, resource link_identifier] )", 
	"snippet" => "( \${1:\$clob_handle} )", 
	"desc" => "Get the size of a CLOB", 
	"docurl" => "function.fbsql-clob-size.html" 
),
"fbsql_close" => array( 
	"methodname" => "fbsql_close", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_close ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Close FrontBase connection", 
	"docurl" => "function.fbsql-close.html" 
),
"fbsql_commit" => array( 
	"methodname" => "fbsql_commit", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_commit ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Commits a transaction to the database", 
	"docurl" => "function.fbsql-commit.html" 
),
"fbsql_connect" => array( 
	"methodname" => "fbsql_connect", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "resource fbsql_connect ( [string hostname [, string username [, string password]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open a connection to a FrontBase Server", 
	"docurl" => "function.fbsql-connect.html" 
),
"fbsql_create_blob" => array( 
	"methodname" => "fbsql_create_blob", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string fbsql_create_blob ( string blob_data [, resource link_identifier] )", 
	"snippet" => "( \${1:\$blob_data} )", 
	"desc" => "Create a BLOB", 
	"docurl" => "function.fbsql-create-blob.html" 
),
"fbsql_create_clob" => array( 
	"methodname" => "fbsql_create_clob", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string fbsql_create_clob ( string clob_data [, resource link_identifier] )", 
	"snippet" => "( \${1:\$clob_data} )", 
	"desc" => "Create a CLOB", 
	"docurl" => "function.fbsql-create-clob.html" 
),
"fbsql_create_db" => array( 
	"methodname" => "fbsql_create_db", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_create_db ( string database_name [, resource link_identifier [, string database_options]] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Create a FrontBase database", 
	"docurl" => "function.fbsql-create-db.html" 
),
"fbsql_data_seek" => array( 
	"methodname" => "fbsql_data_seek", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_data_seek ( resource result_identifier, int row_number )", 
	"snippet" => "( \${1:\$result_identifier}, \${2:\$row_number} )", 
	"desc" => "Move internal result pointer", 
	"docurl" => "function.fbsql-data-seek.html" 
),
"fbsql_database_password" => array( 
	"methodname" => "fbsql_database_password", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string fbsql_database_password ( resource link_identifier [, string database_password] )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Sets or retrieves the password for a FrontBase database", 
	"docurl" => "function.fbsql-database-password.html" 
),
"fbsql_database" => array( 
	"methodname" => "fbsql_database", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string fbsql_database ( resource link_identifier [, string database] )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Get or set the database name used with a connection", 
	"docurl" => "function.fbsql-database.html" 
),
"fbsql_db_query" => array( 
	"methodname" => "fbsql_db_query", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "resource fbsql_db_query ( string database, string query [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database}, \${2:\$query} )", 
	"desc" => "Send a FrontBase query", 
	"docurl" => "function.fbsql-db-query.html" 
),
"fbsql_db_status" => array( 
	"methodname" => "fbsql_db_status", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int fbsql_db_status ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Get the status for a given database", 
	"docurl" => "function.fbsql-db-status.html" 
),
"fbsql_drop_db" => array( 
	"methodname" => "fbsql_drop_db", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_drop_db ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Drop (delete) a FrontBase database", 
	"docurl" => "function.fbsql-drop-db.html" 
),
"fbsql_errno" => array( 
	"methodname" => "fbsql_errno", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int fbsql_errno ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns the numerical value of the error message from previous   FrontBase operation", 
	"docurl" => "function.fbsql-errno.html" 
),
"fbsql_error" => array( 
	"methodname" => "fbsql_error", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string fbsql_error ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns the text of the error message from previous FrontBase   operation", 
	"docurl" => "function.fbsql-error.html" 
),
"fbsql_fetch_array" => array( 
	"methodname" => "fbsql_fetch_array", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array fbsql_fetch_array ( resource result [, int result_type] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an associative array, a numeric array, or   both", 
	"docurl" => "function.fbsql-fetch-array.html" 
),
"fbsql_fetch_assoc" => array( 
	"methodname" => "fbsql_fetch_assoc", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array fbsql_fetch_assoc ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an associative array", 
	"docurl" => "function.fbsql-fetch-assoc.html" 
),
"fbsql_fetch_field" => array( 
	"methodname" => "fbsql_fetch_field", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "object fbsql_fetch_field ( resource result [, int field_offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get column information from a result and return as an object", 
	"docurl" => "function.fbsql-fetch-field.html" 
),
"fbsql_fetch_lengths" => array( 
	"methodname" => "fbsql_fetch_lengths", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array fbsql_fetch_lengths ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get the length of each output in a result", 
	"docurl" => "function.fbsql-fetch-lengths.html" 
),
"fbsql_fetch_object" => array( 
	"methodname" => "fbsql_fetch_object", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "object fbsql_fetch_object ( resource result [, int result_type] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an object", 
	"docurl" => "function.fbsql-fetch-object.html" 
),
"fbsql_fetch_row" => array( 
	"methodname" => "fbsql_fetch_row", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array fbsql_fetch_row ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get a result row as an enumerated array", 
	"docurl" => "function.fbsql-fetch-row.html" 
),
"fbsql_field_flags" => array( 
	"methodname" => "fbsql_field_flags", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string fbsql_field_flags ( resource result [, int field_offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get the flags associated with the specified field in a result", 
	"docurl" => "function.fbsql-field-flags.html" 
),
"fbsql_field_len" => array( 
	"methodname" => "fbsql_field_len", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int fbsql_field_len ( resource result [, int field_offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns the length of the specified field", 
	"docurl" => "function.fbsql-field-len.html" 
),
"fbsql_field_name" => array( 
	"methodname" => "fbsql_field_name", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string fbsql_field_name ( resource result [, int field_index] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get the name of the specified field in a result", 
	"docurl" => "function.fbsql-field-name.html" 
),
"fbsql_field_seek" => array( 
	"methodname" => "fbsql_field_seek", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_field_seek ( resource result [, int field_offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Set result pointer to a specified field offset", 
	"docurl" => "function.fbsql-field-seek.html" 
),
"fbsql_field_table" => array( 
	"methodname" => "fbsql_field_table", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string fbsql_field_table ( resource result [, int field_offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get name of the table the specified field is in", 
	"docurl" => "function.fbsql-field-table.html" 
),
"fbsql_field_type" => array( 
	"methodname" => "fbsql_field_type", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string fbsql_field_type ( resource result [, int field_offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get the type of the specified field in a result", 
	"docurl" => "function.fbsql-field-type.html" 
),
"fbsql_free_result" => array( 
	"methodname" => "fbsql_free_result", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_free_result ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Free result memory", 
	"docurl" => "function.fbsql-free-result.html" 
),
"fbsql_get_autostart_info" => array( 
	"methodname" => "fbsql_get_autostart_info", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array fbsql_get_autostart_info ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "No description given yet", 
	"docurl" => "function.fbsql-get-autostart-info.html" 
),
"fbsql_hostname" => array( 
	"methodname" => "fbsql_hostname", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string fbsql_hostname ( resource link_identifier [, string host_name] )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Get or set the host name used with a connection", 
	"docurl" => "function.fbsql-hostname.html" 
),
"fbsql_insert_id" => array( 
	"methodname" => "fbsql_insert_id", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int fbsql_insert_id ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get the id generated from the previous INSERT operation", 
	"docurl" => "function.fbsql-insert-id.html" 
),
"fbsql_list_dbs" => array( 
	"methodname" => "fbsql_list_dbs", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "resource fbsql_list_dbs ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "List databases available on a FrontBase server", 
	"docurl" => "function.fbsql-list-dbs.html" 
),
"fbsql_list_fields" => array( 
	"methodname" => "fbsql_list_fields", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "resource fbsql_list_fields ( string database_name, string table_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name}, \${2:\$table_name} )", 
	"desc" => "List FrontBase result fields", 
	"docurl" => "function.fbsql-list-fields.html" 
),
"fbsql_list_tables" => array( 
	"methodname" => "fbsql_list_tables", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "resource fbsql_list_tables ( string database [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database} )", 
	"desc" => "List tables in a FrontBase database", 
	"docurl" => "function.fbsql-list-tables.html" 
),
"fbsql_next_result" => array( 
	"methodname" => "fbsql_next_result", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_next_result ( resource result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Move the internal result pointer to the next result", 
	"docurl" => "function.fbsql-next-result.html" 
),
"fbsql_num_fields" => array( 
	"methodname" => "fbsql_num_fields", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int fbsql_num_fields ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get number of fields in result", 
	"docurl" => "function.fbsql-num-fields.html" 
),
"fbsql_num_rows" => array( 
	"methodname" => "fbsql_num_rows", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int fbsql_num_rows ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get number of rows in result", 
	"docurl" => "function.fbsql-num-rows.html" 
),
"fbsql_password" => array( 
	"methodname" => "fbsql_password", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string fbsql_password ( resource link_identifier [, string password] )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Get or set the user password used with a connection", 
	"docurl" => "function.fbsql-password.html" 
),
"fbsql_pconnect" => array( 
	"methodname" => "fbsql_pconnect", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "resource fbsql_pconnect ( [string hostname [, string username [, string password]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open a persistent connection to a FrontBase Server", 
	"docurl" => "function.fbsql-pconnect.html" 
),
"fbsql_query" => array( 
	"methodname" => "fbsql_query", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "resource fbsql_query ( string query [, resource link_identifier [, int batch_size]] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Send a FrontBase query", 
	"docurl" => "function.fbsql-query.html" 
),
"fbsql_read_blob" => array( 
	"methodname" => "fbsql_read_blob", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string fbsql_read_blob ( string blob_handle [, resource link_identifier] )", 
	"snippet" => "( \${1:\$blob_handle} )", 
	"desc" => "Read a BLOB from the database", 
	"docurl" => "function.fbsql-read-blob.html" 
),
"fbsql_read_clob" => array( 
	"methodname" => "fbsql_read_clob", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string fbsql_read_clob ( string clob_handle [, resource link_identifier] )", 
	"snippet" => "( \${1:\$clob_handle} )", 
	"desc" => "Read a CLOB from the database", 
	"docurl" => "function.fbsql-read-clob.html" 
),
"fbsql_result" => array( 
	"methodname" => "fbsql_result", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "mixed fbsql_result ( resource result [, int row [, mixed field]] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get result data", 
	"docurl" => "function.fbsql-result.html" 
),
"fbsql_rollback" => array( 
	"methodname" => "fbsql_rollback", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_rollback ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Rollback a transaction to the database", 
	"docurl" => "function.fbsql-rollback.html" 
),
"fbsql_select_db" => array( 
	"methodname" => "fbsql_select_db", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_select_db ( [string database_name [, resource link_identifier]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Select a FrontBase database", 
	"docurl" => "function.fbsql-select-db.html" 
),
"fbsql_set_lob_mode" => array( 
	"methodname" => "fbsql_set_lob_mode", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool fbsql_set_lob_mode ( resource result, string database_name )", 
	"snippet" => "( \${1:\$result}, \${2:\$database_name} )", 
	"desc" => "Set the LOB retrieve mode for a FrontBase result set", 
	"docurl" => "function.fbsql-set-lob-mode.html" 
),
"fbsql_set_password" => array( 
	"methodname" => "fbsql_set_password", 
	"version" => "PHP5", 
	"method" => "bool fbsql_set_password ( resource link_identifier, string user, string password, string old_password )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$user}, \${3:\$password}, \${4:\$old_password} )", 
	"desc" => "Change the password for a given user", 
	"docurl" => "function.fbsql-set-password.html" 
),
"fbsql_set_transaction" => array( 
	"methodname" => "fbsql_set_transaction", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void fbsql_set_transaction ( resource link_identifier, int Locking, int Isolation )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$Locking}, \${3:\$Isolation} )", 
	"desc" => "Set the transaction locking and isolation", 
	"docurl" => "function.fbsql-set-transaction.html" 
),
"fbsql_start_db" => array( 
	"methodname" => "fbsql_start_db", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_start_db ( string database_name [, resource link_identifier [, string database_options]] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Start a database on local or remote server", 
	"docurl" => "function.fbsql-start-db.html" 
),
"fbsql_stop_db" => array( 
	"methodname" => "fbsql_stop_db", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_stop_db ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Stop a database on local or remote server", 
	"docurl" => "function.fbsql-stop-db.html" 
),
"fbsql_tablename" => array( 
	"methodname" => "fbsql_tablename", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string fbsql_tablename ( resource result, int i )", 
	"snippet" => "( \${1:\$result}, \${2:\$i} )", 
	"desc" => "Get table name of field", 
	"docurl" => "function.fbsql-tablename.html" 
),
"fbsql_username" => array( 
	"methodname" => "fbsql_username", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string fbsql_username ( resource link_identifier [, string username] )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Get or set the host user used with a connection", 
	"docurl" => "function.fbsql-username.html" 
),
"fbsql_warnings" => array( 
	"methodname" => "fbsql_warnings", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool fbsql_warnings ( [bool OnOff] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Enable or disable FrontBase warnings", 
	"docurl" => "function.fbsql-warnings.html" 
),
"fclose" => array( 
	"methodname" => "fclose", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool fclose ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Closes an open file pointer", 
	"docurl" => "function.fclose.html" 
),
"fdf_add_doc_javascript" => array( 
	"methodname" => "fdf_add_doc_javascript", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool fdf_add_doc_javascript ( resource fdfdoc, string script_name, string script_code )", 
	"snippet" => "( \${1:\$fdfdoc}, \${2:\$script_name}, \${3:\$script_code} )", 
	"desc" => "Adds javascript code to the FDF document", 
	"docurl" => "function.fdf-add-doc-javascript.html" 
),
"fdf_add_template" => array( 
	"methodname" => "fdf_add_template", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool fdf_add_template ( resource fdfdoc, int newpage, string filename, string template, int rename )", 
	"snippet" => "( \${1:\$fdfdoc}, \${2:\$newpage}, \${3:\$filename}, \${4:\$template}, \${5:\$rename} )", 
	"desc" => "Adds a template into the FDF document", 
	"docurl" => "function.fdf-add-template.html" 
),
"fdf_close" => array( 
	"methodname" => "fdf_close", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool fdf_close ( resource fdf_document )", 
	"snippet" => "( \${1:\$fdf_document} )", 
	"desc" => "Close an FDF document", 
	"docurl" => "function.fdf-close.html" 
),
"fdf_create" => array( 
	"methodname" => "fdf_create", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource fdf_create ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Create a new FDF document", 
	"docurl" => "function.fdf-create.html" 
),
"fdf_enum_values" => array( 
	"methodname" => "fdf_enum_values", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool fdf_enum_values ( resource fdfdoc, callback function [, mixed userdata] )", 
	"snippet" => "( \${1:\$fdfdoc}, \${2:\$function} )", 
	"desc" => "Call a user defined function for each document value", 
	"docurl" => "function.fdf-enum-values.html" 
),
"fdf_errno" => array( 
	"methodname" => "fdf_errno", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int fdf_errno ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return error code for last fdf operation", 
	"docurl" => "function.fdf-errno.html" 
),
"fdf_error" => array( 
	"methodname" => "fdf_error", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string fdf_error ( [int error_code] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Return error description for fdf error code", 
	"docurl" => "function.fdf-error.html" 
),
"fdf_get_ap" => array( 
	"methodname" => "fdf_get_ap", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool fdf_get_ap ( resource fdf_document, string field, int face, string filename )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$field}, \${3:\$face}, \${4:\$filename} )", 
	"desc" => "Get the appearance of a field", 
	"docurl" => "function.fdf-get-ap.html" 
),
"fdf_get_attachment" => array( 
	"methodname" => "fdf_get_attachment", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array fdf_get_attachment ( resource fdf_document, string fieldname, string savepath )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$fieldname}, \${3:\$savepath} )", 
	"desc" => "Extracts uploaded file embedded in the FDF", 
	"docurl" => "function.fdf-get-attachment.html" 
),
"fdf_get_encoding" => array( 
	"methodname" => "fdf_get_encoding", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string fdf_get_encoding ( resource fdf_document )", 
	"snippet" => "( \${1:\$fdf_document} )", 
	"desc" => "Get the value of the /Encoding key", 
	"docurl" => "function.fdf-get-encoding.html" 
),
"fdf_get_file" => array( 
	"methodname" => "fdf_get_file", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string fdf_get_file ( resource fdf_document )", 
	"snippet" => "( \${1:\$fdf_document} )", 
	"desc" => "Get the value of the /F key", 
	"docurl" => "function.fdf-get-file.html" 
),
"fdf_get_flags" => array( 
	"methodname" => "fdf_get_flags", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int fdf_get_flags ( resource fdfdoc, string fieldname, int whichflags )", 
	"snippet" => "( \${1:\$fdfdoc}, \${2:\$fieldname}, \${3:\$whichflags} )", 
	"desc" => "Gets the flags of a field", 
	"docurl" => "function.fdf-get-flags.html" 
),
"fdf_get_opt" => array( 
	"methodname" => "fdf_get_opt", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "mixed fdf_get_opt ( resource fdfdof, string fieldname [, int element] )", 
	"snippet" => "( \${1:\$fdfdof}, \${2:\$fieldname} )", 
	"desc" => "Gets a value from the opt array of a field", 
	"docurl" => "function.fdf-get-opt.html" 
),
"fdf_get_status" => array( 
	"methodname" => "fdf_get_status", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string fdf_get_status ( resource fdf_document )", 
	"snippet" => "( \${1:\$fdf_document} )", 
	"desc" => "Get the value of the /STATUS key", 
	"docurl" => "function.fdf-get-status.html" 
),
"fdf_get_value" => array( 
	"methodname" => "fdf_get_value", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string fdf_get_value ( resource fdf_document, string fieldname [, int which] )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$fieldname} )", 
	"desc" => "Get the value of a field", 
	"docurl" => "function.fdf-get-value.html" 
),
"fdf_get_version" => array( 
	"methodname" => "fdf_get_version", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string fdf_get_version ( [resource fdf_document] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Gets version number for FDF API or file", 
	"docurl" => "function.fdf-get-version.html" 
),
"fdf_header" => array( 
	"methodname" => "fdf_header", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool fdf_header ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Sets FDF-specific output headers", 
	"docurl" => "function.fdf-header.html" 
),
"fdf_next_field_name" => array( 
	"methodname" => "fdf_next_field_name", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string fdf_next_field_name ( resource fdf_document [, string fieldname] )", 
	"snippet" => "( \${1:\$fdf_document} )", 
	"desc" => "Get the next field name", 
	"docurl" => "function.fdf-next-field-name.html" 
),
"fdf_open_string" => array( 
	"methodname" => "fdf_open_string", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource fdf_open_string ( string fdf_data )", 
	"snippet" => "( \${1:\$fdf_data} )", 
	"desc" => "Read a FDF document from a string", 
	"docurl" => "function.fdf-open-string.html" 
),
"fdf_open" => array( 
	"methodname" => "fdf_open", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource fdf_open ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Open a FDF document", 
	"docurl" => "function.fdf-open.html" 
),
"fdf_remove_item" => array( 
	"methodname" => "fdf_remove_item", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool fdf_remove_item ( resource fdfdoc, string fieldname, int item )", 
	"snippet" => "( \${1:\$fdfdoc}, \${2:\$fieldname}, \${3:\$item} )", 
	"desc" => "Sets target frame for form", 
	"docurl" => "function.fdf-remove-item.html" 
),
"fdf_save_string" => array( 
	"methodname" => "fdf_save_string", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string fdf_save_string ( resource fdf_document )", 
	"snippet" => "( \${1:\$fdf_document} )", 
	"desc" => "Returns the FDF document as a string", 
	"docurl" => "function.fdf-save-string.html" 
),
"fdf_save" => array( 
	"methodname" => "fdf_save", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool fdf_save ( resource fdf_document [, string filename] )", 
	"snippet" => "( \${1:\$fdf_document} )", 
	"desc" => "Save a FDF document", 
	"docurl" => "function.fdf-save.html" 
),
"fdf_set_ap" => array( 
	"methodname" => "fdf_set_ap", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool fdf_set_ap ( resource fdf_document, string field_name, int face, string filename, int page_number )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$field_name}, \${3:\$face}, \${4:\$filename}, \${5:\$page_number} )", 
	"desc" => "Set the appearance of a field", 
	"docurl" => "function.fdf-set-ap.html" 
),
"fdf_set_encoding" => array( 
	"methodname" => "fdf_set_encoding", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool fdf_set_encoding ( resource fdf_document, string encoding )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$encoding} )", 
	"desc" => "Sets FDF character encoding", 
	"docurl" => "function.fdf-set-encoding.html" 
),
"fdf_set_file" => array( 
	"methodname" => "fdf_set_file", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool fdf_set_file ( resource fdf_document, string url [, string target_frame] )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$url} )", 
	"desc" => "Set PDF document to display FDF data in", 
	"docurl" => "function.fdf-set-file.html" 
),
"fdf_set_flags" => array( 
	"methodname" => "fdf_set_flags", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool fdf_set_flags ( resource fdf_document, string fieldname, int whichFlags, int newFlags )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$fieldname}, \${3:\$whichFlags}, \${4:\$newFlags} )", 
	"desc" => "Sets a flag of a field", 
	"docurl" => "function.fdf-set-flags.html" 
),
"fdf_set_javascript_action" => array( 
	"methodname" => "fdf_set_javascript_action", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool fdf_set_javascript_action ( resource fdf_document, string fieldname, int trigger, string script )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$fieldname}, \${3:\$trigger}, \${4:\$script} )", 
	"desc" => "Sets an javascript action of a field", 
	"docurl" => "function.fdf-set-javascript-action.html" 
),
"fdf_set_on_import_javascript" => array( 
	"methodname" => "fdf_set_on_import_javascript", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool fdf_set_on_import_javascript ( resource fdfdoc, string script [, bool before_data_import] )", 
	"snippet" => "( \${1:\$fdfdoc}, \${2:\$script} )", 
	"desc" => "Adds javascript code to be executed when Acrobat opens the FDF", 
	"docurl" => "function.fdf-set-on-import-javascript.html" 
),
"fdf_set_opt" => array( 
	"methodname" => "fdf_set_opt", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool fdf_set_opt ( resource fdf_document, string fieldname, int element, string str1, string str2 )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$fieldname}, \${3:\$element}, \${4:\$str1}, \${5:\$str2} )", 
	"desc" => "Sets an option of a field", 
	"docurl" => "function.fdf-set-opt.html" 
),
"fdf_set_status" => array( 
	"methodname" => "fdf_set_status", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool fdf_set_status ( resource fdf_document, string status )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$status} )", 
	"desc" => "Set the value of the /STATUS key", 
	"docurl" => "function.fdf-set-status.html" 
),
"fdf_set_submit_form_action" => array( 
	"methodname" => "fdf_set_submit_form_action", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool fdf_set_submit_form_action ( resource fdf_document, string fieldname, int trigger, string script, int flags )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$fieldname}, \${3:\$trigger}, \${4:\$script}, \${5:\$flags} )", 
	"desc" => "Sets a submit form action of a field", 
	"docurl" => "function.fdf-set-submit-form-action.html" 
),
"fdf_set_target_frame" => array( 
	"methodname" => "fdf_set_target_frame", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool fdf_set_target_frame ( resource fdf_document, string frame_name )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$frame_name} )", 
	"desc" => "Set target frame for form display", 
	"docurl" => "function.fdf-set-target-frame.html" 
),
"fdf_set_value" => array( 
	"methodname" => "fdf_set_value", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool fdf_set_value ( resource fdf_document, string fieldname, mixed value [, int isName] )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$fieldname}, \${3:\$value} )", 
	"desc" => "Set the value of a field", 
	"docurl" => "function.fdf-set-value.html" 
),
"fdf_set_version" => array( 
	"methodname" => "fdf_set_version", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string fdf_set_version ( resource fdf_document, string version )", 
	"snippet" => "( \${1:\$fdf_document}, \${2:\$version} )", 
	"desc" => "Sets version number for a FDF file", 
	"docurl" => "function.fdf-set-version.html" 
),
"feof" => array( 
	"methodname" => "feof", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool feof ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Tests for end-of-file on a file pointer", 
	"docurl" => "function.feof.html" 
),
"fflush" => array( 
	"methodname" => "fflush", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool fflush ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Flushes the output to a file", 
	"docurl" => "function.fflush.html" 
),
"fgetc" => array( 
	"methodname" => "fgetc", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string fgetc ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Gets character from file pointer", 
	"docurl" => "function.fgetc.html" 
),
"fgetcsv" => array( 
	"methodname" => "fgetcsv", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "array fgetcsv ( resource handle [, int length [, string delimiter [, string enclosure]]] )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Gets line from file pointer and parse for CSV fields", 
	"docurl" => "function.fgetcsv.html" 
),
"fgets" => array( 
	"methodname" => "fgets", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string fgets ( resource handle [, int length] )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Gets line from file pointer", 
	"docurl" => "function.fgets.html" 
),
"fgetss" => array( 
	"methodname" => "fgetss", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string fgetss ( resource handle [, int length [, string allowable_tags]] )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Gets line from file pointer and strip HTML tags", 
	"docurl" => "function.fgetss.html" 
),
"file_exists" => array( 
	"methodname" => "file_exists", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool file_exists ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Checks whether a file or directory exists", 
	"docurl" => "function.file-exists.html" 
),
"file_get_contents" => array( 
	"methodname" => "file_get_contents", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string file_get_contents ( string filename [, bool use_include_path [, resource context [, int offset [, int maxlen]]]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Reads entire file into a string", 
	"docurl" => "function.file-get-contents.html" 
),
"file_put_contents" => array( 
	"methodname" => "file_put_contents", 
	"version" => "PHP5", 
	"method" => "int file_put_contents ( string filename, mixed data [, int flags [, resource context]] )", 
	"snippet" => "( \${1:\$filename}, \${2:\$data} )", 
	"desc" => "Write a string to a file", 
	"docurl" => "function.file-put-contents.html" 
),
"file" => array( 
	"methodname" => "file", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array file ( string filename [, int use_include_path [, resource context]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Reads entire file into an array", 
	"docurl" => "function.file.html" 
),
"fileatime" => array( 
	"methodname" => "fileatime", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int fileatime ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gets last access time of file", 
	"docurl" => "function.fileatime.html" 
),
"filectime" => array( 
	"methodname" => "filectime", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int filectime ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gets inode change time of file", 
	"docurl" => "function.filectime.html" 
),
"filegroup" => array( 
	"methodname" => "filegroup", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int filegroup ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gets file group", 
	"docurl" => "function.filegroup.html" 
),
"fileinode" => array( 
	"methodname" => "fileinode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int fileinode ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gets file inode", 
	"docurl" => "function.fileinode.html" 
),
"filemtime" => array( 
	"methodname" => "filemtime", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int filemtime ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gets file modification time", 
	"docurl" => "function.filemtime.html" 
),
"fileowner" => array( 
	"methodname" => "fileowner", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int fileowner ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gets file owner", 
	"docurl" => "function.fileowner.html" 
),
"fileperms" => array( 
	"methodname" => "fileperms", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int fileperms ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gets file permissions", 
	"docurl" => "function.fileperms.html" 
),
"filepro_fieldcount" => array( 
	"methodname" => "filepro_fieldcount", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int filepro_fieldcount ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Find out how many fields are in a filePro database", 
	"docurl" => "function.filepro-fieldcount.html" 
),
"filepro_fieldname" => array( 
	"methodname" => "filepro_fieldname", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string filepro_fieldname ( int field_number )", 
	"snippet" => "( \${1:\$field_number} )", 
	"desc" => "Gets the name of a field", 
	"docurl" => "function.filepro-fieldname.html" 
),
"filepro_fieldtype" => array( 
	"methodname" => "filepro_fieldtype", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string filepro_fieldtype ( int field_number )", 
	"snippet" => "( \${1:\$field_number} )", 
	"desc" => "Gets the type of a field", 
	"docurl" => "function.filepro-fieldtype.html" 
),
"filepro_fieldwidth" => array( 
	"methodname" => "filepro_fieldwidth", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int filepro_fieldwidth ( int field_number )", 
	"snippet" => "( \${1:\$field_number} )", 
	"desc" => "Gets the width of a field", 
	"docurl" => "function.filepro-fieldwidth.html" 
),
"filepro_retrieve" => array( 
	"methodname" => "filepro_retrieve", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string filepro_retrieve ( int row_number, int field_number )", 
	"snippet" => "( \${1:\$row_number}, \${2:\$field_number} )", 
	"desc" => "Retrieves data from a filePro database", 
	"docurl" => "function.filepro-retrieve.html" 
),
"filepro_rowcount" => array( 
	"methodname" => "filepro_rowcount", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int filepro_rowcount ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Find out how many rows are in a filePro database", 
	"docurl" => "function.filepro-rowcount.html" 
),
"filepro" => array( 
	"methodname" => "filepro", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool filepro ( string directory )", 
	"snippet" => "( \${1:\$directory} )", 
	"desc" => "Read and verify the map file", 
	"docurl" => "function.filepro.html" 
),
"filesize" => array( 
	"methodname" => "filesize", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int filesize ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gets file size", 
	"docurl" => "function.filesize.html" 
),
"filetype" => array( 
	"methodname" => "filetype", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string filetype ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gets file type", 
	"docurl" => "function.filetype.html" 
),
"floatval" => array( 
	"methodname" => "floatval", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "float floatval ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Get float value of a variable", 
	"docurl" => "function.floatval.html" 
),
"flock" => array( 
	"methodname" => "flock", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool flock ( resource handle, int operation [, int &wouldblock] )", 
	"snippet" => "( \${1:\$handle}, \${2:\$operation} )", 
	"desc" => "Portable advisory file locking", 
	"docurl" => "function.flock.html" 
),
"floor" => array( 
	"methodname" => "floor", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float floor ( float value )", 
	"snippet" => "( \${1:\$value} )", 
	"desc" => "Round fractions down", 
	"docurl" => "function.floor.html" 
),
"flush" => array( 
	"methodname" => "flush", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void flush ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Flush the output buffer", 
	"docurl" => "function.flush.html" 
),
"fmod" => array( 
	"methodname" => "fmod", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "float fmod ( float x, float y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "Returns the floating point remainder (modulo) of the division   of the arguments", 
	"docurl" => "function.fmod.html" 
),
"fnmatch" => array( 
	"methodname" => "fnmatch", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool fnmatch ( string pattern, string string [, int flags] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$string} )", 
	"desc" => "Match filename against a pattern", 
	"docurl" => "function.fnmatch.html" 
),
"fopen" => array( 
	"methodname" => "fopen", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource fopen ( string filename, string mode [, bool use_include_path [, resource zcontext]] )", 
	"snippet" => "( \${1:\$filename}, \${2:\$mode} )", 
	"desc" => "Opens file or URL", 
	"docurl" => "function.fopen.html" 
),
"fpassthru" => array( 
	"methodname" => "fpassthru", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int fpassthru ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Output all remaining data on a file pointer", 
	"docurl" => "function.fpassthru.html" 
),
"fprintf" => array( 
	"methodname" => "fprintf", 
	"version" => "PHP5", 
	"method" => "int fprintf ( resource handle, string format [, mixed args [, mixed ...]] )", 
	"snippet" => "( \${1:\$handle}, \${2:\$format} )", 
	"desc" => "Write a formatted string to a stream", 
	"docurl" => "function.fprintf.html" 
),
"fputcsv" => array( 
	"methodname" => "fputcsv", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "int fputcsv ( resource handle [, array fields [, string delimiter [, string enclosure]]] )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Format line as CSV and write to file pointer", 
	"docurl" => "function.fputcsv.html" 
),
"fputs" => array( 
	"methodname" => "fputs", 
	"version" => "(PHP3, PHP4, PHP5)", 
	"method" => "Alias of fwrite()", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of fwrite()\nBinary-safe file write", 
	"docurl" => "function.fputs.html" 
),
"fread" => array( 
	"methodname" => "fread", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string fread ( resource handle, int length )", 
	"snippet" => "( \${1:\$handle}, \${2:\$length} )", 
	"desc" => "Binary-safe file read", 
	"docurl" => "function.fread.html" 
),
"frenchtojd" => array( 
	"methodname" => "frenchtojd", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int frenchtojd ( int month, int day, int year )", 
	"snippet" => "( \${1:\$month}, \${2:\$day}, \${3:\$year} )", 
	"desc" => "Converts a date from the French Republican Calendar to a Julian   Day Count", 
	"docurl" => "function.frenchtojd.html" 
),
"fribidi_log2vis" => array( 
	"methodname" => "fribidi_log2vis", 
	"version" => "PHP4 >= 4.0.4", 
	"method" => "string fribidi_log2vis ( string str, string direction, int charset )", 
	"snippet" => "( \${1:\$str}, \${2:\$direction}, \${3:\$charset} )", 
	"desc" => "Convert a logical string to a visual one", 
	"docurl" => "function.fribidi-log2vis.html" 
),
"fscanf" => array( 
	"methodname" => "fscanf", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "mixed fscanf ( resource handle, string format [, mixed &...] )", 
	"snippet" => "( \${1:\$handle}, \${2:\$format} )", 
	"desc" => "Parses input from a file according to a format", 
	"docurl" => "function.fscanf.html" 
),
"fseek" => array( 
	"methodname" => "fseek", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int fseek ( resource handle, int offset [, int whence] )", 
	"snippet" => "( \${1:\$handle}, \${2:\$offset} )", 
	"desc" => "Seeks on a file pointer", 
	"docurl" => "function.fseek.html" 
),
"fsockopen" => array( 
	"methodname" => "fsockopen", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource fsockopen ( string target, int port [, int &errno [, string &errstr [, float timeout]]] )", 
	"snippet" => "( \${1:\$target}, \${2:\$port} )", 
	"desc" => "Open Internet or Unix domain socket connection", 
	"docurl" => "function.fsockopen.html" 
),
"fstat" => array( 
	"methodname" => "fstat", 
	"version" => "PHP4, PHP5", 
	"method" => "array fstat ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Gets information about a file using an open file pointer", 
	"docurl" => "function.fstat.html" 
),
"ftell" => array( 
	"methodname" => "ftell", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int ftell ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Tells file pointer read/write position", 
	"docurl" => "function.ftell.html" 
),
"ftok" => array( 
	"methodname" => "ftok", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int ftok ( string pathname, string proj )", 
	"snippet" => "( \${1:\$pathname}, \${2:\$proj} )", 
	"desc" => "Convert a pathname and a project identifier to a System V IPC key", 
	"docurl" => "function.ftok.html" 
),
"ftp_alloc" => array( 
	"methodname" => "ftp_alloc", 
	"version" => "PHP5", 
	"method" => "bool ftp_alloc ( resource ftp_stream, int filesize [, string &result] )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$filesize} )", 
	"desc" => "Allocates space for a file to be uploaded", 
	"docurl" => "function.ftp-alloc.html" 
),
"ftp_cdup" => array( 
	"methodname" => "ftp_cdup", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_cdup ( resource ftp_stream )", 
	"snippet" => "( \${1:\$ftp_stream} )", 
	"desc" => "Changes to the parent directory", 
	"docurl" => "function.ftp-cdup.html" 
),
"ftp_chdir" => array( 
	"methodname" => "ftp_chdir", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_chdir ( resource ftp_stream, string directory )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$directory} )", 
	"desc" => "Changes the current directory on a FTP server", 
	"docurl" => "function.ftp-chdir.html" 
),
"ftp_chmod" => array( 
	"methodname" => "ftp_chmod", 
	"version" => "PHP5", 
	"method" => "int ftp_chmod ( resource ftp_stream, int mode, string filename )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$mode}, \${3:\$filename} )", 
	"desc" => "Set permissions on a file via FTP", 
	"docurl" => "function.ftp-chmod.html" 
),
"ftp_close" => array( 
	"methodname" => "ftp_close", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ftp_close ( resource ftp_stream )", 
	"snippet" => "( \${1:\$ftp_stream} )", 
	"desc" => "Closes an FTP connection", 
	"docurl" => "function.ftp-close.html" 
),
"ftp_connect" => array( 
	"methodname" => "ftp_connect", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "resource ftp_connect ( string host [, int port [, int timeout]] )", 
	"snippet" => "( \${1:\$host} )", 
	"desc" => "Opens an FTP connection", 
	"docurl" => "function.ftp-connect.html" 
),
"ftp_delete" => array( 
	"methodname" => "ftp_delete", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_delete ( resource ftp_stream, string path )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$path} )", 
	"desc" => "Deletes a file on the FTP server", 
	"docurl" => "function.ftp-delete.html" 
),
"ftp_exec" => array( 
	"methodname" => "ftp_exec", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool ftp_exec ( resource ftp_stream, string command )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$command} )", 
	"desc" => "Requests execution of a program on the FTP server", 
	"docurl" => "function.ftp-exec.html" 
),
"ftp_fget" => array( 
	"methodname" => "ftp_fget", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_fget ( resource ftp_stream, resource handle, string remote_file, int mode [, int resumepos] )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$handle}, \${3:\$remote_file}, \${4:\$mode} )", 
	"desc" => "Downloads a file from the FTP server and saves to an open file", 
	"docurl" => "function.ftp-fget.html" 
),
"ftp_fput" => array( 
	"methodname" => "ftp_fput", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_fput ( resource ftp_stream, string remote_file, resource handle, int mode [, int startpos] )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$remote_file}, \${3:\$handle}, \${4:\$mode} )", 
	"desc" => "Uploads from an open file to the FTP server", 
	"docurl" => "function.ftp-fput.html" 
),
"ftp_get_option" => array( 
	"methodname" => "ftp_get_option", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "mixed ftp_get_option ( resource ftp_stream, int option )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$option} )", 
	"desc" => "Retrieves various runtime behaviours of the current FTP stream", 
	"docurl" => "function.ftp-get-option.html" 
),
"ftp_get" => array( 
	"methodname" => "ftp_get", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_get ( resource ftp_stream, string local_file, string remote_file, int mode [, int resumepos] )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$local_file}, \${3:\$remote_file}, \${4:\$mode} )", 
	"desc" => "Downloads a file from the FTP server", 
	"docurl" => "function.ftp-get.html" 
),
"ftp_login" => array( 
	"methodname" => "ftp_login", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_login ( resource ftp_stream, string username, string password )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$username}, \${3:\$password} )", 
	"desc" => "Logs in to an FTP connection", 
	"docurl" => "function.ftp-login.html" 
),
"ftp_mdtm" => array( 
	"methodname" => "ftp_mdtm", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "int ftp_mdtm ( resource ftp_stream, string remote_file )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$remote_file} )", 
	"desc" => "Returns the last modified time of the given file", 
	"docurl" => "function.ftp-mdtm.html" 
),
"ftp_mkdir" => array( 
	"methodname" => "ftp_mkdir", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "string ftp_mkdir ( resource ftp_stream, string directory )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$directory} )", 
	"desc" => "Creates a directory", 
	"docurl" => "function.ftp-mkdir.html" 
),
"ftp_nb_continue" => array( 
	"methodname" => "ftp_nb_continue", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ftp_nb_continue ( resource ftp_stream )", 
	"snippet" => "( \${1:\$ftp_stream} )", 
	"desc" => "Continues retrieving/sending a file (non-blocking)", 
	"docurl" => "function.ftp-nb-continue.html" 
),
"ftp_nb_fget" => array( 
	"methodname" => "ftp_nb_fget", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ftp_nb_fget ( resource ftp_stream, resource handle, string remote_file, int mode [, int resumepos] )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$handle}, \${3:\$remote_file}, \${4:\$mode} )", 
	"desc" => "Retrieves a file from the FTP server and writes it to an open file (non-blocking)", 
	"docurl" => "function.ftp-nb-fget.html" 
),
"ftp_nb_fput" => array( 
	"methodname" => "ftp_nb_fput", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ftp_nb_fput ( resource ftp_stream, string remote_file, resource handle, int mode [, int startpos] )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$remote_file}, \${3:\$handle}, \${4:\$mode} )", 
	"desc" => "Stores a file from an open file to the FTP server (non-blocking)", 
	"docurl" => "function.ftp-nb-fput.html" 
),
"ftp_nb_get" => array( 
	"methodname" => "ftp_nb_get", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ftp_nb_get ( resource ftp_stream, string local_file, string remote_file, int mode [, int resumepos] )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$local_file}, \${3:\$remote_file}, \${4:\$mode} )", 
	"desc" => "Retrieves a file from the FTP server and writes it to a local file (non-blocking)", 
	"docurl" => "function.ftp-nb-get.html" 
),
"ftp_nb_put" => array( 
	"methodname" => "ftp_nb_put", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int ftp_nb_put ( resource ftp_stream, string remote_file, string local_file, int mode [, int startpos] )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$remote_file}, \${3:\$local_file}, \${4:\$mode} )", 
	"desc" => "Stores a file on the FTP server (non-blocking)", 
	"docurl" => "function.ftp-nb-put.html" 
),
"ftp_nlist" => array( 
	"methodname" => "ftp_nlist", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "array ftp_nlist ( resource ftp_stream, string directory )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$directory} )", 
	"desc" => "Returns a list of files in the given directory", 
	"docurl" => "function.ftp-nlist.html" 
),
"ftp_pasv" => array( 
	"methodname" => "ftp_pasv", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_pasv ( resource ftp_stream, bool pasv )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$pasv} )", 
	"desc" => "Turns passive mode on or off", 
	"docurl" => "function.ftp-pasv.html" 
),
"ftp_put" => array( 
	"methodname" => "ftp_put", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_put ( resource ftp_stream, string remote_file, string local_file, int mode [, int startpos] )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$remote_file}, \${3:\$local_file}, \${4:\$mode} )", 
	"desc" => "Uploads a file to the FTP server", 
	"docurl" => "function.ftp-put.html" 
),
"ftp_pwd" => array( 
	"methodname" => "ftp_pwd", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "string ftp_pwd ( resource ftp_stream )", 
	"snippet" => "( \${1:\$ftp_stream} )", 
	"desc" => "Returns the current directory name", 
	"docurl" => "function.ftp-pwd.html" 
),
"ftp_quit" => array( 
	"methodname" => "ftp_quit", 
	"version" => "(PHP4 >= 4.2.0, PHP5)", 
	"method" => "bool ftp_quit ( resource ftp_stream )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of ftp_close()\nCloses an FTP connection", 
	"docurl" => "function.ftp-quit.html" 
),
"ftp_raw" => array( 
	"methodname" => "ftp_raw", 
	"version" => "PHP5", 
	"method" => "array ftp_raw ( resource ftp_stream, string command )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$command} )", 
	"desc" => "Sends an arbitrary command to an FTP server", 
	"docurl" => "function.ftp-raw.html" 
),
"ftp_rawlist" => array( 
	"methodname" => "ftp_rawlist", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "array ftp_rawlist ( resource ftp_stream, string directory [, bool recursive] )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$directory} )", 
	"desc" => "Returns a detailed list of files in the given directory", 
	"docurl" => "function.ftp-rawlist.html" 
),
"ftp_rename" => array( 
	"methodname" => "ftp_rename", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_rename ( resource ftp_stream, string oldname, string newname )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$oldname}, \${3:\$newname} )", 
	"desc" => "Renames a file or a directory on the FTP server", 
	"docurl" => "function.ftp-rename.html" 
),
"ftp_rmdir" => array( 
	"methodname" => "ftp_rmdir", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool ftp_rmdir ( resource ftp_stream, string directory )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$directory} )", 
	"desc" => "Removes a directory", 
	"docurl" => "function.ftp-rmdir.html" 
),
"ftp_set_option" => array( 
	"methodname" => "ftp_set_option", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ftp_set_option ( resource ftp_stream, int option, mixed value )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$option}, \${3:\$value} )", 
	"desc" => "Set miscellaneous runtime FTP options", 
	"docurl" => "function.ftp-set-option.html" 
),
"ftp_site" => array( 
	"methodname" => "ftp_site", 
	"version" => "PHP3>= 3.0.15, PHP4, PHP5", 
	"method" => "bool ftp_site ( resource ftp_stream, string command )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$command} )", 
	"desc" => "Sends a SITE command to the server", 
	"docurl" => "function.ftp-site.html" 
),
"ftp_size" => array( 
	"methodname" => "ftp_size", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "int ftp_size ( resource ftp_stream, string remote_file )", 
	"snippet" => "( \${1:\$ftp_stream}, \${2:\$remote_file} )", 
	"desc" => "Returns the size of the given file", 
	"docurl" => "function.ftp-size.html" 
),
"ftp_ssl_connect" => array( 
	"methodname" => "ftp_ssl_connect", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource ftp_ssl_connect ( string host [, int port [, int timeout]] )", 
	"snippet" => "( \${1:\$host} )", 
	"desc" => "Opens an Secure SSL-FTP connection", 
	"docurl" => "function.ftp-ssl-connect.html" 
),
"ftp_systype" => array( 
	"methodname" => "ftp_systype", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "string ftp_systype ( resource ftp_stream )", 
	"snippet" => "( \${1:\$ftp_stream} )", 
	"desc" => "Returns the system type identifier of the remote FTP server", 
	"docurl" => "function.ftp-systype.html" 
),
"ftruncate" => array( 
	"methodname" => "ftruncate", 
	"version" => "PHP4, PHP5", 
	"method" => "bool ftruncate ( resource handle, int size )", 
	"snippet" => "( \${1:\$handle}, \${2:\$size} )", 
	"desc" => "Truncates a file to a given length", 
	"docurl" => "function.ftruncate.html" 
),
"func_get_arg" => array( 
	"methodname" => "func_get_arg", 
	"version" => "PHP4, PHP5", 
	"method" => "mixed func_get_arg ( int arg_num )", 
	"snippet" => "( \${1:\$arg_num} )", 
	"desc" => "Return an item from the argument list", 
	"docurl" => "function.func-get-arg.html" 
),
"func_get_args" => array( 
	"methodname" => "func_get_args", 
	"version" => "PHP4, PHP5", 
	"method" => "array func_get_args ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns an array comprising a function\'s argument list", 
	"docurl" => "function.func-get-args.html" 
),
"func_num_args" => array( 
	"methodname" => "func_num_args", 
	"version" => "PHP4, PHP5", 
	"method" => "int func_num_args ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the number of arguments passed to the function", 
	"docurl" => "function.func-num-args.html" 
),
"function_exists" => array( 
	"methodname" => "function_exists", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool function_exists ( string function_name )", 
	"snippet" => "( \${1:\$function_name} )", 
	"desc" => "Return TRUE if the given function has been defined", 
	"docurl" => "function.function-exists.html" 
),
"fwrite" => array( 
	"methodname" => "fwrite", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int fwrite ( resource handle, string string [, int length] )", 
	"snippet" => "( \${1:\$handle}, \${2:\$string} )", 
	"desc" => "Binary-safe file write", 
	"docurl" => "function.fwrite.html" 
),

); # end of main array
?>