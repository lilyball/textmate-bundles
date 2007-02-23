<?php
$_LOOKUP = array( 
"tan" => array( 
	"methodname" => "tan", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float tan ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Tangent", 
	"docurl" => "function.tan.html" 
),
"tanh" => array( 
	"methodname" => "tanh", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float tanh ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Hyperbolic tangent", 
	"docurl" => "function.tanh.html" 
),
"tcpwrap_check" => array( 
	"methodname" => "tcpwrap_check", 
	"version" => "undefined", 
	"method" => "bool tcpwrap_check ( string daemon, string address [, string user [, bool nodns]] )", 
	"snippet" => "( \${1:\$daemon}, \${2:\$address} )", 
	"desc" => "", 
	"docurl" => "function.tcpwrap-check.html" 
),
"tempnam" => array( 
	"methodname" => "tempnam", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string tempnam ( string dir, string prefix )", 
	"snippet" => "( \${1:\$dir}, \${2:\$prefix} )", 
	"desc" => "Create file with unique file name", 
	"docurl" => "function.tempnam.html" 
),
"textdomain" => array( 
	"methodname" => "textdomain", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string textdomain ( string text_domain )", 
	"snippet" => "( \${1:\$text_domain} )", 
	"desc" => "Sets the default domain", 
	"docurl" => "function.textdomain.html" 
),
"tidy_access_count" => array( 
	"methodname" => "tidy_access_count", 
	"version" => "PHP5", 
	"method" => "int tidy_access_count ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Returns the Number of Tidy accessibility warnings encountered for specified document", 
	"docurl" => "function.tidy-access-count.html" 
),
"tidy_clean_repair" => array( 
	"methodname" => "tidy_clean_repair", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool tidy_clean_repair ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Execute configured cleanup and repair operations on parsed markup", 
	"docurl" => "function.tidy-clean-repair.html" 
),
"tidy_config_count" => array( 
	"methodname" => "tidy_config_count", 
	"version" => "PHP5", 
	"method" => "int tidy_config_count ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Returns the Number of Tidy configuration errors encountered for specified document", 
	"docurl" => "function.tidy-config-count.html" 
),
"tidy_diagnose" => array( 
	"methodname" => "tidy_diagnose", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool tidy_diagnose ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Run configured diagnostics on parsed and repaired markup", 
	"docurl" => "function.tidy-diagnose.html" 
),
"tidy_error_count" => array( 
	"methodname" => "tidy_error_count", 
	"version" => "PHP5", 
	"method" => "int tidy_error_count ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Returns the Number of Tidy errors encountered for specified document", 
	"docurl" => "function.tidy-error-count.html" 
),
"tidy_get_body" => array( 
	"methodname" => "tidy_get_body", 
	"version" => "PHP5", 
	"method" => "Procedural style:tidyNode tidy_get_body ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Returns a tidyNode Object starting from the &#60;body&#62; tag of the tidy parse tree", 
	"docurl" => "function.tidy-get-body.html" 
),
"tidy_get_config" => array( 
	"methodname" => "tidy_get_config", 
	"version" => "PHP5", 
	"method" => "Procedural style:array tidy_get_config ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Get current Tidy configuration", 
	"docurl" => "function.tidy-get-config.html" 
),
"tidy_get_error_buffer" => array( 
	"methodname" => "tidy_get_error_buffer", 
	"version" => "PHP5", 
	"method" => "Procedural style:string tidy_get_error_buffer ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Return warnings and errors which occurred parsing the specified document", 
	"docurl" => "function.tidy-get-error-buffer.html" 
),
"tidy_get_head" => array( 
	"methodname" => "tidy_get_head", 
	"version" => "PHP5", 
	"method" => "Procedural style:tidyNode tidy_get_head ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Returns a tidyNode Object starting from the &#60;head&#62; tag of the tidy parse tree", 
	"docurl" => "function.tidy-get-head.html" 
),
"tidy_get_html_ver" => array( 
	"methodname" => "tidy_get_html_ver", 
	"version" => "PHP5", 
	"method" => "Procedural style:int tidy_get_html_ver ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Get the Detected HTML version for the specified document", 
	"docurl" => "function.tidy-get-html-ver.html" 
),
"tidy_get_html" => array( 
	"methodname" => "tidy_get_html", 
	"version" => "PHP5", 
	"method" => "Procedural style:tidyNode tidy_get_html ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Returns a tidyNode Object starting from the &#60;html&#62; tag of the tidy parse tree", 
	"docurl" => "function.tidy-get-html.html" 
),
"tidy_get_output" => array( 
	"methodname" => "tidy_get_output", 
	"version" => "PHP5", 
	"method" => "string tidy_get_output ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Return a string representing the parsed tidy markup", 
	"docurl" => "function.tidy-get-output.html" 
),
"tidy_get_release" => array( 
	"methodname" => "tidy_get_release", 
	"version" => "PHP5", 
	"method" => "Procedural style:string tidy_get_release ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get release date (version) for Tidy library", 
	"docurl" => "function.tidy-get-release.html" 
),
"tidy_get_root" => array( 
	"methodname" => "tidy_get_root", 
	"version" => "PHP5", 
	"method" => "Procedural style:tidyNode tidy_get_root ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Returns a tidyNode object representing the root of the tidy parse tree", 
	"docurl" => "function.tidy-get-root.html" 
),
"tidy_get_status" => array( 
	"methodname" => "tidy_get_status", 
	"version" => "PHP5", 
	"method" => "Procedural style:int tidy_get_status ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Get status of specified document", 
	"docurl" => "function.tidy-get-status.html" 
),
"tidy_getopt" => array( 
	"methodname" => "tidy_getopt", 
	"version" => "PHP5", 
	"method" => "Procedural style:mixed tidy_getopt ( tidy object, string option )", 
	"snippet" => "( \${1:\$object}, \${2:\$option} )", 
	"desc" => "Returns the value of the specified configuration option for the tidy document", 
	"docurl" => "function.tidy-getopt.html" 
),
"tidy_is_xhtml" => array( 
	"methodname" => "tidy_is_xhtml", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool tidy_is_xhtml ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Indicates if the document is a XHTML document", 
	"docurl" => "function.tidy-is-xhtml.html" 
),
"tidy_is_xml" => array( 
	"methodname" => "tidy_is_xml", 
	"version" => "PHP5", 
	"method" => "Procedural style:bool tidy_is_xml ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Indicates if the document is a generic (non HTML/XHTML) XML document", 
	"docurl" => "function.tidy-is-xml.html" 
),
"tidy_load_config" => array( 
	"methodname" => "tidy_load_config", 
	"version" => "undefined", 
	"method" => "void tidy_load_config ( string filename, string encoding )", 
	"snippet" => "( \${1:\$filename}, \${2:\$encoding} )", 
	"desc" => "", 
	"docurl" => "function.tidy-load-config.html" 
),
"tidy_node_children" => array( 
	"methodname" => "tidy_node_children", 
	"version" => "undefined", 
	"method" => "array tidy_node-&#62;children ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-children.html" 
),
"tidy_node_get_attr" => array( 
	"methodname" => "tidy_node_get_attr", 
	"version" => "undefined", 
	"method" => "tidy_attr tidy_node-&#62;get_attr ( int attrib_id )", 
	"snippet" => "( \${1:\$attrib_id} )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-get-attr.html" 
),
"tidy_node_get_nodes" => array( 
	"methodname" => "tidy_node_get_nodes", 
	"version" => "undefined", 
	"method" => "array tidy_node-&#62;get_nodes ( int node_id )", 
	"snippet" => "( \${1:\$node_id} )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-get-nodes.html" 
),
"tidy_node_haschildren" => array( 
	"methodname" => "tidy_node_haschildren", 
	"version" => "undefined", 
	"method" => "bool tidy_node-&#62;hasChildren ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-haschildren.html" 
),
"tidy_node_hassiblings" => array( 
	"methodname" => "tidy_node_hassiblings", 
	"version" => "undefined", 
	"method" => "bool tidy_node-&#62;hasSiblings ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-hassiblings.html" 
),
"tidy_node_iscomment" => array( 
	"methodname" => "tidy_node_iscomment", 
	"version" => "undefined", 
	"method" => "bool tidy_node-&#62;isComment ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-iscomment.html" 
),
"tidy_node_ishtml" => array( 
	"methodname" => "tidy_node_ishtml", 
	"version" => "undefined", 
	"method" => "bool tidy_node-&#62;isHtml ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-ishtml.html" 
),
"tidy_node_isjste" => array( 
	"methodname" => "tidy_node_isjste", 
	"version" => "undefined", 
	"method" => "bool tidy_node-&#62;isJste ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-isjste.html" 
),
"tidy_node_istext" => array( 
	"methodname" => "tidy_node_istext", 
	"version" => "undefined", 
	"method" => "bool tidy_node-&#62;isText ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-istext.html" 
),
"tidy_node_isxhtml" => array( 
	"methodname" => "tidy_node_isxhtml", 
	"version" => "undefined", 
	"method" => "bool tidy_node-&#62;isXhtml ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-isxhtml.html" 
),
"tidy_node_isxml" => array( 
	"methodname" => "tidy_node_isxml", 
	"version" => "undefined", 
	"method" => "bool tidy_node-&#62;isXml ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-isxml.html" 
),
"tidy_node_next" => array( 
	"methodname" => "tidy_node_next", 
	"version" => "undefined", 
	"method" => "tidy_node tidy_node-&#62;next ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-next.html" 
),
"tidy_node_prev" => array( 
	"methodname" => "tidy_node_prev", 
	"version" => "undefined", 
	"method" => "tidy_node tidy_node-&#62;prev ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-node-prev.html" 
),
"tidy_parse_file" => array( 
	"methodname" => "tidy_parse_file", 
	"version" => "PHP5", 
	"method" => "Procedural style:tidy tidy_parse_file ( string filename [, mixed config [, string encoding [, bool use_include_path]]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Parse markup in file or URI", 
	"docurl" => "function.tidy-parse-file.html" 
),
"tidy_parse_string" => array( 
	"methodname" => "tidy_parse_string", 
	"version" => "PHP5", 
	"method" => "Procedural style:tidy tidy_parse_string ( string input [, mixed config [, string encoding]] )", 
	"snippet" => "( \${1:\$input} )", 
	"desc" => "Parse a document stored in a string", 
	"docurl" => "function.tidy-parse-string.html" 
),
"tidy_repair_file" => array( 
	"methodname" => "tidy_repair_file", 
	"version" => "PHP5", 
	"method" => "string tidy_repair_file ( string filename [, mixed config [, string encoding [, bool use_include_path]]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Repair a file and return it as a string", 
	"docurl" => "function.tidy-repair-file.html" 
),
"tidy_repair_string" => array( 
	"methodname" => "tidy_repair_string", 
	"version" => "PHP5", 
	"method" => "string tidy_repair_string ( string data [, mixed config [, string encoding]] )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Repair a string using an optionally provided configuration file", 
	"docurl" => "function.tidy-repair-string.html" 
),
"tidy_reset_config" => array( 
	"methodname" => "tidy_reset_config", 
	"version" => "undefined", 
	"method" => "bool tidy_reset_config ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidy-reset-config.html" 
),
"tidy_save_config" => array( 
	"methodname" => "tidy_save_config", 
	"version" => "undefined", 
	"method" => "bool tidy_save_config ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.tidy-save-config.html" 
),
"tidy_set_encoding" => array( 
	"methodname" => "tidy_set_encoding", 
	"version" => "undefined", 
	"method" => "bool tidy_set_encoding ( string encoding )", 
	"snippet" => "( \${1:\$encoding} )", 
	"desc" => "", 
	"docurl" => "function.tidy-set-encoding.html" 
),
"tidy_setopt" => array( 
	"methodname" => "tidy_setopt", 
	"version" => "undefined", 
	"method" => "bool tidy_setopt ( string option, mixed value )", 
	"snippet" => "( \${1:\$option}, \${2:\$value} )", 
	"desc" => "", 
	"docurl" => "function.tidy-setopt.html" 
),
"tidy_warning_count" => array( 
	"methodname" => "tidy_warning_count", 
	"version" => "PHP5", 
	"method" => "int tidy_warning_count ( tidy object )", 
	"snippet" => "( \${1:\$object} )", 
	"desc" => "Returns the Number of Tidy warnings encountered for specified document", 
	"docurl" => "function.tidy-warning-count.html" 
),
"tidynode_isasp" => array( 
	"methodname" => "tidynode_isasp", 
	"version" => "undefined", 
	"method" => "bool tidyNode-&#62;isAsp ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidynode-isasp.html" 
),
"tidynode_isphp" => array( 
	"methodname" => "tidynode_isphp", 
	"version" => "undefined", 
	"method" => "bool tidyNode-&#62;isPhp ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.tidynode-isphp.html" 
),
"time_nanosleep" => array( 
	"methodname" => "time_nanosleep", 
	"version" => "PHP5", 
	"method" => "mixed time_nanosleep ( int seconds, int nanoseconds )", 
	"snippet" => "( \${1:\$seconds}, \${2:\$nanoseconds} )", 
	"desc" => "Delay for a number of seconds and nanoseconds", 
	"docurl" => "function.time-nanosleep.html" 
),
"time" => array( 
	"methodname" => "time", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int time ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Return current Unix timestamp", 
	"docurl" => "function.time.html" 
),
"tmpfile" => array( 
	"methodname" => "tmpfile", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "resource tmpfile ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Creates a temporary file", 
	"docurl" => "function.tmpfile.html" 
),
"token_get_all" => array( 
	"methodname" => "token_get_all", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array token_get_all ( string source )", 
	"snippet" => "( \${1:\$source} )", 
	"desc" => "Split given source into PHP tokens", 
	"docurl" => "function.token-get-all.html" 
),
"token_name" => array( 
	"methodname" => "token_name", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string token_name ( int token )", 
	"snippet" => "( \${1:\$token} )", 
	"desc" => "Get the symbolic name of a given PHP token", 
	"docurl" => "function.token-name.html" 
),
"touch" => array( 
	"methodname" => "touch", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool touch ( string filename [, int time [, int atime]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Sets access and modification time of file", 
	"docurl" => "function.touch.html" 
),
"trigger_error" => array( 
	"methodname" => "trigger_error", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "bool trigger_error ( string error_msg [, int error_type] )", 
	"snippet" => "( \${1:\$error_msg} )", 
	"desc" => "Generates a user-level error/warning/notice message", 
	"docurl" => "function.trigger-error.html" 
),
"trim" => array( 
	"methodname" => "trim", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string trim ( string str [, string charlist] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Strip whitespace (or other characters) from the beginning and end of a string", 
	"docurl" => "function.trim.html" 
),

); # end of main array
?>