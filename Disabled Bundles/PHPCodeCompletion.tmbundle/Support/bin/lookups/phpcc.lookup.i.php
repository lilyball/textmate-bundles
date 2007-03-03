<?php
$_LOOKUP = array( 
"ibase_add_user" => array( 
	"methodname" => "ibase_add_user", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ibase_add_user ( resource service_handle, string user_name, string password [, string first_name [, string middle_name [, string last_name]]] )", 
	"snippet" => "( \${1:\$service_handle}, \${2:\$user_name}, \${3:\$password} )", 
	"desc" => "Add a user to a security database (only for IB6 or later)", 
	"docurl" => "function.ibase-add-user.html" 
),
"ibase_affected_rows" => array( 
	"methodname" => "ibase_affected_rows", 
	"version" => "PHP5", 
	"method" => "int ibase_affected_rows ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Return the number of rows that were affected by the previous query", 
	"docurl" => "function.ibase-affected-rows.html" 
),
"ibase_backup" => array( 
	"methodname" => "ibase_backup", 
	"version" => "PHP5", 
	"method" => "mixed ibase_backup ( resource service_handle, string source_db, string dest_file [, int options [, bool verbose]] )", 
	"snippet" => "( \${1:\$service_handle}, \${2:\$source_db}, \${3:\$dest_file} )", 
	"desc" => "Initiates a backup task in the service manager and returns immediately", 
	"docurl" => "function.ibase-backup.html" 
),
"ibase_blob_add" => array( 
	"methodname" => "ibase_blob_add", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool ibase_blob_add ( resource blob_handle, string data )", 
	"snippet" => "( \${1:\$blob_handle}, \${2:\$data} )", 
	"desc" => "Add data into a newly created blob", 
	"docurl" => "function.ibase-blob-add.html" 
),
"ibase_blob_cancel" => array( 
	"methodname" => "ibase_blob_cancel", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool ibase_blob_cancel ( resource blob_handle )", 
	"snippet" => "( \${1:\$blob_handle} )", 
	"desc" => "Cancel creating blob", 
	"docurl" => "function.ibase-blob-cancel.html" 
),
"ibase_blob_close" => array( 
	"methodname" => "ibase_blob_close", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "mixed ibase_blob_close ( resource blob_handle )", 
	"snippet" => "( \${1:\$blob_handle} )", 
	"desc" => "Close blob", 
	"docurl" => "function.ibase-blob-close.html" 
),
"ibase_blob_create" => array( 
	"methodname" => "ibase_blob_create", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "resource ibase_blob_create ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Create a new blob for adding data", 
	"docurl" => "function.ibase-blob-create.html" 
),
"ibase_blob_echo" => array( 
	"methodname" => "ibase_blob_echo", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool ibase_blob_echo ( resource link_identifier, string blob_id )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$blob_id} )", 
	"desc" => "Output blob contents to browser", 
	"docurl" => "function.ibase-blob-echo.html" 
),
"ibase_blob_get" => array( 
	"methodname" => "ibase_blob_get", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string ibase_blob_get ( resource blob_handle, int len )", 
	"snippet" => "( \${1:\$blob_handle}, \${2:\$len} )", 
	"desc" => "Get len bytes data from open blob", 
	"docurl" => "function.ibase-blob-get.html" 
),
"ibase_blob_import" => array( 
	"methodname" => "ibase_blob_import", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string ibase_blob_import ( resource link_identifier, resource file_handle )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$file_handle} )", 
	"desc" => "Create blob, copy file in it, and close it", 
	"docurl" => "function.ibase-blob-import.html" 
),
"ibase_blob_info" => array( 
	"methodname" => "ibase_blob_info", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "array ibase_blob_info ( resource link_identifier, string blob_id )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$blob_id} )", 
	"desc" => "Return blob length and other useful info", 
	"docurl" => "function.ibase-blob-info.html" 
),
"ibase_blob_open" => array( 
	"methodname" => "ibase_blob_open", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "resource ibase_blob_open ( resource link_identifier, string blob_id )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$blob_id} )", 
	"desc" => "Open blob for retrieving data parts", 
	"docurl" => "function.ibase-blob-open.html" 
),
"ibase_close" => array( 
	"methodname" => "ibase_close", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool ibase_close ( [resource connection_id] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Close a connection to an InterBase database", 
	"docurl" => "function.ibase-close.html" 
),
"ibase_commit_ret" => array( 
	"methodname" => "ibase_commit_ret", 
	"version" => "PHP5", 
	"method" => "bool ibase_commit_ret ( [resource link_or_trans_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Commit a transaction without closing it", 
	"docurl" => "function.ibase-commit-ret.html" 
),
"ibase_commit" => array( 
	"methodname" => "ibase_commit", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool ibase_commit ( [resource link_or_trans_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Commit a transaction", 
	"docurl" => "function.ibase-commit.html" 
),
"ibase_connect" => array( 
	"methodname" => "ibase_connect", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource ibase_connect ( string database [, string username [, string password [, string charset [, int buffers [, int dialect [, string role]]]]]] )", 
	"snippet" => "( \${1:\$database} )", 
	"desc" => "Open a connection to an InterBase database", 
	"docurl" => "function.ibase-connect.html" 
),
"ibase_db_info" => array( 
	"methodname" => "ibase_db_info", 
	"version" => "PHP5", 
	"method" => "string ibase_db_info ( resource service_handle, string db, int action [, int argument] )", 
	"snippet" => "( \${1:\$service_handle}, \${2:\$db}, \${3:\$action} )", 
	"desc" => "Request statistics about a database", 
	"docurl" => "function.ibase-db-info.html" 
),
"ibase_delete_user" => array( 
	"methodname" => "ibase_delete_user", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ibase_delete_user ( resource service_handle, string user_name )", 
	"snippet" => "( \${1:\$service_handle}, \${2:\$user_name} )", 
	"desc" => "Delete a user from a security database (only for IB6 or later)", 
	"docurl" => "function.ibase-delete-user.html" 
),
"ibase_drop_db" => array( 
	"methodname" => "ibase_drop_db", 
	"version" => "PHP5", 
	"method" => "bool ibase_drop_db ( [resource connection] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Drops a database", 
	"docurl" => "function.ibase-drop-db.html" 
),
"ibase_errcode" => array( 
	"methodname" => "ibase_errcode", 
	"version" => "PHP5", 
	"method" => "int ibase_errcode ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return an error code", 
	"docurl" => "function.ibase-errcode.html" 
),
"ibase_errmsg" => array( 
	"methodname" => "ibase_errmsg", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string ibase_errmsg ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return error messages", 
	"docurl" => "function.ibase-errmsg.html" 
),
"ibase_execute" => array( 
	"methodname" => "ibase_execute", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource ibase_execute ( resource query [, mixed bind_arg [, mixed ...]] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Execute a previously prepared query", 
	"docurl" => "function.ibase-execute.html" 
),
"ibase_fetch_assoc" => array( 
	"methodname" => "ibase_fetch_assoc", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array ibase_fetch_assoc ( resource result [, int fetch_flag] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row from a query as an associative array", 
	"docurl" => "function.ibase-fetch-assoc.html" 
),
"ibase_fetch_object" => array( 
	"methodname" => "ibase_fetch_object", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "object ibase_fetch_object ( resource result_id [, int fetch_flag] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Get an object from a InterBase database", 
	"docurl" => "function.ibase-fetch-object.html" 
),
"ibase_fetch_row" => array( 
	"methodname" => "ibase_fetch_row", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "array ibase_fetch_row ( resource result_identifier [, int fetch_flag] )", 
	"snippet" => "( \${1:\$result_identifier} )", 
	"desc" => "Fetch a row from an InterBase database", 
	"docurl" => "function.ibase-fetch-row.html" 
),
"ibase_field_info" => array( 
	"methodname" => "ibase_field_info", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "array ibase_field_info ( resource result, int field_number )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_number} )", 
	"desc" => "Get information about a field", 
	"docurl" => "function.ibase-field-info.html" 
),
"ibase_free_event_handler" => array( 
	"methodname" => "ibase_free_event_handler", 
	"version" => "PHP5", 
	"method" => "bool ibase_free_event_handler ( resource event )", 
	"snippet" => "( \${1:\$event} )", 
	"desc" => "Cancels a registered event handler", 
	"docurl" => "function.ibase-free-event-handler.html" 
),
"ibase_free_query" => array( 
	"methodname" => "ibase_free_query", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool ibase_free_query ( resource query )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Free memory allocated by a prepared query", 
	"docurl" => "function.ibase-free-query.html" 
),
"ibase_free_result" => array( 
	"methodname" => "ibase_free_result", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool ibase_free_result ( resource result_identifier )", 
	"snippet" => "( \${1:\$result_identifier} )", 
	"desc" => "Free a result set", 
	"docurl" => "function.ibase-free-result.html" 
),
"ibase_gen_id" => array( 
	"methodname" => "ibase_gen_id", 
	"version" => "PHP5", 
	"method" => "int ibase_gen_id ( string generator [, int increment [, resource link_identifier]] )", 
	"snippet" => "( \${1:\$generator} )", 
	"desc" => "Increments the named generator and returns its new value", 
	"docurl" => "function.ibase-gen-id.html" 
),
"ibase_maintain_db" => array( 
	"methodname" => "ibase_maintain_db", 
	"version" => "PHP5", 
	"method" => "bool ibase_maintain_db ( resource service_handle, string db, int action [, int argument] )", 
	"snippet" => "( \${1:\$service_handle}, \${2:\$db}, \${3:\$action} )", 
	"desc" => "Execute a maintenance command on the database server", 
	"docurl" => "function.ibase-maintain-db.html" 
),
"ibase_modify_user" => array( 
	"methodname" => "ibase_modify_user", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ibase_modify_user ( resource service_handle, string user_name, string password [, string first_name [, string middle_name [, string last_name]]] )", 
	"snippet" => "( \${1:\$service_handle}, \${2:\$user_name}, \${3:\$password} )", 
	"desc" => "Modify a user to a security database (only for IB6 or later)", 
	"docurl" => "function.ibase-modify-user.html" 
),
"ibase_name_result" => array( 
	"methodname" => "ibase_name_result", 
	"version" => "PHP5", 
	"method" => "bool ibase_name_result ( resource result, string name )", 
	"snippet" => "( \${1:\$result}, \${2:\$name} )", 
	"desc" => "Assigns a name to a result set", 
	"docurl" => "function.ibase-name-result.html" 
),
"ibase_num_fields" => array( 
	"methodname" => "ibase_num_fields", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int ibase_num_fields ( resource result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Get the number of fields in a result set", 
	"docurl" => "function.ibase-num-fields.html" 
),
"ibase_num_params" => array( 
	"methodname" => "ibase_num_params", 
	"version" => "PHP5", 
	"method" => "int ibase_num_params ( resource query )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Return the number of parameters in a prepared query", 
	"docurl" => "function.ibase-num-params.html" 
),
"ibase_param_info" => array( 
	"methodname" => "ibase_param_info", 
	"version" => "PHP5", 
	"method" => "array ibase_param_info ( resource query, int param_number )", 
	"snippet" => "( \${1:\$query}, \${2:\$param_number} )", 
	"desc" => "Return information about a parameter in a prepared query", 
	"docurl" => "function.ibase-param-info.html" 
),
"ibase_pconnect" => array( 
	"methodname" => "ibase_pconnect", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource ibase_pconnect ( string database [, string username [, string password [, string charset [, int buffers [, int dialect [, string role]]]]]] )", 
	"snippet" => "( \${1:\$database} )", 
	"desc" => "Open a persistent connection to an InterBase database", 
	"docurl" => "function.ibase-pconnect.html" 
),
"ibase_prepare" => array( 
	"methodname" => "ibase_prepare", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource ibase_prepare ( string query )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Prepare a query for later binding of parameter placeholders and   execution", 
	"docurl" => "function.ibase-prepare.html" 
),
"ibase_query" => array( 
	"methodname" => "ibase_query", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource ibase_query ( [resource link_identifier, string query [, int bind_args]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Execute a query on an InterBase database", 
	"docurl" => "function.ibase-query.html" 
),
"ibase_restore" => array( 
	"methodname" => "ibase_restore", 
	"version" => "PHP5", 
	"method" => "mixed ibase_restore ( resource service_handle, string source_file, string dest_db [, int options [, bool verbose]] )", 
	"snippet" => "( \${1:\$service_handle}, \${2:\$source_file}, \${3:\$dest_db} )", 
	"desc" => "Initiates a restore task in the service manager and returns immediately", 
	"docurl" => "function.ibase-restore.html" 
),
"ibase_rollback_ret" => array( 
	"methodname" => "ibase_rollback_ret", 
	"version" => "PHP5", 
	"method" => "bool ibase_rollback_ret ( [resource link_or_trans_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Roll back a transaction without closing it", 
	"docurl" => "function.ibase-rollback-ret.html" 
),
"ibase_rollback" => array( 
	"methodname" => "ibase_rollback", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool ibase_rollback ( [resource link_or_trans_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Roll back a transaction", 
	"docurl" => "function.ibase-rollback.html" 
),
"ibase_server_info" => array( 
	"methodname" => "ibase_server_info", 
	"version" => "PHP5", 
	"method" => "string ibase_server_info ( resource service_handle, int action )", 
	"snippet" => "( \${1:\$service_handle}, \${2:\$action} )", 
	"desc" => "Request information about a database server", 
	"docurl" => "function.ibase-server-info.html" 
),
"ibase_service_attach" => array( 
	"methodname" => "ibase_service_attach", 
	"version" => "PHP5", 
	"method" => "resource ibase_service_attach ( string host, string dba_username, string dba_password )", 
	"snippet" => "( \${1:\$host}, \${2:\$dba_username}, \${3:\$dba_password} )", 
	"desc" => "Connect to the service manager", 
	"docurl" => "function.ibase-service-attach.html" 
),
"ibase_service_detach" => array( 
	"methodname" => "ibase_service_detach", 
	"version" => "PHP5", 
	"method" => "bool ibase_service_detach ( resource service_handle )", 
	"snippet" => "( \${1:\$service_handle} )", 
	"desc" => "Disconnect from the service manager", 
	"docurl" => "function.ibase-service-detach.html" 
),
"ibase_set_event_handler" => array( 
	"methodname" => "ibase_set_event_handler", 
	"version" => "PHP5", 
	"method" => "resource ibase_set_event_handler ( callback event_handler, string event_name1 [, string event_name2 [, string ...]] )", 
	"snippet" => "( \${1:\$event_handler}, \${2:\$event_name1} )", 
	"desc" => "Register a callback function to be called when events are posted", 
	"docurl" => "function.ibase-set-event-handler.html" 
),
"ibase_timefmt" => array( 
	"methodname" => "ibase_timefmt", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int ibase_timefmt ( string format [, int columntype] )", 
	"snippet" => "( \${1:\$format} )", 
	"desc" => "Sets the format of timestamp, date and time type columns returned from queries", 
	"docurl" => "function.ibase-timefmt.html" 
),
"ibase_trans" => array( 
	"methodname" => "ibase_trans", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "resource ibase_trans ( [int trans_args [, resource link_identifier]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Begin a transaction", 
	"docurl" => "function.ibase-trans.html" 
),
"ibase_wait_event" => array( 
	"methodname" => "ibase_wait_event", 
	"version" => "PHP5", 
	"method" => "string ibase_wait_event ( string event_name1 [, string event_name2 [, string ...]] )", 
	"snippet" => "( \${1:\$event_name1} )", 
	"desc" => "Wait for an event to be posted by the database", 
	"docurl" => "function.ibase-wait-event.html" 
),
"icap_close" => array( 
	"methodname" => "icap_close", 
	"version" => "undefined", 
	"method" => "int icap_close ( int icap_stream [, int flags] )", 
	"snippet" => "( \${1:\$icap_stream} )", 
	"desc" => "Close an ICAP stream", 
	"docurl" => "function.icap-close.html" 
),
"icap_create_calendar" => array( 
	"methodname" => "icap_create_calendar", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "string icap_create_calendar ( int stream_id, string calendar )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$calendar} )", 
	"desc" => "Create a new calendar", 
	"docurl" => "function.icap-create-calendar.html" 
),
"icap_delete_calendar" => array( 
	"methodname" => "icap_delete_calendar", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "string icap_delete_calendar ( int stream_id, string calendar )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$calendar} )", 
	"desc" => "Delete a calendar", 
	"docurl" => "function.icap-delete-calendar.html" 
),
"icap_delete_event" => array( 
	"methodname" => "icap_delete_event", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "string icap_delete_event ( int stream_id, int uid )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$uid} )", 
	"desc" => "Delete an event from an ICAP calendar", 
	"docurl" => "function.icap-delete-event.html" 
),
"icap_fetch_event" => array( 
	"methodname" => "icap_fetch_event", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "int icap_fetch_event ( int stream_id, int event_id [, int options] )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$event_id} )", 
	"desc" => "Fetches an event from the calendar stream/", 
	"docurl" => "function.icap-fetch-event.html" 
),
"icap_list_alarms" => array( 
	"methodname" => "icap_list_alarms", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "int icap_list_alarms ( int stream_id, array date, array time )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$date}, \${3:\$time} )", 
	"desc" => "Return a list of events that has an alarm triggered at the given   datetime", 
	"docurl" => "function.icap-list-alarms.html" 
),
"icap_list_events" => array( 
	"methodname" => "icap_list_events", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "array icap_list_events ( int stream_id, int begin_date [, int end_date] )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$begin_date} )", 
	"desc" => "Return a list of events between two given datetimes", 
	"docurl" => "function.icap-list-events.html" 
),
"icap_open" => array( 
	"methodname" => "icap_open", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "resource icap_open ( string calendar, string username, string password, string options )", 
	"snippet" => "( \${1:\$calendar}, \${2:\$username}, \${3:\$password}, \${4:\$options} )", 
	"desc" => "Opens up an ICAP connection", 
	"docurl" => "function.icap-open.html" 
),
"icap_rename_calendar" => array( 
	"methodname" => "icap_rename_calendar", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "string icap_rename_calendar ( int stream_id, string old_name, string new_name )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$old_name}, \${3:\$new_name} )", 
	"desc" => "Rename a calendar", 
	"docurl" => "function.icap-rename-calendar.html" 
),
"icap_reopen" => array( 
	"methodname" => "icap_reopen", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "int icap_reopen ( int stream_id, string calendar [, int options] )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$calendar} )", 
	"desc" => "Reopen ICAP stream to new calendar", 
	"docurl" => "function.icap-reopen.html" 
),
"icap_snooze" => array( 
	"methodname" => "icap_snooze", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "string icap_snooze ( int stream_id, int uid )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$uid} )", 
	"desc" => "Snooze an alarm", 
	"docurl" => "function.icap-snooze.html" 
),
"icap_store_event" => array( 
	"methodname" => "icap_store_event", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "string icap_store_event ( int stream_id, object event )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$event} )", 
	"desc" => "Store an event into an ICAP calendar", 
	"docurl" => "function.icap-store-event.html" 
),
"iconv_get_encoding" => array( 
	"methodname" => "iconv_get_encoding", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "mixed iconv_get_encoding ( [string type] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Retrieve internal configuration variables of iconv extension", 
	"docurl" => "function.iconv-get-encoding.html" 
),
"iconv_mime_decode_headers" => array( 
	"methodname" => "iconv_mime_decode_headers", 
	"version" => "PHP5", 
	"method" => "array iconv_mime_decode_headers ( string encoded_headers [, int mode [, string charset]] )", 
	"snippet" => "( \${1:\$encoded_headers} )", 
	"desc" => "Decodes multiple MIME header fields at once", 
	"docurl" => "function.iconv-mime-decode-headers.html" 
),
"iconv_mime_decode" => array( 
	"methodname" => "iconv_mime_decode", 
	"version" => "PHP5", 
	"method" => "string iconv_mime_decode ( string encoded_header [, int mode [, string charset]] )", 
	"snippet" => "( \${1:\$encoded_header} )", 
	"desc" => "Decodes a MIME header field", 
	"docurl" => "function.iconv-mime-decode.html" 
),
"iconv_mime_encode" => array( 
	"methodname" => "iconv_mime_encode", 
	"version" => "PHP5", 
	"method" => "string iconv_mime_encode ( string field_name, string field_value [, array preferences] )", 
	"snippet" => "( \${1:\$field_name}, \${2:\$field_value} )", 
	"desc" => "Composes a MIME header field", 
	"docurl" => "function.iconv-mime-encode.html" 
),
"iconv_set_encoding" => array( 
	"methodname" => "iconv_set_encoding", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool iconv_set_encoding ( string type, string charset )", 
	"snippet" => "( \${1:\$type}, \${2:\$charset} )", 
	"desc" => "Set current setting for character encoding conversion", 
	"docurl" => "function.iconv-set-encoding.html" 
),
"iconv_strlen" => array( 
	"methodname" => "iconv_strlen", 
	"version" => "PHP5", 
	"method" => "int iconv_strlen ( string str [, string charset] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Returns the character count of string", 
	"docurl" => "function.iconv-strlen.html" 
),
"iconv_strpos" => array( 
	"methodname" => "iconv_strpos", 
	"version" => "PHP5", 
	"method" => "int iconv_strpos ( string haystack, string needle [, int offset [, string charset]] )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Finds position of first occurrence of a needle within a haystack", 
	"docurl" => "function.iconv-strpos.html" 
),
"iconv_strrpos" => array( 
	"methodname" => "iconv_strrpos", 
	"version" => "PHP5", 
	"method" => "string iconv_strrpos ( string haystack, string needle [, string charset] )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Finds the last occurrence of a needle within the specified range of haystack", 
	"docurl" => "function.iconv-strrpos.html" 
),
"iconv_substr" => array( 
	"methodname" => "iconv_substr", 
	"version" => "PHP5", 
	"method" => "string iconv_substr ( string str, int offset [, int length [, string charset]] )", 
	"snippet" => "( \${1:\$str}, \${2:\$offset} )", 
	"desc" => "Cut out part of a string", 
	"docurl" => "function.iconv-substr.html" 
),
"iconv" => array( 
	"methodname" => "iconv", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string iconv ( string in_charset, string out_charset, string str )", 
	"snippet" => "( \${1:\$in_charset}, \${2:\$out_charset}, \${3:\$str} )", 
	"desc" => "Convert string to requested character encoding", 
	"docurl" => "function.iconv.html" 
),
"id3_get_frame_long_name" => array( 
	"methodname" => "id3_get_frame_long_name", 
	"version" => "undefined", 
	"method" => "string id3_get_frame_long_name ( string frameId )", 
	"snippet" => "( \${1:\$frameId} )", 
	"desc" => "Get the long name of an ID3v2 frame", 
	"docurl" => "function.id3-get-frame-long-name.html" 
),
"id3_get_frame_short_name" => array( 
	"methodname" => "id3_get_frame_short_name", 
	"version" => "undefined", 
	"method" => "string id3_get_frame_short_name ( string frameId )", 
	"snippet" => "( \${1:\$frameId} )", 
	"desc" => "Get the short name of an ID3v2 frame", 
	"docurl" => "function.id3-get-frame-short-name.html" 
),
"id3_get_genre_id" => array( 
	"methodname" => "id3_get_genre_id", 
	"version" => "undefined", 
	"method" => "int id3_get_genre_id ( string genre )", 
	"snippet" => "( \${1:\$genre} )", 
	"desc" => "Get the id for a genre", 
	"docurl" => "function.id3-get-genre-id.html" 
),
"id3_get_genre_list" => array( 
	"methodname" => "id3_get_genre_list", 
	"version" => "undefined", 
	"method" => "array id3_get_genre_list ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get all possible genre values", 
	"docurl" => "function.id3-get-genre-list.html" 
),
"id3_get_genre_name" => array( 
	"methodname" => "id3_get_genre_name", 
	"version" => "undefined", 
	"method" => "string id3_get_genre_name ( int genre_id )", 
	"snippet" => "( \${1:\$genre_id} )", 
	"desc" => "Get the name for a genre id", 
	"docurl" => "function.id3-get-genre-name.html" 
),
"id3_get_tag" => array( 
	"methodname" => "id3_get_tag", 
	"version" => "undefined", 
	"method" => "array id3_get_tag ( string filename [, int version] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Get all information stored in an ID3 tag", 
	"docurl" => "function.id3-get-tag.html" 
),
"id3_get_version" => array( 
	"methodname" => "id3_get_version", 
	"version" => "undefined", 
	"method" => "int id3_get_version ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Get version of an ID3 tag", 
	"docurl" => "function.id3-get-version.html" 
),
"id3_remove_tag" => array( 
	"methodname" => "id3_remove_tag", 
	"version" => "undefined", 
	"method" => "bool id3_remove_tag ( string filename [, int version] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Remove an existing ID3 tag", 
	"docurl" => "function.id3-remove-tag.html" 
),
"id3_set_tag" => array( 
	"methodname" => "id3_set_tag", 
	"version" => "undefined", 
	"method" => "bool id3_set_tag ( string filename, array tag [, int version] )", 
	"snippet" => "( \${1:\$filename}, \${2:\$tag} )", 
	"desc" => "Update information stored in an ID3 tag", 
	"docurl" => "function.id3-set-tag.html" 
),
"idate" => array( 
	"methodname" => "idate", 
	"version" => "PHP5", 
	"method" => "int idate ( string format [, int timestamp] )", 
	"snippet" => "( \${1:\$format} )", 
	"desc" => "Format a local time/date as integer", 
	"docurl" => "function.idate.html" 
),
"ifx_affected_rows" => array( 
	"methodname" => "ifx_affected_rows", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int ifx_affected_rows ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Get number of rows affected by a query", 
	"docurl" => "function.ifx-affected-rows.html" 
),
"ifx_blobinfile_mode" => array( 
	"methodname" => "ifx_blobinfile_mode", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "void ifx_blobinfile_mode ( int mode )", 
	"snippet" => "( \${1:\$mode} )", 
	"desc" => "Set the default blob mode for all select queries", 
	"docurl" => "function.ifx-blobinfile-mode.html" 
),
"ifx_byteasvarchar" => array( 
	"methodname" => "ifx_byteasvarchar", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "void ifx_byteasvarchar ( int mode )", 
	"snippet" => "( \${1:\$mode} )", 
	"desc" => "Set the default byte mode", 
	"docurl" => "function.ifx-byteasvarchar.html" 
),
"ifx_close" => array( 
	"methodname" => "ifx_close", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int ifx_close ( [int link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Close Informix connection", 
	"docurl" => "function.ifx-close.html" 
),
"ifx_connect" => array( 
	"methodname" => "ifx_connect", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int ifx_connect ( [string database [, string userid [, string password]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open Informix server connection", 
	"docurl" => "function.ifx-connect.html" 
),
"ifx_copy_blob" => array( 
	"methodname" => "ifx_copy_blob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifx_copy_blob ( int bid )", 
	"snippet" => "( \${1:\$bid} )", 
	"desc" => "Duplicates the given blob object", 
	"docurl" => "function.ifx-copy-blob.html" 
),
"ifx_create_blob" => array( 
	"methodname" => "ifx_create_blob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifx_create_blob ( int type, int mode, string param )", 
	"snippet" => "( \${1:\$type}, \${2:\$mode}, \${3:\$param} )", 
	"desc" => "Creates an blob object", 
	"docurl" => "function.ifx-create-blob.html" 
),
"ifx_create_char" => array( 
	"methodname" => "ifx_create_char", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int ifx_create_char ( string param )", 
	"snippet" => "( \${1:\$param} )", 
	"desc" => "Creates an char object", 
	"docurl" => "function.ifx-create-char.html" 
),
"ifx_do" => array( 
	"methodname" => "ifx_do", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifx_do ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Execute a previously prepared SQL-statement", 
	"docurl" => "function.ifx-do.html" 
),
"ifx_error" => array( 
	"methodname" => "ifx_error", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "string ifx_error ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns error code of last Informix call", 
	"docurl" => "function.ifx-error.html" 
),
"ifx_errormsg" => array( 
	"methodname" => "ifx_errormsg", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "string ifx_errormsg ( [int errorcode] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns error message of last Informix call", 
	"docurl" => "function.ifx-errormsg.html" 
),
"ifx_fetch_row" => array( 
	"methodname" => "ifx_fetch_row", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "array ifx_fetch_row ( int result_id [, mixed position] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Get row as enumerated array", 
	"docurl" => "function.ifx-fetch-row.html" 
),
"ifx_fieldproperties" => array( 
	"methodname" => "ifx_fieldproperties", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "array ifx_fieldproperties ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "List of SQL fieldproperties", 
	"docurl" => "function.ifx-fieldproperties.html" 
),
"ifx_fieldtypes" => array( 
	"methodname" => "ifx_fieldtypes", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "array ifx_fieldtypes ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "List of Informix SQL fields", 
	"docurl" => "function.ifx-fieldtypes.html" 
),
"ifx_free_blob" => array( 
	"methodname" => "ifx_free_blob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifx_free_blob ( int bid )", 
	"snippet" => "( \${1:\$bid} )", 
	"desc" => "Deletes the blob object", 
	"docurl" => "function.ifx-free-blob.html" 
),
"ifx_free_char" => array( 
	"methodname" => "ifx_free_char", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int ifx_free_char ( int bid )", 
	"snippet" => "( \${1:\$bid} )", 
	"desc" => "Deletes the char object", 
	"docurl" => "function.ifx-free-char.html" 
),
"ifx_free_result" => array( 
	"methodname" => "ifx_free_result", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int ifx_free_result ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Releases resources for the query", 
	"docurl" => "function.ifx-free-result.html" 
),
"ifx_get_blob" => array( 
	"methodname" => "ifx_get_blob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifx_get_blob ( int bid )", 
	"snippet" => "( \${1:\$bid} )", 
	"desc" => "Return the content of a blob object", 
	"docurl" => "function.ifx-get-blob.html" 
),
"ifx_get_char" => array( 
	"methodname" => "ifx_get_char", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int ifx_get_char ( int bid )", 
	"snippet" => "( \${1:\$bid} )", 
	"desc" => "Return the content of the char object", 
	"docurl" => "function.ifx-get-char.html" 
),
"ifx_getsqlca" => array( 
	"methodname" => "ifx_getsqlca", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "array ifx_getsqlca ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Get the contents of sqlca.sqlerrd[0..5] after a query", 
	"docurl" => "function.ifx-getsqlca.html" 
),
"ifx_htmltbl_result" => array( 
	"methodname" => "ifx_htmltbl_result", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int ifx_htmltbl_result ( int result_id [, string html_table_options] )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Formats all rows of a query into a HTML table", 
	"docurl" => "function.ifx-htmltbl-result.html" 
),
"ifx_nullformat" => array( 
	"methodname" => "ifx_nullformat", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "void ifx_nullformat ( int mode )", 
	"snippet" => "( \${1:\$mode} )", 
	"desc" => "Sets the default return value on a fetch row", 
	"docurl" => "function.ifx-nullformat.html" 
),
"ifx_num_fields" => array( 
	"methodname" => "ifx_num_fields", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int ifx_num_fields ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Returns the number of columns in the query", 
	"docurl" => "function.ifx-num-fields.html" 
),
"ifx_num_rows" => array( 
	"methodname" => "ifx_num_rows", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int ifx_num_rows ( int result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Count the rows already fetched from a query", 
	"docurl" => "function.ifx-num-rows.html" 
),
"ifx_pconnect" => array( 
	"methodname" => "ifx_pconnect", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int ifx_pconnect ( [string database [, string userid [, string password]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open persistent Informix connection", 
	"docurl" => "function.ifx-pconnect.html" 
),
"ifx_prepare" => array( 
	"methodname" => "ifx_prepare", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifx_prepare ( string query, int conn_id [, int cursor_def, mixed blobidarray] )", 
	"snippet" => "( \${1:\$query}, \${2:\$conn_id} )", 
	"desc" => "Prepare an SQL-statement for execution", 
	"docurl" => "function.ifx-prepare.html" 
),
"ifx_query" => array( 
	"methodname" => "ifx_query", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int ifx_query ( string query, int link_identifier [, int cursor_type [, mixed blobidarray]] )", 
	"snippet" => "( \${1:\$query}, \${2:\$link_identifier} )", 
	"desc" => "Send Informix query", 
	"docurl" => "function.ifx-query.html" 
),
"ifx_textasvarchar" => array( 
	"methodname" => "ifx_textasvarchar", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "void ifx_textasvarchar ( int mode )", 
	"snippet" => "( \${1:\$mode} )", 
	"desc" => "Set the default text mode", 
	"docurl" => "function.ifx-textasvarchar.html" 
),
"ifx_update_blob" => array( 
	"methodname" => "ifx_update_blob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "bool ifx_update_blob ( int bid, string content )", 
	"snippet" => "( \${1:\$bid}, \${2:\$content} )", 
	"desc" => "Updates the content of the blob object", 
	"docurl" => "function.ifx-update-blob.html" 
),
"ifx_update_char" => array( 
	"methodname" => "ifx_update_char", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int ifx_update_char ( int bid, string content )", 
	"snippet" => "( \${1:\$bid}, \${2:\$content} )", 
	"desc" => "Updates the content of the char object", 
	"docurl" => "function.ifx-update-char.html" 
),
"ifxus_close_slob" => array( 
	"methodname" => "ifxus_close_slob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifxus_close_slob ( int bid )", 
	"snippet" => "( \${1:\$bid} )", 
	"desc" => "Deletes the slob object", 
	"docurl" => "function.ifxus-close-slob.html" 
),
"ifxus_create_slob" => array( 
	"methodname" => "ifxus_create_slob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifxus_create_slob ( int mode )", 
	"snippet" => "( \${1:\$mode} )", 
	"desc" => "Creates an slob object and opens it", 
	"docurl" => "function.ifxus-create-slob.html" 
),
"ifxus_free_slob" => array( 
	"methodname" => "ifxus_free_slob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifxus_free_slob ( int bid )", 
	"snippet" => "( \${1:\$bid} )", 
	"desc" => "Deletes the slob object", 
	"docurl" => "function.ifxus-free-slob.html" 
),
"ifxus_open_slob" => array( 
	"methodname" => "ifxus_open_slob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifxus_open_slob ( int bid, int mode )", 
	"snippet" => "( \${1:\$bid}, \${2:\$mode} )", 
	"desc" => "Opens an slob object", 
	"docurl" => "function.ifxus-open-slob.html" 
),
"ifxus_read_slob" => array( 
	"methodname" => "ifxus_read_slob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifxus_read_slob ( int bid, int nbytes )", 
	"snippet" => "( \${1:\$bid}, \${2:\$nbytes} )", 
	"desc" => "Reads nbytes of the slob object", 
	"docurl" => "function.ifxus-read-slob.html" 
),
"ifxus_seek_slob" => array( 
	"methodname" => "ifxus_seek_slob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifxus_seek_slob ( int bid, int mode, int offset )", 
	"snippet" => "( \${1:\$bid}, \${2:\$mode}, \${3:\$offset} )", 
	"desc" => "Sets the current file or seek position", 
	"docurl" => "function.ifxus-seek-slob.html" 
),
"ifxus_tell_slob" => array( 
	"methodname" => "ifxus_tell_slob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifxus_tell_slob ( int bid )", 
	"snippet" => "( \${1:\$bid} )", 
	"desc" => "Returns the current file or seek position", 
	"docurl" => "function.ifxus-tell-slob.html" 
),
"ifxus_write_slob" => array( 
	"methodname" => "ifxus_write_slob", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "int ifxus_write_slob ( int bid, string content )", 
	"snippet" => "( \${1:\$bid}, \${2:\$content} )", 
	"desc" => "Writes a string into the slob object", 
	"docurl" => "function.ifxus-write-slob.html" 
),
"ignore_user_abort" => array( 
	"methodname" => "ignore_user_abort", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int ignore_user_abort ( [bool setting] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Set whether a client disconnect should abort script execution", 
	"docurl" => "function.ignore-user-abort.html" 
),
"iis_add_server" => array( 
	"methodname" => "iis_add_server", 
	"version" => "undefined", 
	"method" => "int iis_add_server ( string path, string comment, string server_ip, int port, string host_name, int rights, int start_server )", 
	"snippet" => "( \${1:\$path}, \${2:\$comment}, \${3:\$server_ip}, \${4:\$port}, \${5:\$host_name}, \${6:\$rights}, \${7:\$start_server} )", 
	"desc" => "", 
	"docurl" => "function.iis-add-server.html" 
),
"iis_get_dir_security" => array( 
	"methodname" => "iis_get_dir_security", 
	"version" => "undefined", 
	"method" => "int iis_get_dir_security ( int server_instance, string virtual_path )", 
	"snippet" => "( \${1:\$server_instance}, \${2:\$virtual_path} )", 
	"desc" => "", 
	"docurl" => "function.iis-get-dir-security.html" 
),
"iis_get_script_map" => array( 
	"methodname" => "iis_get_script_map", 
	"version" => "undefined", 
	"method" => "int iis_get_script_map ( int server_instance, string virtual_path, string script_extension )", 
	"snippet" => "( \${1:\$server_instance}, \${2:\$virtual_path}, \${3:\$script_extension} )", 
	"desc" => "", 
	"docurl" => "function.iis-get-script-map.html" 
),
"iis_get_server_by_comment" => array( 
	"methodname" => "iis_get_server_by_comment", 
	"version" => "undefined", 
	"method" => "int iis_get_server_by_comment ( string comment )", 
	"snippet" => "( \${1:\$comment} )", 
	"desc" => "", 
	"docurl" => "function.iis-get-server-by-comment.html" 
),
"iis_get_server_by_path" => array( 
	"methodname" => "iis_get_server_by_path", 
	"version" => "undefined", 
	"method" => "int iis_get_server_by_path ( string path )", 
	"snippet" => "( \${1:\$path} )", 
	"desc" => "", 
	"docurl" => "function.iis-get-server-by-path.html" 
),
"iis_get_server_rights" => array( 
	"methodname" => "iis_get_server_rights", 
	"version" => "undefined", 
	"method" => "int iis_get_server_rights ( int server_instance, string virtual_path )", 
	"snippet" => "( \${1:\$server_instance}, \${2:\$virtual_path} )", 
	"desc" => "", 
	"docurl" => "function.iis-get-server-rights.html" 
),
"iis_get_service_state" => array( 
	"methodname" => "iis_get_service_state", 
	"version" => "undefined", 
	"method" => "int iis_get_service_state ( string service_id )", 
	"snippet" => "( \${1:\$service_id} )", 
	"desc" => "", 
	"docurl" => "function.iis-get-service-state.html" 
),
"iis_remove_server" => array( 
	"methodname" => "iis_remove_server", 
	"version" => "undefined", 
	"method" => "int iis_remove_server ( int server_instance )", 
	"snippet" => "( \${1:\$server_instance} )", 
	"desc" => "", 
	"docurl" => "function.iis-remove-server.html" 
),
"iis_set_app_settings" => array( 
	"methodname" => "iis_set_app_settings", 
	"version" => "undefined", 
	"method" => "int iis_set_app_settings ( int server_instance, string virtual_path, string application_scope )", 
	"snippet" => "( \${1:\$server_instance}, \${2:\$virtual_path}, \${3:\$application_scope} )", 
	"desc" => "", 
	"docurl" => "function.iis-set-app-settings.html" 
),
"iis_set_dir_security" => array( 
	"methodname" => "iis_set_dir_security", 
	"version" => "undefined", 
	"method" => "int iis_set_dir_security ( int server_instance, string virtual_path, int directory_flags )", 
	"snippet" => "( \${1:\$server_instance}, \${2:\$virtual_path}, \${3:\$directory_flags} )", 
	"desc" => "", 
	"docurl" => "function.iis-set-dir-security.html" 
),
"iis_set_script_map" => array( 
	"methodname" => "iis_set_script_map", 
	"version" => "undefined", 
	"method" => "int iis_set_script_map ( int server_instance, string virtual_path, string script_extension, string engine_path, int allow_scripting )", 
	"snippet" => "( \${1:\$server_instance}, \${2:\$virtual_path}, \${3:\$script_extension}, \${4:\$engine_path}, \${5:\$allow_scripting} )", 
	"desc" => "", 
	"docurl" => "function.iis-set-script-map.html" 
),
"iis_set_server_rights" => array( 
	"methodname" => "iis_set_server_rights", 
	"version" => "undefined", 
	"method" => "int iis_set_server_rights ( int server_instance, string virtual_path, int directory_flags )", 
	"snippet" => "( \${1:\$server_instance}, \${2:\$virtual_path}, \${3:\$directory_flags} )", 
	"desc" => "", 
	"docurl" => "function.iis-set-server-rights.html" 
),
"iis_start_server" => array( 
	"methodname" => "iis_start_server", 
	"version" => "undefined", 
	"method" => "int iis_start_server ( int server_instance )", 
	"snippet" => "( \${1:\$server_instance} )", 
	"desc" => "", 
	"docurl" => "function.iis-start-server.html" 
),
"iis_start_service" => array( 
	"methodname" => "iis_start_service", 
	"version" => "undefined", 
	"method" => "int iis_start_service ( string service_id )", 
	"snippet" => "( \${1:\$service_id} )", 
	"desc" => "", 
	"docurl" => "function.iis-start-service.html" 
),
"iis_stop_server" => array( 
	"methodname" => "iis_stop_server", 
	"version" => "undefined", 
	"method" => "int iis_stop_server ( int server_instance )", 
	"snippet" => "( \${1:\$server_instance} )", 
	"desc" => "", 
	"docurl" => "function.iis-stop-server.html" 
),
"iis_stop_service" => array( 
	"methodname" => "iis_stop_service", 
	"version" => "undefined", 
	"method" => "int iis_stop_service ( string service_id )", 
	"snippet" => "( \${1:\$service_id} )", 
	"desc" => "", 
	"docurl" => "function.iis-stop-service.html" 
),
"image_type_to_extension" => array( 
	"methodname" => "image_type_to_extension", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "string image_type_to_extension ( int imagetype [, bool include_dot] )", 
	"snippet" => "( \${1:\$imagetype} )", 
	"desc" => "Get file extension for image type", 
	"docurl" => "function.image-type-to-extension.html" 
),
"image_type_to_mime_type" => array( 
	"methodname" => "image_type_to_mime_type", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string image_type_to_mime_type ( int imagetype )", 
	"snippet" => "( \${1:\$imagetype} )", 
	"desc" => "Get Mime-Type for image-type returned by getimagesize, exif_read_data, exif_thumbnail, exif_imagetype", 
	"docurl" => "function.image-type-to-mime-type.html" 
),
"image2wbmp" => array( 
	"methodname" => "image2wbmp", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int image2wbmp ( resource image [, string filename [, int threshold]] )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Output image to browser or file", 
	"docurl" => "function.image2wbmp.html" 
),
"imagealphablending" => array( 
	"methodname" => "imagealphablending", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool imagealphablending ( resource image, bool blendmode )", 
	"snippet" => "( \${1:\$image}, \${2:\$blendmode} )", 
	"desc" => "Set the blending mode for an image", 
	"docurl" => "function.imagealphablending.html" 
),
"imageantialias" => array( 
	"methodname" => "imageantialias", 
	"version" => "PHP4 >= 4.3.2, PHP5", 
	"method" => "bool imageantialias ( resource im, bool on )", 
	"snippet" => "( \${1:\$im}, \${2:\$on} )", 
	"desc" => "Should antialias functions be used or not", 
	"docurl" => "function.imageantialias.html" 
),
"imagearc" => array( 
	"methodname" => "imagearc", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagearc ( resource image, int cx, int cy, int w, int h, int s, int e, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$cx}, \${3:\$cy}, \${4:\$w}, \${5:\$h}, \${6:\$s}, \${7:\$e}, \${8:\$color} )", 
	"desc" => "Draw a partial ellipse", 
	"docurl" => "function.imagearc.html" 
),
"imagechar" => array( 
	"methodname" => "imagechar", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagechar ( resource image, int font, int x, int y, string c, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$font}, \${3:\$x}, \${4:\$y}, \${5:\$c}, \${6:\$color} )", 
	"desc" => "Draw a character horizontally", 
	"docurl" => "function.imagechar.html" 
),
"imagecharup" => array( 
	"methodname" => "imagecharup", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagecharup ( resource image, int font, int x, int y, string c, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$font}, \${3:\$x}, \${4:\$y}, \${5:\$c}, \${6:\$color} )", 
	"desc" => "Draw a character vertically", 
	"docurl" => "function.imagecharup.html" 
),
"imagecolorallocate" => array( 
	"methodname" => "imagecolorallocate", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagecolorallocate ( resource image, int red, int green, int blue )", 
	"snippet" => "( \${1:\$image}, \${2:\$red}, \${3:\$green}, \${4:\$blue} )", 
	"desc" => "Allocate a color for an image", 
	"docurl" => "function.imagecolorallocate.html" 
),
"imagecolorallocatealpha" => array( 
	"methodname" => "imagecolorallocatealpha", 
	"version" => "PHP4 >= 4.3.2, PHP5", 
	"method" => "int imagecolorallocatealpha ( resource image, int red, int green, int blue, int alpha )", 
	"snippet" => "( \${1:\$image}, \${2:\$red}, \${3:\$green}, \${4:\$blue}, \${5:\$alpha} )", 
	"desc" => "Allocate a color for an image", 
	"docurl" => "function.imagecolorallocatealpha.html" 
),
"imagecolorat" => array( 
	"methodname" => "imagecolorat", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagecolorat ( resource image, int x, int y )", 
	"snippet" => "( \${1:\$image}, \${2:\$x}, \${3:\$y} )", 
	"desc" => "Get the index of the color of a pixel", 
	"docurl" => "function.imagecolorat.html" 
),
"imagecolorclosest" => array( 
	"methodname" => "imagecolorclosest", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagecolorclosest ( resource image, int red, int green, int blue )", 
	"snippet" => "( \${1:\$image}, \${2:\$red}, \${3:\$green}, \${4:\$blue} )", 
	"desc" => "Get the index of the closest color to the specified color", 
	"docurl" => "function.imagecolorclosest.html" 
),
"imagecolorclosestalpha" => array( 
	"methodname" => "imagecolorclosestalpha", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int imagecolorclosestalpha ( resource image, int red, int green, int blue, int alpha )", 
	"snippet" => "( \${1:\$image}, \${2:\$red}, \${3:\$green}, \${4:\$blue}, \${5:\$alpha} )", 
	"desc" => "Get the index of the closest color to the specified color + alpha", 
	"docurl" => "function.imagecolorclosestalpha.html" 
),
"imagecolorclosesthwb" => array( 
	"methodname" => "imagecolorclosesthwb", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "int imagecolorclosesthwb ( resource image, int red, int green, int blue )", 
	"snippet" => "( \${1:\$image}, \${2:\$red}, \${3:\$green}, \${4:\$blue} )", 
	"desc" => "Get the index of the color which has the hue, white and blackness nearest to the given color", 
	"docurl" => "function.imagecolorclosesthwb.html" 
),
"imagecolordeallocate" => array( 
	"methodname" => "imagecolordeallocate", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int imagecolordeallocate ( resource image, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$color} )", 
	"desc" => "De-allocate a color for an image", 
	"docurl" => "function.imagecolordeallocate.html" 
),
"imagecolorexact" => array( 
	"methodname" => "imagecolorexact", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagecolorexact ( resource image, int red, int green, int blue )", 
	"snippet" => "( \${1:\$image}, \${2:\$red}, \${3:\$green}, \${4:\$blue} )", 
	"desc" => "Get the index of the specified color", 
	"docurl" => "function.imagecolorexact.html" 
),
"imagecolorexactalpha" => array( 
	"methodname" => "imagecolorexactalpha", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int imagecolorexactalpha ( resource image, int red, int green, int blue, int alpha )", 
	"snippet" => "( \${1:\$image}, \${2:\$red}, \${3:\$green}, \${4:\$blue}, \${5:\$alpha} )", 
	"desc" => "Get the index of the specified color + alpha", 
	"docurl" => "function.imagecolorexactalpha.html" 
),
"imagecolormatch" => array( 
	"methodname" => "imagecolormatch", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool imagecolormatch ( resource image1, resource image2 )", 
	"snippet" => "( \${1:\$image1}, \${2:\$image2} )", 
	"desc" => "Makes the colors of the palette version of an image more closely match   the true color version", 
	"docurl" => "function.imagecolormatch.html" 
),
"imagecolorresolve" => array( 
	"methodname" => "imagecolorresolve", 
	"version" => "PHP3>= 3.0.2, PHP4, PHP5", 
	"method" => "int imagecolorresolve ( resource image, int red, int green, int blue )", 
	"snippet" => "( \${1:\$image}, \${2:\$red}, \${3:\$green}, \${4:\$blue} )", 
	"desc" => "Get the index of the specified color or its closest possible   alternative", 
	"docurl" => "function.imagecolorresolve.html" 
),
"imagecolorresolvealpha" => array( 
	"methodname" => "imagecolorresolvealpha", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int imagecolorresolvealpha ( resource image, int red, int green, int blue, int alpha )", 
	"snippet" => "( \${1:\$image}, \${2:\$red}, \${3:\$green}, \${4:\$blue}, \${5:\$alpha} )", 
	"desc" => "Get the index of the specified color + alpha or its closest possible   alternative", 
	"docurl" => "function.imagecolorresolvealpha.html" 
),
"imagecolorset" => array( 
	"methodname" => "imagecolorset", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imagecolorset ( resource image, int index, int red, int green, int blue )", 
	"snippet" => "( \${1:\$image}, \${2:\$index}, \${3:\$red}, \${4:\$green}, \${5:\$blue} )", 
	"desc" => "Set the color for the specified palette index", 
	"docurl" => "function.imagecolorset.html" 
),
"imagecolorsforindex" => array( 
	"methodname" => "imagecolorsforindex", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array imagecolorsforindex ( resource image, int index )", 
	"snippet" => "( \${1:\$image}, \${2:\$index} )", 
	"desc" => "Get the colors for an index", 
	"docurl" => "function.imagecolorsforindex.html" 
),
"imagecolorstotal" => array( 
	"methodname" => "imagecolorstotal", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagecolorstotal ( resource image )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Find out the number of colors in an image\'s palette", 
	"docurl" => "function.imagecolorstotal.html" 
),
"imagecolortransparent" => array( 
	"methodname" => "imagecolortransparent", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagecolortransparent ( resource image [, int color] )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Define a color as transparent", 
	"docurl" => "function.imagecolortransparent.html" 
),
"imagecopy" => array( 
	"methodname" => "imagecopy", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int imagecopy ( resource dst_im, resource src_im, int dst_x, int dst_y, int src_x, int src_y, int src_w, int src_h )", 
	"snippet" => "( \${1:\$dst_im}, \${2:\$src_im}, \${3:\$dst_x}, \${4:\$dst_y}, \${5:\$src_x}, \${6:\$src_y}, \${7:\$src_w}, \${8:\$src_h} )", 
	"desc" => "Copy part of an image", 
	"docurl" => "function.imagecopy.html" 
),
"imagecopymerge" => array( 
	"methodname" => "imagecopymerge", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "int imagecopymerge ( resource dst_im, resource src_im, int dst_x, int dst_y, int src_x, int src_y, int src_w, int src_h, int pct )", 
	"snippet" => "( \${1:\$dst_im}, \${2:\$src_im}, \${3:\$dst_x}, \${4:\$dst_y}, \${5:\$src_x}, \${6:\$src_y}, \${7:\$src_w}, \${8:\$src_h}, \${9:\$pct} )", 
	"desc" => "Copy and merge part of an image", 
	"docurl" => "function.imagecopymerge.html" 
),
"imagecopymergegray" => array( 
	"methodname" => "imagecopymergegray", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int imagecopymergegray ( resource dst_im, resource src_im, int dst_x, int dst_y, int src_x, int src_y, int src_w, int src_h, int pct )", 
	"snippet" => "( \${1:\$dst_im}, \${2:\$src_im}, \${3:\$dst_x}, \${4:\$dst_y}, \${5:\$src_x}, \${6:\$src_y}, \${7:\$src_w}, \${8:\$src_h}, \${9:\$pct} )", 
	"desc" => "Copy and merge part of an image with gray scale", 
	"docurl" => "function.imagecopymergegray.html" 
),
"imagecopyresampled" => array( 
	"methodname" => "imagecopyresampled", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool imagecopyresampled ( resource dst_image, resource src_image, int dst_x, int dst_y, int src_x, int src_y, int dst_w, int dst_h, int src_w, int src_h )", 
	"snippet" => "( \${1:\$dst_image}, \${2:\$src_image}, \${3:\$dst_x}, \${4:\$dst_y}, \${5:\$src_x}, \${6:\$src_y}, \${7:\$dst_w}, \${8:\$dst_h}, \${9:\$src_w}, \${10:\$src_h} )", 
	"desc" => "Copy and resize part of an image with resampling", 
	"docurl" => "function.imagecopyresampled.html" 
),
"imagecopyresized" => array( 
	"methodname" => "imagecopyresized", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagecopyresized ( resource dst_image, resource src_image, int dst_x, int dst_y, int src_x, int src_y, int dst_w, int dst_h, int src_w, int src_h )", 
	"snippet" => "( \${1:\$dst_image}, \${2:\$src_image}, \${3:\$dst_x}, \${4:\$dst_y}, \${5:\$src_x}, \${6:\$src_y}, \${7:\$dst_w}, \${8:\$dst_h}, \${9:\$src_w}, \${10:\$src_h} )", 
	"desc" => "Copy and resize part of an image", 
	"docurl" => "function.imagecopyresized.html" 
),
"imagecreate" => array( 
	"methodname" => "imagecreate", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource imagecreate ( int x_size, int y_size )", 
	"snippet" => "( \${1:\$x_size}, \${2:\$y_size} )", 
	"desc" => "Create a new palette based image", 
	"docurl" => "function.imagecreate.html" 
),
"imagecreatefromgd" => array( 
	"methodname" => "imagecreatefromgd", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "resource imagecreatefromgd ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Create a new image from GD file or URL", 
	"docurl" => "function.imagecreatefromgd.html" 
),
"imagecreatefromgd2" => array( 
	"methodname" => "imagecreatefromgd2", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "resource imagecreatefromgd2 ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Create a new image from GD2 file or URL", 
	"docurl" => "function.imagecreatefromgd2.html" 
),
"imagecreatefromgd2part" => array( 
	"methodname" => "imagecreatefromgd2part", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "resource imagecreatefromgd2part ( string filename, int srcX, int srcY, int width, int height )", 
	"snippet" => "( \${1:\$filename}, \${2:\$srcX}, \${3:\$srcY}, \${4:\$width}, \${5:\$height} )", 
	"desc" => "Create a new image from a given part of GD2 file or URL", 
	"docurl" => "function.imagecreatefromgd2part.html" 
),
"imagecreatefromgif" => array( 
	"methodname" => "imagecreatefromgif", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource imagecreatefromgif ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Create a new image from file or URL", 
	"docurl" => "function.imagecreatefromgif.html" 
),
"imagecreatefromjpeg" => array( 
	"methodname" => "imagecreatefromjpeg", 
	"version" => "PHP3>= 3.0.16, PHP4, PHP5", 
	"method" => "resource imagecreatefromjpeg ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Create a new image from file or URL", 
	"docurl" => "function.imagecreatefromjpeg.html" 
),
"imagecreatefrompng" => array( 
	"methodname" => "imagecreatefrompng", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "resource imagecreatefrompng ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Create a new image from file or URL", 
	"docurl" => "function.imagecreatefrompng.html" 
),
"imagecreatefromstring" => array( 
	"methodname" => "imagecreatefromstring", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource imagecreatefromstring ( string image )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Create a new image from the image stream in the string", 
	"docurl" => "function.imagecreatefromstring.html" 
),
"imagecreatefromwbmp" => array( 
	"methodname" => "imagecreatefromwbmp", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "resource imagecreatefromwbmp ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Create a new image from file or URL", 
	"docurl" => "function.imagecreatefromwbmp.html" 
),
"imagecreatefromxbm" => array( 
	"methodname" => "imagecreatefromxbm", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "resource imagecreatefromxbm ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Create a new image from file or URL", 
	"docurl" => "function.imagecreatefromxbm.html" 
),
"imagecreatefromxpm" => array( 
	"methodname" => "imagecreatefromxpm", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "resource imagecreatefromxpm ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Create a new image from file or URL", 
	"docurl" => "function.imagecreatefromxpm.html" 
),
"imagecreatetruecolor" => array( 
	"methodname" => "imagecreatetruecolor", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "resource imagecreatetruecolor ( int x_size, int y_size )", 
	"snippet" => "( \${1:\$x_size}, \${2:\$y_size} )", 
	"desc" => "Create a new true color image", 
	"docurl" => "function.imagecreatetruecolor.html" 
),
"imagedashedline" => array( 
	"methodname" => "imagedashedline", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagedashedline ( resource image, int x1, int y1, int x2, int y2, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$x1}, \${3:\$y1}, \${4:\$x2}, \${5:\$y2}, \${6:\$color} )", 
	"desc" => "Draw a dashed line", 
	"docurl" => "function.imagedashedline.html" 
),
"imagedestroy" => array( 
	"methodname" => "imagedestroy", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imagedestroy ( resource image )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Destroy an image", 
	"docurl" => "function.imagedestroy.html" 
),
"imageellipse" => array( 
	"methodname" => "imageellipse", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int imageellipse ( resource image, int cx, int cy, int w, int h, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$cx}, \${3:\$cy}, \${4:\$w}, \${5:\$h}, \${6:\$color} )", 
	"desc" => "Draw an ellipse", 
	"docurl" => "function.imageellipse.html" 
),
"imagefill" => array( 
	"methodname" => "imagefill", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagefill ( resource image, int x, int y, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$x}, \${3:\$y}, \${4:\$color} )", 
	"desc" => "Flood fill", 
	"docurl" => "function.imagefill.html" 
),
"imagefilledarc" => array( 
	"methodname" => "imagefilledarc", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool imagefilledarc ( resource image, int cx, int cy, int w, int h, int s, int e, int color, int style )", 
	"snippet" => "( \${1:\$image}, \${2:\$cx}, \${3:\$cy}, \${4:\$w}, \${5:\$h}, \${6:\$s}, \${7:\$e}, \${8:\$color}, \${9:\$style} )", 
	"desc" => "Draw a partial ellipse and fill it", 
	"docurl" => "function.imagefilledarc.html" 
),
"imagefilledellipse" => array( 
	"methodname" => "imagefilledellipse", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool imagefilledellipse ( resource image, int cx, int cy, int w, int h, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$cx}, \${3:\$cy}, \${4:\$w}, \${5:\$h}, \${6:\$color} )", 
	"desc" => "Draw a filled ellipse", 
	"docurl" => "function.imagefilledellipse.html" 
),
"imagefilledpolygon" => array( 
	"methodname" => "imagefilledpolygon", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagefilledpolygon ( resource image, array points, int num_points, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$points}, \${3:\$num_points}, \${4:\$color} )", 
	"desc" => "Draw a filled polygon", 
	"docurl" => "function.imagefilledpolygon.html" 
),
"imagefilledrectangle" => array( 
	"methodname" => "imagefilledrectangle", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagefilledrectangle ( resource image, int x1, int y1, int x2, int y2, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$x1}, \${3:\$y1}, \${4:\$x2}, \${5:\$y2}, \${6:\$color} )", 
	"desc" => "Draw a filled rectangle", 
	"docurl" => "function.imagefilledrectangle.html" 
),
"imagefilltoborder" => array( 
	"methodname" => "imagefilltoborder", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagefilltoborder ( resource image, int x, int y, int border, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$x}, \${3:\$y}, \${4:\$border}, \${5:\$color} )", 
	"desc" => "Flood fill to specific color", 
	"docurl" => "function.imagefilltoborder.html" 
),
"imagefilter" => array( 
	"methodname" => "imagefilter", 
	"version" => "PHP5", 
	"method" => "bool imagefilter ( resource src_im, int filtertype [, int arg1 [, int arg2 [, int arg3]]] )", 
	"snippet" => "( \${1:\$src_im}, \${2:\$filtertype} )", 
	"desc" => "Applies a filter to an image", 
	"docurl" => "function.imagefilter.html" 
),
"imagefontheight" => array( 
	"methodname" => "imagefontheight", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagefontheight ( int font )", 
	"snippet" => "( \${1:\$font} )", 
	"desc" => "Get font height", 
	"docurl" => "function.imagefontheight.html" 
),
"imagefontwidth" => array( 
	"methodname" => "imagefontwidth", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagefontwidth ( int font )", 
	"snippet" => "( \${1:\$font} )", 
	"desc" => "Get font width", 
	"docurl" => "function.imagefontwidth.html" 
),
"imageftbbox" => array( 
	"methodname" => "imageftbbox", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array imageftbbox ( float size, float angle, string font_file, string text [, array extrainfo] )", 
	"snippet" => "( \${1:\$size}, \${2:\$angle}, \${3:\$font_file}, \${4:\$text} )", 
	"desc" => "Give the bounding box of a text using fonts via freetype2", 
	"docurl" => "function.imageftbbox.html" 
),
"imagefttext" => array( 
	"methodname" => "imagefttext", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array imagefttext ( resource image, float size, float angle, int x, int y, int col, string font_file, string text [, array extrainfo] )", 
	"snippet" => "( \${1:\$image}, \${2:\$size}, \${3:\$angle}, \${4:\$x}, \${5:\$y}, \${6:\$col}, \${7:\$font_file}, \${8:\$text} )", 
	"desc" => "Write text to the image using fonts using FreeType 2", 
	"docurl" => "function.imagefttext.html" 
),
"imagegammacorrect" => array( 
	"methodname" => "imagegammacorrect", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "int imagegammacorrect ( resource image, float inputgamma, float outputgamma )", 
	"snippet" => "( \${1:\$image}, \${2:\$inputgamma}, \${3:\$outputgamma} )", 
	"desc" => "Apply a gamma correction to a GD image", 
	"docurl" => "function.imagegammacorrect.html" 
),
"imagegd" => array( 
	"methodname" => "imagegd", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool imagegd ( resource image [, string filename] )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Output GD image to browser or file", 
	"docurl" => "function.imagegd.html" 
),
"imagegd2" => array( 
	"methodname" => "imagegd2", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool imagegd2 ( resource image [, string filename [, int chunk_size [, int type]]] )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Output GD2 image to browser or file", 
	"docurl" => "function.imagegd2.html" 
),
"imagegif" => array( 
	"methodname" => "imagegif", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imagegif ( resource image [, string filename] )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Output image to browser or file", 
	"docurl" => "function.imagegif.html" 
),
"imageinterlace" => array( 
	"methodname" => "imageinterlace", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imageinterlace ( resource image [, int interlace] )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Enable or disable interlace", 
	"docurl" => "function.imageinterlace.html" 
),
"imageistruecolor" => array( 
	"methodname" => "imageistruecolor", 
	"version" => "PHP4 >= 4.3.2, PHP5", 
	"method" => "bool imageistruecolor ( resource image )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Finds whether an image is a truecolor image", 
	"docurl" => "function.imageistruecolor.html" 
),
"imagejpeg" => array( 
	"methodname" => "imagejpeg", 
	"version" => "PHP3>= 3.0.16, PHP4, PHP5", 
	"method" => "bool imagejpeg ( resource image [, string filename [, int quality]] )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Output image to browser or file", 
	"docurl" => "function.imagejpeg.html" 
),
"imagelayereffect" => array( 
	"methodname" => "imagelayereffect", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool imagelayereffect ( resource image, int effect )", 
	"snippet" => "( \${1:\$image}, \${2:\$effect} )", 
	"desc" => "Set the alpha blending flag to use the bundled libgd layering effects", 
	"docurl" => "function.imagelayereffect.html" 
),
"imageline" => array( 
	"methodname" => "imageline", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imageline ( resource image, int x1, int y1, int x2, int y2, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$x1}, \${3:\$y1}, \${4:\$x2}, \${5:\$y2}, \${6:\$color} )", 
	"desc" => "Draw a line", 
	"docurl" => "function.imageline.html" 
),
"imageloadfont" => array( 
	"methodname" => "imageloadfont", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imageloadfont ( string file )", 
	"snippet" => "( \${1:\$file} )", 
	"desc" => "Load a new font", 
	"docurl" => "function.imageloadfont.html" 
),
"imagepalettecopy" => array( 
	"methodname" => "imagepalettecopy", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "int imagepalettecopy ( resource destination, resource source )", 
	"snippet" => "( \${1:\$destination}, \${2:\$source} )", 
	"desc" => "Copy the palette from one image to another", 
	"docurl" => "function.imagepalettecopy.html" 
),
"imagepng" => array( 
	"methodname" => "imagepng", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "bool imagepng ( resource image [, string filename] )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Output a PNG image to either the browser or a file", 
	"docurl" => "function.imagepng.html" 
),
"imagepolygon" => array( 
	"methodname" => "imagepolygon", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagepolygon ( resource image, array points, int num_points, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$points}, \${3:\$num_points}, \${4:\$color} )", 
	"desc" => "Draw a polygon", 
	"docurl" => "function.imagepolygon.html" 
),
"imagepsbbox" => array( 
	"methodname" => "imagepsbbox", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "array imagepsbbox ( string text, int font, int size [, int space, int tightness, float angle] )", 
	"snippet" => "( \${1:\$text}, \${2:\$font}, \${3:\$size} )", 
	"desc" => "Give the bounding box of a text rectangle using PostScript Type1   fonts", 
	"docurl" => "function.imagepsbbox.html" 
),
"imagepscopyfont" => array( 
	"methodname" => "imagepscopyfont", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "int imagepscopyfont ( int fontindex )", 
	"snippet" => "( \${1:\$fontindex} )", 
	"desc" => "Make a copy of an already loaded font for further modification", 
	"docurl" => "function.imagepscopyfont.html" 
),
"imagepsencodefont" => array( 
	"methodname" => "imagepsencodefont", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "int imagepsencodefont ( int font_index, string encodingfile )", 
	"snippet" => "( \${1:\$font_index}, \${2:\$encodingfile} )", 
	"desc" => "Change the character encoding vector of a font", 
	"docurl" => "function.imagepsencodefont.html" 
),
"imagepsextendfont" => array( 
	"methodname" => "imagepsextendfont", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool imagepsextendfont ( int font_index, float extend )", 
	"snippet" => "( \${1:\$font_index}, \${2:\$extend} )", 
	"desc" => "Extend or condense a font", 
	"docurl" => "function.imagepsextendfont.html" 
),
"imagepsfreefont" => array( 
	"methodname" => "imagepsfreefont", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "void imagepsfreefont ( int fontindex )", 
	"snippet" => "( \${1:\$fontindex} )", 
	"desc" => "Free memory used by a PostScript Type 1 font", 
	"docurl" => "function.imagepsfreefont.html" 
),
"imagepsloadfont" => array( 
	"methodname" => "imagepsloadfont", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "int imagepsloadfont ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Load a PostScript Type 1 font from file", 
	"docurl" => "function.imagepsloadfont.html" 
),
"imagepsslantfont" => array( 
	"methodname" => "imagepsslantfont", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool imagepsslantfont ( int font_index, float slant )", 
	"snippet" => "( \${1:\$font_index}, \${2:\$slant} )", 
	"desc" => "Slant a font", 
	"docurl" => "function.imagepsslantfont.html" 
),
"imagepstext" => array( 
	"methodname" => "imagepstext", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "array imagepstext ( resource image, string text, int font, int size, int foreground, int background, int x, int y [, int space, int tightness, float angle, int antialias_steps] )", 
	"snippet" => "( \${1:\$image}, \${2:\$text}, \${3:\$font}, \${4:\$size}, \${5:\$foreground}, \${6:\$background}, \${7:\$x}, \${8:\$y} )", 
	"desc" => "To draw a text string over an image using PostScript Type1 fonts", 
	"docurl" => "function.imagepstext.html" 
),
"imagerectangle" => array( 
	"methodname" => "imagerectangle", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagerectangle ( resource image, int x1, int y1, int x2, int y2, int col )", 
	"snippet" => "( \${1:\$image}, \${2:\$x1}, \${3:\$y1}, \${4:\$x2}, \${5:\$y2}, \${6:\$col} )", 
	"desc" => "Draw a rectangle", 
	"docurl" => "function.imagerectangle.html" 
),
"imagerotate" => array( 
	"methodname" => "imagerotate", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource imagerotate ( resource src_im, float angle, int bgd_color )", 
	"snippet" => "( \${1:\$src_im}, \${2:\$angle}, \${3:\$bgd_color} )", 
	"desc" => "Rotate an image with a given angle", 
	"docurl" => "function.imagerotate.html" 
),
"imagesavealpha" => array( 
	"methodname" => "imagesavealpha", 
	"version" => "PHP4 >= 4.3.2, PHP5", 
	"method" => "bool imagesavealpha ( resource image, bool saveflag )", 
	"snippet" => "( \${1:\$image}, \${2:\$saveflag} )", 
	"desc" => "Set the flag to save full alpha channel information (as opposed to   single-color transparency) when saving PNG images", 
	"docurl" => "function.imagesavealpha.html" 
),
"imagesetbrush" => array( 
	"methodname" => "imagesetbrush", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int imagesetbrush ( resource image, resource brush )", 
	"snippet" => "( \${1:\$image}, \${2:\$brush} )", 
	"desc" => "Set the brush image for line drawing", 
	"docurl" => "function.imagesetbrush.html" 
),
"imagesetpixel" => array( 
	"methodname" => "imagesetpixel", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagesetpixel ( resource image, int x, int y, int color )", 
	"snippet" => "( \${1:\$image}, \${2:\$x}, \${3:\$y}, \${4:\$color} )", 
	"desc" => "Set a single pixel", 
	"docurl" => "function.imagesetpixel.html" 
),
"imagesetstyle" => array( 
	"methodname" => "imagesetstyle", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool imagesetstyle ( resource image, array style )", 
	"snippet" => "( \${1:\$image}, \${2:\$style} )", 
	"desc" => "Set the style for line drawing", 
	"docurl" => "function.imagesetstyle.html" 
),
"imagesetthickness" => array( 
	"methodname" => "imagesetthickness", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool imagesetthickness ( resource image, int thickness )", 
	"snippet" => "( \${1:\$image}, \${2:\$thickness} )", 
	"desc" => "Set the thickness for line drawing", 
	"docurl" => "function.imagesetthickness.html" 
),
"imagesettile" => array( 
	"methodname" => "imagesettile", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int imagesettile ( resource image, resource tile )", 
	"snippet" => "( \${1:\$image}, \${2:\$tile} )", 
	"desc" => "Set the tile image for filling", 
	"docurl" => "function.imagesettile.html" 
),
"imagestring" => array( 
	"methodname" => "imagestring", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagestring ( resource image, int font, int x, int y, string s, int col )", 
	"snippet" => "( \${1:\$image}, \${2:\$font}, \${3:\$x}, \${4:\$y}, \${5:\$s}, \${6:\$col} )", 
	"desc" => "Draw a string horizontally", 
	"docurl" => "function.imagestring.html" 
),
"imagestringup" => array( 
	"methodname" => "imagestringup", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagestringup ( resource image, int font, int x, int y, string s, int col )", 
	"snippet" => "( \${1:\$image}, \${2:\$font}, \${3:\$x}, \${4:\$y}, \${5:\$s}, \${6:\$col} )", 
	"desc" => "Draw a string vertically", 
	"docurl" => "function.imagestringup.html" 
),
"imagesx" => array( 
	"methodname" => "imagesx", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagesx ( resource image )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Get image width", 
	"docurl" => "function.imagesx.html" 
),
"imagesy" => array( 
	"methodname" => "imagesy", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imagesy ( resource image )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Get image height", 
	"docurl" => "function.imagesy.html" 
),
"imagetruecolortopalette" => array( 
	"methodname" => "imagetruecolortopalette", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "void imagetruecolortopalette ( resource image, bool dither, int ncolors )", 
	"snippet" => "( \${1:\$image}, \${2:\$dither}, \${3:\$ncolors} )", 
	"desc" => "Convert a true color image to a palette image", 
	"docurl" => "function.imagetruecolortopalette.html" 
),
"imagettfbbox" => array( 
	"methodname" => "imagettfbbox", 
	"version" => "PHP3>= 3.0.1, PHP4, PHP5", 
	"method" => "array imagettfbbox ( float size, float angle, string fontfile, string text )", 
	"snippet" => "( \${1:\$size}, \${2:\$angle}, \${3:\$fontfile}, \${4:\$text} )", 
	"desc" => "Give the bounding box of a text using TrueType fonts", 
	"docurl" => "function.imagettfbbox.html" 
),
"imagettftext" => array( 
	"methodname" => "imagettftext", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array imagettftext ( resource image, float size, float angle, int x, int y, int color, string fontfile, string text )", 
	"snippet" => "( \${1:\$image}, \${2:\$size}, \${3:\$angle}, \${4:\$x}, \${5:\$y}, \${6:\$color}, \${7:\$fontfile}, \${8:\$text} )", 
	"desc" => "Write text to the image using TrueType fonts", 
	"docurl" => "function.imagettftext.html" 
),
"imagetypes" => array( 
	"methodname" => "imagetypes", 
	"version" => "PHP3 CVS only, PHP4 >= 4.0.2, PHP5", 
	"method" => "int imagetypes ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return the image types supported by this PHP build", 
	"docurl" => "function.imagetypes.html" 
),
"imagewbmp" => array( 
	"methodname" => "imagewbmp", 
	"version" => "PHP3>= 3.0.15, PHP4 >= 4.0.1, PHP5", 
	"method" => "bool imagewbmp ( resource image [, string filename [, int foreground]] )", 
	"snippet" => "( \${1:\$image} )", 
	"desc" => "Output image to browser or file", 
	"docurl" => "function.imagewbmp.html" 
),
"imagexbm" => array( 
	"methodname" => "imagexbm", 
	"version" => "PHP5", 
	"method" => "bool imagexbm ( resource image, string filename [, int foreground] )", 
	"snippet" => "( \${1:\$image}, \${2:\$filename} )", 
	"desc" => "Output XBM image to browser or file", 
	"docurl" => "function.imagexbm.html" 
),
"imap_8bit" => array( 
	"methodname" => "imap_8bit", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string imap_8bit ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Convert an 8bit string to a quoted-printable string", 
	"docurl" => "function.imap-8bit.html" 
),
"imap_alerts" => array( 
	"methodname" => "imap_alerts", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "array imap_alerts ( void  )", 
	"snippet" => "(  )", 
	"desc" => "This function returns all IMAP alert messages (if any) that have   occurred during this page request or since the alert stack was   reset", 
	"docurl" => "function.imap-alerts.html" 
),
"imap_append" => array( 
	"methodname" => "imap_append", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_append ( resource imap_stream, string mbox, string message [, string options] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$mbox}, \${3:\$message} )", 
	"desc" => "Append a string message to a specified mailbox", 
	"docurl" => "function.imap-append.html" 
),
"imap_base64" => array( 
	"methodname" => "imap_base64", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string imap_base64 ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Decode BASE64 encoded text", 
	"docurl" => "function.imap-base64.html" 
),
"imap_binary" => array( 
	"methodname" => "imap_binary", 
	"version" => "PHP3>= 3.0.2, PHP4, PHP5", 
	"method" => "string imap_binary ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Convert an 8bit string to a base64 string", 
	"docurl" => "function.imap-binary.html" 
),
"imap_body" => array( 
	"methodname" => "imap_body", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string imap_body ( resource imap_stream, int msg_number [, int options] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$msg_number} )", 
	"desc" => "Read the message body", 
	"docurl" => "function.imap-body.html" 
),
"imap_bodystruct" => array( 
	"methodname" => "imap_bodystruct", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "object imap_bodystruct ( resource stream_id, int msg_no, string section )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$msg_no}, \${3:\$section} )", 
	"desc" => "Read the structure of a specified body section of a specific message", 
	"docurl" => "function.imap-bodystruct.html" 
),
"imap_check" => array( 
	"methodname" => "imap_check", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object imap_check ( resource imap_stream )", 
	"snippet" => "( \${1:\$imap_stream} )", 
	"desc" => "Check current mailbox", 
	"docurl" => "function.imap-check.html" 
),
"imap_clearflag_full" => array( 
	"methodname" => "imap_clearflag_full", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "bool imap_clearflag_full ( resource stream, string sequence, string flag [, string options] )", 
	"snippet" => "( \${1:\$stream}, \${2:\$sequence}, \${3:\$flag} )", 
	"desc" => "Clears flags on messages", 
	"docurl" => "function.imap-clearflag-full.html" 
),
"imap_close" => array( 
	"methodname" => "imap_close", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_close ( resource imap_stream [, int flag] )", 
	"snippet" => "( \${1:\$imap_stream} )", 
	"desc" => "Close an IMAP stream", 
	"docurl" => "function.imap-close.html" 
),
"imap_createmailbox" => array( 
	"methodname" => "imap_createmailbox", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_createmailbox ( resource imap_stream, string mbox )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$mbox} )", 
	"desc" => "Create a new mailbox", 
	"docurl" => "function.imap-createmailbox.html" 
),
"imap_delete" => array( 
	"methodname" => "imap_delete", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_delete ( int imap_stream, int msg_number [, int options] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$msg_number} )", 
	"desc" => "Mark a message for deletion from current mailbox", 
	"docurl" => "function.imap-delete.html" 
),
"imap_deletemailbox" => array( 
	"methodname" => "imap_deletemailbox", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_deletemailbox ( resource imap_stream, string mbox )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$mbox} )", 
	"desc" => "Delete a mailbox", 
	"docurl" => "function.imap-deletemailbox.html" 
),
"imap_errors" => array( 
	"methodname" => "imap_errors", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "array imap_errors ( void  )", 
	"snippet" => "(  )", 
	"desc" => "This function returns all of the IMAP errors (if any) that have   occurred during this page request or since the error stack was   reset", 
	"docurl" => "function.imap-errors.html" 
),
"imap_expunge" => array( 
	"methodname" => "imap_expunge", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_expunge ( resource imap_stream )", 
	"snippet" => "( \${1:\$imap_stream} )", 
	"desc" => "Delete all messages marked for deletion", 
	"docurl" => "function.imap-expunge.html" 
),
"imap_fetch_overview" => array( 
	"methodname" => "imap_fetch_overview", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "array imap_fetch_overview ( resource imap_stream, string sequence [, int options] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$sequence} )", 
	"desc" => "Read an overview of the information in the headers of the given message", 
	"docurl" => "function.imap-fetch-overview.html" 
),
"imap_fetchbody" => array( 
	"methodname" => "imap_fetchbody", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string imap_fetchbody ( resource imap_stream, int msg_number, string part_number [, int options] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$msg_number}, \${3:\$part_number} )", 
	"desc" => "Fetch a particular section of the body of the message", 
	"docurl" => "function.imap-fetchbody.html" 
),
"imap_fetchheader" => array( 
	"methodname" => "imap_fetchheader", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "string imap_fetchheader ( resource imap_stream, int msgno [, int options] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$msgno} )", 
	"desc" => "Returns header for a message", 
	"docurl" => "function.imap-fetchheader.html" 
),
"imap_fetchstructure" => array( 
	"methodname" => "imap_fetchstructure", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object imap_fetchstructure ( resource imap_stream, int msg_number [, int options] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$msg_number} )", 
	"desc" => "Read the structure of a particular message", 
	"docurl" => "function.imap-fetchstructure.html" 
),
"imap_get_quota" => array( 
	"methodname" => "imap_get_quota", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "array imap_get_quota ( resource imap_stream, string quota_root )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$quota_root} )", 
	"desc" => "Retrieve the quota level settings, and usage statics per mailbox", 
	"docurl" => "function.imap-get-quota.html" 
),
"imap_get_quotaroot" => array( 
	"methodname" => "imap_get_quotaroot", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array imap_get_quotaroot ( resource imap_stream, string quota_root )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$quota_root} )", 
	"desc" => "Retrieve the quota settings per user", 
	"docurl" => "function.imap-get-quotaroot.html" 
),
"imap_getacl" => array( 
	"methodname" => "imap_getacl", 
	"version" => "PHP5", 
	"method" => "array imap_getacl ( resource stream_id, string mailbox )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$mailbox} )", 
	"desc" => "Gets the ACL for a given mailbox", 
	"docurl" => "function.imap-getacl.html" 
),
"imap_getmailboxes" => array( 
	"methodname" => "imap_getmailboxes", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "array imap_getmailboxes ( resource imap_stream, string ref, string pattern )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$ref}, \${3:\$pattern} )", 
	"desc" => "Read the list of mailboxes, returning detailed information on   each one", 
	"docurl" => "function.imap-getmailboxes.html" 
),
"imap_getsubscribed" => array( 
	"methodname" => "imap_getsubscribed", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "array imap_getsubscribed ( resource imap_stream, string ref, string pattern )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$ref}, \${3:\$pattern} )", 
	"desc" => "List all the subscribed mailboxes", 
	"docurl" => "function.imap-getsubscribed.html" 
),
"imap_header" => array( 
	"methodname" => "imap_header", 
	"version" => "undefined", 
	"method" => "Alias of imap_headerinfo()", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of imap_headerinfo()\n", 
	"docurl" => "function.imap-header.html" 
),
"imap_headerinfo" => array( 
	"methodname" => "imap_headerinfo", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object imap_headerinfo ( resource imap_stream, int msg_number [, int fromlength [, int subjectlength [, string defaulthost]]] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$msg_number} )", 
	"desc" => "Read the header of the message", 
	"docurl" => "function.imap-headerinfo.html" 
),
"imap_headers" => array( 
	"methodname" => "imap_headers", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array imap_headers ( resource imap_stream )", 
	"snippet" => "( \${1:\$imap_stream} )", 
	"desc" => "Returns headers for all messages in a mailbox", 
	"docurl" => "function.imap-headers.html" 
),
"imap_last_error" => array( 
	"methodname" => "imap_last_error", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "string imap_last_error ( void  )", 
	"snippet" => "(  )", 
	"desc" => "This function returns the last IMAP error (if any) that occurred   during this page request", 
	"docurl" => "function.imap-last-error.html" 
),
"imap_list" => array( 
	"methodname" => "imap_list", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "array imap_list ( resource imap_stream, string ref, string pattern )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$ref}, \${3:\$pattern} )", 
	"desc" => "Read the list of mailboxes", 
	"docurl" => "function.imap-list.html" 
),
"imap_listmailbox" => array( 
	"methodname" => "imap_listmailbox", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.imap-listmailbox.html" 
),
"imap_listscan" => array( 
	"methodname" => "imap_listscan", 
	"version" => "undefined", 
	"method" => "array imap_listscan ( resource imap_stream, string ref, string pattern, string content )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$ref}, \${3:\$pattern}, \${4:\$content} )", 
	"desc" => "", 
	"docurl" => "function.imap-listscan.html" 
),
"imap_listsubscribed" => array( 
	"methodname" => "imap_listsubscribed", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.imap-listsubscribed.html" 
),
"imap_lsub" => array( 
	"methodname" => "imap_lsub", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "array imap_lsub ( resource imap_stream, string ref, string pattern )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$ref}, \${3:\$pattern} )", 
	"desc" => "List all the subscribed mailboxes", 
	"docurl" => "function.imap-lsub.html" 
),
"imap_mail_compose" => array( 
	"methodname" => "imap_mail_compose", 
	"version" => "PHP3>= 3.0.5, PHP4, PHP5", 
	"method" => "string imap_mail_compose ( array envelope, array body )", 
	"snippet" => "( \${1:\$envelope}, \${2:\$body} )", 
	"desc" => "Create a MIME message based on given envelope and body sections", 
	"docurl" => "function.imap-mail-compose.html" 
),
"imap_mail_copy" => array( 
	"methodname" => "imap_mail_copy", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_mail_copy ( resource imap_stream, string msglist, string mbox [, int options] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$msglist}, \${3:\$mbox} )", 
	"desc" => "Copy specified messages to a mailbox", 
	"docurl" => "function.imap-mail-copy.html" 
),
"imap_mail_move" => array( 
	"methodname" => "imap_mail_move", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_mail_move ( resource imap_stream, string msglist, string mbox [, int options] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$msglist}, \${3:\$mbox} )", 
	"desc" => "Move specified messages to a mailbox", 
	"docurl" => "function.imap-mail-move.html" 
),
"imap_mail" => array( 
	"methodname" => "imap_mail", 
	"version" => "PHP3>= 3.0.14, PHP4, PHP5", 
	"method" => "bool imap_mail ( string to, string subject, string message [, string additional_headers [, string cc [, string bcc [, string rpath]]]] )", 
	"snippet" => "( \${1:\$to}, \${2:\$subject}, \${3:\$message} )", 
	"desc" => "Send an email message", 
	"docurl" => "function.imap-mail.html" 
),
"imap_mailboxmsginfo" => array( 
	"methodname" => "imap_mailboxmsginfo", 
	"version" => "PHP3>= 3.0.2, PHP4, PHP5", 
	"method" => "object imap_mailboxmsginfo ( resource imap_stream )", 
	"snippet" => "( \${1:\$imap_stream} )", 
	"desc" => "Get information about the current mailbox", 
	"docurl" => "function.imap-mailboxmsginfo.html" 
),
"imap_mime_header_decode" => array( 
	"methodname" => "imap_mime_header_decode", 
	"version" => "PHP3>= 3.0.17, PHP4, PHP5", 
	"method" => "array imap_mime_header_decode ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Decode MIME header elements", 
	"docurl" => "function.imap-mime-header-decode.html" 
),
"imap_msgno" => array( 
	"methodname" => "imap_msgno", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int imap_msgno ( resource imap_stream, int uid )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$uid} )", 
	"desc" => "This function returns the message sequence number for the given   UID", 
	"docurl" => "function.imap-msgno.html" 
),
"imap_num_msg" => array( 
	"methodname" => "imap_num_msg", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imap_num_msg ( resource imap_stream )", 
	"snippet" => "( \${1:\$imap_stream} )", 
	"desc" => "Gives the number of messages in the current mailbox", 
	"docurl" => "function.imap-num-msg.html" 
),
"imap_num_recent" => array( 
	"methodname" => "imap_num_recent", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int imap_num_recent ( resource imap_stream )", 
	"snippet" => "( \${1:\$imap_stream} )", 
	"desc" => "Gives the number of recent messages in current   mailbox", 
	"docurl" => "function.imap-num-recent.html" 
),
"imap_open" => array( 
	"methodname" => "imap_open", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource imap_open ( string mailbox, string username, string password [, int options] )", 
	"snippet" => "( \${1:\$mailbox}, \${2:\$username}, \${3:\$password} )", 
	"desc" => "Open an IMAP stream to a mailbox", 
	"docurl" => "function.imap-open.html" 
),
"imap_ping" => array( 
	"methodname" => "imap_ping", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_ping ( resource imap_stream )", 
	"snippet" => "( \${1:\$imap_stream} )", 
	"desc" => "Check if the IMAP stream is still active", 
	"docurl" => "function.imap-ping.html" 
),
"imap_qprint" => array( 
	"methodname" => "imap_qprint", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string imap_qprint ( string string )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Convert a quoted-printable string to an 8 bit   string", 
	"docurl" => "function.imap-qprint.html" 
),
"imap_renamemailbox" => array( 
	"methodname" => "imap_renamemailbox", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_renamemailbox ( resource imap_stream, string old_mbox, string new_mbox )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$old_mbox}, \${3:\$new_mbox} )", 
	"desc" => "Rename an old mailbox to new mailbox", 
	"docurl" => "function.imap-renamemailbox.html" 
),
"imap_reopen" => array( 
	"methodname" => "imap_reopen", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_reopen ( resource imap_stream, string mailbox [, string options] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$mailbox} )", 
	"desc" => "Reopen IMAP stream to new mailbox", 
	"docurl" => "function.imap-reopen.html" 
),
"imap_rfc822_parse_adrlist" => array( 
	"methodname" => "imap_rfc822_parse_adrlist", 
	"version" => "PHP3>= 3.0.2, PHP4, PHP5", 
	"method" => "array imap_rfc822_parse_adrlist ( string address, string default_host )", 
	"snippet" => "( \${1:\$address}, \${2:\$default_host} )", 
	"desc" => "Parses an address string", 
	"docurl" => "function.imap-rfc822-parse-adrlist.html" 
),
"imap_rfc822_parse_headers" => array( 
	"methodname" => "imap_rfc822_parse_headers", 
	"version" => "PHP4, PHP5", 
	"method" => "object imap_rfc822_parse_headers ( string headers [, string defaulthost] )", 
	"snippet" => "( \${1:\$headers} )", 
	"desc" => "Parse mail headers from a string", 
	"docurl" => "function.imap-rfc822-parse-headers.html" 
),
"imap_rfc822_write_address" => array( 
	"methodname" => "imap_rfc822_write_address", 
	"version" => "PHP3>= 3.0.2, PHP4, PHP5", 
	"method" => "string imap_rfc822_write_address ( string mailbox, string host, string personal )", 
	"snippet" => "( \${1:\$mailbox}, \${2:\$host}, \${3:\$personal} )", 
	"desc" => "Returns a properly formatted email address given the mailbox,   host, and personal info", 
	"docurl" => "function.imap-rfc822-write-address.html" 
),
"imap_scanmailbox" => array( 
	"methodname" => "imap_scanmailbox", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.imap-scanmailbox.html" 
),
"imap_search" => array( 
	"methodname" => "imap_search", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "array imap_search ( resource imap_stream, string criteria [, int options [, string charset]] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$criteria} )", 
	"desc" => "This function returns an array of messages matching the given   search criteria", 
	"docurl" => "function.imap-search.html" 
),
"imap_set_quota" => array( 
	"methodname" => "imap_set_quota", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool imap_set_quota ( resource imap_stream, string quota_root, int quota_limit )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$quota_root}, \${3:\$quota_limit} )", 
	"desc" => "Sets a quota for a given mailbox", 
	"docurl" => "function.imap-set-quota.html" 
),
"imap_setacl" => array( 
	"methodname" => "imap_setacl", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool imap_setacl ( resource stream_id, string mailbox, string id, string rights )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$mailbox}, \${3:\$id}, \${4:\$rights} )", 
	"desc" => "Sets the ACL for a giving mailbox", 
	"docurl" => "function.imap-setacl.html" 
),
"imap_setflag_full" => array( 
	"methodname" => "imap_setflag_full", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "bool imap_setflag_full ( resource stream, string sequence, string flag [, string options] )", 
	"snippet" => "( \${1:\$stream}, \${2:\$sequence}, \${3:\$flag} )", 
	"desc" => "Sets flags on messages", 
	"docurl" => "function.imap-setflag-full.html" 
),
"imap_sort" => array( 
	"methodname" => "imap_sort", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "array imap_sort ( resource stream, int criteria, int reverse [, int options [, string search_criteria [, string charset]]] )", 
	"snippet" => "( \${1:\$stream}, \${2:\$criteria}, \${3:\$reverse} )", 
	"desc" => "Sort an array of message headers", 
	"docurl" => "function.imap-sort.html" 
),
"imap_status" => array( 
	"methodname" => "imap_status", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "object imap_status ( resource imap_stream, string mailbox, int options )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$mailbox}, \${3:\$options} )", 
	"desc" => "This function returns status information on a mailbox other than   the current one", 
	"docurl" => "function.imap-status.html" 
),
"imap_subscribe" => array( 
	"methodname" => "imap_subscribe", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_subscribe ( resource imap_stream, string mbox )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$mbox} )", 
	"desc" => "Subscribe to a mailbox", 
	"docurl" => "function.imap-subscribe.html" 
),
"imap_thread" => array( 
	"methodname" => "imap_thread", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array imap_thread ( resource stream_id [, int options] )", 
	"snippet" => "( \${1:\$stream_id} )", 
	"desc" => "Returns a tree of threaded message", 
	"docurl" => "function.imap-thread.html" 
),
"imap_timeout" => array( 
	"methodname" => "imap_timeout", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "mixed imap_timeout ( int timeout_type [, int timeout] )", 
	"snippet" => "( \${1:\$timeout_type} )", 
	"desc" => "Set or fetch imap timeout", 
	"docurl" => "function.imap-timeout.html" 
),
"imap_uid" => array( 
	"methodname" => "imap_uid", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int imap_uid ( resource imap_stream, int msgno )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$msgno} )", 
	"desc" => "This function returns the UID for the given message sequence   number", 
	"docurl" => "function.imap-uid.html" 
),
"imap_undelete" => array( 
	"methodname" => "imap_undelete", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_undelete ( resource imap_stream, int msg_number [, int flags] )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$msg_number} )", 
	"desc" => "Unmark the message which is marked deleted", 
	"docurl" => "function.imap-undelete.html" 
),
"imap_unsubscribe" => array( 
	"methodname" => "imap_unsubscribe", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool imap_unsubscribe ( string imap_stream, string mbox )", 
	"snippet" => "( \${1:\$imap_stream}, \${2:\$mbox} )", 
	"desc" => "Unsubscribe from a mailbox", 
	"docurl" => "function.imap-unsubscribe.html" 
),
"imap_utf7_decode" => array( 
	"methodname" => "imap_utf7_decode", 
	"version" => "PHP3>= 3.0.15, PHP4, PHP5", 
	"method" => "string imap_utf7_decode ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Decodes a modified UTF-7 encoded string", 
	"docurl" => "function.imap-utf7-decode.html" 
),
"imap_utf7_encode" => array( 
	"methodname" => "imap_utf7_encode", 
	"version" => "PHP3>= 3.0.15, PHP4, PHP5", 
	"method" => "string imap_utf7_encode ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Converts ISO-8859-1 string to modified UTF-7 text", 
	"docurl" => "function.imap-utf7-encode.html" 
),
"imap_utf8" => array( 
	"methodname" => "imap_utf8", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "string imap_utf8 ( string mime_encoded_text )", 
	"snippet" => "( \${1:\$mime_encoded_text} )", 
	"desc" => "Converts MIME-encoded text to UTF-8", 
	"docurl" => "function.imap-utf8.html" 
),
"implode" => array( 
	"methodname" => "implode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string implode ( string glue, array pieces )", 
	"snippet" => "( \${1:\$glue}, \${2:\$pieces} )", 
	"desc" => "Join array elements with a string", 
	"docurl" => "function.implode.html" 
),
"import_request_variables" => array( 
	"methodname" => "import_request_variables", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool import_request_variables ( string types [, string prefix] )", 
	"snippet" => "( \${1:\$types} )", 
	"desc" => "Import GET/POST/Cookie variables into the global scope", 
	"docurl" => "function.import-request-variables.html" 
),
"in_array" => array( 
	"methodname" => "in_array", 
	"version" => "PHP4, PHP5", 
	"method" => "bool in_array ( mixed needle, array haystack [, bool strict] )", 
	"snippet" => "( \${1:\$needle}, \${2:\$haystack} )", 
	"desc" => "Checks if a value exists in an array", 
	"docurl" => "function.in-array.html" 
),
"include_once" => array( 
	"methodname" => "include_once", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "include_once( string file )", 
	"snippet" => "( \$1 )", 
	"desc" => "The include_once() statement includes and evaluates the specified file during the execution of the script. This is a behavior similar to the include() statement, with the only difference being that if the code from a file has already been included, it will not be included again. As the name suggests, it will be included just once.", 
	"docurl" => "function.include-once.html" 
),
"include" => array( 
	"methodname" => "include", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "include( string file )", 
	"snippet" => "( \$1 )", 
	"desc" => "The include() statement includes and evaluates the specified file.\nWhen a file is included, the code it contains inherits the variable scope of the line on which the include occurs. Any variables available at that line in the calling file will be available within the called file, from that point forward.", 
	"docurl" => "function.include.html" 
),
"inet_ntop" => array( 
	"methodname" => "inet_ntop", 
	"version" => "undefined", 
	"method" => "string inet_ntop ( string in_addr )", 
	"snippet" => "( \${1:\$in_addr} )", 
	"desc" => "", 
	"docurl" => "function.inet-ntop.html" 
),
"inet_pton" => array( 
	"methodname" => "inet_pton", 
	"version" => "undefined", 
	"method" => "string inet_pton ( string address )", 
	"snippet" => "( \${1:\$address} )", 
	"desc" => "", 
	"docurl" => "function.inet-pton.html" 
),
"ingres_autocommit" => array( 
	"methodname" => "ingres_autocommit", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool ingres_autocommit ( [resource link] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Switch autocommit on or off", 
	"docurl" => "function.ingres-autocommit.html" 
),
"ingres_close" => array( 
	"methodname" => "ingres_close", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool ingres_close ( [resource link] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Close an Ingres II database connection", 
	"docurl" => "function.ingres-close.html" 
),
"ingres_commit" => array( 
	"methodname" => "ingres_commit", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool ingres_commit ( [resource link] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Commit a transaction", 
	"docurl" => "function.ingres-commit.html" 
),
"ingres_connect" => array( 
	"methodname" => "ingres_connect", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "resource ingres_connect ( [string database [, string username [, string password]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open a connection to an Ingres II database", 
	"docurl" => "function.ingres-connect.html" 
),
"ingres_fetch_array" => array( 
	"methodname" => "ingres_fetch_array", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "array ingres_fetch_array ( [int result_type [, resource link]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Fetch a row of result into an array", 
	"docurl" => "function.ingres-fetch-array.html" 
),
"ingres_fetch_object" => array( 
	"methodname" => "ingres_fetch_object", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "object ingres_fetch_object ( [int result_type [, resource link]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Fetch a row of result into an object", 
	"docurl" => "function.ingres-fetch-object.html" 
),
"ingres_fetch_row" => array( 
	"methodname" => "ingres_fetch_row", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "array ingres_fetch_row ( [resource link] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Fetch a row of result into an enumerated array", 
	"docurl" => "function.ingres-fetch-row.html" 
),
"ingres_field_length" => array( 
	"methodname" => "ingres_field_length", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int ingres_field_length ( int index [, resource link] )", 
	"snippet" => "( \${1:\$index} )", 
	"desc" => "Get the length of a field", 
	"docurl" => "function.ingres-field-length.html" 
),
"ingres_field_name" => array( 
	"methodname" => "ingres_field_name", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string ingres_field_name ( int index [, resource link] )", 
	"snippet" => "( \${1:\$index} )", 
	"desc" => "Get the name of a field in a query result", 
	"docurl" => "function.ingres-field-name.html" 
),
"ingres_field_nullable" => array( 
	"methodname" => "ingres_field_nullable", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool ingres_field_nullable ( int index [, resource link] )", 
	"snippet" => "( \${1:\$index} )", 
	"desc" => "Test if a field is nullable", 
	"docurl" => "function.ingres-field-nullable.html" 
),
"ingres_field_precision" => array( 
	"methodname" => "ingres_field_precision", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int ingres_field_precision ( int index [, resource link] )", 
	"snippet" => "( \${1:\$index} )", 
	"desc" => "Get the precision of a field", 
	"docurl" => "function.ingres-field-precision.html" 
),
"ingres_field_scale" => array( 
	"methodname" => "ingres_field_scale", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int ingres_field_scale ( int index [, resource link] )", 
	"snippet" => "( \${1:\$index} )", 
	"desc" => "Get the scale of a field", 
	"docurl" => "function.ingres-field-scale.html" 
),
"ingres_field_type" => array( 
	"methodname" => "ingres_field_type", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string ingres_field_type ( int index [, resource link] )", 
	"snippet" => "( \${1:\$index} )", 
	"desc" => "Get the type of a field in a query result", 
	"docurl" => "function.ingres-field-type.html" 
),
"ingres_num_fields" => array( 
	"methodname" => "ingres_num_fields", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int ingres_num_fields ( [resource link] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get the number of fields returned by the last query", 
	"docurl" => "function.ingres-num-fields.html" 
),
"ingres_num_rows" => array( 
	"methodname" => "ingres_num_rows", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int ingres_num_rows ( [resource link] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get the number of rows affected or returned by the last query", 
	"docurl" => "function.ingres-num-rows.html" 
),
"ingres_pconnect" => array( 
	"methodname" => "ingres_pconnect", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "resource ingres_pconnect ( [string database [, string username [, string password]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open a persistent connection to an Ingres II database", 
	"docurl" => "function.ingres-pconnect.html" 
),
"ingres_query" => array( 
	"methodname" => "ingres_query", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool ingres_query ( string query [, resource link] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Send a SQL query to Ingres II", 
	"docurl" => "function.ingres-query.html" 
),
"ingres_rollback" => array( 
	"methodname" => "ingres_rollback", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool ingres_rollback ( [resource link] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Roll back a transaction", 
	"docurl" => "function.ingres-rollback.html" 
),
"ini_alter" => array( 
	"methodname" => "ini_alter", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.ini-alter.html" 
),
"ini_get_all" => array( 
	"methodname" => "ini_get_all", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array ini_get_all ( [string extension] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Gets all configuration options", 
	"docurl" => "function.ini-get-all.html" 
),
"ini_get" => array( 
	"methodname" => "ini_get", 
	"version" => "PHP4, PHP5", 
	"method" => "string ini_get ( string varname )", 
	"snippet" => "( \${1:\$varname} )", 
	"desc" => "Gets the value of a configuration option", 
	"docurl" => "function.ini-get.html" 
),
"ini_restore" => array( 
	"methodname" => "ini_restore", 
	"version" => "PHP4, PHP5", 
	"method" => "void ini_restore ( string varname )", 
	"snippet" => "( \${1:\$varname} )", 
	"desc" => "Restores the value of a configuration option", 
	"docurl" => "function.ini-restore.html" 
),
"ini_set" => array( 
	"methodname" => "ini_set", 
	"version" => "PHP4, PHP5", 
	"method" => "string ini_set ( string varname, string newvalue )", 
	"snippet" => "( \${1:\$varname}, \${2:\$newvalue} )", 
	"desc" => "Sets the value of a configuration option", 
	"docurl" => "function.ini-set.html" 
),
"interface_exists" => array( 
	"methodname" => "interface_exists", 
	"version" => "undefined", 
	"method" => "bool interface_exists ( string interface_name [, bool autoload] )", 
	"snippet" => "( \${1:\$interface_name} )", 
	"desc" => "", 
	"docurl" => "function.interface-exists.html" 
),
"intval" => array( 
	"methodname" => "intval", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int intval ( mixed var [, int base] )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Get the integer value of a variable", 
	"docurl" => "function.intval.html" 
),
"ip2long" => array( 
	"methodname" => "ip2long", 
	"version" => "PHP4, PHP5", 
	"method" => "int ip2long ( string ip_address )", 
	"snippet" => "( \${1:\$ip_address} )", 
	"desc" => "Converts a string containing an (IPv4) Internet Protocol dotted address    into a proper address", 
	"docurl" => "function.ip2long.html" 
),
"iptcembed" => array( 
	"methodname" => "iptcembed", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "array iptcembed ( string iptcdata, string jpeg_file_name [, int spool] )", 
	"snippet" => "( \${1:\$iptcdata}, \${2:\$jpeg_file_name} )", 
	"desc" => "Embed binary IPTC data into a JPEG image", 
	"docurl" => "function.iptcembed.html" 
),
"iptcparse" => array( 
	"methodname" => "iptcparse", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "array iptcparse ( string iptcblock )", 
	"snippet" => "( \${1:\$iptcblock} )", 
	"desc" => "Parse a binary IPTC http://www.iptc.org/   block into single tags.", 
	"docurl" => "function.iptcparse.html" 
),
"ircg_channel_mode" => array( 
	"methodname" => "ircg_channel_mode", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_channel_mode ( resource connection, string channel, string mode_spec, string nick )", 
	"snippet" => "( \${1:\$connection}, \${2:\$channel}, \${3:\$mode_spec}, \${4:\$nick} )", 
	"desc" => "Set channel mode flags for user", 
	"docurl" => "function.ircg-channel-mode.html" 
),
"ircg_disconnect" => array( 
	"methodname" => "ircg_disconnect", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ircg_disconnect ( resource connection, string reason )", 
	"snippet" => "( \${1:\$connection}, \${2:\$reason} )", 
	"desc" => "Close connection to server", 
	"docurl" => "function.ircg-disconnect.html" 
),
"ircg_eval_ecmascript_params" => array( 
	"methodname" => "ircg_eval_ecmascript_params", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array ircg_eval_ecmascript_params ( string params )", 
	"snippet" => "( \${1:\$params} )", 
	"desc" => "Decodes a list of JS-encoded parameters", 
	"docurl" => "function.ircg-eval-ecmascript-params.html" 
),
"ircg_fetch_error_msg" => array( 
	"methodname" => "ircg_fetch_error_msg", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array ircg_fetch_error_msg ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Returns the error from previous IRCG operation", 
	"docurl" => "function.ircg-fetch-error-msg.html" 
),
"ircg_get_username" => array( 
	"methodname" => "ircg_get_username", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string ircg_get_username ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Get username for connection", 
	"docurl" => "function.ircg-get-username.html" 
),
"ircg_html_encode" => array( 
	"methodname" => "ircg_html_encode", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_html_encode ( string html_string [, bool auto_links [, bool conv_br]] )", 
	"snippet" => "( \${1:\$html_string} )", 
	"desc" => "Encodes HTML preserving output", 
	"docurl" => "function.ircg-html-encode.html" 
),
"ircg_ignore_add" => array( 
	"methodname" => "ircg_ignore_add", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_ignore_add ( resource connection, string nick )", 
	"snippet" => "( \${1:\$connection}, \${2:\$nick} )", 
	"desc" => "Add a user to your ignore list on a server", 
	"docurl" => "function.ircg-ignore-add.html" 
),
"ircg_ignore_del" => array( 
	"methodname" => "ircg_ignore_del", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_ignore_del ( resource connection, string nick )", 
	"snippet" => "( \${1:\$connection}, \${2:\$nick} )", 
	"desc" => "Remove a user from your ignore list on a server", 
	"docurl" => "function.ircg-ignore-del.html" 
),
"ircg_invite" => array( 
	"methodname" => "ircg_invite", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "bool ircg_invite ( resource connection, string channel, string nickname )", 
	"snippet" => "( \${1:\$connection}, \${2:\$channel}, \${3:\$nickname} )", 
	"desc" => "Invites nickname to channel", 
	"docurl" => "function.ircg-invite.html" 
),
"ircg_is_conn_alive" => array( 
	"methodname" => "ircg_is_conn_alive", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_is_conn_alive ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Check connection status", 
	"docurl" => "function.ircg-is-conn-alive.html" 
),
"ircg_join" => array( 
	"methodname" => "ircg_join", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ircg_join ( resource connection, string channel [, string key] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$channel} )", 
	"desc" => "Join a channel on a connected server", 
	"docurl" => "function.ircg-join.html" 
),
"ircg_kick" => array( 
	"methodname" => "ircg_kick", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_kick ( resource connection, string channel, string nick, string reason )", 
	"snippet" => "( \${1:\$connection}, \${2:\$channel}, \${3:\$nick}, \${4:\$reason} )", 
	"desc" => "Kick a user out of a channel on server", 
	"docurl" => "function.ircg-kick.html" 
),
"ircg_list" => array( 
	"methodname" => "ircg_list", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "bool ircg_list ( resource connection, string channel )", 
	"snippet" => "( \${1:\$connection}, \${2:\$channel} )", 
	"desc" => "List topic/user count of channel(s)", 
	"docurl" => "function.ircg-list.html" 
),
"ircg_lookup_format_messages" => array( 
	"methodname" => "ircg_lookup_format_messages", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_lookup_format_messages ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Check for the existence of a format message set", 
	"docurl" => "function.ircg-lookup-format-messages.html" 
),
"ircg_lusers" => array( 
	"methodname" => "ircg_lusers", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "bool ircg_lusers ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "IRC network statistics", 
	"docurl" => "function.ircg-lusers.html" 
),
"ircg_msg" => array( 
	"methodname" => "ircg_msg", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ircg_msg ( resource connection, string recipient, string message [, bool suppress] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$recipient}, \${3:\$message} )", 
	"desc" => "Send message to channel or user on server", 
	"docurl" => "function.ircg-msg.html" 
),
"ircg_names" => array( 
	"methodname" => "ircg_names", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "bool ircg_names ( int connection, string channel [, string target] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$channel} )", 
	"desc" => "Query visible usernames", 
	"docurl" => "function.ircg-names.html" 
),
"ircg_nick" => array( 
	"methodname" => "ircg_nick", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_nick ( resource connection, string nick )", 
	"snippet" => "( \${1:\$connection}, \${2:\$nick} )", 
	"desc" => "Change nickname on server", 
	"docurl" => "function.ircg-nick.html" 
),
"ircg_nickname_escape" => array( 
	"methodname" => "ircg_nickname_escape", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string ircg_nickname_escape ( string nick )", 
	"snippet" => "( \${1:\$nick} )", 
	"desc" => "Encode special characters in nickname to be IRC-compliant", 
	"docurl" => "function.ircg-nickname-escape.html" 
),
"ircg_nickname_unescape" => array( 
	"methodname" => "ircg_nickname_unescape", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string ircg_nickname_unescape ( string nick )", 
	"snippet" => "( \${1:\$nick} )", 
	"desc" => "Decodes encoded nickname", 
	"docurl" => "function.ircg-nickname-unescape.html" 
),
"ircg_notice" => array( 
	"methodname" => "ircg_notice", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_notice ( resource connection, string recipient, string message )", 
	"snippet" => "( \${1:\$connection}, \${2:\$recipient}, \${3:\$message} )", 
	"desc" => "Send a notice to a user on server", 
	"docurl" => "function.ircg-notice.html" 
),
"ircg_oper" => array( 
	"methodname" => "ircg_oper", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "bool ircg_oper ( resource connection, string name, string password )", 
	"snippet" => "( \${1:\$connection}, \${2:\$name}, \${3:\$password} )", 
	"desc" => "Elevates privileges to IRC OPER", 
	"docurl" => "function.ircg-oper.html" 
),
"ircg_part" => array( 
	"methodname" => "ircg_part", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ircg_part ( resource connection, string channel )", 
	"snippet" => "( \${1:\$connection}, \${2:\$channel} )", 
	"desc" => "Leave a channel on server", 
	"docurl" => "function.ircg-part.html" 
),
"ircg_pconnect" => array( 
	"methodname" => "ircg_pconnect", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource ircg_pconnect ( string username [, string server_ip [, int server_port [, string msg_format [, array ctcp_messages [, array user_settings [, bool bailout_on_trivial]]]]]] )", 
	"snippet" => "( \${1:\$username} )", 
	"desc" => "Connect to an IRC server", 
	"docurl" => "function.ircg-pconnect.html" 
),
"ircg_register_format_messages" => array( 
	"methodname" => "ircg_register_format_messages", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_register_format_messages ( string name, array messages )", 
	"snippet" => "( \${1:\$name}, \${2:\$messages} )", 
	"desc" => "Register a format message set", 
	"docurl" => "function.ircg-register-format-messages.html" 
),
"ircg_set_current" => array( 
	"methodname" => "ircg_set_current", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ircg_set_current ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Set current connection for output", 
	"docurl" => "function.ircg-set-current.html" 
),
"ircg_set_file" => array( 
	"methodname" => "ircg_set_file", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ircg_set_file ( resource connection, string path )", 
	"snippet" => "( \${1:\$connection}, \${2:\$path} )", 
	"desc" => "Set logfile for connection", 
	"docurl" => "function.ircg-set-file.html" 
),
"ircg_set_on_die" => array( 
	"methodname" => "ircg_set_on_die", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ircg_set_on_die ( resource connection, string host, int port, string data )", 
	"snippet" => "( \${1:\$connection}, \${2:\$host}, \${3:\$port}, \${4:\$data} )", 
	"desc" => "Set action to be executed when connection dies", 
	"docurl" => "function.ircg-set-on-die.html" 
),
"ircg_topic" => array( 
	"methodname" => "ircg_topic", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_topic ( resource connection, string channel, string new_topic )", 
	"snippet" => "( \${1:\$connection}, \${2:\$channel}, \${3:\$new_topic} )", 
	"desc" => "Set topic for channel on server", 
	"docurl" => "function.ircg-topic.html" 
),
"ircg_who" => array( 
	"methodname" => "ircg_who", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "bool ircg_who ( resource connection, string mask [, bool ops_only] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$mask} )", 
	"desc" => "Queries server for WHO information", 
	"docurl" => "function.ircg-who.html" 
),
"ircg_whois" => array( 
	"methodname" => "ircg_whois", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ircg_whois ( resource connection, string nick )", 
	"snippet" => "( \${1:\$connection}, \${2:\$nick} )", 
	"desc" => "Query server for user information", 
	"docurl" => "function.ircg-whois.html" 
),
"is_a" => array( 
	"methodname" => "is_a", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool is_a ( object object, string class_name )", 
	"snippet" => "( \${1:\$object}, \${2:\$class_name} )", 
	"desc" => "Returns TRUE if the object is of this class or has this class as    one of its parents", 
	"docurl" => "function.is-a.html" 
),
"is_array" => array( 
	"methodname" => "is_array", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool is_array ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Finds whether a variable is an array", 
	"docurl" => "function.is-array.html" 
),
"is_bool" => array( 
	"methodname" => "is_bool", 
	"version" => "PHP4, PHP5", 
	"method" => "bool is_bool ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Finds out whether a variable is a boolean", 
	"docurl" => "function.is-bool.html" 
),
"is_callable" => array( 
	"methodname" => "is_callable", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool is_callable ( mixed var [, bool syntax_only [, string &callable_name]] )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Verify that the contents of a variable can be called as a function", 
	"docurl" => "function.is-callable.html" 
),
"is_dir" => array( 
	"methodname" => "is_dir", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool is_dir ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Tells whether the filename is a directory", 
	"docurl" => "function.is-dir.html" 
),
"is_double" => array( 
	"methodname" => "is_double", 
	"version" => "(PHP3, PHP4, PHP5)", 
	"method" => "bool is_double ( mixed var )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of is_float()\nFinds whether a variable is a float", 
	"docurl" => "function.is-double.html" 
),
"is_executable" => array( 
	"methodname" => "is_executable", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool is_executable ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Tells whether the filename is executable", 
	"docurl" => "function.is-executable.html" 
),
"is_file" => array( 
	"methodname" => "is_file", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool is_file ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Tells whether the filename is a regular file", 
	"docurl" => "function.is-file.html" 
),
"is_finite" => array( 
	"methodname" => "is_finite", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool is_finite ( float val )", 
	"snippet" => "( \${1:\$val} )", 
	"desc" => "Finds whether a value is a legal finite number", 
	"docurl" => "function.is-finite.html" 
),
"is_float" => array( 
	"methodname" => "is_float", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool is_float ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Finds whether a variable is a float", 
	"docurl" => "function.is-float.html" 
),
"is_infinite" => array( 
	"methodname" => "is_infinite", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool is_infinite ( float val )", 
	"snippet" => "( \${1:\$val} )", 
	"desc" => "Finds whether a value is infinite", 
	"docurl" => "function.is-infinite.html" 
),
"is_int" => array( 
	"methodname" => "is_int", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool is_int ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Find whether a variable is an integer", 
	"docurl" => "function.is-int.html" 
),
"is_integer" => array( 
	"methodname" => "is_integer", 
	"version" => "(PHP3, PHP4, PHP5)", 
	"method" => "bool is_integer ( mixed var )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of is_int()\nFind whether a variable is an integer", 
	"docurl" => "function.is-integer.html" 
),
"is_link" => array( 
	"methodname" => "is_link", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool is_link ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Tells whether the filename is a symbolic link", 
	"docurl" => "function.is-link.html" 
),
"is_long" => array( 
	"methodname" => "is_long", 
	"version" => "(PHP3, PHP4, PHP5)", 
	"method" => "bool is_long ( mixed var )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of is_int()\nFind whether a variable is an integer", 
	"docurl" => "function.is-long.html" 
),
"is_nan" => array( 
	"methodname" => "is_nan", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool is_nan ( float val )", 
	"snippet" => "( \${1:\$val} )", 
	"desc" => "Finds whether a value is not a number", 
	"docurl" => "function.is-nan.html" 
),
"is_null" => array( 
	"methodname" => "is_null", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool is_null ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Finds whether a variable is NULL", 
	"docurl" => "function.is-null.html" 
),
"is_numeric" => array( 
	"methodname" => "is_numeric", 
	"version" => "PHP4, PHP5", 
	"method" => "bool is_numeric ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Finds whether a variable is a number or a numeric string", 
	"docurl" => "function.is-numeric.html" 
),
"is_object" => array( 
	"methodname" => "is_object", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool is_object ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Finds whether a variable is an object", 
	"docurl" => "function.is-object.html" 
),
"is_readable" => array( 
	"methodname" => "is_readable", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool is_readable ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Tells whether the filename is readable", 
	"docurl" => "function.is-readable.html" 
),
"is_real" => array( 
	"methodname" => "is_real", 
	"version" => "(PHP3, PHP4, PHP5)", 
	"method" => "bool is_real ( mixed var )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of is_float()\nFinds whether a variable is a float", 
	"docurl" => "function.is-real.html" 
),
"is_resource" => array( 
	"methodname" => "is_resource", 
	"version" => "PHP4, PHP5", 
	"method" => "bool is_resource ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Finds whether a variable is a resource", 
	"docurl" => "function.is-resource.html" 
),
"is_scalar" => array( 
	"methodname" => "is_scalar", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool is_scalar ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Finds whether a variable is a scalar", 
	"docurl" => "function.is-scalar.html" 
),
"is_soap_fault" => array( 
	"methodname" => "is_soap_fault", 
	"version" => "PHP5", 
	"method" => "bool is_soap_fault ( mixed obj )", 
	"snippet" => "( \${1:\$obj} )", 
	"desc" => "Checks if SOAP call was failed", 
	"docurl" => "function.is-soap-fault.html" 
),
"is_string" => array( 
	"methodname" => "is_string", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool is_string ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Finds whether a variable is a string", 
	"docurl" => "function.is-string.html" 
),
"is_subclass_of" => array( 
	"methodname" => "is_subclass_of", 
	"version" => "PHP4, PHP5", 
	"method" => "bool is_subclass_of ( mixed object, string class_name )", 
	"snippet" => "( \${1:\$object}, \${2:\$class_name} )", 
	"desc" => "Returns TRUE if the object has this class as one of its parents", 
	"docurl" => "function.is-subclass-of.html" 
),
"is_uploaded_file" => array( 
	"methodname" => "is_uploaded_file", 
	"version" => "PHP3>= 3.0.17, PHP4 >= 4.0.3, PHP5", 
	"method" => "bool is_uploaded_file ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Tells whether the file was uploaded via HTTP POST", 
	"docurl" => "function.is-uploaded-file.html" 
),
"is_writable" => array( 
	"methodname" => "is_writable", 
	"version" => "PHP4, PHP5", 
	"method" => "bool is_writable ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Tells whether the filename is writable", 
	"docurl" => "function.is-writable.html" 
),
"is_writeable" => array( 
	"methodname" => "is_writeable", 
	"version" => "(PHP4, PHP5)", 
	"method" => "bool is_writeable ( string filename )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of is_writable()\nTells whether the filename is writable", 
	"docurl" => "function.is-writeable.html" 
),
"isset" => array( 
	"methodname" => "isset", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool isset ( mixed var [, mixed var [, ...]] )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Determine whether a variable is set", 
	"docurl" => "function.isset.html" 
),
"iterator_count" => array( 
	"methodname" => "iterator_count", 
	"version" => "undefined", 
	"method" => "int iterator_count ( IteratorAggregate iterator )", 
	"snippet" => "( \${1:\$iterator} )", 
	"desc" => "", 
	"docurl" => "function.iterator-count.html" 
),
"iterator_to_array" => array( 
	"methodname" => "iterator_to_array", 
	"version" => "undefined", 
	"method" => "array iterator_to_array ( IteratorAggregate iterator )", 
	"snippet" => "( \${1:\$iterator} )", 
	"desc" => "", 
	"docurl" => "function.iterator-to-array.html" 
),
); # end of main array
?>