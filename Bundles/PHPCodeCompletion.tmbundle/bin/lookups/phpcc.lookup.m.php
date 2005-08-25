<?php
$_LOOKUP = array( 
"mail" => array( 
	"methodname" => "mail", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mail ( string to, string subject, string message [, string additional_headers [, string additional_parameters]] )", 
	"snippet" => "( \${1:\$to}, \${2:\$subject}, \${3:\$message} )", 
	"desc" => "Send mail", 
	"docurl" => "function.mail.html" 
),
"max" => array( 
	"methodname" => "max", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed max ( number arg1, number arg2 [, number ...] )", 
	"snippet" => "( \${1:\$arg1}, \${2:\$arg2} )", 
	"desc" => "Find highest value", 
	"docurl" => "function.max.html" 
),
"maxdb_affected_rows" => array( 
	"methodname" => "maxdb_affected_rows", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_affected_rows ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-affected-rows.html" 
),
"maxdb_autocommit" => array( 
	"methodname" => "maxdb_autocommit", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_autocommit ( resource link, bool mode )", 
	"snippet" => "( \${1:\$link}, \${2:\$mode} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-autocommit.html" 
),
"maxdb_bind_param" => array( 
	"methodname" => "maxdb_bind_param", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-bind-param.html" 
),
"maxdb_bind_result" => array( 
	"methodname" => "maxdb_bind_result", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-bind-result.html" 
),
"maxdb_change_user" => array( 
	"methodname" => "maxdb_change_user", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_change_user ( resource link, string user, string password, string database )", 
	"snippet" => "( \${1:\$link}, \${2:\$user}, \${3:\$password}, \${4:\$database} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-change-user.html" 
),
"maxdb_character_set_name" => array( 
	"methodname" => "maxdb_character_set_name", 
	"version" => "undefined", 
	"method" => "Procedural style:string maxdb_character_set_name ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-character-set-name.html" 
),
"maxdb_client_encoding" => array( 
	"methodname" => "maxdb_client_encoding", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-client-encoding.html" 
),
"maxdb_close_long_data" => array( 
	"methodname" => "maxdb_close_long_data", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-close-long-data.html" 
),
"maxdb_close" => array( 
	"methodname" => "maxdb_close", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_close ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-close.html" 
),
"maxdb_commit" => array( 
	"methodname" => "maxdb_commit", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_commit ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-commit.html" 
),
"maxdb_connect_errno" => array( 
	"methodname" => "maxdb_connect_errno", 
	"version" => "undefined", 
	"method" => "int maxdb_connect_errno ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.maxdb-connect-errno.html" 
),
"maxdb_connect_error" => array( 
	"methodname" => "maxdb_connect_error", 
	"version" => "undefined", 
	"method" => "string maxdb_connect_error ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.maxdb-connect-error.html" 
),
"maxdb_connect" => array( 
	"methodname" => "maxdb_connect", 
	"version" => "undefined", 
	"method" => "Procedural styleresource maxdb_connect ( [string host [, string username [, string passwd [, string dbname [, int port [, string socket]]]]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-connect.html" 
),
"maxdb_data_seek" => array( 
	"methodname" => "maxdb_data_seek", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_data_seek ( resource result, int offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$offset} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-data-seek.html" 
),
"maxdb_debug" => array( 
	"methodname" => "maxdb_debug", 
	"version" => "undefined", 
	"method" => "void maxdb_debug ( string debug )", 
	"snippet" => "( \${1:\$debug} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-debug.html" 
),
"maxdb_disable_reads_from_master" => array( 
	"methodname" => "maxdb_disable_reads_from_master", 
	"version" => "undefined", 
	"method" => "Procedural style:void maxdb_disable_reads_from_master ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-disable-reads-from-master.html" 
),
"maxdb_disable_rpl_parse" => array( 
	"methodname" => "maxdb_disable_rpl_parse", 
	"version" => "undefined", 
	"method" => "void maxdb_disable_rpl_parse ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-disable-rpl-parse.html" 
),
"maxdb_dump_debug_info" => array( 
	"methodname" => "maxdb_dump_debug_info", 
	"version" => "undefined", 
	"method" => "bool maxdb_dump_debug_info ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-dump-debug-info.html" 
),
"maxdb_embedded_connect" => array( 
	"methodname" => "maxdb_embedded_connect", 
	"version" => "undefined", 
	"method" => "resource maxdb_embedded_connect ( [string dbname] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-embedded-connect.html" 
),
"maxdb_enable_reads_from_master" => array( 
	"methodname" => "maxdb_enable_reads_from_master", 
	"version" => "undefined", 
	"method" => "void maxdb_enable_reads_from_master ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-enable-reads-from-master.html" 
),
"maxdb_enable_rpl_parse" => array( 
	"methodname" => "maxdb_enable_rpl_parse", 
	"version" => "undefined", 
	"method" => "void maxdb_enable_rpl_parse ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-enable-rpl-parse.html" 
),
"maxdb_errno" => array( 
	"methodname" => "maxdb_errno", 
	"version" => "undefined", 
	"method" => "Procedural style:int maxdb_errno ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-errno.html" 
),
"maxdb_error" => array( 
	"methodname" => "maxdb_error", 
	"version" => "undefined", 
	"method" => "Procedural style:string maxdb_error ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-error.html" 
),
"maxdb_escape_string" => array( 
	"methodname" => "maxdb_escape_string", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-escape-string.html" 
),
"maxdb_execute" => array( 
	"methodname" => "maxdb_execute", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-execute.html" 
),
"maxdb_fetch_array" => array( 
	"methodname" => "maxdb_fetch_array", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_fetch_array ( resource result [, int resulttype] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-fetch-array.html" 
),
"maxdb_fetch_assoc" => array( 
	"methodname" => "maxdb_fetch_assoc", 
	"version" => "undefined", 
	"method" => "Procedural style:array maxdb_fetch_assoc ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-fetch-assoc.html" 
),
"maxdb_fetch_field_direct" => array( 
	"methodname" => "maxdb_fetch_field_direct", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_fetch_field_direct ( resource result, int fieldnr )", 
	"snippet" => "( \${1:\$result}, \${2:\$fieldnr} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-fetch-field-direct.html" 
),
"maxdb_fetch_field" => array( 
	"methodname" => "maxdb_fetch_field", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_fetch_field ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-fetch-field.html" 
),
"maxdb_fetch_fields" => array( 
	"methodname" => "maxdb_fetch_fields", 
	"version" => "undefined", 
	"method" => "Procedural Style:mixed maxdb_fetch_fields ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-fetch-fields.html" 
),
"maxdb_fetch_lengths" => array( 
	"methodname" => "maxdb_fetch_lengths", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_fetch_lengths ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-fetch-lengths.html" 
),
"maxdb_fetch_object" => array( 
	"methodname" => "maxdb_fetch_object", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_fetch_object ( object result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-fetch-object.html" 
),
"maxdb_fetch_row" => array( 
	"methodname" => "maxdb_fetch_row", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_fetch_row ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-fetch-row.html" 
),
"maxdb_fetch" => array( 
	"methodname" => "maxdb_fetch", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-fetch.html" 
),
"maxdb_field_count" => array( 
	"methodname" => "maxdb_field_count", 
	"version" => "undefined", 
	"method" => "Procedural style:int maxdb_field_count ( object link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-field-count.html" 
),
"maxdb_field_seek" => array( 
	"methodname" => "maxdb_field_seek", 
	"version" => "undefined", 
	"method" => "Procedural style:int maxdb_field_seek ( object result, int fieldnr )", 
	"snippet" => "( \${1:\$result}, \${2:\$fieldnr} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-field-seek.html" 
),
"maxdb_field_tell" => array( 
	"methodname" => "maxdb_field_tell", 
	"version" => "undefined", 
	"method" => "Procedural style:int maxdb_field_tell ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-field-tell.html" 
),
"maxdb_free_result" => array( 
	"methodname" => "maxdb_free_result", 
	"version" => "undefined", 
	"method" => "Procedural style:void maxdb_free_result ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-free-result.html" 
),
"maxdb_get_client_info" => array( 
	"methodname" => "maxdb_get_client_info", 
	"version" => "undefined", 
	"method" => "string maxdb_get_client_info ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.maxdb-get-client-info.html" 
),
"maxdb_get_client_version" => array( 
	"methodname" => "maxdb_get_client_version", 
	"version" => "undefined", 
	"method" => "int maxdb_get_client_version ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.maxdb-get-client-version.html" 
),
"maxdb_get_host_info" => array( 
	"methodname" => "maxdb_get_host_info", 
	"version" => "undefined", 
	"method" => "Procdural style:string maxdb_get_host_info ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-get-host-info.html" 
),
"maxdb_get_metadata" => array( 
	"methodname" => "maxdb_get_metadata", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-get-metadata.html" 
),
"maxdb_get_proto_info" => array( 
	"methodname" => "maxdb_get_proto_info", 
	"version" => "undefined", 
	"method" => "Procedural style:int maxdb_get_proto_info ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-get-proto-info.html" 
),
"maxdb_get_server_info" => array( 
	"methodname" => "maxdb_get_server_info", 
	"version" => "undefined", 
	"method" => "Procedural style:string maxdb_get_server_info ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-get-server-info.html" 
),
"maxdb_get_server_version" => array( 
	"methodname" => "maxdb_get_server_version", 
	"version" => "undefined", 
	"method" => "Procedural style:int maxdb_get_server_version ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-get-server-version.html" 
),
"maxdb_info" => array( 
	"methodname" => "maxdb_info", 
	"version" => "undefined", 
	"method" => "Procedural style:string maxdb_info ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-info.html" 
),
"maxdb_init" => array( 
	"methodname" => "maxdb_init", 
	"version" => "undefined", 
	"method" => "resource maxdb_init ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.maxdb-init.html" 
),
"maxdb_insert_id" => array( 
	"methodname" => "maxdb_insert_id", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_insert_id ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-insert-id.html" 
),
"maxdb_kill" => array( 
	"methodname" => "maxdb_kill", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_kill ( resource link, int processid )", 
	"snippet" => "( \${1:\$link}, \${2:\$processid} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-kill.html" 
),
"maxdb_master_query" => array( 
	"methodname" => "maxdb_master_query", 
	"version" => "undefined", 
	"method" => "bool maxdb_master_query ( resource link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-master-query.html" 
),
"maxdb_more_results" => array( 
	"methodname" => "maxdb_more_results", 
	"version" => "undefined", 
	"method" => "bool maxdb_more_results ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-more-results.html" 
),
"maxdb_multi_query" => array( 
	"methodname" => "maxdb_multi_query", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_multi_query ( resource link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-multi-query.html" 
),
"maxdb_next_result" => array( 
	"methodname" => "maxdb_next_result", 
	"version" => "undefined", 
	"method" => "bool maxdb_next_result ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-next-result.html" 
),
"maxdb_num_fields" => array( 
	"methodname" => "maxdb_num_fields", 
	"version" => "undefined", 
	"method" => "Procedural style:int maxdb_num_fields ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-num-fields.html" 
),
"maxdb_num_rows" => array( 
	"methodname" => "maxdb_num_rows", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_num_rows ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-num-rows.html" 
),
"maxdb_options" => array( 
	"methodname" => "maxdb_options", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_options ( resource link, int option, mixed value )", 
	"snippet" => "( \${1:\$link}, \${2:\$option}, \${3:\$value} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-options.html" 
),
"maxdb_param_count" => array( 
	"methodname" => "maxdb_param_count", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-param-count.html" 
),
"maxdb_ping" => array( 
	"methodname" => "maxdb_ping", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_ping ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-ping.html" 
),
"maxdb_prepare" => array( 
	"methodname" => "maxdb_prepare", 
	"version" => "undefined", 
	"method" => "Procedure style:mixed maxdb_prepare ( resource link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-prepare.html" 
),
"maxdb_query" => array( 
	"methodname" => "maxdb_query", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_query ( resource link, string query [, int resultmode] )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-query.html" 
),
"maxdb_real_connect" => array( 
	"methodname" => "maxdb_real_connect", 
	"version" => "undefined", 
	"method" => "Procedural stylebool maxdb_real_connect ( resource link [, string hostname [, string username [, string passwd [, string dbname [, int port [, string socket]]]]]] )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-real-connect.html" 
),
"maxdb_real_escape_string" => array( 
	"methodname" => "maxdb_real_escape_string", 
	"version" => "undefined", 
	"method" => "Procedural style:string maxdb_real_escape_string ( resource link, string escapestr )", 
	"snippet" => "( \${1:\$link}, \${2:\$escapestr} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-real-escape-string.html" 
),
"maxdb_real_query" => array( 
	"methodname" => "maxdb_real_query", 
	"version" => "undefined", 
	"method" => "Procedural stylebool maxdb_real_query ( resource link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-real-query.html" 
),
"maxdb_report" => array( 
	"methodname" => "maxdb_report", 
	"version" => "undefined", 
	"method" => "bool maxdb_report ( int flags )", 
	"snippet" => "( \${1:\$flags} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-report.html" 
),
"maxdb_rollback" => array( 
	"methodname" => "maxdb_rollback", 
	"version" => "undefined", 
	"method" => "bool maxdb_rollback ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-rollback.html" 
),
"maxdb_rpl_parse_enabled" => array( 
	"methodname" => "maxdb_rpl_parse_enabled", 
	"version" => "undefined", 
	"method" => "int maxdb_rpl_parse_enabled ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-rpl-parse-enabled.html" 
),
"maxdb_rpl_probe" => array( 
	"methodname" => "maxdb_rpl_probe", 
	"version" => "undefined", 
	"method" => "bool maxdb_rpl_probe ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-rpl-probe.html" 
),
"maxdb_rpl_query_type" => array( 
	"methodname" => "maxdb_rpl_query_type", 
	"version" => "undefined", 
	"method" => "int maxdb_rpl_query_type ( string query )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-rpl-query-type.html" 
),
"maxdb_select_db" => array( 
	"methodname" => "maxdb_select_db", 
	"version" => "undefined", 
	"method" => "bool maxdb_select_db ( resource link, string dbname )", 
	"snippet" => "( \${1:\$link}, \${2:\$dbname} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-select-db.html" 
),
"maxdb_send_long_data" => array( 
	"methodname" => "maxdb_send_long_data", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-send-long-data.html" 
),
"maxdb_send_query" => array( 
	"methodname" => "maxdb_send_query", 
	"version" => "undefined", 
	"method" => "bool maxdb_send_query ( resource link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-send-query.html" 
),
"maxdb_server_end" => array( 
	"methodname" => "maxdb_server_end", 
	"version" => "undefined", 
	"method" => "void maxdb_server_end ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.maxdb-server-end.html" 
),
"maxdb_server_init" => array( 
	"methodname" => "maxdb_server_init", 
	"version" => "undefined", 
	"method" => "bool maxdb_server_init ( [array server [, array groups]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-server-init.html" 
),
"maxdb_set_opt" => array( 
	"methodname" => "maxdb_set_opt", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.maxdb-set-opt.html" 
),
"maxdb_sqlstate" => array( 
	"methodname" => "maxdb_sqlstate", 
	"version" => "undefined", 
	"method" => "Procedural style:string maxdb_sqlstate ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-sqlstate.html" 
),
"maxdb_ssl_set" => array( 
	"methodname" => "maxdb_ssl_set", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_ssl_set ( resource link [, string key [, string cert [, string ca [, string capath [, string cipher]]]]] )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-ssl-set.html" 
),
"maxdb_stat" => array( 
	"methodname" => "maxdb_stat", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_stat ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stat.html" 
),
"maxdb_stmt_affected_rows" => array( 
	"methodname" => "maxdb_stmt_affected_rows", 
	"version" => "undefined", 
	"method" => "Procedural style :mixed maxdb_stmt_affected_rows ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-affected-rows.html" 
),
"maxdb_stmt_bind_param" => array( 
	"methodname" => "maxdb_stmt_bind_param", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_stmt_bind_param ( resource stmt, string types, mixed &var1 [, mixed &...] )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$types}, \${3:\$var1} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-bind-param.html" 
),
"maxdb_stmt_bind_result" => array( 
	"methodname" => "maxdb_stmt_bind_result", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_stmt_bind_result ( resource stmt, mixed &var1 [, mixed &...] )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$var1} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-bind-result.html" 
),
"maxdb_stmt_close_long_data" => array( 
	"methodname" => "maxdb_stmt_close_long_data", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_stmt_send_long_data ( resource stmt, int param_nr )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$param_nr} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-close-long-data.html" 
),
"maxdb_stmt_close" => array( 
	"methodname" => "maxdb_stmt_close", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_stmt_close ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-close.html" 
),
"maxdb_stmt_data_seek" => array( 
	"methodname" => "maxdb_stmt_data_seek", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_stmt_data_seek ( resource statement, int offset )", 
	"snippet" => "( \${1:\$statement}, \${2:\$offset} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-data-seek.html" 
),
"maxdb_stmt_errno" => array( 
	"methodname" => "maxdb_stmt_errno", 
	"version" => "undefined", 
	"method" => "Procedural style :int maxdb_stmt_errno ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-errno.html" 
),
"maxdb_stmt_error" => array( 
	"methodname" => "maxdb_stmt_error", 
	"version" => "undefined", 
	"method" => "Procedural style:string maxdb_stmt_error ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-error.html" 
),
"maxdb_stmt_execute" => array( 
	"methodname" => "maxdb_stmt_execute", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_stmt_execute ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-execute.html" 
),
"maxdb_stmt_fetch" => array( 
	"methodname" => "maxdb_stmt_fetch", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_stmt_fetch ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-fetch.html" 
),
"maxdb_stmt_free_result" => array( 
	"methodname" => "maxdb_stmt_free_result", 
	"version" => "undefined", 
	"method" => "Procedural style:void maxdb_stmt_free_result ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-free-result.html" 
),
"maxdb_stmt_init" => array( 
	"methodname" => "maxdb_stmt_init", 
	"version" => "undefined", 
	"method" => "Procedural style :resource maxdb_stmt_init ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-init.html" 
),
"maxdb_stmt_num_rows" => array( 
	"methodname" => "maxdb_stmt_num_rows", 
	"version" => "undefined", 
	"method" => "Procedural style :mixed maxdb_stmt_num_rows ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-num-rows.html" 
),
"maxdb_stmt_param_count" => array( 
	"methodname" => "maxdb_stmt_param_count", 
	"version" => "undefined", 
	"method" => "Procedural style:int maxdb_stmt_param_count ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-param-count.html" 
),
"maxdb_stmt_prepare" => array( 
	"methodname" => "maxdb_stmt_prepare", 
	"version" => "undefined", 
	"method" => "Procedure style:bool maxdb_stmt_prepare ( resource stmt, string query )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$query} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-prepare.html" 
),
"maxdb_stmt_reset" => array( 
	"methodname" => "maxdb_stmt_reset", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_stmt_reset ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-reset.html" 
),
"maxdb_stmt_result_metadata" => array( 
	"methodname" => "maxdb_stmt_result_metadata", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_stmt_result_metadata ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-result-metadata.html" 
),
"maxdb_stmt_send_long_data" => array( 
	"methodname" => "maxdb_stmt_send_long_data", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_stmt_send_long_data ( resource stmt, int param_nr, string data )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$param_nr}, \${3:\$data} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-send-long-data.html" 
),
"maxdb_stmt_sqlstate" => array( 
	"methodname" => "maxdb_stmt_sqlstate", 
	"version" => "undefined", 
	"method" => "string maxdb_stmt_sqlstate ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-sqlstate.html" 
),
"maxdb_stmt_store_result" => array( 
	"methodname" => "maxdb_stmt_store_result", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_stmt_store_result ( resource stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-stmt-store-result.html" 
),
"maxdb_store_result" => array( 
	"methodname" => "maxdb_store_result", 
	"version" => "undefined", 
	"method" => "Procedural style:resource maxdb_store_result ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-store-result.html" 
),
"maxdb_thread_id" => array( 
	"methodname" => "maxdb_thread_id", 
	"version" => "undefined", 
	"method" => "Procedural style:int maxdb_thread_id ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-thread-id.html" 
),
"maxdb_thread_safe" => array( 
	"methodname" => "maxdb_thread_safe", 
	"version" => "undefined", 
	"method" => "Procedural style:bool maxdb_thread_safe ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.maxdb-thread-safe.html" 
),
"maxdb_use_result" => array( 
	"methodname" => "maxdb_use_result", 
	"version" => "undefined", 
	"method" => "Procedural style:mixed maxdb_use_result ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-use-result.html" 
),
"maxdb_warning_count" => array( 
	"methodname" => "maxdb_warning_count", 
	"version" => "undefined", 
	"method" => "Procedural style:int maxdb_warning_count ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "", 
	"docurl" => "function.maxdb-warning-count.html" 
),
"mb_convert_case" => array( 
	"methodname" => "mb_convert_case", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mb_convert_case ( string str, int mode [, string encoding] )", 
	"snippet" => "( \${1:\$str}, \${2:\$mode} )", 
	"desc" => "Perform case folding on a string", 
	"docurl" => "function.mb-convert-case.html" 
),
"mb_convert_encoding" => array( 
	"methodname" => "mb_convert_encoding", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_convert_encoding ( string str, string to_encoding [, mixed from_encoding] )", 
	"snippet" => "( \${1:\$str}, \${2:\$to_encoding} )", 
	"desc" => "Convert character encoding", 
	"docurl" => "function.mb-convert-encoding.html" 
),
"mb_convert_kana" => array( 
	"methodname" => "mb_convert_kana", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_convert_kana ( string str [, string option [, string encoding]] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Convert \"kana\" one from another (\"zen-kaku\", \"han-kaku\" and more)", 
	"docurl" => "function.mb-convert-kana.html" 
),
"mb_convert_variables" => array( 
	"methodname" => "mb_convert_variables", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_convert_variables ( string to_encoding, mixed from_encoding, mixed &vars [, mixed &...] )", 
	"snippet" => "( \${1:\$to_encoding}, \${2:\$from_encoding}, \${3:\$vars} )", 
	"desc" => "Convert character code in variable(s)", 
	"docurl" => "function.mb-convert-variables.html" 
),
"mb_decode_mimeheader" => array( 
	"methodname" => "mb_decode_mimeheader", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_decode_mimeheader ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Decode string in MIME header field", 
	"docurl" => "function.mb-decode-mimeheader.html" 
),
"mb_decode_numericentity" => array( 
	"methodname" => "mb_decode_numericentity", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_decode_numericentity ( string str, array convmap [, string encoding] )", 
	"snippet" => "( \${1:\$str}, \${2:\$convmap} )", 
	"desc" => "Decode HTML numeric string reference to character", 
	"docurl" => "function.mb-decode-numericentity.html" 
),
"mb_detect_encoding" => array( 
	"methodname" => "mb_detect_encoding", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_detect_encoding ( string str [, mixed encoding_list [, bool strict]] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Detect character encoding", 
	"docurl" => "function.mb-detect-encoding.html" 
),
"mb_detect_order" => array( 
	"methodname" => "mb_detect_order", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array mb_detect_order ( [mixed encoding_list] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Set/Get character encoding detection order", 
	"docurl" => "function.mb-detect-order.html" 
),
"mb_encode_mimeheader" => array( 
	"methodname" => "mb_encode_mimeheader", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_encode_mimeheader ( string str [, string charset [, string transfer_encoding [, string linefeed]]] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Encode string for MIME header", 
	"docurl" => "function.mb-encode-mimeheader.html" 
),
"mb_encode_numericentity" => array( 
	"methodname" => "mb_encode_numericentity", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_encode_numericentity ( string str, array convmap [, string encoding] )", 
	"snippet" => "( \${1:\$str}, \${2:\$convmap} )", 
	"desc" => "Encode character to HTML numeric string reference", 
	"docurl" => "function.mb-encode-numericentity.html" 
),
"mb_ereg_match" => array( 
	"methodname" => "mb_ereg_match", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "bool mb_ereg_match ( string pattern, string string [, string option] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$string} )", 
	"desc" => "Regular expression match for multibyte string", 
	"docurl" => "function.mb-ereg-match.html" 
),
"mb_ereg_replace" => array( 
	"methodname" => "mb_ereg_replace", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "string mb_ereg_replace ( string pattern, string replacement, string string [, array option] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$replacement}, \${3:\$string} )", 
	"desc" => "Replace regular expression with multibyte support", 
	"docurl" => "function.mb-ereg-replace.html" 
),
"mb_ereg_search_getpos" => array( 
	"methodname" => "mb_ereg_search_getpos", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "array mb_ereg_search_getpos ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns start point for next regular expression match", 
	"docurl" => "function.mb-ereg-search-getpos.html" 
),
"mb_ereg_search_getregs" => array( 
	"methodname" => "mb_ereg_search_getregs", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "array mb_ereg_search_getregs ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Retrieve the result from the last multibyte regular expression   match", 
	"docurl" => "function.mb-ereg-search-getregs.html" 
),
"mb_ereg_search_init" => array( 
	"methodname" => "mb_ereg_search_init", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "array mb_ereg_search_init ( string string [, string pattern [, string option]] )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Setup string and regular expression for multibyte regular   expression match", 
	"docurl" => "function.mb-ereg-search-init.html" 
),
"mb_ereg_search_pos" => array( 
	"methodname" => "mb_ereg_search_pos", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "array mb_ereg_search_pos ( [string pattern [, string option]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Return position and length of matched part of multibyte regular   expression for predefined multibyte string", 
	"docurl" => "function.mb-ereg-search-pos.html" 
),
"mb_ereg_search_regs" => array( 
	"methodname" => "mb_ereg_search_regs", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "array mb_ereg_search_regs ( [string pattern [, string option]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns the matched part of multibyte regular expression", 
	"docurl" => "function.mb-ereg-search-regs.html" 
),
"mb_ereg_search_setpos" => array( 
	"methodname" => "mb_ereg_search_setpos", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "array mb_ereg_search_setpos ( int position )", 
	"snippet" => "( \${1:\$position} )", 
	"desc" => "Set start point of next regular expression match", 
	"docurl" => "function.mb-ereg-search-setpos.html" 
),
"mb_ereg_search" => array( 
	"methodname" => "mb_ereg_search", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "bool mb_ereg_search ( [string pattern [, string option]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Multibyte regular expression match for predefined multibyte string", 
	"docurl" => "function.mb-ereg-search.html" 
),
"mb_ereg" => array( 
	"methodname" => "mb_ereg", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "int mb_ereg ( string pattern, string string [, array regs] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$string} )", 
	"desc" => "Regular expression match with multibyte support", 
	"docurl" => "function.mb-ereg.html" 
),
"mb_eregi_replace" => array( 
	"methodname" => "mb_eregi_replace", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "string mb_eregi_replace ( string pattern, string replace, string string )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$replace}, \${3:\$string} )", 
	"desc" => "Replace regular expression with multibyte support   ignoring case", 
	"docurl" => "function.mb-eregi-replace.html" 
),
"mb_eregi" => array( 
	"methodname" => "mb_eregi", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "int mb_eregi ( string pattern, string string [, array regs] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$string} )", 
	"desc" => "Regular expression match ignoring case with multibyte support", 
	"docurl" => "function.mb-eregi.html" 
),
"mb_get_info" => array( 
	"methodname" => "mb_get_info", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string mb_get_info ( [string type] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get internal settings of mbstring", 
	"docurl" => "function.mb-get-info.html" 
),
"mb_http_input" => array( 
	"methodname" => "mb_http_input", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_http_input ( [string type] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Detect HTTP input character encoding", 
	"docurl" => "function.mb-http-input.html" 
),
"mb_http_output" => array( 
	"methodname" => "mb_http_output", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_http_output ( [string encoding] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Set/Get HTTP output character encoding", 
	"docurl" => "function.mb-http-output.html" 
),
"mb_internal_encoding" => array( 
	"methodname" => "mb_internal_encoding", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "mixed mb_internal_encoding ( [string encoding] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Set/Get internal character encoding", 
	"docurl" => "function.mb-internal-encoding.html" 
),
"mb_language" => array( 
	"methodname" => "mb_language", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_language ( [string language] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Set/Get current language", 
	"docurl" => "function.mb-language.html" 
),
"mb_list_encodings" => array( 
	"methodname" => "mb_list_encodings", 
	"version" => "PHP5", 
	"method" => "array mb_list_encodings ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns an array of all supported encodings", 
	"docurl" => "function.mb-list-encodings.html" 
),
"mb_output_handler" => array( 
	"methodname" => "mb_output_handler", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_output_handler ( string contents, int status )", 
	"snippet" => "( \${1:\$contents}, \${2:\$status} )", 
	"desc" => "Callback function converts character encoding in output buffer", 
	"docurl" => "function.mb-output-handler.html" 
),
"mb_parse_str" => array( 
	"methodname" => "mb_parse_str", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool mb_parse_str ( string encoded_string [, array &result] )", 
	"snippet" => "( \${1:\$encoded_string} )", 
	"desc" => "Parse GET/POST/COOKIE data and set global variable", 
	"docurl" => "function.mb-parse-str.html" 
),
"mb_preferred_mime_name" => array( 
	"methodname" => "mb_preferred_mime_name", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_preferred_mime_name ( string encoding )", 
	"snippet" => "( \${1:\$encoding} )", 
	"desc" => "Get MIME charset string", 
	"docurl" => "function.mb-preferred-mime-name.html" 
),
"mb_regex_encoding" => array( 
	"methodname" => "mb_regex_encoding", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "string mb_regex_encoding ( [string encoding] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns current encoding for multibyte regex as string", 
	"docurl" => "function.mb-regex-encoding.html" 
),
"mb_regex_set_options" => array( 
	"methodname" => "mb_regex_set_options", 
	"version" => "PHP4 >= 4.3.0", 
	"method" => "string mb_regex_set_options ( [string options] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Set/Get the default options for mbregex functions", 
	"docurl" => "function.mb-regex-set-options.html" 
),
"mb_send_mail" => array( 
	"methodname" => "mb_send_mail", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool mb_send_mail ( string to, string subject, string message [, string additional_headers [, string additional_parameter]] )", 
	"snippet" => "( \${1:\$to}, \${2:\$subject}, \${3:\$message} )", 
	"desc" => "Send encoded mail", 
	"docurl" => "function.mb-send-mail.html" 
),
"mb_split" => array( 
	"methodname" => "mb_split", 
	"version" => "PHP4 >= 4.2.0", 
	"method" => "array mb_split ( string pattern, string string [, int limit] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$string} )", 
	"desc" => "Split multibyte string using regular expression", 
	"docurl" => "function.mb-split.html" 
),
"mb_strcut" => array( 
	"methodname" => "mb_strcut", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_strcut ( string str, int start [, int length [, string encoding]] )", 
	"snippet" => "( \${1:\$str}, \${2:\$start} )", 
	"desc" => "Get part of string", 
	"docurl" => "function.mb-strcut.html" 
),
"mb_strimwidth" => array( 
	"methodname" => "mb_strimwidth", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_strimwidth ( string str, int start, int width [, string trimmarker [, string encoding]] )", 
	"snippet" => "( \${1:\$str}, \${2:\$start}, \${3:\$width} )", 
	"desc" => "Get truncated string with specified width", 
	"docurl" => "function.mb-strimwidth.html" 
),
"mb_strlen" => array( 
	"methodname" => "mb_strlen", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_strlen ( string str [, string encoding] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Get string length", 
	"docurl" => "function.mb-strlen.html" 
),
"mb_strpos" => array( 
	"methodname" => "mb_strpos", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int mb_strpos ( string haystack, string needle [, int offset [, string encoding]] )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Find position of first occurrence of string in a string", 
	"docurl" => "function.mb-strpos.html" 
),
"mb_strrpos" => array( 
	"methodname" => "mb_strrpos", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int mb_strrpos ( string haystack, string needle [, string encoding] )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Find position of last occurrence of a string in a string", 
	"docurl" => "function.mb-strrpos.html" 
),
"mb_strtolower" => array( 
	"methodname" => "mb_strtolower", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mb_strtolower ( string str [, string encoding] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Make a string lowercase", 
	"docurl" => "function.mb-strtolower.html" 
),
"mb_strtoupper" => array( 
	"methodname" => "mb_strtoupper", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mb_strtoupper ( string str [, string encoding] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Make a string uppercase", 
	"docurl" => "function.mb-strtoupper.html" 
),
"mb_strwidth" => array( 
	"methodname" => "mb_strwidth", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int mb_strwidth ( string str [, string encoding] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Return width of string", 
	"docurl" => "function.mb-strwidth.html" 
),
"mb_substitute_character" => array( 
	"methodname" => "mb_substitute_character", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "mixed mb_substitute_character ( [mixed substrchar] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Set/Get substitution character", 
	"docurl" => "function.mb-substitute-character.html" 
),
"mb_substr_count" => array( 
	"methodname" => "mb_substr_count", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int mb_substr_count ( string haystack, string needle [, string encoding] )", 
	"snippet" => "( \${1:\$haystack}, \${2:\$needle} )", 
	"desc" => "Count the number of substring occurrences", 
	"docurl" => "function.mb-substr-count.html" 
),
"mb_substr" => array( 
	"methodname" => "mb_substr", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string mb_substr ( string str, int start [, int length [, string encoding]] )", 
	"snippet" => "( \${1:\$str}, \${2:\$start} )", 
	"desc" => "Get part of string", 
	"docurl" => "function.mb-substr.html" 
),
"mcal_append_event" => array( 
	"methodname" => "mcal_append_event", 
	"version" => "PHP4", 
	"method" => "int mcal_append_event ( int mcal_stream )", 
	"snippet" => "( \${1:\$mcal_stream} )", 
	"desc" => "Store a new event into an MCAL calendar", 
	"docurl" => "function.mcal-append-event.html" 
),
"mcal_close" => array( 
	"methodname" => "mcal_close", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_close ( int mcal_stream [, int flags] )", 
	"snippet" => "( \${1:\$mcal_stream} )", 
	"desc" => "Close an MCAL stream", 
	"docurl" => "function.mcal-close.html" 
),
"mcal_create_calendar" => array( 
	"methodname" => "mcal_create_calendar", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "bool mcal_create_calendar ( int stream, string calendar )", 
	"snippet" => "( \${1:\$stream}, \${2:\$calendar} )", 
	"desc" => "Create a new MCAL calendar", 
	"docurl" => "function.mcal-create-calendar.html" 
),
"mcal_date_compare" => array( 
	"methodname" => "mcal_date_compare", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_date_compare ( int a_year, int a_month, int a_day, int b_year, int b_month, int b_day )", 
	"snippet" => "( \${1:\$a_year}, \${2:\$a_month}, \${3:\$a_day}, \${4:\$b_year}, \${5:\$b_month}, \${6:\$b_day} )", 
	"desc" => "Compares two dates", 
	"docurl" => "function.mcal-date-compare.html" 
),
"mcal_date_valid" => array( 
	"methodname" => "mcal_date_valid", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_date_valid ( int year, int month, int day )", 
	"snippet" => "( \${1:\$year}, \${2:\$month}, \${3:\$day} )", 
	"desc" => "Returns TRUE if the given year, month, day is a valid date", 
	"docurl" => "function.mcal-date-valid.html" 
),
"mcal_day_of_week" => array( 
	"methodname" => "mcal_day_of_week", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_day_of_week ( int year, int month, int day )", 
	"snippet" => "( \${1:\$year}, \${2:\$month}, \${3:\$day} )", 
	"desc" => "Returns the day of the week of the given date", 
	"docurl" => "function.mcal-day-of-week.html" 
),
"mcal_day_of_year" => array( 
	"methodname" => "mcal_day_of_year", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_day_of_year ( int year, int month, int day )", 
	"snippet" => "( \${1:\$year}, \${2:\$month}, \${3:\$day} )", 
	"desc" => "Returns the day of the year of the given date", 
	"docurl" => "function.mcal-day-of-year.html" 
),
"mcal_days_in_month" => array( 
	"methodname" => "mcal_days_in_month", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_days_in_month ( int month, int leap_year )", 
	"snippet" => "( \${1:\$month}, \${2:\$leap_year} )", 
	"desc" => "Returns the number of days in a month", 
	"docurl" => "function.mcal-days-in-month.html" 
),
"mcal_delete_calendar" => array( 
	"methodname" => "mcal_delete_calendar", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "string mcal_delete_calendar ( int stream, string calendar )", 
	"snippet" => "( \${1:\$stream}, \${2:\$calendar} )", 
	"desc" => "Delete an MCAL calendar", 
	"docurl" => "function.mcal-delete-calendar.html" 
),
"mcal_delete_event" => array( 
	"methodname" => "mcal_delete_event", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_delete_event ( int mcal_stream, int event_id )", 
	"snippet" => "( \${1:\$mcal_stream}, \${2:\$event_id} )", 
	"desc" => "Delete an event from an MCAL calendar", 
	"docurl" => "function.mcal-delete-event.html" 
),
"mcal_event_add_attribute" => array( 
	"methodname" => "mcal_event_add_attribute", 
	"version" => "PHP3>= 3.0.15, PHP4", 
	"method" => "void mcal_event_add_attribute ( int stream, string attribute, string value )", 
	"snippet" => "( \${1:\$stream}, \${2:\$attribute}, \${3:\$value} )", 
	"desc" => "Adds an attribute and a value to the streams global event structure", 
	"docurl" => "function.mcal-event-add-attribute.html" 
),
"mcal_event_init" => array( 
	"methodname" => "mcal_event_init", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_init ( int stream )", 
	"snippet" => "( \${1:\$stream} )", 
	"desc" => "Initializes a streams global event structure", 
	"docurl" => "function.mcal-event-init.html" 
),
"mcal_event_set_alarm" => array( 
	"methodname" => "mcal_event_set_alarm", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_alarm ( int stream, int alarm )", 
	"snippet" => "( \${1:\$stream}, \${2:\$alarm} )", 
	"desc" => "Sets the alarm of the streams global event structure", 
	"docurl" => "function.mcal-event-set-alarm.html" 
),
"mcal_event_set_category" => array( 
	"methodname" => "mcal_event_set_category", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_category ( int stream, string category )", 
	"snippet" => "( \${1:\$stream}, \${2:\$category} )", 
	"desc" => "Sets the category of the streams global event structure", 
	"docurl" => "function.mcal-event-set-category.html" 
),
"mcal_event_set_class" => array( 
	"methodname" => "mcal_event_set_class", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_class ( int stream, int class )", 
	"snippet" => "( \${1:\$stream}, \${2:\$class} )", 
	"desc" => "Sets the class of the streams global event structure", 
	"docurl" => "function.mcal-event-set-class.html" 
),
"mcal_event_set_description" => array( 
	"methodname" => "mcal_event_set_description", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_description ( int stream, string description )", 
	"snippet" => "( \${1:\$stream}, \${2:\$description} )", 
	"desc" => "Sets the description of the streams global event structure", 
	"docurl" => "function.mcal-event-set-description.html" 
),
"mcal_event_set_end" => array( 
	"methodname" => "mcal_event_set_end", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_end ( int stream, int year, int month, int day [, int hour [, int min [, int sec]]] )", 
	"snippet" => "( \${1:\$stream}, \${2:\$year}, \${3:\$month}, \${4:\$day} )", 
	"desc" => "Sets the end date and time of the streams global event structure", 
	"docurl" => "function.mcal-event-set-end.html" 
),
"mcal_event_set_recur_daily" => array( 
	"methodname" => "mcal_event_set_recur_daily", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_recur_daily ( int stream, int year, int month, int day, int interval )", 
	"snippet" => "( \${1:\$stream}, \${2:\$year}, \${3:\$month}, \${4:\$day}, \${5:\$interval} )", 
	"desc" => "Sets the recurrence of the streams global event structure", 
	"docurl" => "function.mcal-event-set-recur-daily.html" 
),
"mcal_event_set_recur_monthly_mday" => array( 
	"methodname" => "mcal_event_set_recur_monthly_mday", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_recur_monthly_mday ( int stream, int year, int month, int day, int interval )", 
	"snippet" => "( \${1:\$stream}, \${2:\$year}, \${3:\$month}, \${4:\$day}, \${5:\$interval} )", 
	"desc" => "Sets the recurrence of the streams global event structure", 
	"docurl" => "function.mcal-event-set-recur-monthly-mday.html" 
),
"mcal_event_set_recur_monthly_wday" => array( 
	"methodname" => "mcal_event_set_recur_monthly_wday", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_recur_monthly_wday ( int stream, int year, int month, int day, int interval )", 
	"snippet" => "( \${1:\$stream}, \${2:\$year}, \${3:\$month}, \${4:\$day}, \${5:\$interval} )", 
	"desc" => "Sets the recurrence of the streams global event structure", 
	"docurl" => "function.mcal-event-set-recur-monthly-wday.html" 
),
"mcal_event_set_recur_none" => array( 
	"methodname" => "mcal_event_set_recur_none", 
	"version" => "PHP3>= 3.0.15, PHP4", 
	"method" => "int mcal_event_set_recur_none ( int stream )", 
	"snippet" => "( \${1:\$stream} )", 
	"desc" => "Sets the recurrence of the streams global event structure", 
	"docurl" => "function.mcal-event-set-recur-none.html" 
),
"mcal_event_set_recur_weekly" => array( 
	"methodname" => "mcal_event_set_recur_weekly", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_recur_weekly ( int stream, int year, int month, int day, int interval, int weekdays )", 
	"snippet" => "( \${1:\$stream}, \${2:\$year}, \${3:\$month}, \${4:\$day}, \${5:\$interval}, \${6:\$weekdays} )", 
	"desc" => "Sets the recurrence of the streams global event structure", 
	"docurl" => "function.mcal-event-set-recur-weekly.html" 
),
"mcal_event_set_recur_yearly" => array( 
	"methodname" => "mcal_event_set_recur_yearly", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_recur_yearly ( int stream, int year, int month, int day, int interval )", 
	"snippet" => "( \${1:\$stream}, \${2:\$year}, \${3:\$month}, \${4:\$day}, \${5:\$interval} )", 
	"desc" => "Sets the recurrence of the streams global event structure", 
	"docurl" => "function.mcal-event-set-recur-yearly.html" 
),
"mcal_event_set_start" => array( 
	"methodname" => "mcal_event_set_start", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_start ( int stream, int year, int month, int day [, int hour [, int min [, int sec]]] )", 
	"snippet" => "( \${1:\$stream}, \${2:\$year}, \${3:\$month}, \${4:\$day} )", 
	"desc" => "Sets the start date and time of the streams global event   structure", 
	"docurl" => "function.mcal-event-set-start.html" 
),
"mcal_event_set_title" => array( 
	"methodname" => "mcal_event_set_title", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_event_set_title ( int stream, string title )", 
	"snippet" => "( \${1:\$stream}, \${2:\$title} )", 
	"desc" => "Sets the title of the streams global event structure", 
	"docurl" => "function.mcal-event-set-title.html" 
),
"mcal_expunge" => array( 
	"methodname" => "mcal_expunge", 
	"version" => "undefined", 
	"method" => "int mcal_expunge ( int stream )", 
	"snippet" => "( \${1:\$stream} )", 
	"desc" => "", 
	"docurl" => "function.mcal-expunge.html" 
),
"mcal_fetch_current_stream_event" => array( 
	"methodname" => "mcal_fetch_current_stream_event", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "object mcal_fetch_current_stream_event ( int stream )", 
	"snippet" => "( \${1:\$stream} )", 
	"desc" => "Returns an object containing the current streams event structure", 
	"docurl" => "function.mcal-fetch-current-stream-event.html" 
),
"mcal_fetch_event" => array( 
	"methodname" => "mcal_fetch_event", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "object mcal_fetch_event ( int mcal_stream, int event_id [, int options] )", 
	"snippet" => "( \${1:\$mcal_stream}, \${2:\$event_id} )", 
	"desc" => "Fetches an event from the calendar stream", 
	"docurl" => "function.mcal-fetch-event.html" 
),
"mcal_is_leap_year" => array( 
	"methodname" => "mcal_is_leap_year", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_is_leap_year ( int year )", 
	"snippet" => "( \${1:\$year} )", 
	"desc" => "Returns if the given year is a leap year or not", 
	"docurl" => "function.mcal-is-leap-year.html" 
),
"mcal_list_alarms" => array( 
	"methodname" => "mcal_list_alarms", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "array mcal_list_alarms ( int mcal_stream [, int begin_year, int begin_month, int begin_day, int end_year, int end_month, int end_day] )", 
	"snippet" => "( \${1:\$mcal_stream} )", 
	"desc" => "Return a list of events that has an alarm triggered at the given   datetime", 
	"docurl" => "function.mcal-list-alarms.html" 
),
"mcal_list_events" => array( 
	"methodname" => "mcal_list_events", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "array mcal_list_events ( int mcal_stream [, int begin_year, int begin_month, int begin_day, int end_year, int end_month, int end_day] )", 
	"snippet" => "( \${1:\$mcal_stream} )", 
	"desc" => "Return a list of IDs for a date or a range of dates", 
	"docurl" => "function.mcal-list-events.html" 
),
"mcal_next_recurrence" => array( 
	"methodname" => "mcal_next_recurrence", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_next_recurrence ( int stream, int weekstart, array next )", 
	"snippet" => "( \${1:\$stream}, \${2:\$weekstart}, \${3:\$next} )", 
	"desc" => "Returns the next recurrence of the event", 
	"docurl" => "function.mcal-next-recurrence.html" 
),
"mcal_open" => array( 
	"methodname" => "mcal_open", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_open ( string calendar, string username, string password [, int options] )", 
	"snippet" => "( \${1:\$calendar}, \${2:\$username}, \${3:\$password} )", 
	"desc" => "Opens up an MCAL connection", 
	"docurl" => "function.mcal-open.html" 
),
"mcal_popen" => array( 
	"methodname" => "mcal_popen", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_popen ( string calendar, string username, string password [, int options] )", 
	"snippet" => "( \${1:\$calendar}, \${2:\$username}, \${3:\$password} )", 
	"desc" => "Opens up a persistent MCAL connection", 
	"docurl" => "function.mcal-popen.html" 
),
"mcal_rename_calendar" => array( 
	"methodname" => "mcal_rename_calendar", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "string mcal_rename_calendar ( int stream, string old_name, string new_name )", 
	"snippet" => "( \${1:\$stream}, \${2:\$old_name}, \${3:\$new_name} )", 
	"desc" => "Rename an MCAL calendar", 
	"docurl" => "function.mcal-rename-calendar.html" 
),
"mcal_reopen" => array( 
	"methodname" => "mcal_reopen", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_reopen ( int mcal_stream, string calendar [, int options] )", 
	"snippet" => "( \${1:\$mcal_stream}, \${2:\$calendar} )", 
	"desc" => "Reopens an MCAL connection", 
	"docurl" => "function.mcal-reopen.html" 
),
"mcal_snooze" => array( 
	"methodname" => "mcal_snooze", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "bool mcal_snooze ( int stream_id, int event_id )", 
	"snippet" => "( \${1:\$stream_id}, \${2:\$event_id} )", 
	"desc" => "Turn off an alarm for an event", 
	"docurl" => "function.mcal-snooze.html" 
),
"mcal_store_event" => array( 
	"methodname" => "mcal_store_event", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_store_event ( int mcal_stream )", 
	"snippet" => "( \${1:\$mcal_stream} )", 
	"desc" => "Modify an existing event in an MCAL calendar", 
	"docurl" => "function.mcal-store-event.html" 
),
"mcal_time_valid" => array( 
	"methodname" => "mcal_time_valid", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int mcal_time_valid ( int hour, int minutes, int seconds )", 
	"snippet" => "( \${1:\$hour}, \${2:\$minutes}, \${3:\$seconds} )", 
	"desc" => "Returns TRUE if the given hour, minutes and seconds is a valid time", 
	"docurl" => "function.mcal-time-valid.html" 
),
"mcal_week_of_year" => array( 
	"methodname" => "mcal_week_of_year", 
	"version" => "PHP4", 
	"method" => "int mcal_week_of_year ( int day, int month, int year )", 
	"snippet" => "( \${1:\$day}, \${2:\$month}, \${3:\$year} )", 
	"desc" => "Returns the week number of the given date", 
	"docurl" => "function.mcal-week-of-year.html" 
),
"mcrypt_cbc" => array( 
	"methodname" => "mcrypt_cbc", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "string mcrypt_cbc ( int cipher, string key, string data, int mode [, string iv] )", 
	"snippet" => "( \${1:\$cipher}, \${2:\$key}, \${3:\$data}, \${4:\$mode} )", 
	"desc" => "Encrypt/decrypt data in CBC mode", 
	"docurl" => "function.mcrypt-cbc.html" 
),
"mcrypt_cfb" => array( 
	"methodname" => "mcrypt_cfb", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "string mcrypt_cfb ( int cipher, string key, string data, int mode, string iv )", 
	"snippet" => "( \${1:\$cipher}, \${2:\$key}, \${3:\$data}, \${4:\$mode}, \${5:\$iv} )", 
	"desc" => "Encrypt/decrypt data in CFB mode", 
	"docurl" => "function.mcrypt-cfb.html" 
),
"mcrypt_create_iv" => array( 
	"methodname" => "mcrypt_create_iv", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "string mcrypt_create_iv ( int size [, int source] )", 
	"snippet" => "( \${1:\$size} )", 
	"desc" => "Create an initialization vector (IV) from a random source", 
	"docurl" => "function.mcrypt-create-iv.html" 
),
"mcrypt_decrypt" => array( 
	"methodname" => "mcrypt_decrypt", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string mcrypt_decrypt ( string cipher, string key, string data, string mode [, string iv] )", 
	"snippet" => "( \${1:\$cipher}, \${2:\$key}, \${3:\$data}, \${4:\$mode} )", 
	"desc" => "Decrypts crypttext with given parameters", 
	"docurl" => "function.mcrypt-decrypt.html" 
),
"mcrypt_ecb" => array( 
	"methodname" => "mcrypt_ecb", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "string mcrypt_ecb ( int cipher, string key, string data, int mode )", 
	"snippet" => "( \${1:\$cipher}, \${2:\$key}, \${3:\$data}, \${4:\$mode} )", 
	"desc" => "Deprecated: Encrypt/decrypt data in ECB mode", 
	"docurl" => "function.mcrypt-ecb.html" 
),
"mcrypt_enc_get_algorithms_name" => array( 
	"methodname" => "mcrypt_enc_get_algorithms_name", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string mcrypt_enc_get_algorithms_name ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "Returns the name of the opened algorithm", 
	"docurl" => "function.mcrypt-enc-get-algorithms-name.html" 
),
"mcrypt_enc_get_block_size" => array( 
	"methodname" => "mcrypt_enc_get_block_size", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int mcrypt_enc_get_block_size ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "Returns the blocksize of the opened algorithm", 
	"docurl" => "function.mcrypt-enc-get-block-size.html" 
),
"mcrypt_enc_get_iv_size" => array( 
	"methodname" => "mcrypt_enc_get_iv_size", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int mcrypt_enc_get_iv_size ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "Returns the size of the IV of the opened algorithm", 
	"docurl" => "function.mcrypt-enc-get-iv-size.html" 
),
"mcrypt_enc_get_key_size" => array( 
	"methodname" => "mcrypt_enc_get_key_size", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int mcrypt_enc_get_key_size ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "Returns the maximum supported keysize of the opened mode", 
	"docurl" => "function.mcrypt-enc-get-key-size.html" 
),
"mcrypt_enc_get_modes_name" => array( 
	"methodname" => "mcrypt_enc_get_modes_name", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string mcrypt_enc_get_modes_name ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "Returns the name of the opened mode", 
	"docurl" => "function.mcrypt-enc-get-modes-name.html" 
),
"mcrypt_enc_get_supported_key_sizes" => array( 
	"methodname" => "mcrypt_enc_get_supported_key_sizes", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "array mcrypt_enc_get_supported_key_sizes ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "Returns an array with the supported keysizes of the opened algorithm", 
	"docurl" => "function.mcrypt-enc-get-supported-key-sizes.html" 
),
"mcrypt_enc_is_block_algorithm_mode" => array( 
	"methodname" => "mcrypt_enc_is_block_algorithm_mode", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool mcrypt_enc_is_block_algorithm_mode ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "Checks whether the encryption of the opened mode works on blocks", 
	"docurl" => "function.mcrypt-enc-is-block-algorithm-mode.html" 
),
"mcrypt_enc_is_block_algorithm" => array( 
	"methodname" => "mcrypt_enc_is_block_algorithm", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool mcrypt_enc_is_block_algorithm ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "Checks whether the algorithm of the opened mode is a block algorithm", 
	"docurl" => "function.mcrypt-enc-is-block-algorithm.html" 
),
"mcrypt_enc_is_block_mode" => array( 
	"methodname" => "mcrypt_enc_is_block_mode", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool mcrypt_enc_is_block_mode ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "Checks whether the opened mode outputs blocks", 
	"docurl" => "function.mcrypt-enc-is-block-mode.html" 
),
"mcrypt_enc_self_test" => array( 
	"methodname" => "mcrypt_enc_self_test", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool mcrypt_enc_self_test ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "This function runs a self test on the opened module", 
	"docurl" => "function.mcrypt-enc-self-test.html" 
),
"mcrypt_encrypt" => array( 
	"methodname" => "mcrypt_encrypt", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string mcrypt_encrypt ( string cipher, string key, string data, string mode [, string iv] )", 
	"snippet" => "( \${1:\$cipher}, \${2:\$key}, \${3:\$data}, \${4:\$mode} )", 
	"desc" => "Encrypts plaintext with given parameters", 
	"docurl" => "function.mcrypt-encrypt.html" 
),
"mcrypt_generic_deinit" => array( 
	"methodname" => "mcrypt_generic_deinit", 
	"version" => "PHP4 >= 4.1.1, PHP5", 
	"method" => "bool mcrypt_generic_deinit ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "This function deinitializes an encryption module", 
	"docurl" => "function.mcrypt-generic-deinit.html" 
),
"mcrypt_generic_end" => array( 
	"methodname" => "mcrypt_generic_end", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool mcrypt_generic_end ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "This function terminates encryption", 
	"docurl" => "function.mcrypt-generic-end.html" 
),
"mcrypt_generic_init" => array( 
	"methodname" => "mcrypt_generic_init", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int mcrypt_generic_init ( resource td, string key, string iv )", 
	"snippet" => "( \${1:\$td}, \${2:\$key}, \${3:\$iv} )", 
	"desc" => "This function initializes all buffers needed for encryption", 
	"docurl" => "function.mcrypt-generic-init.html" 
),
"mcrypt_generic" => array( 
	"methodname" => "mcrypt_generic", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string mcrypt_generic ( resource td, string data )", 
	"snippet" => "( \${1:\$td}, \${2:\$data} )", 
	"desc" => "This function encrypts data", 
	"docurl" => "function.mcrypt-generic.html" 
),
"mcrypt_get_block_size" => array( 
	"methodname" => "mcrypt_get_block_size", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "int mcrypt_get_block_size ( int cipher )", 
	"snippet" => "( \${1:\$cipher} )", 
	"desc" => "Get the block size of the specified cipher", 
	"docurl" => "function.mcrypt-get-block-size.html" 
),
"mcrypt_get_cipher_name" => array( 
	"methodname" => "mcrypt_get_cipher_name", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "string mcrypt_get_cipher_name ( int cipher )", 
	"snippet" => "( \${1:\$cipher} )", 
	"desc" => "Get the name of the specified cipher", 
	"docurl" => "function.mcrypt-get-cipher-name.html" 
),
"mcrypt_get_iv_size" => array( 
	"methodname" => "mcrypt_get_iv_size", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int mcrypt_get_iv_size ( string cipher, string mode )", 
	"snippet" => "( \${1:\$cipher}, \${2:\$mode} )", 
	"desc" => "Returns the size of the IV belonging to a specific cipher/mode combination", 
	"docurl" => "function.mcrypt-get-iv-size.html" 
),
"mcrypt_get_key_size" => array( 
	"methodname" => "mcrypt_get_key_size", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "int mcrypt_get_key_size ( int cipher )", 
	"snippet" => "( \${1:\$cipher} )", 
	"desc" => "Get the key size of the specified cipher", 
	"docurl" => "function.mcrypt-get-key-size.html" 
),
"mcrypt_list_algorithms" => array( 
	"methodname" => "mcrypt_list_algorithms", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "array mcrypt_list_algorithms ( [string lib_dir] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get an array of all supported ciphers", 
	"docurl" => "function.mcrypt-list-algorithms.html" 
),
"mcrypt_list_modes" => array( 
	"methodname" => "mcrypt_list_modes", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "array mcrypt_list_modes ( [string lib_dir] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get an array of all supported modes", 
	"docurl" => "function.mcrypt-list-modes.html" 
),
"mcrypt_module_close" => array( 
	"methodname" => "mcrypt_module_close", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool mcrypt_module_close ( resource td )", 
	"snippet" => "( \${1:\$td} )", 
	"desc" => "Close the mcrypt module", 
	"docurl" => "function.mcrypt-module-close.html" 
),
"mcrypt_module_get_algo_block_size" => array( 
	"methodname" => "mcrypt_module_get_algo_block_size", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int mcrypt_module_get_algo_block_size ( string algorithm [, string lib_dir] )", 
	"snippet" => "( \${1:\$algorithm} )", 
	"desc" => "Returns the blocksize of the specified algorithm", 
	"docurl" => "function.mcrypt-module-get-algo-block-size.html" 
),
"mcrypt_module_get_algo_key_size" => array( 
	"methodname" => "mcrypt_module_get_algo_key_size", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "int mcrypt_module_get_algo_key_size ( string algorithm [, string lib_dir] )", 
	"snippet" => "( \${1:\$algorithm} )", 
	"desc" => "Returns the maximum supported keysize of the opened mode", 
	"docurl" => "function.mcrypt-module-get-algo-key-size.html" 
),
"mcrypt_module_get_supported_key_sizes" => array( 
	"methodname" => "mcrypt_module_get_supported_key_sizes", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "array mcrypt_module_get_supported_key_sizes ( string algorithm [, string lib_dir] )", 
	"snippet" => "( \${1:\$algorithm} )", 
	"desc" => "Returns an array with the supported keysizes of the opened algorithm", 
	"docurl" => "function.mcrypt-module-get-supported-key-sizes.html" 
),
"mcrypt_module_is_block_algorithm_mode" => array( 
	"methodname" => "mcrypt_module_is_block_algorithm_mode", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool mcrypt_module_is_block_algorithm_mode ( string mode [, string lib_dir] )", 
	"snippet" => "( \${1:\$mode} )", 
	"desc" => "Returns if the specified module is a block algorithm or not", 
	"docurl" => "function.mcrypt-module-is-block-algorithm-mode.html" 
),
"mcrypt_module_is_block_algorithm" => array( 
	"methodname" => "mcrypt_module_is_block_algorithm", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool mcrypt_module_is_block_algorithm ( string algorithm [, string lib_dir] )", 
	"snippet" => "( \${1:\$algorithm} )", 
	"desc" => "This function checks whether the specified algorithm is a block algorithm", 
	"docurl" => "function.mcrypt-module-is-block-algorithm.html" 
),
"mcrypt_module_is_block_mode" => array( 
	"methodname" => "mcrypt_module_is_block_mode", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool mcrypt_module_is_block_mode ( string mode [, string lib_dir] )", 
	"snippet" => "( \${1:\$mode} )", 
	"desc" => "Returns if the specified mode outputs blocks or not", 
	"docurl" => "function.mcrypt-module-is-block-mode.html" 
),
"mcrypt_module_open" => array( 
	"methodname" => "mcrypt_module_open", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "resource mcrypt_module_open ( string algorithm, string algorithm_directory, string mode, string mode_directory )", 
	"snippet" => "( \${1:\$algorithm}, \${2:\$algorithm_directory}, \${3:\$mode}, \${4:\$mode_directory} )", 
	"desc" => "Opens the module of the algorithm and the mode to be used", 
	"docurl" => "function.mcrypt-module-open.html" 
),
"mcrypt_module_self_test" => array( 
	"methodname" => "mcrypt_module_self_test", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool mcrypt_module_self_test ( string algorithm [, string lib_dir] )", 
	"snippet" => "( \${1:\$algorithm} )", 
	"desc" => "This function runs a self test on the specified module", 
	"docurl" => "function.mcrypt-module-self-test.html" 
),
"mcrypt_ofb" => array( 
	"methodname" => "mcrypt_ofb", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "string mcrypt_ofb ( int cipher, string key, string data, int mode, string iv )", 
	"snippet" => "( \${1:\$cipher}, \${2:\$key}, \${3:\$data}, \${4:\$mode}, \${5:\$iv} )", 
	"desc" => "Encrypt/decrypt data in OFB mode", 
	"docurl" => "function.mcrypt-ofb.html" 
),
"mcve_adduser" => array( 
	"methodname" => "mcve_adduser", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_adduser ( resource conn, string admin_password, int usersetup )", 
	"snippet" => "( \${1:\$conn}, \${2:\$admin_password}, \${3:\$usersetup} )", 
	"desc" => "Add an MCVE user using usersetup structure", 
	"docurl" => "function.mcve-adduser.html" 
),
"mcve_adduserarg" => array( 
	"methodname" => "mcve_adduserarg", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_adduserarg ( resource usersetup, int argtype, string argval )", 
	"snippet" => "( \${1:\$usersetup}, \${2:\$argtype}, \${3:\$argval} )", 
	"desc" => "Add a value to user configuration structure", 
	"docurl" => "function.mcve-adduserarg.html" 
),
"mcve_bt" => array( 
	"methodname" => "mcve_bt", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_bt ( resource conn, string username, string password )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password} )", 
	"desc" => "Get unsettled batch totals", 
	"docurl" => "function.mcve-bt.html" 
),
"mcve_checkstatus" => array( 
	"methodname" => "mcve_checkstatus", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_checkstatus ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Check to see if a transaction has completed", 
	"docurl" => "function.mcve-checkstatus.html" 
),
"mcve_chkpwd" => array( 
	"methodname" => "mcve_chkpwd", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_chkpwd ( resource conn, string username, string password )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password} )", 
	"desc" => "Verify Password", 
	"docurl" => "function.mcve-chkpwd.html" 
),
"mcve_chngpwd" => array( 
	"methodname" => "mcve_chngpwd", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_chngpwd ( resource conn, string admin_password, string new_password )", 
	"snippet" => "( \${1:\$conn}, \${2:\$admin_password}, \${3:\$new_password} )", 
	"desc" => "Change the system administrator\'s password", 
	"docurl" => "function.mcve-chngpwd.html" 
),
"mcve_completeauthorizations" => array( 
	"methodname" => "mcve_completeauthorizations", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_completeauthorizations ( resource conn, int &array )", 
	"snippet" => "( \${1:\$conn}, \${2:\$array} )", 
	"desc" => "Number of complete authorizations in queue, returning an array of their identifiers", 
	"docurl" => "function.mcve-completeauthorizations.html" 
),
"mcve_connect" => array( 
	"methodname" => "mcve_connect", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_connect ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Establish the connection to MCVE", 
	"docurl" => "function.mcve-connect.html" 
),
"mcve_connectionerror" => array( 
	"methodname" => "mcve_connectionerror", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mcve_connectionerror ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Get a textual representation of why a connection failed", 
	"docurl" => "function.mcve-connectionerror.html" 
),
"mcve_deleteresponse" => array( 
	"methodname" => "mcve_deleteresponse", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool mcve_deleteresponse ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Delete specified transaction from MCVE_CONN structure", 
	"docurl" => "function.mcve-deleteresponse.html" 
),
"mcve_deletetrans" => array( 
	"methodname" => "mcve_deletetrans", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool mcve_deletetrans ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Delete specified transaction from MCVE_CONN structure", 
	"docurl" => "function.mcve-deletetrans.html" 
),
"mcve_deleteusersetup" => array( 
	"methodname" => "mcve_deleteusersetup", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void mcve_deleteusersetup ( resource usersetup )", 
	"snippet" => "( \${1:\$usersetup} )", 
	"desc" => "Deallocate data associated with usersetup structure", 
	"docurl" => "function.mcve-deleteusersetup.html" 
),
"mcve_deluser" => array( 
	"methodname" => "mcve_deluser", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_deluser ( resource conn, string admin_password, string username )", 
	"snippet" => "( \${1:\$conn}, \${2:\$admin_password}, \${3:\$username} )", 
	"desc" => "Delete an MCVE user account", 
	"docurl" => "function.mcve-deluser.html" 
),
"mcve_destroyconn" => array( 
	"methodname" => "mcve_destroyconn", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void mcve_destroyconn ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Destroy the connection and MCVE_CONN structure", 
	"docurl" => "function.mcve-destroyconn.html" 
),
"mcve_destroyengine" => array( 
	"methodname" => "mcve_destroyengine", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void mcve_destroyengine ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Free memory associated with IP/SSL connectivity", 
	"docurl" => "function.mcve-destroyengine.html" 
),
"mcve_disableuser" => array( 
	"methodname" => "mcve_disableuser", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_disableuser ( resource conn, string admin_password, string username )", 
	"snippet" => "( \${1:\$conn}, \${2:\$admin_password}, \${3:\$username} )", 
	"desc" => "Disable an active MCVE user account", 
	"docurl" => "function.mcve-disableuser.html" 
),
"mcve_edituser" => array( 
	"methodname" => "mcve_edituser", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_edituser ( resource conn, string admin_password, int usersetup )", 
	"snippet" => "( \${1:\$conn}, \${2:\$admin_password}, \${3:\$usersetup} )", 
	"desc" => "Edit MCVE user using usersetup structure", 
	"docurl" => "function.mcve-edituser.html" 
),
"mcve_enableuser" => array( 
	"methodname" => "mcve_enableuser", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_enableuser ( resource conn, string admin_password, string username )", 
	"snippet" => "( \${1:\$conn}, \${2:\$admin_password}, \${3:\$username} )", 
	"desc" => "Enable an inactive MCVE user account", 
	"docurl" => "function.mcve-enableuser.html" 
),
"mcve_force" => array( 
	"methodname" => "mcve_force", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_force ( resource conn, string username, string password, string trackdata, string account, string expdate, float amount, string authcode, string comments, string clerkid, string stationid, int ptrannum )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$trackdata}, \${5:\$account}, \${6:\$expdate}, \${7:\$amount}, \${8:\$authcode}, \${9:\$comments}, \${10:\$clerkid}, \${11:\$stationid}, \${12:\$ptrannum} )", 
	"desc" => "Send a FORCE to MCVE (typically, a phone-authorization)", 
	"docurl" => "function.mcve-force.html" 
),
"mcve_getcell" => array( 
	"methodname" => "mcve_getcell", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string mcve_getcell ( resource conn, int identifier, string column, int row )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier}, \${3:\$column}, \${4:\$row} )", 
	"desc" => "Get a specific cell from a comma delimited response by column name", 
	"docurl" => "function.mcve-getcell.html" 
),
"mcve_getcellbynum" => array( 
	"methodname" => "mcve_getcellbynum", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string mcve_getcellbynum ( resource conn, int identifier, int column, int row )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier}, \${3:\$column}, \${4:\$row} )", 
	"desc" => "Get a specific cell from a comma delimited response by column number", 
	"docurl" => "function.mcve-getcellbynum.html" 
),
"mcve_getcommadelimited" => array( 
	"methodname" => "mcve_getcommadelimited", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string mcve_getcommadelimited ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Get the RAW comma delimited data returned from MCVE", 
	"docurl" => "function.mcve-getcommadelimited.html" 
),
"mcve_getheader" => array( 
	"methodname" => "mcve_getheader", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string mcve_getheader ( resource conn, int identifier, int column_num )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier}, \${3:\$column_num} )", 
	"desc" => "Get the name of the column in a comma-delimited response", 
	"docurl" => "function.mcve-getheader.html" 
),
"mcve_getuserarg" => array( 
	"methodname" => "mcve_getuserarg", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string mcve_getuserarg ( resource usersetup, int argtype )", 
	"snippet" => "( \${1:\$usersetup}, \${2:\$argtype} )", 
	"desc" => "Grab a value from usersetup structure", 
	"docurl" => "function.mcve-getuserarg.html" 
),
"mcve_getuserparam" => array( 
	"methodname" => "mcve_getuserparam", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mcve_getuserparam ( resource conn, int identifier, int key )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier}, \${3:\$key} )", 
	"desc" => "Get a user response parameter", 
	"docurl" => "function.mcve-getuserparam.html" 
),
"mcve_gft" => array( 
	"methodname" => "mcve_gft", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_gft ( resource conn, string username, string password, int type, string account, string clerkid, string stationid, string comments, int ptrannum, string startdate, string enddate )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$type}, \${5:\$account}, \${6:\$clerkid}, \${7:\$stationid}, \${8:\$comments}, \${9:\$ptrannum}, \${10:\$startdate}, \${11:\$enddate} )", 
	"desc" => "Audit MCVE for Failed transactions", 
	"docurl" => "function.mcve-gft.html" 
),
"mcve_gl" => array( 
	"methodname" => "mcve_gl", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_gl ( int conn, string username, string password, int type, string account, string batch, string clerkid, string stationid, string comments, int ptrannum, string startdate, string enddate )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$type}, \${5:\$account}, \${6:\$batch}, \${7:\$clerkid}, \${8:\$stationid}, \${9:\$comments}, \${10:\$ptrannum}, \${11:\$startdate}, \${12:\$enddate} )", 
	"desc" => "Audit MCVE for settled transactions", 
	"docurl" => "function.mcve-gl.html" 
),
"mcve_gut" => array( 
	"methodname" => "mcve_gut", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_gut ( resource conn, string username, string password, int type, string account, string clerkid, string stationid, string comments, int ptrannum, string startdate, string enddate )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$type}, \${5:\$account}, \${6:\$clerkid}, \${7:\$stationid}, \${8:\$comments}, \${9:\$ptrannum}, \${10:\$startdate}, \${11:\$enddate} )", 
	"desc" => "Audit MCVE for Unsettled Transactions", 
	"docurl" => "function.mcve-gut.html" 
),
"mcve_initconn" => array( 
	"methodname" => "mcve_initconn", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "resource mcve_initconn ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Create and initialize an MCVE_CONN structure", 
	"docurl" => "function.mcve-initconn.html" 
),
"mcve_initengine" => array( 
	"methodname" => "mcve_initengine", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_initengine ( string location )", 
	"snippet" => "( \${1:\$location} )", 
	"desc" => "Ready the client for IP/SSL Communication", 
	"docurl" => "function.mcve-initengine.html" 
),
"mcve_initusersetup" => array( 
	"methodname" => "mcve_initusersetup", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "resource mcve_initusersetup ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Initialize structure to store user data", 
	"docurl" => "function.mcve-initusersetup.html" 
),
"mcve_iscommadelimited" => array( 
	"methodname" => "mcve_iscommadelimited", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_iscommadelimited ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Checks to see if response is comma delimited", 
	"docurl" => "function.mcve-iscommadelimited.html" 
),
"mcve_liststats" => array( 
	"methodname" => "mcve_liststats", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_liststats ( resource conn, string admin_password )", 
	"snippet" => "( \${1:\$conn}, \${2:\$admin_password} )", 
	"desc" => "List statistics for all users on MCVE system", 
	"docurl" => "function.mcve-liststats.html" 
),
"mcve_listusers" => array( 
	"methodname" => "mcve_listusers", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_listusers ( resource conn, string admin_password )", 
	"snippet" => "( \${1:\$conn}, \${2:\$admin_password} )", 
	"desc" => "List all users on MCVE system", 
	"docurl" => "function.mcve-listusers.html" 
),
"mcve_maxconntimeout" => array( 
	"methodname" => "mcve_maxconntimeout", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool mcve_maxconntimeout ( resource conn, int secs )", 
	"snippet" => "( \${1:\$conn}, \${2:\$secs} )", 
	"desc" => "The maximum amount of time the API will attempt a connection to MCVE", 
	"docurl" => "function.mcve-maxconntimeout.html" 
),
"mcve_monitor" => array( 
	"methodname" => "mcve_monitor", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_monitor ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Perform communication with MCVE (send/receive data) Non-blocking", 
	"docurl" => "function.mcve-monitor.html" 
),
"mcve_numcolumns" => array( 
	"methodname" => "mcve_numcolumns", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_numcolumns ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Number of columns returned in a comma delimited response", 
	"docurl" => "function.mcve-numcolumns.html" 
),
"mcve_numrows" => array( 
	"methodname" => "mcve_numrows", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_numrows ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Number of rows returned in a comma delimited response", 
	"docurl" => "function.mcve-numrows.html" 
),
"mcve_override" => array( 
	"methodname" => "mcve_override", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_override ( resource conn, string username, string password, string trackdata, string account, string expdate, float amount, string street, string zip, string cv, string comments, string clerkid, string stationid, int ptrannum )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$trackdata}, \${5:\$account}, \${6:\$expdate}, \${7:\$amount}, \${8:\$street}, \${9:\$zip}, \${10:\$cv}, \${11:\$comments}, \${12:\$clerkid}, \${13:\$stationid}, \${14:\$ptrannum} )", 
	"desc" => "Send an OVERRIDE to MCVE", 
	"docurl" => "function.mcve-override.html" 
),
"mcve_parsecommadelimited" => array( 
	"methodname" => "mcve_parsecommadelimited", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_parsecommadelimited ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Parse the comma delimited response so mcve_getcell, etc will work", 
	"docurl" => "function.mcve-parsecommadelimited.html" 
),
"mcve_ping" => array( 
	"methodname" => "mcve_ping", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int mcve_ping ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Send a ping request to MCVE", 
	"docurl" => "function.mcve-ping.html" 
),
"mcve_preauth" => array( 
	"methodname" => "mcve_preauth", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_preauth ( resource conn, string username, string password, string trackdata, string account, string expdate, float amount, string street, string zip, string cv, string comments, string clerkid, string stationid, int ptrannum )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$trackdata}, \${5:\$account}, \${6:\$expdate}, \${7:\$amount}, \${8:\$street}, \${9:\$zip}, \${10:\$cv}, \${11:\$comments}, \${12:\$clerkid}, \${13:\$stationid}, \${14:\$ptrannum} )", 
	"desc" => "Send a PREAUTHORIZATION to MCVE", 
	"docurl" => "function.mcve-preauth.html" 
),
"mcve_preauthcompletion" => array( 
	"methodname" => "mcve_preauthcompletion", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_preauthcompletion ( resource conn, string username, string password, float finalamount, int sid, int ptrannum )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$finalamount}, \${5:\$sid}, \${6:\$ptrannum} )", 
	"desc" => "Complete a PREAUTHORIZATION, ready it for settlement", 
	"docurl" => "function.mcve-preauthcompletion.html" 
),
"mcve_qc" => array( 
	"methodname" => "mcve_qc", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_qc ( resource conn, string username, string password, string clerkid, string stationid, string comments, int ptrannum )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$clerkid}, \${5:\$stationid}, \${6:\$comments}, \${7:\$ptrannum} )", 
	"desc" => "Audit MCVE for a list of transactions in the outgoing queue", 
	"docurl" => "function.mcve-qc.html" 
),
"mcve_responseparam" => array( 
	"methodname" => "mcve_responseparam", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mcve_responseparam ( resource conn, int identifier, string key )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier}, \${3:\$key} )", 
	"desc" => "Get a custom response parameter", 
	"docurl" => "function.mcve-responseparam.html" 
),
"mcve_return" => array( 
	"methodname" => "mcve_return", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_return ( int conn, string username, string password, string trackdata, string account, string expdate, float amount, string comments, string clerkid, string stationid, int ptrannum )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$trackdata}, \${5:\$account}, \${6:\$expdate}, \${7:\$amount}, \${8:\$comments}, \${9:\$clerkid}, \${10:\$stationid}, \${11:\$ptrannum} )", 
	"desc" => "Issue a RETURN or CREDIT to MCVE", 
	"docurl" => "function.mcve-return.html" 
),
"mcve_returncode" => array( 
	"methodname" => "mcve_returncode", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_returncode ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Grab the exact return code from the transaction", 
	"docurl" => "function.mcve-returncode.html" 
),
"mcve_returnstatus" => array( 
	"methodname" => "mcve_returnstatus", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_returnstatus ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Check to see if the transaction was successful", 
	"docurl" => "function.mcve-returnstatus.html" 
),
"mcve_sale" => array( 
	"methodname" => "mcve_sale", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_sale ( resource conn, string username, string password, string trackdata, string account, string expdate, float amount, string street, string zip, string cv, string comments, string clerkid, string stationid, int ptrannum )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$trackdata}, \${5:\$account}, \${6:\$expdate}, \${7:\$amount}, \${8:\$street}, \${9:\$zip}, \${10:\$cv}, \${11:\$comments}, \${12:\$clerkid}, \${13:\$stationid}, \${14:\$ptrannum} )", 
	"desc" => "Send a SALE to MCVE", 
	"docurl" => "function.mcve-sale.html" 
),
"mcve_setblocking" => array( 
	"methodname" => "mcve_setblocking", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int mcve_setblocking ( resource conn, int tf )", 
	"snippet" => "( \${1:\$conn}, \${2:\$tf} )", 
	"desc" => "Set blocking/non-blocking mode for connection", 
	"docurl" => "function.mcve-setblocking.html" 
),
"mcve_setdropfile" => array( 
	"methodname" => "mcve_setdropfile", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_setdropfile ( resource conn, string directory )", 
	"snippet" => "( \${1:\$conn}, \${2:\$directory} )", 
	"desc" => "Set the connection method to Drop-File", 
	"docurl" => "function.mcve-setdropfile.html" 
),
"mcve_setip" => array( 
	"methodname" => "mcve_setip", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_setip ( resource conn, string host, int port )", 
	"snippet" => "( \${1:\$conn}, \${2:\$host}, \${3:\$port} )", 
	"desc" => "Set the connection method to IP", 
	"docurl" => "function.mcve-setip.html" 
),
"mcve_setssl_files" => array( 
	"methodname" => "mcve_setssl_files", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "int mcve_setssl_files ( string sslkeyfile, string sslcertfile )", 
	"snippet" => "( \${1:\$sslkeyfile}, \${2:\$sslcertfile} )", 
	"desc" => "Set certificate key files and certificates if server requires client certificate verification", 
	"docurl" => "function.mcve-setssl-files.html" 
),
"mcve_setssl" => array( 
	"methodname" => "mcve_setssl", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_setssl ( resource conn, string host, int port )", 
	"snippet" => "( \${1:\$conn}, \${2:\$host}, \${3:\$port} )", 
	"desc" => "Set the connection method to SSL", 
	"docurl" => "function.mcve-setssl.html" 
),
"mcve_settimeout" => array( 
	"methodname" => "mcve_settimeout", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_settimeout ( resource conn, int seconds )", 
	"snippet" => "( \${1:\$conn}, \${2:\$seconds} )", 
	"desc" => "Set maximum transaction time (per trans)", 
	"docurl" => "function.mcve-settimeout.html" 
),
"mcve_settle" => array( 
	"methodname" => "mcve_settle", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_settle ( resource conn, string username, string password, string batch )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$batch} )", 
	"desc" => "Issue a settlement command to do a batch deposit", 
	"docurl" => "function.mcve-settle.html" 
),
"mcve_text_avs" => array( 
	"methodname" => "mcve_text_avs", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mcve_text_avs ( string code )", 
	"snippet" => "( \${1:\$code} )", 
	"desc" => "Get a textual representation of the return_avs", 
	"docurl" => "function.mcve-text-avs.html" 
),
"mcve_text_code" => array( 
	"methodname" => "mcve_text_code", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mcve_text_code ( string code )", 
	"snippet" => "( \${1:\$code} )", 
	"desc" => "Get a textual representation of the return_code", 
	"docurl" => "function.mcve-text-code.html" 
),
"mcve_text_cv" => array( 
	"methodname" => "mcve_text_cv", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mcve_text_cv ( int code )", 
	"snippet" => "( \${1:\$code} )", 
	"desc" => "Get a textual representation of the return_cv", 
	"docurl" => "function.mcve-text-cv.html" 
),
"mcve_transactionauth" => array( 
	"methodname" => "mcve_transactionauth", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string mcve_transactionauth ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Get the authorization number returned for the transaction (alpha-numeric)", 
	"docurl" => "function.mcve-transactionauth.html" 
),
"mcve_transactionavs" => array( 
	"methodname" => "mcve_transactionavs", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_transactionavs ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Get the Address Verification return status", 
	"docurl" => "function.mcve-transactionavs.html" 
),
"mcve_transactionbatch" => array( 
	"methodname" => "mcve_transactionbatch", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_transactionbatch ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Get the batch number associated with the transaction", 
	"docurl" => "function.mcve-transactionbatch.html" 
),
"mcve_transactioncv" => array( 
	"methodname" => "mcve_transactioncv", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_transactioncv ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Get the CVC2/CVV2/CID return status", 
	"docurl" => "function.mcve-transactioncv.html" 
),
"mcve_transactionid" => array( 
	"methodname" => "mcve_transactionid", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_transactionid ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Get the unique system id for the transaction", 
	"docurl" => "function.mcve-transactionid.html" 
),
"mcve_transactionitem" => array( 
	"methodname" => "mcve_transactionitem", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_transactionitem ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Get the ITEM number in the associated batch for this transaction", 
	"docurl" => "function.mcve-transactionitem.html" 
),
"mcve_transactionssent" => array( 
	"methodname" => "mcve_transactionssent", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_transactionssent ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Check to see if outgoing buffer is clear", 
	"docurl" => "function.mcve-transactionssent.html" 
),
"mcve_transactiontext" => array( 
	"methodname" => "mcve_transactiontext", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string mcve_transactiontext ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Get verbiage (text) return from MCVE or processing institution", 
	"docurl" => "function.mcve-transactiontext.html" 
),
"mcve_transinqueue" => array( 
	"methodname" => "mcve_transinqueue", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_transinqueue ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Number of transactions in client-queue", 
	"docurl" => "function.mcve-transinqueue.html" 
),
"mcve_transnew" => array( 
	"methodname" => "mcve_transnew", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int mcve_transnew ( resource conn )", 
	"snippet" => "( \${1:\$conn} )", 
	"desc" => "Start a new transaction", 
	"docurl" => "function.mcve-transnew.html" 
),
"mcve_transparam" => array( 
	"methodname" => "mcve_transparam", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int mcve_transparam ( resource conn, int identifier, int key )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier}, \${3:\$key} )", 
	"desc" => "Add a parameter to a transaction", 
	"docurl" => "function.mcve-transparam.html" 
),
"mcve_transsend" => array( 
	"methodname" => "mcve_transsend", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int mcve_transsend ( resource conn, int identifier )", 
	"snippet" => "( \${1:\$conn}, \${2:\$identifier} )", 
	"desc" => "Finalize and send the transaction", 
	"docurl" => "function.mcve-transsend.html" 
),
"mcve_ub" => array( 
	"methodname" => "mcve_ub", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_ub ( resource conn, string username, string password )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password} )", 
	"desc" => "Get a list of all Unsettled batches", 
	"docurl" => "function.mcve-ub.html" 
),
"mcve_uwait" => array( 
	"methodname" => "mcve_uwait", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int mcve_uwait ( int microsecs )", 
	"snippet" => "( \${1:\$microsecs} )", 
	"desc" => "Wait x microsecs", 
	"docurl" => "function.mcve-uwait.html" 
),
"mcve_verifyconnection" => array( 
	"methodname" => "mcve_verifyconnection", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool mcve_verifyconnection ( resource conn, int tf )", 
	"snippet" => "( \${1:\$conn}, \${2:\$tf} )", 
	"desc" => "Set whether or not to PING upon connect to verify connection", 
	"docurl" => "function.mcve-verifyconnection.html" 
),
"mcve_verifysslcert" => array( 
	"methodname" => "mcve_verifysslcert", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool mcve_verifysslcert ( resource conn, int tf )", 
	"snippet" => "( \${1:\$conn}, \${2:\$tf} )", 
	"desc" => "Set whether or not to verify the server ssl certificate", 
	"docurl" => "function.mcve-verifysslcert.html" 
),
"mcve_void" => array( 
	"methodname" => "mcve_void", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int mcve_void ( resource conn, string username, string password, int sid, int ptrannum )", 
	"snippet" => "( \${1:\$conn}, \${2:\$username}, \${3:\$password}, \${4:\$sid}, \${5:\$ptrannum} )", 
	"desc" => "VOID a transaction in the settlement queue", 
	"docurl" => "function.mcve-void.html" 
),
"md5_file" => array( 
	"methodname" => "md5_file", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string md5_file ( string filename [, bool raw_output] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Calculates the md5 hash of a given file", 
	"docurl" => "function.md5-file.html" 
),
"md5" => array( 
	"methodname" => "md5", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string md5 ( string str [, bool raw_output] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Calculate the md5 hash of a string", 
	"docurl" => "function.md5.html" 
),
"mdecrypt_generic" => array( 
	"methodname" => "mdecrypt_generic", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string mdecrypt_generic ( resource td, string data )", 
	"snippet" => "( \${1:\$td}, \${2:\$data} )", 
	"desc" => "Decrypt data", 
	"docurl" => "function.mdecrypt-generic.html" 
),
"memcache_debug" => array( 
	"methodname" => "memcache_debug", 
	"version" => "undefined", 
	"method" => "bool memcache_debug ( int on_off )", 
	"snippet" => "( \${1:\$on_off} )", 
	"desc" => "", 
	"docurl" => "function.memcache-debug.html" 
),
"memory_get_usage" => array( 
	"methodname" => "memory_get_usage", 
	"version" => "PHP4 >= 4.3.2, PHP5", 
	"method" => "int memory_get_usage ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the amount of memory allocated to PHP", 
	"docurl" => "function.memory-get-usage.html" 
),
"metaphone" => array( 
	"methodname" => "metaphone", 
	"version" => "PHP4, PHP5", 
	"method" => "string metaphone ( string str [, int phones] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Calculate the metaphone key of a string", 
	"docurl" => "function.metaphone.html" 
),
"method_exists" => array( 
	"methodname" => "method_exists", 
	"version" => "PHP4, PHP5", 
	"method" => "bool method_exists ( object object, string method_name )", 
	"snippet" => "( \${1:\$object}, \${2:\$method_name} )", 
	"desc" => "Checks if the class method exists", 
	"docurl" => "function.method-exists.html" 
),
"mhash_count" => array( 
	"methodname" => "mhash_count", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "int mhash_count ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get the highest available hash id", 
	"docurl" => "function.mhash-count.html" 
),
"mhash_get_block_size" => array( 
	"methodname" => "mhash_get_block_size", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "int mhash_get_block_size ( int hash )", 
	"snippet" => "( \${1:\$hash} )", 
	"desc" => "Get the block size of the specified hash", 
	"docurl" => "function.mhash-get-block-size.html" 
),
"mhash_get_hash_name" => array( 
	"methodname" => "mhash_get_hash_name", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "string mhash_get_hash_name ( int hash )", 
	"snippet" => "( \${1:\$hash} )", 
	"desc" => "Get the name of the specified hash", 
	"docurl" => "function.mhash-get-hash-name.html" 
),
"mhash_keygen_s2k" => array( 
	"methodname" => "mhash_keygen_s2k", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string mhash_keygen_s2k ( int hash, string password, string salt, int bytes )", 
	"snippet" => "( \${1:\$hash}, \${2:\$password}, \${3:\$salt}, \${4:\$bytes} )", 
	"desc" => "Generates a key", 
	"docurl" => "function.mhash-keygen-s2k.html" 
),
"mhash" => array( 
	"methodname" => "mhash", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "string mhash ( int hash, string data [, string key] )", 
	"snippet" => "( \${1:\$hash}, \${2:\$data} )", 
	"desc" => "Compute hash", 
	"docurl" => "function.mhash.html" 
),
"microtime" => array( 
	"methodname" => "microtime", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed microtime ( [bool get_as_float] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Return current Unix timestamp with microseconds", 
	"docurl" => "function.microtime.html" 
),
"mime_content_type" => array( 
	"methodname" => "mime_content_type", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mime_content_type ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Detect MIME Content-type for a file", 
	"docurl" => "function.mime-content-type.html" 
),
"min" => array( 
	"methodname" => "min", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed min ( number arg1, number arg2 [, number ...] )", 
	"snippet" => "( \${1:\$arg1}, \${2:\$arg2} )", 
	"desc" => "Find lowest value", 
	"docurl" => "function.min.html" 
),
"ming_setcubicthreshold" => array( 
	"methodname" => "ming_setcubicthreshold", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "void ming_setcubicthreshold ( int threshold )", 
	"snippet" => "( \${1:\$threshold} )", 
	"desc" => "Set cubic threshold (?)", 
	"docurl" => "function.ming-setcubicthreshold.html" 
),
"ming_setscale" => array( 
	"methodname" => "ming_setscale", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "void ming_setscale ( int scale )", 
	"snippet" => "( \${1:\$scale} )", 
	"desc" => "Set scale (?)", 
	"docurl" => "function.ming-setscale.html" 
),
"ming_useswfversion" => array( 
	"methodname" => "ming_useswfversion", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void ming_useswfversion ( int version )", 
	"snippet" => "( \${1:\$version} )", 
	"desc" => "Use SWF version (?)", 
	"docurl" => "function.ming-useswfversion.html" 
),
"mkdir" => array( 
	"methodname" => "mkdir", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mkdir ( string pathname [, int mode [, bool recursive [, resource context]]] )", 
	"snippet" => "( \${1:\$pathname} )", 
	"desc" => "Makes directory", 
	"docurl" => "function.mkdir.html" 
),
"mktime" => array( 
	"methodname" => "mktime", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mktime ( [int hour [, int minute [, int second [, int month [, int day [, int year [, int is_dst]]]]]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get Unix timestamp for a date", 
	"docurl" => "function.mktime.html" 
),
"money_format" => array( 
	"methodname" => "money_format", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string money_format ( string format, float number )", 
	"snippet" => "( \${1:\$format}, \${2:\$number} )", 
	"desc" => "Formats a number as a currency string", 
	"docurl" => "function.money-format.html" 
),
"move_uploaded_file" => array( 
	"methodname" => "move_uploaded_file", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "bool move_uploaded_file ( string filename, string destination )", 
	"snippet" => "( \${1:\$filename}, \${2:\$destination} )", 
	"desc" => "Moves an uploaded file to a new location", 
	"docurl" => "function.move-uploaded-file.html" 
),
"msession_connect" => array( 
	"methodname" => "msession_connect", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool msession_connect ( string host, string port )", 
	"snippet" => "( \${1:\$host}, \${2:\$port} )", 
	"desc" => "Connect to msession server", 
	"docurl" => "function.msession-connect.html" 
),
"msession_count" => array( 
	"methodname" => "msession_count", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int msession_count ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get session count", 
	"docurl" => "function.msession-count.html" 
),
"msession_create" => array( 
	"methodname" => "msession_create", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool msession_create ( string session )", 
	"snippet" => "( \${1:\$session} )", 
	"desc" => "Create a session", 
	"docurl" => "function.msession-create.html" 
),
"msession_destroy" => array( 
	"methodname" => "msession_destroy", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool msession_destroy ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Destroy a session", 
	"docurl" => "function.msession-destroy.html" 
),
"msession_disconnect" => array( 
	"methodname" => "msession_disconnect", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "void msession_disconnect ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Close connection to msession server", 
	"docurl" => "function.msession-disconnect.html" 
),
"msession_find" => array( 
	"methodname" => "msession_find", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array msession_find ( string name, string value )", 
	"snippet" => "( \${1:\$name}, \${2:\$value} )", 
	"desc" => "Find all sessions with name and value", 
	"docurl" => "function.msession-find.html" 
),
"msession_get_array" => array( 
	"methodname" => "msession_get_array", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array msession_get_array ( string session )", 
	"snippet" => "( \${1:\$session} )", 
	"desc" => "Get array of msession variables", 
	"docurl" => "function.msession-get-array.html" 
),
"msession_get_data" => array( 
	"methodname" => "msession_get_data", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string msession_get_data ( string session )", 
	"snippet" => "( \${1:\$session} )", 
	"desc" => "Get data session unstructured data", 
	"docurl" => "function.msession-get-data.html" 
),
"msession_get" => array( 
	"methodname" => "msession_get", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string msession_get ( string session, string name, string value )", 
	"snippet" => "( \${1:\$session}, \${2:\$name}, \${3:\$value} )", 
	"desc" => "Get value from session", 
	"docurl" => "function.msession-get.html" 
),
"msession_inc" => array( 
	"methodname" => "msession_inc", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string msession_inc ( string session, string name )", 
	"snippet" => "( \${1:\$session}, \${2:\$name} )", 
	"desc" => "Increment value in session", 
	"docurl" => "function.msession-inc.html" 
),
"msession_list" => array( 
	"methodname" => "msession_list", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array msession_list ( void  )", 
	"snippet" => "(  )", 
	"desc" => "List all sessions", 
	"docurl" => "function.msession-list.html" 
),
"msession_listvar" => array( 
	"methodname" => "msession_listvar", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array msession_listvar ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "List sessions with variable", 
	"docurl" => "function.msession-listvar.html" 
),
"msession_lock" => array( 
	"methodname" => "msession_lock", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int msession_lock ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Lock a session", 
	"docurl" => "function.msession-lock.html" 
),
"msession_plugin" => array( 
	"methodname" => "msession_plugin", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string msession_plugin ( string session, string val [, string param] )", 
	"snippet" => "( \${1:\$session}, \${2:\$val} )", 
	"desc" => "Call an escape function within the msession personality plugin", 
	"docurl" => "function.msession-plugin.html" 
),
"msession_randstr" => array( 
	"methodname" => "msession_randstr", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string msession_randstr ( int param )", 
	"snippet" => "( \${1:\$param} )", 
	"desc" => "Get random string", 
	"docurl" => "function.msession-randstr.html" 
),
"msession_set_array" => array( 
	"methodname" => "msession_set_array", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool msession_set_array ( string session, array tuples )", 
	"snippet" => "( \${1:\$session}, \${2:\$tuples} )", 
	"desc" => "Set msession variables from an array", 
	"docurl" => "function.msession-set-array.html" 
),
"msession_set_data" => array( 
	"methodname" => "msession_set_data", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool msession_set_data ( string session, string value )", 
	"snippet" => "( \${1:\$session}, \${2:\$value} )", 
	"desc" => "Set data session unstructured data", 
	"docurl" => "function.msession-set-data.html" 
),
"msession_set" => array( 
	"methodname" => "msession_set", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool msession_set ( string session, string name, string value )", 
	"snippet" => "( \${1:\$session}, \${2:\$name}, \${3:\$value} )", 
	"desc" => "Set value in session", 
	"docurl" => "function.msession-set.html" 
),
"msession_timeout" => array( 
	"methodname" => "msession_timeout", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int msession_timeout ( string session [, int param] )", 
	"snippet" => "( \${1:\$session} )", 
	"desc" => "Set/get session timeout", 
	"docurl" => "function.msession-timeout.html" 
),
"msession_uniq" => array( 
	"methodname" => "msession_uniq", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string msession_uniq ( int param )", 
	"snippet" => "( \${1:\$param} )", 
	"desc" => "Get unique id", 
	"docurl" => "function.msession-uniq.html" 
),
"msession_unlock" => array( 
	"methodname" => "msession_unlock", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int msession_unlock ( string session, int key )", 
	"snippet" => "( \${1:\$session}, \${2:\$key} )", 
	"desc" => "Unlock a session", 
	"docurl" => "function.msession-unlock.html" 
),
"msg_get_queue" => array( 
	"methodname" => "msg_get_queue", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource msg_get_queue ( int key [, int perms] )", 
	"snippet" => "( \${1:\$key} )", 
	"desc" => "Create or attach to a message queue", 
	"docurl" => "function.msg-get-queue.html" 
),
"msg_receive" => array( 
	"methodname" => "msg_receive", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool msg_receive ( resource queue, int desiredmsgtype, int &msgtype, int maxsize, mixed &message [, bool unserialize [, int flags [, int &errorcode]]] )", 
	"snippet" => "( \${1:\$queue}, \${2:\$desiredmsgtype}, \${3:\$msgtype}, \${4:\$maxsize}, \${5:\$message} )", 
	"desc" => "Receive a message from a message queue", 
	"docurl" => "function.msg-receive.html" 
),
"msg_remove_queue" => array( 
	"methodname" => "msg_remove_queue", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool msg_remove_queue ( resource queue )", 
	"snippet" => "( \${1:\$queue} )", 
	"desc" => "Destroy a message queue", 
	"docurl" => "function.msg-remove-queue.html" 
),
"msg_send" => array( 
	"methodname" => "msg_send", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool msg_send ( resource queue, int msgtype, mixed message [, bool serialize [, bool blocking [, int &errorcode]]] )", 
	"snippet" => "( \${1:\$queue}, \${2:\$msgtype}, \${3:\$message} )", 
	"desc" => "Send a message to a message queue", 
	"docurl" => "function.msg-send.html" 
),
"msg_set_queue" => array( 
	"methodname" => "msg_set_queue", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool msg_set_queue ( resource queue, array data )", 
	"snippet" => "( \${1:\$queue}, \${2:\$data} )", 
	"desc" => "Set information in the message queue data structure", 
	"docurl" => "function.msg-set-queue.html" 
),
"msg_stat_queue" => array( 
	"methodname" => "msg_stat_queue", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array msg_stat_queue ( resource queue )", 
	"snippet" => "( \${1:\$queue} )", 
	"desc" => "Returns information from the message queue data structure", 
	"docurl" => "function.msg-stat-queue.html" 
),
"msql_affected_rows" => array( 
	"methodname" => "msql_affected_rows", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int msql_affected_rows ( resource query_identifier )", 
	"snippet" => "( \${1:\$query_identifier} )", 
	"desc" => "Returns number of affected rows", 
	"docurl" => "function.msql-affected-rows.html" 
),
"msql_close" => array( 
	"methodname" => "msql_close", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int msql_close ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Close mSQL connection", 
	"docurl" => "function.msql-close.html" 
),
"msql_connect" => array( 
	"methodname" => "msql_connect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int msql_connect ( [string hostname] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open mSQL connection", 
	"docurl" => "function.msql-connect.html" 
),
"msql_create_db" => array( 
	"methodname" => "msql_create_db", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool msql_create_db ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Create mSQL database", 
	"docurl" => "function.msql-create-db.html" 
),
"msql_createdb" => array( 
	"methodname" => "msql_createdb", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-createdb.html" 
),
"msql_data_seek" => array( 
	"methodname" => "msql_data_seek", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool msql_data_seek ( resource query_identifier, int row_number )", 
	"snippet" => "( \${1:\$query_identifier}, \${2:\$row_number} )", 
	"desc" => "Move internal row pointer", 
	"docurl" => "function.msql-data-seek.html" 
),
"msql_db_query" => array( 
	"methodname" => "msql_db_query", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource msql_db_query ( string database, string query [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database}, \${2:\$query} )", 
	"desc" => "Send mSQL query", 
	"docurl" => "function.msql-db-query.html" 
),
"msql_dbname" => array( 
	"methodname" => "msql_dbname", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-dbname.html" 
),
"msql_drop_db" => array( 
	"methodname" => "msql_drop_db", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int msql_drop_db ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Drop (delete) mSQL database", 
	"docurl" => "function.msql-drop-db.html" 
),
"msql_error" => array( 
	"methodname" => "msql_error", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string msql_error ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns error message of last msql call", 
	"docurl" => "function.msql-error.html" 
),
"msql_fetch_array" => array( 
	"methodname" => "msql_fetch_array", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array msql_fetch_array ( resource query_identifier [, int result_type] )", 
	"snippet" => "( \${1:\$query_identifier} )", 
	"desc" => "Fetch row as array", 
	"docurl" => "function.msql-fetch-array.html" 
),
"msql_fetch_field" => array( 
	"methodname" => "msql_fetch_field", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object msql_fetch_field ( resource query_identifier [, int field_offset] )", 
	"snippet" => "( \${1:\$query_identifier} )", 
	"desc" => "Get field information", 
	"docurl" => "function.msql-fetch-field.html" 
),
"msql_fetch_object" => array( 
	"methodname" => "msql_fetch_object", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object msql_fetch_object ( resource query_identifier [, int result_type] )", 
	"snippet" => "( \${1:\$query_identifier} )", 
	"desc" => "Fetch row as object", 
	"docurl" => "function.msql-fetch-object.html" 
),
"msql_fetch_row" => array( 
	"methodname" => "msql_fetch_row", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array msql_fetch_row ( resource query_identifier [, int result_type] )", 
	"snippet" => "( \${1:\$query_identifier} )", 
	"desc" => "Get row as enumerated array", 
	"docurl" => "function.msql-fetch-row.html" 
),
"msql_field_flags" => array( 
	"methodname" => "msql_field_flags", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string msql_field_flags ( resource query_identifier, int field_offset )", 
	"snippet" => "( \${1:\$query_identifier}, \${2:\$field_offset} )", 
	"desc" => "Get field flags", 
	"docurl" => "function.msql-field-flags.html" 
),
"msql_field_len" => array( 
	"methodname" => "msql_field_len", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int msql_field_len ( resource query_identifier, int field_offset )", 
	"snippet" => "( \${1:\$query_identifier}, \${2:\$field_offset} )", 
	"desc" => "Get field length", 
	"docurl" => "function.msql-field-len.html" 
),
"msql_field_name" => array( 
	"methodname" => "msql_field_name", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string msql_field_name ( resource query_identifier, int field )", 
	"snippet" => "( \${1:\$query_identifier}, \${2:\$field} )", 
	"desc" => "Get field name", 
	"docurl" => "function.msql-field-name.html" 
),
"msql_field_seek" => array( 
	"methodname" => "msql_field_seek", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int msql_field_seek ( int query_identifier, int field_offset )", 
	"snippet" => "( \${1:\$query_identifier}, \${2:\$field_offset} )", 
	"desc" => "Set field offset", 
	"docurl" => "function.msql-field-seek.html" 
),
"msql_field_table" => array( 
	"methodname" => "msql_field_table", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int msql_field_table ( int query_identifier, int field )", 
	"snippet" => "( \${1:\$query_identifier}, \${2:\$field} )", 
	"desc" => "Get table name for field", 
	"docurl" => "function.msql-field-table.html" 
),
"msql_field_type" => array( 
	"methodname" => "msql_field_type", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string msql_field_type ( resource query_identifier, int field_offset )", 
	"snippet" => "( \${1:\$query_identifier}, \${2:\$field_offset} )", 
	"desc" => "Get field type", 
	"docurl" => "function.msql-field-type.html" 
),
"msql_fieldflags" => array( 
	"methodname" => "msql_fieldflags", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-fieldflags.html" 
),
"msql_fieldlen" => array( 
	"methodname" => "msql_fieldlen", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-fieldlen.html" 
),
"msql_fieldname" => array( 
	"methodname" => "msql_fieldname", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-fieldname.html" 
),
"msql_fieldtable" => array( 
	"methodname" => "msql_fieldtable", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-fieldtable.html" 
),
"msql_fieldtype" => array( 
	"methodname" => "msql_fieldtype", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-fieldtype.html" 
),
"msql_free_result" => array( 
	"methodname" => "msql_free_result", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int msql_free_result ( resource query_identifier )", 
	"snippet" => "( \${1:\$query_identifier} )", 
	"desc" => "Free result memory", 
	"docurl" => "function.msql-free-result.html" 
),
"msql_list_dbs" => array( 
	"methodname" => "msql_list_dbs", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource msql_list_dbs ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "List mSQL databases on server", 
	"docurl" => "function.msql-list-dbs.html" 
),
"msql_list_fields" => array( 
	"methodname" => "msql_list_fields", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource msql_list_fields ( string database, string tablename [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database}, \${2:\$tablename} )", 
	"desc" => "List result fields", 
	"docurl" => "function.msql-list-fields.html" 
),
"msql_list_tables" => array( 
	"methodname" => "msql_list_tables", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource msql_list_tables ( string database [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database} )", 
	"desc" => "List tables in an mSQL database", 
	"docurl" => "function.msql-list-tables.html" 
),
"msql_num_fields" => array( 
	"methodname" => "msql_num_fields", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int msql_num_fields ( resource query_identifier )", 
	"snippet" => "( \${1:\$query_identifier} )", 
	"desc" => "Get number of fields in result", 
	"docurl" => "function.msql-num-fields.html" 
),
"msql_num_rows" => array( 
	"methodname" => "msql_num_rows", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int msql_num_rows ( resource query_identifier )", 
	"snippet" => "( \${1:\$query_identifier} )", 
	"desc" => "Get number of rows in result", 
	"docurl" => "function.msql-num-rows.html" 
),
"msql_numfields" => array( 
	"methodname" => "msql_numfields", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-numfields.html" 
),
"msql_numrows" => array( 
	"methodname" => "msql_numrows", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-numrows.html" 
),
"msql_pconnect" => array( 
	"methodname" => "msql_pconnect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int msql_pconnect ( [string server [, string username [, string password]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open persistent mSQL connection", 
	"docurl" => "function.msql-pconnect.html" 
),
"msql_query" => array( 
	"methodname" => "msql_query", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource msql_query ( string query [, resource link_identifier] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Send mSQL query", 
	"docurl" => "function.msql-query.html" 
),
"msql_regcase" => array( 
	"methodname" => "msql_regcase", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-regcase.html" 
),
"msql_result" => array( 
	"methodname" => "msql_result", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string msql_result ( resource query_identifier, int row [, mixed field] )", 
	"snippet" => "( \${1:\$query_identifier}, \${2:\$row} )", 
	"desc" => "Get result data", 
	"docurl" => "function.msql-result.html" 
),
"msql_select_db" => array( 
	"methodname" => "msql_select_db", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool msql_select_db ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Select mSQL database", 
	"docurl" => "function.msql-select-db.html" 
),
"msql_tablename" => array( 
	"methodname" => "msql_tablename", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql-tablename.html" 
),
"msql" => array( 
	"methodname" => "msql", 
	"version" => "undefined", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.msql.html" 
),
"mssql_bind" => array( 
	"methodname" => "mssql_bind", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool mssql_bind ( resource stmt, string param_name, mixed &var, int type [, int is_output [, int is_null [, int maxlen]]] )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$param_name}, \${3:\$var}, \${4:\$type} )", 
	"desc" => "Adds a parameter to a stored procedure or a remote stored procedure", 
	"docurl" => "function.mssql-bind.html" 
),
"mssql_close" => array( 
	"methodname" => "mssql_close", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mssql_close ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Close MS SQL Server connection", 
	"docurl" => "function.mssql-close.html" 
),
"mssql_connect" => array( 
	"methodname" => "mssql_connect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mssql_connect ( [string servername [, string username [, string password]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open MS SQL server connection", 
	"docurl" => "function.mssql-connect.html" 
),
"mssql_data_seek" => array( 
	"methodname" => "mssql_data_seek", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mssql_data_seek ( resource result_identifier, int row_number )", 
	"snippet" => "( \${1:\$result_identifier}, \${2:\$row_number} )", 
	"desc" => "Moves internal row pointer", 
	"docurl" => "function.mssql-data-seek.html" 
),
"mssql_execute" => array( 
	"methodname" => "mssql_execute", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "mixed mssql_execute ( resource stmt [, bool skip_results] )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Executes a stored procedure on a MS SQL server database", 
	"docurl" => "function.mssql-execute.html" 
),
"mssql_fetch_array" => array( 
	"methodname" => "mssql_fetch_array", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array mssql_fetch_array ( resource result [, int result_type] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an associative array, a numeric array, or both", 
	"docurl" => "function.mssql-fetch-array.html" 
),
"mssql_fetch_assoc" => array( 
	"methodname" => "mssql_fetch_assoc", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array mssql_fetch_assoc ( resource result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Returns an associative array of the current row in the result set specified by result_id", 
	"docurl" => "function.mssql-fetch-assoc.html" 
),
"mssql_fetch_batch" => array( 
	"methodname" => "mssql_fetch_batch", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int mssql_fetch_batch ( resource result_index )", 
	"snippet" => "( \${1:\$result_index} )", 
	"desc" => "Returns the next batch of records", 
	"docurl" => "function.mssql-fetch-batch.html" 
),
"mssql_fetch_field" => array( 
	"methodname" => "mssql_fetch_field", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object mssql_fetch_field ( resource result [, int field_offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get field information", 
	"docurl" => "function.mssql-fetch-field.html" 
),
"mssql_fetch_object" => array( 
	"methodname" => "mssql_fetch_object", 
	"version" => "PHP3, PHP5", 
	"method" => "object mssql_fetch_object ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch row as object", 
	"docurl" => "function.mssql-fetch-object.html" 
),
"mssql_fetch_row" => array( 
	"methodname" => "mssql_fetch_row", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array mssql_fetch_row ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get row as enumerated array", 
	"docurl" => "function.mssql-fetch-row.html" 
),
"mssql_field_length" => array( 
	"methodname" => "mssql_field_length", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "int mssql_field_length ( resource result [, int offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get the length of a field", 
	"docurl" => "function.mssql-field-length.html" 
),
"mssql_field_name" => array( 
	"methodname" => "mssql_field_name", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "string mssql_field_name ( resource result [, int offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get the name of a field", 
	"docurl" => "function.mssql-field-name.html" 
),
"mssql_field_seek" => array( 
	"methodname" => "mssql_field_seek", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mssql_field_seek ( resource result, int field_offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_offset} )", 
	"desc" => "Seeks to the specified field offset", 
	"docurl" => "function.mssql-field-seek.html" 
),
"mssql_field_type" => array( 
	"methodname" => "mssql_field_type", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "string mssql_field_type ( resource result [, int offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Gets the type of a field", 
	"docurl" => "function.mssql-field-type.html" 
),
"mssql_free_result" => array( 
	"methodname" => "mssql_free_result", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mssql_free_result ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Free result memory", 
	"docurl" => "function.mssql-free-result.html" 
),
"mssql_free_statement" => array( 
	"methodname" => "mssql_free_statement", 
	"version" => "PHP4 >= 4.3.2, PHP5", 
	"method" => "bool mssql_free_statement ( resource statement )", 
	"snippet" => "( \${1:\$statement} )", 
	"desc" => "Free statement memory", 
	"docurl" => "function.mssql-free-statement.html" 
),
"mssql_get_last_message" => array( 
	"methodname" => "mssql_get_last_message", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string mssql_get_last_message ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the last message from the server", 
	"docurl" => "function.mssql-get-last-message.html" 
),
"mssql_guid_string" => array( 
	"methodname" => "mssql_guid_string", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string mssql_guid_string ( string binary [, int short_format] )", 
	"snippet" => "( \${1:\$binary} )", 
	"desc" => "Converts a 16 byte binary GUID to a string", 
	"docurl" => "function.mssql-guid-string.html" 
),
"mssql_init" => array( 
	"methodname" => "mssql_init", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int mssql_init ( string sp_name [, resource conn_id] )", 
	"snippet" => "( \${1:\$sp_name} )", 
	"desc" => "Initializes a stored procedure or a remote stored procedure", 
	"docurl" => "function.mssql-init.html" 
),
"mssql_min_error_severity" => array( 
	"methodname" => "mssql_min_error_severity", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void mssql_min_error_severity ( int severity )", 
	"snippet" => "( \${1:\$severity} )", 
	"desc" => "Sets the lower error severity", 
	"docurl" => "function.mssql-min-error-severity.html" 
),
"mssql_min_message_severity" => array( 
	"methodname" => "mssql_min_message_severity", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void mssql_min_message_severity ( int severity )", 
	"snippet" => "( \${1:\$severity} )", 
	"desc" => "Sets the lower message severity", 
	"docurl" => "function.mssql-min-message-severity.html" 
),
"mssql_next_result" => array( 
	"methodname" => "mssql_next_result", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool mssql_next_result ( resource result_id )", 
	"snippet" => "( \${1:\$result_id} )", 
	"desc" => "Move the internal result pointer to the next result", 
	"docurl" => "function.mssql-next-result.html" 
),
"mssql_num_fields" => array( 
	"methodname" => "mssql_num_fields", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mssql_num_fields ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Gets the number of fields in result", 
	"docurl" => "function.mssql-num-fields.html" 
),
"mssql_num_rows" => array( 
	"methodname" => "mssql_num_rows", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mssql_num_rows ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Gets the number of rows in result", 
	"docurl" => "function.mssql-num-rows.html" 
),
"mssql_pconnect" => array( 
	"methodname" => "mssql_pconnect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mssql_pconnect ( [string servername [, string username [, string password]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open persistent MS SQL connection", 
	"docurl" => "function.mssql-pconnect.html" 
),
"mssql_query" => array( 
	"methodname" => "mssql_query", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource mssql_query ( string query [, resource link_identifier [, int batch_size]] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Send MS SQL query", 
	"docurl" => "function.mssql-query.html" 
),
"mssql_result" => array( 
	"methodname" => "mssql_result", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string mssql_result ( resource result, int row, mixed field )", 
	"snippet" => "( \${1:\$result}, \${2:\$row}, \${3:\$field} )", 
	"desc" => "Get result data", 
	"docurl" => "function.mssql-result.html" 
),
"mssql_rows_affected" => array( 
	"methodname" => "mssql_rows_affected", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int mssql_rows_affected ( resource conn_id )", 
	"snippet" => "( \${1:\$conn_id} )", 
	"desc" => "Returns the number of records affected by the query", 
	"docurl" => "function.mssql-rows-affected.html" 
),
"mssql_select_db" => array( 
	"methodname" => "mssql_select_db", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mssql_select_db ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Select MS SQL database", 
	"docurl" => "function.mssql-select-db.html" 
),
"mt_getrandmax" => array( 
	"methodname" => "mt_getrandmax", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int mt_getrandmax ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Show largest possible random value", 
	"docurl" => "function.mt-getrandmax.html" 
),
"mt_rand" => array( 
	"methodname" => "mt_rand", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int mt_rand ( [int min, int max] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Generate a better random value", 
	"docurl" => "function.mt-rand.html" 
),
"mt_srand" => array( 
	"methodname" => "mt_srand", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "void mt_srand ( [int seed] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Seed the better random number generator", 
	"docurl" => "function.mt-srand.html" 
),
"muscat_close" => array( 
	"methodname" => "muscat_close", 
	"version" => "undefined", 
	"method" => "int muscat_close ( resource muscat_handle )", 
	"snippet" => "( \${1:\$muscat_handle} )", 
	"desc" => "", 
	"docurl" => "function.muscat-close.html" 
),
"muscat_get" => array( 
	"methodname" => "muscat_get", 
	"version" => "undefined", 
	"method" => "string muscat_get ( resource muscat_handle )", 
	"snippet" => "( \${1:\$muscat_handle} )", 
	"desc" => "", 
	"docurl" => "function.muscat-get.html" 
),
"muscat_give" => array( 
	"methodname" => "muscat_give", 
	"version" => "undefined", 
	"method" => "int muscat_give ( resource muscat_handle, string string )", 
	"snippet" => "( \${1:\$muscat_handle}, \${2:\$string} )", 
	"desc" => "", 
	"docurl" => "function.muscat-give.html" 
),
"muscat_setup_net" => array( 
	"methodname" => "muscat_setup_net", 
	"version" => "undefined", 
	"method" => "resource muscat_setup_net ( string muscat_host )", 
	"snippet" => "( \${1:\$muscat_host} )", 
	"desc" => "", 
	"docurl" => "function.muscat-setup-net.html" 
),
"muscat_setup" => array( 
	"methodname" => "muscat_setup", 
	"version" => "undefined", 
	"method" => "resource muscat_setup ( int size [, string muscat_dir] )", 
	"snippet" => "( \${1:\$size} )", 
	"desc" => "", 
	"docurl" => "function.muscat-setup.html" 
),
"mysql_affected_rows" => array( 
	"methodname" => "mysql_affected_rows", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mysql_affected_rows ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get number of affected rows in previous MySQL operation", 
	"docurl" => "function.mysql-affected-rows.html" 
),
"mysql_change_user" => array( 
	"methodname" => "mysql_change_user", 
	"version" => "PHP3>= 3.0.13", 
	"method" => "int mysql_change_user ( string user, string password [, string database [, resource link_identifier]] )", 
	"snippet" => "( \${1:\$user}, \${2:\$password} )", 
	"desc" => "Change logged in user of the active connection", 
	"docurl" => "function.mysql-change-user.html" 
),
"mysql_client_encoding" => array( 
	"methodname" => "mysql_client_encoding", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mysql_client_encoding ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns the name of the character set", 
	"docurl" => "function.mysql-client-encoding.html" 
),
"mysql_close" => array( 
	"methodname" => "mysql_close", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mysql_close ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Close MySQL connection", 
	"docurl" => "function.mysql-close.html" 
),
"mysql_connect" => array( 
	"methodname" => "mysql_connect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource mysql_connect ( [string server [, string username [, string password [, bool new_link [, int client_flags]]]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open a connection to a MySQL Server", 
	"docurl" => "function.mysql-connect.html" 
),
"mysql_create_db" => array( 
	"methodname" => "mysql_create_db", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mysql_create_db ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Create a MySQL database", 
	"docurl" => "function.mysql-create-db.html" 
),
"mysql_data_seek" => array( 
	"methodname" => "mysql_data_seek", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mysql_data_seek ( resource result, int row_number )", 
	"snippet" => "( \${1:\$result}, \${2:\$row_number} )", 
	"desc" => "Move internal result pointer", 
	"docurl" => "function.mysql-data-seek.html" 
),
"mysql_db_name" => array( 
	"methodname" => "mysql_db_name", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string mysql_db_name ( resource result, int row [, mixed field] )", 
	"snippet" => "( \${1:\$result}, \${2:\$row} )", 
	"desc" => "Get result data", 
	"docurl" => "function.mysql-db-name.html" 
),
"mysql_db_query" => array( 
	"methodname" => "mysql_db_query", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource mysql_db_query ( string database, string query [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database}, \${2:\$query} )", 
	"desc" => "Send a MySQL query", 
	"docurl" => "function.mysql-db-query.html" 
),
"mysql_drop_db" => array( 
	"methodname" => "mysql_drop_db", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mysql_drop_db ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Drop (delete) a MySQL database", 
	"docurl" => "function.mysql-drop-db.html" 
),
"mysql_errno" => array( 
	"methodname" => "mysql_errno", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mysql_errno ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns the numerical value of the error message from previous MySQL operation", 
	"docurl" => "function.mysql-errno.html" 
),
"mysql_error" => array( 
	"methodname" => "mysql_error", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string mysql_error ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns the text of the error message from previous MySQL operation", 
	"docurl" => "function.mysql-error.html" 
),
"mysql_escape_string" => array( 
	"methodname" => "mysql_escape_string", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "string mysql_escape_string ( string unescaped_string )", 
	"snippet" => "( \${1:\$unescaped_string} )", 
	"desc" => "Escapes a string for use in a mysql_query", 
	"docurl" => "function.mysql-escape-string.html" 
),
"mysql_fetch_array" => array( 
	"methodname" => "mysql_fetch_array", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array mysql_fetch_array ( resource result [, int result_type] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an associative array, a numeric array, or both", 
	"docurl" => "function.mysql-fetch-array.html" 
),
"mysql_fetch_assoc" => array( 
	"methodname" => "mysql_fetch_assoc", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "array mysql_fetch_assoc ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an associative array", 
	"docurl" => "function.mysql-fetch-assoc.html" 
),
"mysql_fetch_field" => array( 
	"methodname" => "mysql_fetch_field", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object mysql_fetch_field ( resource result [, int field_offset] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get column information from a result and return as an object", 
	"docurl" => "function.mysql-fetch-field.html" 
),
"mysql_fetch_lengths" => array( 
	"methodname" => "mysql_fetch_lengths", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array mysql_fetch_lengths ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get the length of each output in a result", 
	"docurl" => "function.mysql-fetch-lengths.html" 
),
"mysql_fetch_object" => array( 
	"methodname" => "mysql_fetch_object", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object mysql_fetch_object ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an object", 
	"docurl" => "function.mysql-fetch-object.html" 
),
"mysql_fetch_row" => array( 
	"methodname" => "mysql_fetch_row", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array mysql_fetch_row ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get a result row as an enumerated array", 
	"docurl" => "function.mysql-fetch-row.html" 
),
"mysql_field_flags" => array( 
	"methodname" => "mysql_field_flags", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string mysql_field_flags ( resource result, int field_offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_offset} )", 
	"desc" => "Get the flags associated with the specified field in a result", 
	"docurl" => "function.mysql-field-flags.html" 
),
"mysql_field_len" => array( 
	"methodname" => "mysql_field_len", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mysql_field_len ( resource result, int field_offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_offset} )", 
	"desc" => "Returns the length of the specified field", 
	"docurl" => "function.mysql-field-len.html" 
),
"mysql_field_name" => array( 
	"methodname" => "mysql_field_name", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string mysql_field_name ( resource result, int field_offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_offset} )", 
	"desc" => "Get the name of the specified field in a result", 
	"docurl" => "function.mysql-field-name.html" 
),
"mysql_field_seek" => array( 
	"methodname" => "mysql_field_seek", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mysql_field_seek ( resource result, int field_offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_offset} )", 
	"desc" => "Set result pointer to a specified field offset", 
	"docurl" => "function.mysql-field-seek.html" 
),
"mysql_field_table" => array( 
	"methodname" => "mysql_field_table", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string mysql_field_table ( resource result, int field_offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_offset} )", 
	"desc" => "Get name of the table the specified field is in", 
	"docurl" => "function.mysql-field-table.html" 
),
"mysql_field_type" => array( 
	"methodname" => "mysql_field_type", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string mysql_field_type ( resource result, int field_offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$field_offset} )", 
	"desc" => "Get the type of the specified field in a result", 
	"docurl" => "function.mysql-field-type.html" 
),
"mysql_free_result" => array( 
	"methodname" => "mysql_free_result", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mysql_free_result ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Free result memory", 
	"docurl" => "function.mysql-free-result.html" 
),
"mysql_get_client_info" => array( 
	"methodname" => "mysql_get_client_info", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string mysql_get_client_info ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get MySQL client info", 
	"docurl" => "function.mysql-get-client-info.html" 
),
"mysql_get_host_info" => array( 
	"methodname" => "mysql_get_host_info", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string mysql_get_host_info ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get MySQL host info", 
	"docurl" => "function.mysql-get-host-info.html" 
),
"mysql_get_proto_info" => array( 
	"methodname" => "mysql_get_proto_info", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int mysql_get_proto_info ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get MySQL protocol info", 
	"docurl" => "function.mysql-get-proto-info.html" 
),
"mysql_get_server_info" => array( 
	"methodname" => "mysql_get_server_info", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string mysql_get_server_info ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get MySQL server info", 
	"docurl" => "function.mysql-get-server-info.html" 
),
"mysql_info" => array( 
	"methodname" => "mysql_info", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mysql_info ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get information about the most recent query", 
	"docurl" => "function.mysql-info.html" 
),
"mysql_insert_id" => array( 
	"methodname" => "mysql_insert_id", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mysql_insert_id ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get the ID generated from the previous INSERT operation", 
	"docurl" => "function.mysql-insert-id.html" 
),
"mysql_list_dbs" => array( 
	"methodname" => "mysql_list_dbs", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource mysql_list_dbs ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "List databases available on a MySQL server", 
	"docurl" => "function.mysql-list-dbs.html" 
),
"mysql_list_fields" => array( 
	"methodname" => "mysql_list_fields", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource mysql_list_fields ( string database_name, string table_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name}, \${2:\$table_name} )", 
	"desc" => "List MySQL table fields", 
	"docurl" => "function.mysql-list-fields.html" 
),
"mysql_list_processes" => array( 
	"methodname" => "mysql_list_processes", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "resource mysql_list_processes ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "List MySQL processes", 
	"docurl" => "function.mysql-list-processes.html" 
),
"mysql_list_tables" => array( 
	"methodname" => "mysql_list_tables", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource mysql_list_tables ( string database [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database} )", 
	"desc" => "List tables in a MySQL database", 
	"docurl" => "function.mysql-list-tables.html" 
),
"mysql_num_fields" => array( 
	"methodname" => "mysql_num_fields", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mysql_num_fields ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get number of fields in result", 
	"docurl" => "function.mysql-num-fields.html" 
),
"mysql_num_rows" => array( 
	"methodname" => "mysql_num_rows", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int mysql_num_rows ( resource result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get number of rows in result", 
	"docurl" => "function.mysql-num-rows.html" 
),
"mysql_pconnect" => array( 
	"methodname" => "mysql_pconnect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource mysql_pconnect ( [string server [, string username [, string password [, int client_flags]]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open a persistent connection to a MySQL server", 
	"docurl" => "function.mysql-pconnect.html" 
),
"mysql_ping" => array( 
	"methodname" => "mysql_ping", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool mysql_ping ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Ping a server connection or reconnect if there is no connection", 
	"docurl" => "function.mysql-ping.html" 
),
"mysql_query" => array( 
	"methodname" => "mysql_query", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource mysql_query ( string query [, resource link_identifier] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Send a MySQL query", 
	"docurl" => "function.mysql-query.html" 
),
"mysql_real_escape_string" => array( 
	"methodname" => "mysql_real_escape_string", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mysql_real_escape_string ( string unescaped_string [, resource link_identifier] )", 
	"snippet" => "( \${1:\$unescaped_string} )", 
	"desc" => "Escapes special characters in a string for use in a SQL statement", 
	"docurl" => "function.mysql-real-escape-string.html" 
),
"mysql_result" => array( 
	"methodname" => "mysql_result", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed mysql_result ( resource result, int row [, mixed field] )", 
	"snippet" => "( \${1:\$result}, \${2:\$row} )", 
	"desc" => "Get result data", 
	"docurl" => "function.mysql-result.html" 
),
"mysql_select_db" => array( 
	"methodname" => "mysql_select_db", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool mysql_select_db ( string database_name [, resource link_identifier] )", 
	"snippet" => "( \${1:\$database_name} )", 
	"desc" => "Select a MySQL database", 
	"docurl" => "function.mysql-select-db.html" 
),
"mysql_stat" => array( 
	"methodname" => "mysql_stat", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string mysql_stat ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get current system status", 
	"docurl" => "function.mysql-stat.html" 
),
"mysql_tablename" => array( 
	"methodname" => "mysql_tablename", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string mysql_tablename ( resource result, int i )", 
	"snippet" => "( \${1:\$result}, \${2:\$i} )", 
	"desc" => "Get table name of field", 
	"docurl" => "function.mysql-tablename.html" 
),
"mysql_thread_id" => array( 
	"methodname" => "mysql_thread_id", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int mysql_thread_id ( [resource link_identifier] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Return the current thread ID", 
	"docurl" => "function.mysql-thread-id.html" 
),
"mysql_unbuffered_query" => array( 
	"methodname" => "mysql_unbuffered_query", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "resource mysql_unbuffered_query ( string query [, resource link_identifier] )", 
	"snippet" => "( \${1:\$query} )", 
	"desc" => "Send an SQL query to MySQL, without fetching and buffering the result rows", 
	"docurl" => "function.mysql-unbuffered-query.html" 
),
"mysqli_affected_rows" => array( 
	"methodname" => "mysqli_affected_rows", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_affected_rows ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Gets the number of affected rows in a previous MySQL operation", 
	"docurl" => "function.mysqli-affected-rows.html" 
),
"mysqli_autocommit" => array( 
	"methodname" => "mysqli_autocommit", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_autocommit ( mysqli link, bool mode )", 
	"snippet" => "( \${1:\$link}, \${2:\$mode} )", 
	"desc" => "Turns on or off auto-commiting database modifications", 
	"docurl" => "function.mysqli-autocommit.html" 
),
"mysqli_change_user" => array( 
	"methodname" => "mysqli_change_user", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_change_user ( mysqli link, string user, string password, string database )", 
	"snippet" => "( \${1:\$link}, \${2:\$user}, \${3:\$password}, \${4:\$database} )", 
	"desc" => "Changes the user of the specified database connection", 
	"docurl" => "function.mysqli-change-user.html" 
),
"mysqli_character_set_name" => array( 
	"methodname" => "mysqli_character_set_name", 
	"version" => "PHP5", 
	"method" => "Procedural style:string mysqli_character_set_name ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns the default character set for the database connection", 
	"docurl" => "function.mysqli-character-set-name.html" 
),
"mysqli_client_encoding" => array( 
	"methodname" => "mysqli_client_encoding", 
	"version" => "PHP5", 
	"method" => "Alias of mysqli_character_set_name()", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of mysqli_character_set_name()\n", 
	"docurl" => "function.mysqli-client-encoding.html" 
),
"mysqli_close" => array( 
	"methodname" => "mysqli_close", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_close ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Closes a previously opened database connection", 
	"docurl" => "function.mysqli-close.html" 
),
"mysqli_commit" => array( 
	"methodname" => "mysqli_commit", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_commit ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Commits the current transaction", 
	"docurl" => "function.mysqli-commit.html" 
),
"mysqli_connect_errno" => array( 
	"methodname" => "mysqli_connect_errno", 
	"version" => "PHP5", 
	"method" => "int mysqli_connect_errno ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the error code from last connect call", 
	"docurl" => "function.mysqli-connect-errno.html" 
),
"mysqli_connect_error" => array( 
	"methodname" => "mysqli_connect_error", 
	"version" => "PHP5", 
	"method" => "string mysqli_connect_error ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns a string description of the last connect error", 
	"docurl" => "function.mysqli-connect-error.html" 
),
"mysqli_connect" => array( 
	"methodname" => "mysqli_connect", 
	"version" => "PHP5", 
	"method" => "Procedural stylemysqli mysqli_connect ( [string host [, string username [, string passwd [, string dbname [, int port [, string socket]]]]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open a new connection to the MySQL server", 
	"docurl" => "function.mysqli-connect.html" 
),
"mysqli_data_seek" => array( 
	"methodname" => "mysqli_data_seek", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_data_seek ( mysqli_result result, int offset )", 
	"snippet" => "( \${1:\$result}, \${2:\$offset} )", 
	"desc" => "Adjusts the result pointer to an arbitary row in the result", 
	"docurl" => "function.mysqli-data-seek.html" 
),
"mysqli_debug" => array( 
	"methodname" => "mysqli_debug", 
	"version" => "PHP5", 
	"method" => "void mysqli_debug ( string debug )", 
	"snippet" => "( \${1:\$debug} )", 
	"desc" => "Performs debugging operations", 
	"docurl" => "function.mysqli-debug.html" 
),
"mysqli_disable_reads_from_master" => array( 
	"methodname" => "mysqli_disable_reads_from_master", 
	"version" => "PHP5", 
	"method" => "Procedural style:void mysqli_disable_reads_from_master ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Disable reads from master", 
	"docurl" => "function.mysqli-disable-reads-from-master.html" 
),
"mysqli_disable_rpl_parse" => array( 
	"methodname" => "mysqli_disable_rpl_parse", 
	"version" => "PHP5", 
	"method" => "void mysqli_disable_rpl_parse ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Disable RPL parse", 
	"docurl" => "function.mysqli-disable-rpl-parse.html" 
),
"mysqli_dump_debug_info" => array( 
	"methodname" => "mysqli_dump_debug_info", 
	"version" => "PHP5", 
	"method" => "bool mysqli_dump_debug_info ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Dump debugging information into the log", 
	"docurl" => "function.mysqli-dump-debug-info.html" 
),
"mysqli_embedded_connect" => array( 
	"methodname" => "mysqli_embedded_connect", 
	"version" => "PHP5", 
	"method" => "mysqli mysqli_embedded_connect ( [string dbname] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Open a connection to an embedded mysql server", 
	"docurl" => "function.mysqli-embedded-connect.html" 
),
"mysqli_enable_reads_from_master" => array( 
	"methodname" => "mysqli_enable_reads_from_master", 
	"version" => "PHP5", 
	"method" => "void mysqli_enable_reads_from_master ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Enable reads from master", 
	"docurl" => "function.mysqli-enable-reads-from-master.html" 
),
"mysqli_enable_rpl_parse" => array( 
	"methodname" => "mysqli_enable_rpl_parse", 
	"version" => "PHP5", 
	"method" => "void mysqli_enable_rpl_parse ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Enable RPL parse", 
	"docurl" => "function.mysqli-enable-rpl-parse.html" 
),
"mysqli_errno" => array( 
	"methodname" => "mysqli_errno", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_errno ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns the error code for the most recent function call", 
	"docurl" => "function.mysqli-errno.html" 
),
"mysqli_error" => array( 
	"methodname" => "mysqli_error", 
	"version" => "PHP5", 
	"method" => "Procedural style:string mysqli_error ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns a string description of the last error", 
	"docurl" => "function.mysqli-error.html" 
),
"mysqli_escape_string" => array( 
	"methodname" => "mysqli_escape_string", 
	"version" => "PHP5", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of mysqli_real_escape_string()", 
	"docurl" => "function.mysqli-escape-string.html" 
),
"mysqli_fetch_array" => array( 
	"methodname" => "mysqli_fetch_array", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_fetch_array ( mysqli_result result [, int resulttype] )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an associative, a numeric array, or both", 
	"docurl" => "function.mysqli-fetch-array.html" 
),
"mysqli_fetch_assoc" => array( 
	"methodname" => "mysqli_fetch_assoc", 
	"version" => "PHP5", 
	"method" => "Procedural style:array mysqli_fetch_assoc ( mysqli_result result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Fetch a result row as an associative array", 
	"docurl" => "function.mysqli-fetch-assoc.html" 
),
"mysqli_fetch_field_direct" => array( 
	"methodname" => "mysqli_fetch_field_direct", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_fetch_field_direct ( mysqli_result result, int fieldnr )", 
	"snippet" => "( \${1:\$result}, \${2:\$fieldnr} )", 
	"desc" => "Fetch meta-data for a single field", 
	"docurl" => "function.mysqli-fetch-field-direct.html" 
),
"mysqli_fetch_field" => array( 
	"methodname" => "mysqli_fetch_field", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_fetch_field ( mysqli_result result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns the next field in the result set", 
	"docurl" => "function.mysqli-fetch-field.html" 
),
"mysqli_fetch_fields" => array( 
	"methodname" => "mysqli_fetch_fields", 
	"version" => "PHP5", 
	"method" => "Procedural Style:mixed mysqli_fetch_fields ( mysqli_result result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns an array of objects representing the fields in a result set", 
	"docurl" => "function.mysqli-fetch-fields.html" 
),
"mysqli_fetch_lengths" => array( 
	"methodname" => "mysqli_fetch_lengths", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_fetch_lengths ( mysqli_result result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns the lengths of the columns of the current row in the result set", 
	"docurl" => "function.mysqli-fetch-lengths.html" 
),
"mysqli_fetch_object" => array( 
	"methodname" => "mysqli_fetch_object", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_fetch_object ( mysqli_result result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Returns the current row of a result set as an object", 
	"docurl" => "function.mysqli-fetch-object.html" 
),
"mysqli_fetch_row" => array( 
	"methodname" => "mysqli_fetch_row", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_fetch_row ( mysqli_result result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get a result row as an enumerated array", 
	"docurl" => "function.mysqli-fetch-row.html" 
),
"mysqli_field_count" => array( 
	"methodname" => "mysqli_field_count", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_field_count ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns the number of columns for the most recent query", 
	"docurl" => "function.mysqli-field-count.html" 
),
"mysqli_field_seek" => array( 
	"methodname" => "mysqli_field_seek", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_field_seek ( mysqli_result result, int fieldnr )", 
	"snippet" => "( \${1:\$result}, \${2:\$fieldnr} )", 
	"desc" => "Set result pointer to a specified field offset", 
	"docurl" => "function.mysqli-field-seek.html" 
),
"mysqli_field_tell" => array( 
	"methodname" => "mysqli_field_tell", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_field_tell ( mysqli_result result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get current field offset of a result pointer", 
	"docurl" => "function.mysqli-field-tell.html" 
),
"mysqli_free_result" => array( 
	"methodname" => "mysqli_free_result", 
	"version" => "PHP5", 
	"method" => "Procedural style:void mysqli_free_result ( mysqli_result result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Frees the memory associated with a result", 
	"docurl" => "function.mysqli-free-result.html" 
),
"mysqli_get_client_info" => array( 
	"methodname" => "mysqli_get_client_info", 
	"version" => "PHP5", 
	"method" => "string mysqli_get_client_info ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the MySQL client version as a string", 
	"docurl" => "function.mysqli-get-client-info.html" 
),
"mysqli_get_client_version" => array( 
	"methodname" => "mysqli_get_client_version", 
	"version" => "PHP5", 
	"method" => "int mysqli_get_client_version ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get MySQL client info", 
	"docurl" => "function.mysqli-get-client-version.html" 
),
"mysqli_get_host_info" => array( 
	"methodname" => "mysqli_get_host_info", 
	"version" => "PHP5", 
	"method" => "Procdural style:string mysqli_get_host_info ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns a string representing the type of connection used", 
	"docurl" => "function.mysqli-get-host-info.html" 
),
"mysqli_get_proto_info" => array( 
	"methodname" => "mysqli_get_proto_info", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_get_proto_info ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns the version of the MySQL protocol used", 
	"docurl" => "function.mysqli-get-proto-info.html" 
),
"mysqli_get_server_info" => array( 
	"methodname" => "mysqli_get_server_info", 
	"version" => "PHP5", 
	"method" => "Procedural style:string mysqli_get_server_info ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns the version of the MySQL server", 
	"docurl" => "function.mysqli-get-server-info.html" 
),
"mysqli_get_server_version" => array( 
	"methodname" => "mysqli_get_server_version", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_get_server_version ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns the version of the MySQL server as an integer", 
	"docurl" => "function.mysqli-get-server-version.html" 
),
"mysqli_info" => array( 
	"methodname" => "mysqli_info", 
	"version" => "PHP5", 
	"method" => "Procedural style:string mysqli_info ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Retrieves information about the most recently executed query", 
	"docurl" => "function.mysqli-info.html" 
),
"mysqli_init" => array( 
	"methodname" => "mysqli_init", 
	"version" => "PHP5", 
	"method" => "mysqli mysqli_init ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Initializes MySQLi and returns an object for use with mysqli_real_connect", 
	"docurl" => "function.mysqli-init.html" 
),
"mysqli_insert_id" => array( 
	"methodname" => "mysqli_insert_id", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_insert_id ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns the auto generated id used in the last query", 
	"docurl" => "function.mysqli-insert-id.html" 
),
"mysqli_kill" => array( 
	"methodname" => "mysqli_kill", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_kill ( mysqli link, int processid )", 
	"snippet" => "( \${1:\$link}, \${2:\$processid} )", 
	"desc" => "Asks the server to kill a MySQL thread", 
	"docurl" => "function.mysqli-kill.html" 
),
"mysqli_master_query" => array( 
	"methodname" => "mysqli_master_query", 
	"version" => "PHP5", 
	"method" => "bool mysqli_master_query ( mysqli link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "Enforce execution of a query on the master in a master/slave setup", 
	"docurl" => "function.mysqli-master-query.html" 
),
"mysqli_more_results" => array( 
	"methodname" => "mysqli_more_results", 
	"version" => "PHP5", 
	"method" => "bool mysqli_more_results ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Check if there any more query results from a multi query", 
	"docurl" => "function.mysqli-more-results.html" 
),
"mysqli_multi_query" => array( 
	"methodname" => "mysqli_multi_query", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_multi_query ( mysqli link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "Performs a query on the database", 
	"docurl" => "function.mysqli-multi-query.html" 
),
"mysqli_next_result" => array( 
	"methodname" => "mysqli_next_result", 
	"version" => "PHP5", 
	"method" => "bool mysqli_next_result ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Prepare next result from multi_query", 
	"docurl" => "function.mysqli-next-result.html" 
),
"mysqli_num_fields" => array( 
	"methodname" => "mysqli_num_fields", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_num_fields ( mysqli_result result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Get the number of fields in a result", 
	"docurl" => "function.mysqli-num-fields.html" 
),
"mysqli_num_rows" => array( 
	"methodname" => "mysqli_num_rows", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_num_rows ( mysqli result )", 
	"snippet" => "( \${1:\$result} )", 
	"desc" => "Gets the number of rows in a result", 
	"docurl" => "function.mysqli-num-rows.html" 
),
"mysqli_options" => array( 
	"methodname" => "mysqli_options", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_options ( mysqli link, int option, mixed value )", 
	"snippet" => "( \${1:\$link}, \${2:\$option}, \${3:\$value} )", 
	"desc" => "Set options", 
	"docurl" => "function.mysqli-options.html" 
),
"mysqli_ping" => array( 
	"methodname" => "mysqli_ping", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_ping ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Pings a server connection, or tries to reconnect if the connection has gone down", 
	"docurl" => "function.mysqli-ping.html" 
),
"mysqli_prepare" => array( 
	"methodname" => "mysqli_prepare", 
	"version" => "PHP5", 
	"method" => "Procedure style:mixed mysqli_prepare ( mysqli link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "Prepare a SQL statement for execution", 
	"docurl" => "function.mysqli-prepare.html" 
),
"mysqli_query" => array( 
	"methodname" => "mysqli_query", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_query ( mysqli link, string query [, int resultmode] )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "Performs a query on the database", 
	"docurl" => "function.mysqli-query.html" 
),
"mysqli_real_connect" => array( 
	"methodname" => "mysqli_real_connect", 
	"version" => "PHP5", 
	"method" => "Procedural stylebool mysqli_real_connect ( mysqli link [, string hostname [, string username [, string passwd [, string dbname [, int port [, string socket [, int flags]]]]]]] )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Opens a connection to a mysql server", 
	"docurl" => "function.mysqli-real-connect.html" 
),
"mysqli_real_escape_string" => array( 
	"methodname" => "mysqli_real_escape_string", 
	"version" => "PHP5", 
	"method" => "Procedural style:string mysqli_real_escape_string ( mysqli link, string escapestr )", 
	"snippet" => "( \${1:\$link}, \${2:\$escapestr} )", 
	"desc" => "Escapes special characters in a string for use in a SQL statement,   taking into account the current charset of the connection", 
	"docurl" => "function.mysqli-real-escape-string.html" 
),
"mysqli_real_query" => array( 
	"methodname" => "mysqli_real_query", 
	"version" => "PHP5", 
	"method" => "Procedural stylebool mysqli_real_query ( mysqli link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "Execute an SQL query", 
	"docurl" => "function.mysqli-real-query.html" 
),
"mysqli_report" => array( 
	"methodname" => "mysqli_report", 
	"version" => "PHP5", 
	"method" => "bool mysqli_report ( int flags )", 
	"snippet" => "( \${1:\$flags} )", 
	"desc" => "Enables or disables internal report functions", 
	"docurl" => "function.mysqli-report.html" 
),
"mysqli_rollback" => array( 
	"methodname" => "mysqli_rollback", 
	"version" => "PHP5", 
	"method" => "bool mysqli_rollback ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Rolls back current transaction", 
	"docurl" => "function.mysqli-rollback.html" 
),
"mysqli_rpl_parse_enabled" => array( 
	"methodname" => "mysqli_rpl_parse_enabled", 
	"version" => "PHP5", 
	"method" => "int mysqli_rpl_parse_enabled ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Check if RPL parse is enabled", 
	"docurl" => "function.mysqli-rpl-parse-enabled.html" 
),
"mysqli_rpl_probe" => array( 
	"methodname" => "mysqli_rpl_probe", 
	"version" => "PHP5", 
	"method" => "bool mysqli_rpl_probe ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "RPL probe", 
	"docurl" => "function.mysqli-rpl-probe.html" 
),
"mysqli_rpl_query_type" => array( 
	"methodname" => "mysqli_rpl_query_type", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_rpl_query_type ( mysqli link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "Returns RPL query type", 
	"docurl" => "function.mysqli-rpl-query-type.html" 
),
"mysqli_select_db" => array( 
	"methodname" => "mysqli_select_db", 
	"version" => "PHP5", 
	"method" => "bool mysqli_select_db ( mysqli link, string dbname )", 
	"snippet" => "( \${1:\$link}, \${2:\$dbname} )", 
	"desc" => "Selects the default database for database queries", 
	"docurl" => "function.mysqli-select-db.html" 
),
"mysqli_send_query" => array( 
	"methodname" => "mysqli_send_query", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_send_query ( mysqli link, string query )", 
	"snippet" => "( \${1:\$link}, \${2:\$query} )", 
	"desc" => "Send the query and return", 
	"docurl" => "function.mysqli-send-query.html" 
),
"mysqli_server_end" => array( 
	"methodname" => "mysqli_server_end", 
	"version" => "PHP5", 
	"method" => "void mysqli_server_end ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Shut down the embedded server", 
	"docurl" => "function.mysqli-server-end.html" 
),
"mysqli_server_init" => array( 
	"methodname" => "mysqli_server_init", 
	"version" => "PHP5", 
	"method" => "bool mysqli_server_init ( [array server [, array groups]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Initialize embedded server", 
	"docurl" => "function.mysqli-server-init.html" 
),
"mysqli_set_opt" => array( 
	"methodname" => "mysqli_set_opt", 
	"version" => "PHP5", 
	"method" => "Alias of mysqli_options()", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of mysqli_options()", 
	"docurl" => "function.mysqli-set-opt.html" 
),
"mysqli_sqlstate" => array( 
	"methodname" => "mysqli_sqlstate", 
	"version" => "PHP5", 
	"method" => "Procedural style:string mysqli_sqlstate ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns the SQLSTATE error from previous MySQL operation", 
	"docurl" => "function.mysqli-sqlstate.html" 
),
"mysqli_ssl_set" => array( 
	"methodname" => "mysqli_ssl_set", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_ssl_set ( mysqli link, string key, string cert, string ca, string capath, string cipher )", 
	"snippet" => "( \${1:\$link}, \${2:\$key}, \${3:\$cert}, \${4:\$ca}, \${5:\$capath}, \${6:\$cipher} )", 
	"desc" => "Used for establishing secure connections using SSL", 
	"docurl" => "function.mysqli-ssl-set.html" 
),
"mysqli_stat" => array( 
	"methodname" => "mysqli_stat", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_stat ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Gets the current system status", 
	"docurl" => "function.mysqli-stat.html" 
),
"mysqli_stmt_affected_rows" => array( 
	"methodname" => "mysqli_stmt_affected_rows", 
	"version" => "PHP5", 
	"method" => "Procedural style :mixed mysqli_stmt_affected_rows ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Returns the total number of rows changed, deleted, or   inserted by the last executed statement", 
	"docurl" => "function.mysqli-stmt-affected-rows.html" 
),
"mysqli_stmt_bind_param" => array( 
	"methodname" => "mysqli_stmt_bind_param", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_stmt_bind_param ( mysqli_stmt stmt, string types, mixed &var1 [, mixed &...] )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$types}, \${3:\$var1} )", 
	"desc" => "Binds variables to a prepared statement as parameters", 
	"docurl" => "function.mysqli-stmt-bind-param.html" 
),
"mysqli_stmt_bind_result" => array( 
	"methodname" => "mysqli_stmt_bind_result", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_stmt_bind_result ( mysqli_stmt stmt, mixed &var1 [, mixed &...] )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$var1} )", 
	"desc" => "Binds variables to a prepared statement for result storage", 
	"docurl" => "function.mysqli-stmt-bind-result.html" 
),
"mysqli_stmt_close" => array( 
	"methodname" => "mysqli_stmt_close", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_stmt_close ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Closes a prepared statement", 
	"docurl" => "function.mysqli-stmt-close.html" 
),
"mysqli_stmt_data_seek" => array( 
	"methodname" => "mysqli_stmt_data_seek", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_stmt_data_seek ( mysqli_stmt statement, int offset )", 
	"snippet" => "( \${1:\$statement}, \${2:\$offset} )", 
	"desc" => "Seeks to an arbitray row in statement result set", 
	"docurl" => "function.mysqli-stmt-data-seek.html" 
),
"mysqli_stmt_errno" => array( 
	"methodname" => "mysqli_stmt_errno", 
	"version" => "PHP5", 
	"method" => "Procedural style :int mysqli_stmt_errno ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Returns the error code for the most recent statement call", 
	"docurl" => "function.mysqli-stmt-errno.html" 
),
"mysqli_stmt_error" => array( 
	"methodname" => "mysqli_stmt_error", 
	"version" => "PHP5", 
	"method" => "Procedural style:string mysqli_stmt_error ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Returns a string description for last statement error", 
	"docurl" => "function.mysqli-stmt-error.html" 
),
"mysqli_stmt_execute" => array( 
	"methodname" => "mysqli_stmt_execute", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_stmt_execute ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Executes a prepared Query", 
	"docurl" => "function.mysqli-stmt-execute.html" 
),
"mysqli_stmt_fetch" => array( 
	"methodname" => "mysqli_stmt_fetch", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_stmt_fetch ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Fetch results from a prepared statement into the bound variables", 
	"docurl" => "function.mysqli-stmt-fetch.html" 
),
"mysqli_stmt_free_result" => array( 
	"methodname" => "mysqli_stmt_free_result", 
	"version" => "PHP5", 
	"method" => "Procedural style:void mysqli_stmt_free_result ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Frees stored result memory for the given statement handle", 
	"docurl" => "function.mysqli-stmt-free-result.html" 
),
"mysqli_stmt_init" => array( 
	"methodname" => "mysqli_stmt_init", 
	"version" => "PHP5", 
	"method" => "Procedural style :mysqli_stmt mysqli_stmt_init ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Initializes a statement and returns an object for use with mysqli_stmt_prepare", 
	"docurl" => "function.mysqli-stmt-init.html" 
),
"mysqli_stmt_num_rows" => array( 
	"methodname" => "mysqli_stmt_num_rows", 
	"version" => "PHP5", 
	"method" => "Procedural style :mixed mysqli_stmt_num_rows ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Return the number of rows in statements result set", 
	"docurl" => "function.mysqli-stmt-num-rows.html" 
),
"mysqli_stmt_param_count" => array( 
	"methodname" => "mysqli_stmt_param_count", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_stmt_param_count ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Returns the number of parameter for the given statement", 
	"docurl" => "function.mysqli-stmt-param-count.html" 
),
"mysqli_stmt_prepare" => array( 
	"methodname" => "mysqli_stmt_prepare", 
	"version" => "PHP5", 
	"method" => "Procedure style:bool mysqli_stmt_prepare ( mysqli_stmt stmt, string query )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$query} )", 
	"desc" => "Prepare a SQL statement for execution", 
	"docurl" => "function.mysqli-stmt-prepare.html" 
),
"mysqli_stmt_reset" => array( 
	"methodname" => "mysqli_stmt_reset", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_stmt_reset ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Resets a prepared statement", 
	"docurl" => "function.mysqli-stmt-reset.html" 
),
"mysqli_stmt_result_metadata" => array( 
	"methodname" => "mysqli_stmt_result_metadata", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_stmt_result_metadata ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Returns result set metadata from a prepared statement", 
	"docurl" => "function.mysqli-stmt-result-metadata.html" 
),
"mysqli_stmt_send_long_data" => array( 
	"methodname" => "mysqli_stmt_send_long_data", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_stmt_send_long_data ( mysqli_stmt stmt, int param_nr, string data )", 
	"snippet" => "( \${1:\$stmt}, \${2:\$param_nr}, \${3:\$data} )", 
	"desc" => "Send data in blocks", 
	"docurl" => "function.mysqli-stmt-send-long-data.html" 
),
"mysqli_stmt_sqlstate" => array( 
	"methodname" => "mysqli_stmt_sqlstate", 
	"version" => "PHP5", 
	"method" => "string mysqli_stmt_sqlstate ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Returns SQLSTATE error from previous statement operation", 
	"docurl" => "function.mysqli-stmt-sqlstate.html" 
),
"mysqli_stmt_store_result" => array( 
	"methodname" => "mysqli_stmt_store_result", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_stmt_store_result ( mysqli_stmt stmt )", 
	"snippet" => "( \${1:\$stmt} )", 
	"desc" => "Transfers a result set from a prepared statement", 
	"docurl" => "function.mysqli-stmt-store-result.html" 
),
"mysqli_store_result" => array( 
	"methodname" => "mysqli_store_result", 
	"version" => "PHP5", 
	"method" => "Procedural style:mysqli_result mysqli_store_result ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Transfers a result set from the last query", 
	"docurl" => "function.mysqli-store-result.html" 
),
"mysqli_thread_id" => array( 
	"methodname" => "mysqli_thread_id", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_thread_id ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns the thread ID for the current connection", 
	"docurl" => "function.mysqli-thread-id.html" 
),
"mysqli_thread_safe" => array( 
	"methodname" => "mysqli_thread_safe", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool mysqli_thread_safe ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns whether thread safety is given or not", 
	"docurl" => "function.mysqli-thread-safe.html" 
),
"mysqli_use_result" => array( 
	"methodname" => "mysqli_use_result", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed mysqli_use_result ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Initiate a result set retrieval", 
	"docurl" => "function.mysqli-use-result.html" 
),
"mysqli_warning_count" => array( 
	"methodname" => "mysqli_warning_count", 
	"version" => "PHP5", 
	"method" => "Procedural style:int mysqli_warning_count ( mysqli link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns the number of warnings from the last query for the given link", 
	"docurl" => "function.mysqli-warning-count.html" 
),

); # end of main array
?>