<?php
$_LOOKUP = array( 
"uasort" => array( 
	"methodname" => "uasort", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "bool uasort ( array &array, callback cmp_function )", 
	"snippet" => "( \${1:\$array}, \${2:\$cmp_function} )", 
	"desc" => "Sort an array with a user-defined comparison function and   maintain index association", 
	"docurl" => "function.uasort.html" 
),
"ucfirst" => array( 
	"methodname" => "ucfirst", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string ucfirst ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Make a string\'s first character uppercase", 
	"docurl" => "function.ucfirst.html" 
),
"ucwords" => array( 
	"methodname" => "ucwords", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "string ucwords ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Uppercase the first character of each word in a string", 
	"docurl" => "function.ucwords.html" 
),
"udm_add_search_limit" => array( 
	"methodname" => "udm_add_search_limit", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool udm_add_search_limit ( resource agent, int var, string val )", 
	"snippet" => "( \${1:\$agent}, \${2:\$var}, \${3:\$val} )", 
	"desc" => "Add various search limits", 
	"docurl" => "function.udm-add-search-limit.html" 
),
"udm_alloc_agent_array" => array( 
	"methodname" => "udm_alloc_agent_array", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "resource udm_alloc_agent_array ( array databases )", 
	"snippet" => "( \${1:\$databases} )", 
	"desc" => "Allocate mnoGoSearch session", 
	"docurl" => "function.udm-alloc-agent-array.html" 
),
"udm_alloc_agent" => array( 
	"methodname" => "udm_alloc_agent", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "resource udm_alloc_agent ( string dbaddr [, string dbmode] )", 
	"snippet" => "( \${1:\$dbaddr} )", 
	"desc" => "Allocate mnoGoSearch session", 
	"docurl" => "function.udm-alloc-agent.html" 
),
"udm_api_version" => array( 
	"methodname" => "udm_api_version", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int udm_api_version ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get mnoGoSearch API version", 
	"docurl" => "function.udm-api-version.html" 
),
"udm_cat_list" => array( 
	"methodname" => "udm_cat_list", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array udm_cat_list ( resource agent, string category )", 
	"snippet" => "( \${1:\$agent}, \${2:\$category} )", 
	"desc" => "Get all the categories on the same level with the current one", 
	"docurl" => "function.udm-cat-list.html" 
),
"udm_cat_path" => array( 
	"methodname" => "udm_cat_path", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "array udm_cat_path ( resource agent, string category )", 
	"snippet" => "( \${1:\$agent}, \${2:\$category} )", 
	"desc" => "Get the path to the current category", 
	"docurl" => "function.udm-cat-path.html" 
),
"udm_check_charset" => array( 
	"methodname" => "udm_check_charset", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool udm_check_charset ( resource agent, string charset )", 
	"snippet" => "( \${1:\$agent}, \${2:\$charset} )", 
	"desc" => "Check if the given charset is known to mnogosearch", 
	"docurl" => "function.udm-check-charset.html" 
),
"udm_check_stored" => array( 
	"methodname" => "udm_check_stored", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int udm_check_stored ( resource agent, int link, string doc_id )", 
	"snippet" => "( \${1:\$agent}, \${2:\$link}, \${3:\$doc_id} )", 
	"desc" => "Check connection to stored", 
	"docurl" => "function.udm-check-stored.html" 
),
"udm_clear_search_limits" => array( 
	"methodname" => "udm_clear_search_limits", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool udm_clear_search_limits ( resource agent )", 
	"snippet" => "( \${1:\$agent} )", 
	"desc" => "Clear all mnoGoSearch search restrictions", 
	"docurl" => "function.udm-clear-search-limits.html" 
),
"udm_close_stored" => array( 
	"methodname" => "udm_close_stored", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int udm_close_stored ( resource agent, int link )", 
	"snippet" => "( \${1:\$agent}, \${2:\$link} )", 
	"desc" => "Close connection to stored", 
	"docurl" => "function.udm-close-stored.html" 
),
"udm_crc32" => array( 
	"methodname" => "udm_crc32", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int udm_crc32 ( resource agent, string str )", 
	"snippet" => "( \${1:\$agent}, \${2:\$str} )", 
	"desc" => "Return CRC32 checksum of given string", 
	"docurl" => "function.udm-crc32.html" 
),
"udm_errno" => array( 
	"methodname" => "udm_errno", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int udm_errno ( resource agent )", 
	"snippet" => "( \${1:\$agent} )", 
	"desc" => "Get mnoGoSearch error number", 
	"docurl" => "function.udm-errno.html" 
),
"udm_error" => array( 
	"methodname" => "udm_error", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string udm_error ( resource agent )", 
	"snippet" => "( \${1:\$agent} )", 
	"desc" => "Get mnoGoSearch error message", 
	"docurl" => "function.udm-error.html" 
),
"udm_find" => array( 
	"methodname" => "udm_find", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "resource udm_find ( resource agent, string query )", 
	"snippet" => "( \${1:\$agent}, \${2:\$query} )", 
	"desc" => "Perform search", 
	"docurl" => "function.udm-find.html" 
),
"udm_free_agent" => array( 
	"methodname" => "udm_free_agent", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int udm_free_agent ( resource agent )", 
	"snippet" => "( \${1:\$agent} )", 
	"desc" => "Free mnoGoSearch session", 
	"docurl" => "function.udm-free-agent.html" 
),
"udm_free_ispell_data" => array( 
	"methodname" => "udm_free_ispell_data", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool udm_free_ispell_data ( int agent )", 
	"snippet" => "( \${1:\$agent} )", 
	"desc" => "Free memory allocated for ispell data", 
	"docurl" => "function.udm-free-ispell-data.html" 
),
"udm_free_res" => array( 
	"methodname" => "udm_free_res", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool udm_free_res ( resource res )", 
	"snippet" => "( \${1:\$res} )", 
	"desc" => "Free mnoGoSearch result", 
	"docurl" => "function.udm-free-res.html" 
),
"udm_get_doc_count" => array( 
	"methodname" => "udm_get_doc_count", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "int udm_get_doc_count ( resource agent )", 
	"snippet" => "( \${1:\$agent} )", 
	"desc" => "Get total number of documents in database", 
	"docurl" => "function.udm-get-doc-count.html" 
),
"udm_get_res_field" => array( 
	"methodname" => "udm_get_res_field", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string udm_get_res_field ( resource res, int row, int field )", 
	"snippet" => "( \${1:\$res}, \${2:\$row}, \${3:\$field} )", 
	"desc" => "Fetch mnoGoSearch result field", 
	"docurl" => "function.udm-get-res-field.html" 
),
"udm_get_res_param" => array( 
	"methodname" => "udm_get_res_param", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "string udm_get_res_param ( resource res, int param )", 
	"snippet" => "( \${1:\$res}, \${2:\$param} )", 
	"desc" => "Get mnoGoSearch result parameters", 
	"docurl" => "function.udm-get-res-param.html" 
),
"udm_hash32" => array( 
	"methodname" => "udm_hash32", 
	"version" => "PHP4 >= 4.3.3, PHP5", 
	"method" => "int udm_hash32 ( resource agent, string str )", 
	"snippet" => "( \${1:\$agent}, \${2:\$str} )", 
	"desc" => "Return Hash32 checksum of gived string", 
	"docurl" => "function.udm-hash32.html" 
),
"udm_load_ispell_data" => array( 
	"methodname" => "udm_load_ispell_data", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool udm_load_ispell_data ( resource agent, int var, string val1, string val2, int flag )", 
	"snippet" => "( \${1:\$agent}, \${2:\$var}, \${3:\$val1}, \${4:\$val2}, \${5:\$flag} )", 
	"desc" => "Load ispell data", 
	"docurl" => "function.udm-load-ispell-data.html" 
),
"udm_open_stored" => array( 
	"methodname" => "udm_open_stored", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "int udm_open_stored ( resource agent, string storedaddr )", 
	"snippet" => "( \${1:\$agent}, \${2:\$storedaddr} )", 
	"desc" => "Open connection to stored", 
	"docurl" => "function.udm-open-stored.html" 
),
"udm_set_agent_param" => array( 
	"methodname" => "udm_set_agent_param", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool udm_set_agent_param ( resource agent, int var, string val )", 
	"snippet" => "( \${1:\$agent}, \${2:\$var}, \${3:\$val} )", 
	"desc" => "Set mnoGoSearch agent session parameters", 
	"docurl" => "function.udm-set-agent-param.html" 
),
"uksort" => array( 
	"methodname" => "uksort", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "bool uksort ( array &array, callback cmp_function )", 
	"snippet" => "( \${1:\$array}, \${2:\$cmp_function} )", 
	"desc" => "Sort an array by keys using a user-defined comparison function", 
	"docurl" => "function.uksort.html" 
),
"umask" => array( 
	"methodname" => "umask", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int umask ( [int mask] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Changes the current umask", 
	"docurl" => "function.umask.html" 
),
"uniqid" => array( 
	"methodname" => "uniqid", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string uniqid ( [string prefix [, bool more_entropy]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Generate a unique ID", 
	"docurl" => "function.uniqid.html" 
),
"unixtojd" => array( 
	"methodname" => "unixtojd", 
	"version" => "PHP4, PHP5", 
	"method" => "int unixtojd ( [int timestamp] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Convert Unix timestamp to Julian Day", 
	"docurl" => "function.unixtojd.html" 
),
"unlink" => array( 
	"methodname" => "unlink", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool unlink ( string filename [, resource context] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Deletes a file", 
	"docurl" => "function.unlink.html" 
),
"unpack" => array( 
	"methodname" => "unpack", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array unpack ( string format, string data )", 
	"snippet" => "( \${1:\$format}, \${2:\$data} )", 
	"desc" => "Unpack data from binary string", 
	"docurl" => "function.unpack.html" 
),
"unregister_tick_function" => array( 
	"methodname" => "unregister_tick_function", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "void unregister_tick_function ( string function_name )", 
	"snippet" => "( \${1:\$function_name} )", 
	"desc" => "De-register a function for execution on each tick", 
	"docurl" => "function.unregister-tick-function.html" 
),
"unserialize" => array( 
	"methodname" => "unserialize", 
	"version" => "PHP3>= 3.0.5, PHP4, PHP5", 
	"method" => "mixed unserialize ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Creates a PHP value from a stored representation", 
	"docurl" => "function.unserialize.html" 
),
"unset" => array( 
	"methodname" => "unset", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void unset ( mixed var [, mixed var [, mixed ...]] )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Unset a given variable", 
	"docurl" => "function.unset.html" 
),
"urldecode" => array( 
	"methodname" => "urldecode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string urldecode ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Decodes URL-encoded string", 
	"docurl" => "function.urldecode.html" 
),
"urlencode" => array( 
	"methodname" => "urlencode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string urlencode ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "URL-encodes string", 
	"docurl" => "function.urlencode.html" 
),
"use_soap_error_handler" => array( 
	"methodname" => "use_soap_error_handler", 
	"version" => "undefined", 
	"method" => "void use_soap_error_handler ( [bool handler] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.use-soap-error-handler.html" 
),
"user_error" => array( 
	"methodname" => "user_error", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool trigger_error ( string error_msg [, int error_type] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of trigger_error()\nGenerates a user-level error/warning/notice message", 
	"docurl" => "function.user-error.html" 
),
"usleep" => array( 
	"methodname" => "usleep", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void usleep ( int micro_seconds )", 
	"snippet" => "( \${1:\$micro_seconds} )", 
	"desc" => "Delay execution in microseconds", 
	"docurl" => "function.usleep.html" 
),
"usort" => array( 
	"methodname" => "usort", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "bool usort ( array &array, callback cmp_function )", 
	"snippet" => "( \${1:\$array}, \${2:\$cmp_function} )", 
	"desc" => "Sort an array by values using a user-defined comparison function", 
	"docurl" => "function.usort.html" 
),
"utf8_decode" => array( 
	"methodname" => "utf8_decode", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string utf8_decode ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Converts a string with ISO-8859-1 characters encoded with UTF-8   to single-byte ISO-8859-1", 
	"docurl" => "function.utf8-decode.html" 
),
"utf8_encode" => array( 
	"methodname" => "utf8_encode", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string utf8_encode ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Encodes an ISO-8859-1 string to UTF-8", 
	"docurl" => "function.utf8-encode.html" 
),

); # end of main array
?>