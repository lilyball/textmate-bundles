<?php
$_LOOKUP = array( 
"yaz_addinfo" => array( 
	"methodname" => "yaz_addinfo", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "string yaz_addinfo ( resource id )", 
	"snippet" => "( \${1:\$id} )", 
	"desc" => "Returns additional error information", 
	"docurl" => "function.yaz-addinfo.html" 
),
"yaz_ccl_conf" => array( 
	"methodname" => "yaz_ccl_conf", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int yaz_ccl_conf ( resource id, array config )", 
	"snippet" => "( \${1:\$id}, \${2:\$config} )", 
	"desc" => "Configure CCL parser", 
	"docurl" => "function.yaz-ccl-conf.html" 
),
"yaz_ccl_parse" => array( 
	"methodname" => "yaz_ccl_parse", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool yaz_ccl_parse ( resource id, string query, array &result )", 
	"snippet" => "( \${1:\$id}, \${2:\$query}, \${3:\$result} )", 
	"desc" => "Invoke CCL Parser", 
	"docurl" => "function.yaz-ccl-parse.html" 
),
"yaz_close" => array( 
	"methodname" => "yaz_close", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool yaz_close ( resource id )", 
	"snippet" => "( \${1:\$id} )", 
	"desc" => "Close YAZ connection", 
	"docurl" => "function.yaz-close.html" 
),
"yaz_connect" => array( 
	"methodname" => "yaz_connect", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "resource yaz_connect ( string zurl [, mixed options] )", 
	"snippet" => "( \${1:\$zurl} )", 
	"desc" => "Prepares for a connection to a Z39.50 server", 
	"docurl" => "function.yaz-connect.html" 
),
"yaz_database" => array( 
	"methodname" => "yaz_database", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool yaz_database ( resource id, string databases )", 
	"snippet" => "( \${1:\$id}, \${2:\$databases} )", 
	"desc" => "Specifies the databases within a session", 
	"docurl" => "function.yaz-database.html" 
),
"yaz_element" => array( 
	"methodname" => "yaz_element", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool yaz_element ( resource id, string elementset )", 
	"snippet" => "( \${1:\$id}, \${2:\$elementset} )", 
	"desc" => "Specifies Element-Set Name for retrieval", 
	"docurl" => "function.yaz-element.html" 
),
"yaz_errno" => array( 
	"methodname" => "yaz_errno", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "int yaz_errno ( resource id )", 
	"snippet" => "( \${1:\$id} )", 
	"desc" => "Returns error number", 
	"docurl" => "function.yaz-errno.html" 
),
"yaz_error" => array( 
	"methodname" => "yaz_error", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "string yaz_error ( resource id )", 
	"snippet" => "( \${1:\$id} )", 
	"desc" => "Returns error description", 
	"docurl" => "function.yaz-error.html" 
),
"yaz_es_result" => array( 
	"methodname" => "yaz_es_result", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array yaz_es_result ( resource id )", 
	"snippet" => "( \${1:\$id} )", 
	"desc" => "Inspects Extended Services Result", 
	"docurl" => "function.yaz-es-result.html" 
),
"yaz_get_option" => array( 
	"methodname" => "yaz_get_option", 
	"version" => "PHP5", 
	"method" => "string yaz_get_option ( resource id, string name )", 
	"snippet" => "( \${1:\$id}, \${2:\$name} )", 
	"desc" => "Returns value of option for connection", 
	"docurl" => "function.yaz-get-option.html" 
),
"yaz_hits" => array( 
	"methodname" => "yaz_hits", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "int yaz_hits ( resource id )", 
	"snippet" => "( \${1:\$id} )", 
	"desc" => "Returns number of hits for last search", 
	"docurl" => "function.yaz-hits.html" 
),
"yaz_itemorder" => array( 
	"methodname" => "yaz_itemorder", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int yaz_itemorder ( resource id, array args )", 
	"snippet" => "( \${1:\$id}, \${2:\$args} )", 
	"desc" => "Prepares for Z39.50 Item Order with an ILL-Request package", 
	"docurl" => "function.yaz-itemorder.html" 
),
"yaz_present" => array( 
	"methodname" => "yaz_present", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool yaz_present ( resource id )", 
	"snippet" => "( \${1:\$id} )", 
	"desc" => "Prepares for retrieval (Z39.50 present)", 
	"docurl" => "function.yaz-present.html" 
),
"yaz_range" => array( 
	"methodname" => "yaz_range", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool yaz_range ( resource id, int start, int number )", 
	"snippet" => "( \${1:\$id}, \${2:\$start}, \${3:\$number} )", 
	"desc" => "Specifies the maximum number of records to retrieve", 
	"docurl" => "function.yaz-range.html" 
),
"yaz_record" => array( 
	"methodname" => "yaz_record", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "string yaz_record ( resource id, int pos, string type )", 
	"snippet" => "( \${1:\$id}, \${2:\$pos}, \${3:\$type} )", 
	"desc" => "Returns a record", 
	"docurl" => "function.yaz-record.html" 
),
"yaz_scan_result" => array( 
	"methodname" => "yaz_scan_result", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "array yaz_scan_result ( resource id [, array &result] )", 
	"snippet" => "( \${1:\$id} )", 
	"desc" => "Returns Scan Response result", 
	"docurl" => "function.yaz-scan-result.html" 
),
"yaz_scan" => array( 
	"methodname" => "yaz_scan", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int yaz_scan ( resource id, string type, string startterm [, array flags] )", 
	"snippet" => "( \${1:\$id}, \${2:\$type}, \${3:\$startterm} )", 
	"desc" => "Prepares for a scan", 
	"docurl" => "function.yaz-scan.html" 
),
"yaz_schema" => array( 
	"methodname" => "yaz_schema", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int yaz_schema ( resource id, string schema )", 
	"snippet" => "( \${1:\$id}, \${2:\$schema} )", 
	"desc" => "Specifies schema for retrieval", 
	"docurl" => "function.yaz-schema.html" 
),
"yaz_search" => array( 
	"methodname" => "yaz_search", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "int yaz_search ( resource id, string type, string query )", 
	"snippet" => "( \${1:\$id}, \${2:\$type}, \${3:\$query} )", 
	"desc" => "Prepares for a search", 
	"docurl" => "function.yaz-search.html" 
),
"yaz_set_option" => array( 
	"methodname" => "yaz_set_option", 
	"version" => "PHP5", 
	"method" => "string yaz_set_option ( resource id, string name, string value )", 
	"snippet" => "( \${1:\$id}, \${2:\$name}, \${3:\$value} )", 
	"desc" => "Sets one or more options for connection", 
	"docurl" => "function.yaz-set-option.html" 
),
"yaz_sort" => array( 
	"methodname" => "yaz_sort", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int yaz_sort ( resource id, string criteria )", 
	"snippet" => "( \${1:\$id}, \${2:\$criteria} )", 
	"desc" => "Sets sorting criteria", 
	"docurl" => "function.yaz-sort.html" 
),
"yaz_syntax" => array( 
	"methodname" => "yaz_syntax", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "int yaz_syntax ( resource id, string syntax )", 
	"snippet" => "( \${1:\$id}, \${2:\$syntax} )", 
	"desc" => "Specifies the preferred record syntax for retrieval", 
	"docurl" => "function.yaz-syntax.html" 
),
"yaz_wait" => array( 
	"methodname" => "yaz_wait", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "int yaz_wait ( [array &options] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Wait for Z39.50 requests to complete", 
	"docurl" => "function.yaz-wait.html" 
),
"yp_all" => array( 
	"methodname" => "yp_all", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "void yp_all ( string domain, string map, string callback )", 
	"snippet" => "( \${1:\$domain}, \${2:\$map}, \${3:\$callback} )", 
	"desc" => "Traverse the map and call a function on each entry", 
	"docurl" => "function.yp-all.html" 
),
"yp_cat" => array( 
	"methodname" => "yp_cat", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array yp_cat ( string domain, string map )", 
	"snippet" => "( \${1:\$domain}, \${2:\$map} )", 
	"desc" => "Return an array containing the entire map", 
	"docurl" => "function.yp-cat.html" 
),
"yp_err_string" => array( 
	"methodname" => "yp_err_string", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "string yp_err_string ( int errorcode )", 
	"snippet" => "( \${1:\$errorcode} )", 
	"desc" => "Returns the error string associated with the given error code", 
	"docurl" => "function.yp-err-string.html" 
),
"yp_errno" => array( 
	"methodname" => "yp_errno", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "int yp_errno ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the error code of the previous operation", 
	"docurl" => "function.yp-errno.html" 
),
"yp_first" => array( 
	"methodname" => "yp_first", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "array yp_first ( string domain, string map )", 
	"snippet" => "( \${1:\$domain}, \${2:\$map} )", 
	"desc" => "Returns the first key-value pair from the named map", 
	"docurl" => "function.yp-first.html" 
),
"yp_get_default_domain" => array( 
	"methodname" => "yp_get_default_domain", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int yp_get_default_domain ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Fetches the machine\'s default NIS domain", 
	"docurl" => "function.yp-get-default-domain.html" 
),
"yp_master" => array( 
	"methodname" => "yp_master", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string yp_master ( string domain, string map )", 
	"snippet" => "( \${1:\$domain}, \${2:\$map} )", 
	"desc" => "Returns the machine name of the master NIS server for a map", 
	"docurl" => "function.yp-master.html" 
),
"yp_match" => array( 
	"methodname" => "yp_match", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string yp_match ( string domain, string map, string key )", 
	"snippet" => "( \${1:\$domain}, \${2:\$map}, \${3:\$key} )", 
	"desc" => "Returns the matched line", 
	"docurl" => "function.yp-match.html" 
),
"yp_next" => array( 
	"methodname" => "yp_next", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "array yp_next ( string domain, string map, string key )", 
	"snippet" => "( \${1:\$domain}, \${2:\$map}, \${3:\$key} )", 
	"desc" => "Returns the next key-value pair in the named map", 
	"docurl" => "function.yp-next.html" 
),
"yp_order" => array( 
	"methodname" => "yp_order", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int yp_order ( string domain, string map )", 
	"snippet" => "( \${1:\$domain}, \${2:\$map} )", 
	"desc" => "Returns the order number for a map", 
	"docurl" => "function.yp-order.html" 
),

); # end of main array
?>