<?php
$_LOOKUP = array( 
"w32api_deftype" => array( 
	"methodname" => "w32api_deftype", 
	"version" => "undefined", 
	"method" => "bool w32api_deftype ( string typename, string member1_type, string member1_name [, string ... [, string ...]] )", 
	"snippet" => "( \${1:\$typename}, \${2:\$member1_type}, \${3:\$member1_name} )", 
	"desc" => "", 
	"docurl" => "function.w32api-deftype.html" 
),
"w32api_init_dtype" => array( 
	"methodname" => "w32api_init_dtype", 
	"version" => "undefined", 
	"method" => "resource w32api_init_dtype ( string typename, mixed value [, mixed ...] )", 
	"snippet" => "( \${1:\$typename}, \${2:\$value} )", 
	"desc" => "", 
	"docurl" => "function.w32api-init-dtype.html" 
),
"w32api_invoke_function" => array( 
	"methodname" => "w32api_invoke_function", 
	"version" => "undefined", 
	"method" => "mixed w32api_invoke_function ( string funcname, mixed argument [, mixed ...] )", 
	"snippet" => "( \${1:\$funcname}, \${2:\$argument} )", 
	"desc" => "", 
	"docurl" => "function.w32api-invoke-function.html" 
),
"w32api_register_function" => array( 
	"methodname" => "w32api_register_function", 
	"version" => "undefined", 
	"method" => "bool w32api_register_function ( string library, string function_name, string return_type )", 
	"snippet" => "( \${1:\$library}, \${2:\$function_name}, \${3:\$return_type} )", 
	"desc" => "", 
	"docurl" => "function.w32api-register-function.html" 
),
"w32api_set_call_method" => array( 
	"methodname" => "w32api_set_call_method", 
	"version" => "undefined", 
	"method" => "void w32api_set_call_method ( int method )", 
	"snippet" => "( \${1:\$method} )", 
	"desc" => "", 
	"docurl" => "function.w32api-set-call-method.html" 
),
"wddx_add_vars" => array( 
	"methodname" => "wddx_add_vars", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "bool wddx_add_vars ( int packet_id, mixed name_var [, mixed ...] )", 
	"snippet" => "( \${1:\$packet_id}, \${2:\$name_var} )", 
	"desc" => "Add variables to a WDDX packet with the specified ID", 
	"docurl" => "function.wddx-add-vars.html" 
),
"wddx_deserialize" => array( 
	"methodname" => "wddx_deserialize", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "mixed wddx_deserialize ( string packet )", 
	"snippet" => "( \${1:\$packet} )", 
	"desc" => "Deserializes a WDDX packet", 
	"docurl" => "function.wddx-deserialize.html" 
),
"wddx_packet_end" => array( 
	"methodname" => "wddx_packet_end", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string wddx_packet_end ( int packet_id )", 
	"snippet" => "( \${1:\$packet_id} )", 
	"desc" => "Ends a WDDX packet with the specified ID", 
	"docurl" => "function.wddx-packet-end.html" 
),
"wddx_packet_start" => array( 
	"methodname" => "wddx_packet_start", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int wddx_packet_start ( [string comment] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Starts a new WDDX packet with structure inside it", 
	"docurl" => "function.wddx-packet-start.html" 
),
"wddx_serialize_value" => array( 
	"methodname" => "wddx_serialize_value", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string wddx_serialize_value ( mixed var [, string comment] )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Serialize a single value into a WDDX packet", 
	"docurl" => "function.wddx-serialize-value.html" 
),
"wddx_serialize_vars" => array( 
	"methodname" => "wddx_serialize_vars", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string wddx_serialize_vars ( mixed var_name [, mixed ...] )", 
	"snippet" => "( \${1:\$var_name} )", 
	"desc" => "Serialize variables into a WDDX packet", 
	"docurl" => "function.wddx-serialize-vars.html" 
),
"wordwrap" => array( 
	"methodname" => "wordwrap", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string wordwrap ( string str [, int width [, string break [, bool cut]]] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Wraps a string to a given number of characters using a string   break character", 
	"docurl" => "function.wordwrap.html" 
),

); # end of main array
?>