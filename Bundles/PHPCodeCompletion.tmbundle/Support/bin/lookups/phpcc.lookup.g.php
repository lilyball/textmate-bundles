<?php
$_LOOKUP = array( 
"gd_info" => array( 
	"methodname" => "gd_info", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array gd_info ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Retrieve information about the currently installed GD library", 
	"docurl" => "function.gd-info.html" 
),
"get_browser" => array( 
	"methodname" => "get_browser", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "object get_browser ( [string user_agent [, bool return_array]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Tells what the user\'s browser is capable of", 
	"docurl" => "function.get-browser.html" 
),
"get_cfg_var" => array( 
	"methodname" => "get_cfg_var", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string get_cfg_var ( string varname )", 
	"snippet" => "( \${1:\$varname} )", 
	"desc" => "Gets the value of a PHP configuration option", 
	"docurl" => "function.get-cfg-var.html" 
),
"get_class_methods" => array( 
	"methodname" => "get_class_methods", 
	"version" => "PHP4, PHP5", 
	"method" => "array get_class_methods ( mixed class_name )", 
	"snippet" => "( \${1:\$class_name} )", 
	"desc" => "Returns an array of class methods\' names", 
	"docurl" => "function.get-class-methods.html" 
),
"get_class_vars" => array( 
	"methodname" => "get_class_vars", 
	"version" => "PHP4, PHP5", 
	"method" => "array get_class_vars ( string class_name )", 
	"snippet" => "( \${1:\$class_name} )", 
	"desc" => "Returns an array of default properties of the class", 
	"docurl" => "function.get-class-vars.html" 
),
"get_class" => array( 
	"methodname" => "get_class", 
	"version" => "PHP4, PHP5", 
	"method" => "string get_class ( object obj )", 
	"snippet" => "( \${1:\$obj} )", 
	"desc" => "Returns the name of the class of an object", 
	"docurl" => "function.get-class.html" 
),
"get_current_user" => array( 
	"methodname" => "get_current_user", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string get_current_user ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets the name of the owner of the current PHP script", 
	"docurl" => "function.get-current-user.html" 
),
"get_declared_classes" => array( 
	"methodname" => "get_declared_classes", 
	"version" => "PHP4, PHP5", 
	"method" => "array get_declared_classes ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns an array with the name of the defined classes", 
	"docurl" => "function.get-declared-classes.html" 
),
"get_declared_interfaces" => array( 
	"methodname" => "get_declared_interfaces", 
	"version" => "PHP5", 
	"method" => "array get_declared_interfaces ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns an array of all declared interfaces", 
	"docurl" => "function.get-declared-interfaces.html" 
),
"get_defined_constants" => array( 
	"methodname" => "get_defined_constants", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array get_defined_constants ( [mixed categorize] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns an associative array with the names of all the constants   and their values", 
	"docurl" => "function.get-defined-constants.html" 
),
"get_defined_functions" => array( 
	"methodname" => "get_defined_functions", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "array get_defined_functions ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns an array of all defined functions", 
	"docurl" => "function.get-defined-functions.html" 
),
"get_defined_vars" => array( 
	"methodname" => "get_defined_vars", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "array get_defined_vars ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns an array of all defined variables", 
	"docurl" => "function.get-defined-vars.html" 
),
"get_extension_funcs" => array( 
	"methodname" => "get_extension_funcs", 
	"version" => "PHP4, PHP5", 
	"method" => "array get_extension_funcs ( string module_name )", 
	"snippet" => "( \${1:\$module_name} )", 
	"desc" => "Returns an array with the names of the functions of a module", 
	"docurl" => "function.get-extension-funcs.html" 
),
"get_headers" => array( 
	"methodname" => "get_headers", 
	"version" => "PHP5", 
	"method" => "array get_headers ( string url [, int format] )", 
	"snippet" => "( \${1:\$url} )", 
	"desc" => "Fetches all the headers sent by the server in response to a HTTP request", 
	"docurl" => "function.get-headers.html" 
),
"get_html_translation_table" => array( 
	"methodname" => "get_html_translation_table", 
	"version" => "PHP4, PHP5", 
	"method" => "array get_html_translation_table ( [int table [, int quote_style]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns the translation table used by   htmlspecialchars() and   htmlentities()", 
	"docurl" => "function.get-html-translation-table.html" 
),
"get_include_path" => array( 
	"methodname" => "get_include_path", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string get_include_path ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets the current include_path configuration option", 
	"docurl" => "function.get-include-path.html" 
),
"get_included_files" => array( 
	"methodname" => "get_included_files", 
	"version" => "PHP4, PHP5", 
	"method" => "array get_included_files ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns an array with the names of included or required files", 
	"docurl" => "function.get-included-files.html" 
),
"get_loaded_extensions" => array( 
	"methodname" => "get_loaded_extensions", 
	"version" => "PHP4, PHP5", 
	"method" => "array get_loaded_extensions ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns an array with the names of all modules compiled and   loaded", 
	"docurl" => "function.get-loaded-extensions.html" 
),
"get_magic_quotes_gpc" => array( 
	"methodname" => "get_magic_quotes_gpc", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int get_magic_quotes_gpc ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets the current configuration setting of magic quotes gpc", 
	"docurl" => "function.get-magic-quotes-gpc.html" 
),
"get_magic_quotes_runtime" => array( 
	"methodname" => "get_magic_quotes_runtime", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int get_magic_quotes_runtime ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets the current active configuration setting of   magic_quotes_runtime", 
	"docurl" => "function.get-magic-quotes-runtime.html" 
),
"get_meta_tags" => array( 
	"methodname" => "get_meta_tags", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "array get_meta_tags ( string filename [, bool use_include_path] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Extracts all meta tag content attributes from a file and returns   an array", 
	"docurl" => "function.get-meta-tags.html" 
),
"get_object_vars" => array( 
	"methodname" => "get_object_vars", 
	"version" => "PHP4, PHP5", 
	"method" => "array get_object_vars ( object obj )", 
	"snippet" => "( \${1:\$obj} )", 
	"desc" => "Returns an associative array of object properties", 
	"docurl" => "function.get-object-vars.html" 
),
"get_parent_class" => array( 
	"methodname" => "get_parent_class", 
	"version" => "PHP4, PHP5", 
	"method" => "string get_parent_class ( mixed obj )", 
	"snippet" => "( \${1:\$obj} )", 
	"desc" => "Retrieves the parent class name for object or class", 
	"docurl" => "function.get-parent-class.html" 
),
"get_required_files" => array( 
	"methodname" => "get_required_files", 
	"version" => "(PHP4, PHP5)", 
	"method" => "array get_required_files ( void )", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of get_included_files()\n", 
	"docurl" => "function.get-required-files.html" 
),
"get_resource_type" => array( 
	"methodname" => "get_resource_type", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string get_resource_type ( resource handle )", 
	"snippet" => "( \${1:\$handle} )", 
	"desc" => "Returns the resource type", 
	"docurl" => "function.get-resource-type.html" 
),
"getallheaders" => array( 
	"methodname" => "getallheaders", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array getallheaders ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Fetch all HTTP request headers", 
	"docurl" => "function.getallheaders.html" 
),
"getcwd" => array( 
	"methodname" => "getcwd", 
	"version" => "PHP4, PHP5", 
	"method" => "string getcwd ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets the current working directory", 
	"docurl" => "function.getcwd.html" 
),
"getdate" => array( 
	"methodname" => "getdate", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array getdate ( [int timestamp] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get date/time information", 
	"docurl" => "function.getdate.html" 
),
"getenv" => array( 
	"methodname" => "getenv", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string getenv ( string varname )", 
	"snippet" => "( \${1:\$varname} )", 
	"desc" => "Gets the value of an environment variable", 
	"docurl" => "function.getenv.html" 
),
"gethostbyaddr" => array( 
	"methodname" => "gethostbyaddr", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string gethostbyaddr ( string ip_address )", 
	"snippet" => "( \${1:\$ip_address} )", 
	"desc" => "Get the Internet host name corresponding to a given IP address", 
	"docurl" => "function.gethostbyaddr.html" 
),
"gethostbyname" => array( 
	"methodname" => "gethostbyname", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string gethostbyname ( string hostname )", 
	"snippet" => "( \${1:\$hostname} )", 
	"desc" => "Get the IP address corresponding to a given Internet host name", 
	"docurl" => "function.gethostbyname.html" 
),
"gethostbynamel" => array( 
	"methodname" => "gethostbynamel", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array gethostbynamel ( string hostname )", 
	"snippet" => "( \${1:\$hostname} )", 
	"desc" => "Get a list of IP addresses corresponding to a given Internet host   name", 
	"docurl" => "function.gethostbynamel.html" 
),
"getimagesize" => array( 
	"methodname" => "getimagesize", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array getimagesize ( string filename [, array &imageinfo] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Get the size of an image", 
	"docurl" => "function.getimagesize.html" 
),
"getlastmod" => array( 
	"methodname" => "getlastmod", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int getlastmod ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets time of last page modification", 
	"docurl" => "function.getlastmod.html" 
),
"getmxrr" => array( 
	"methodname" => "getmxrr", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool getmxrr ( string hostname, array &mxhosts [, array &weight] )", 
	"snippet" => "( \${1:\$hostname}, \${2:\$mxhosts} )", 
	"desc" => "Get MX records corresponding to a given Internet host name", 
	"docurl" => "function.getmxrr.html" 
),
"getmygid" => array( 
	"methodname" => "getmygid", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int getmygid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get PHP script owner\'s GID", 
	"docurl" => "function.getmygid.html" 
),
"getmyinode" => array( 
	"methodname" => "getmyinode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int getmyinode ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets the inode of the current script", 
	"docurl" => "function.getmyinode.html" 
),
"getmypid" => array( 
	"methodname" => "getmypid", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int getmypid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets PHP\'s process ID", 
	"docurl" => "function.getmypid.html" 
),
"getmyuid" => array( 
	"methodname" => "getmyuid", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int getmyuid ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Gets PHP script owner\'s UID", 
	"docurl" => "function.getmyuid.html" 
),
"getopt" => array( 
	"methodname" => "getopt", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array getopt ( string options [, array longopts] )", 
	"snippet" => "( \${1:\$options} )", 
	"desc" => "Gets options from the command line argument list", 
	"docurl" => "function.getopt.html" 
),
"getprotobyname" => array( 
	"methodname" => "getprotobyname", 
	"version" => "PHP4, PHP5", 
	"method" => "int getprotobyname ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Get protocol number associated with protocol name", 
	"docurl" => "function.getprotobyname.html" 
),
"getprotobynumber" => array( 
	"methodname" => "getprotobynumber", 
	"version" => "PHP4, PHP5", 
	"method" => "string getprotobynumber ( int number )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Get protocol name associated with protocol number", 
	"docurl" => "function.getprotobynumber.html" 
),
"getrandmax" => array( 
	"methodname" => "getrandmax", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int getrandmax ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Show largest possible random value", 
	"docurl" => "function.getrandmax.html" 
),
"getrusage" => array( 
	"methodname" => "getrusage", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "array getrusage ( [int who] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Gets the current resource usages", 
	"docurl" => "function.getrusage.html" 
),
"getservbyname" => array( 
	"methodname" => "getservbyname", 
	"version" => "PHP4, PHP5", 
	"method" => "int getservbyname ( string service, string protocol )", 
	"snippet" => "( \${1:\$service}, \${2:\$protocol} )", 
	"desc" => "Get port number associated with an Internet service and protocol", 
	"docurl" => "function.getservbyname.html" 
),
"getservbyport" => array( 
	"methodname" => "getservbyport", 
	"version" => "PHP4, PHP5", 
	"method" => "string getservbyport ( int port, string protocol )", 
	"snippet" => "( \${1:\$port}, \${2:\$protocol} )", 
	"desc" => "Get Internet service which corresponds to port and protocol", 
	"docurl" => "function.getservbyport.html" 
),
"gettext" => array( 
	"methodname" => "gettext", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string gettext ( string message )", 
	"snippet" => "( \${1:\$message} )", 
	"desc" => "Lookup a message in the current domain", 
	"docurl" => "function.gettext.html" 
),
"gettimeofday" => array( 
	"methodname" => "gettimeofday", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "mixed gettimeofday ( [bool return_float] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get current time", 
	"docurl" => "function.gettimeofday.html" 
),
"gettype" => array( 
	"methodname" => "gettype", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string gettype ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Get the type of a variable", 
	"docurl" => "function.gettype.html" 
),
"glob" => array( 
	"methodname" => "glob", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "array glob ( string pattern [, int flags] )", 
	"snippet" => "( \${1:\$pattern} )", 
	"desc" => "Find pathnames matching a pattern", 
	"docurl" => "function.glob.html" 
),
"gmdate" => array( 
	"methodname" => "gmdate", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string gmdate ( string format [, int timestamp] )", 
	"snippet" => "( \${1:\$format} )", 
	"desc" => "Format a GMT/UTC date/time", 
	"docurl" => "function.gmdate.html" 
),
"gmmktime" => array( 
	"methodname" => "gmmktime", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int gmmktime ( [int hour [, int minute [, int second [, int month [, int day [, int year [, int is_dst]]]]]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get Unix timestamp for a GMT date", 
	"docurl" => "function.gmmktime.html" 
),
"gmp_abs" => array( 
	"methodname" => "gmp_abs", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_abs ( resource a )", 
	"snippet" => "( \${1:\$a} )", 
	"desc" => "Absolute value", 
	"docurl" => "function.gmp-abs.html" 
),
"gmp_add" => array( 
	"methodname" => "gmp_add", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_add ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Add numbers", 
	"docurl" => "function.gmp-add.html" 
),
"gmp_and" => array( 
	"methodname" => "gmp_and", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_and ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Logical AND", 
	"docurl" => "function.gmp-and.html" 
),
"gmp_clrbit" => array( 
	"methodname" => "gmp_clrbit", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "void gmp_clrbit ( resource &a, int index )", 
	"snippet" => "( \${1:\$a}, \${2:\$index} )", 
	"desc" => "Clear bit", 
	"docurl" => "function.gmp-clrbit.html" 
),
"gmp_cmp" => array( 
	"methodname" => "gmp_cmp", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int gmp_cmp ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Compare numbers", 
	"docurl" => "function.gmp-cmp.html" 
),
"gmp_com" => array( 
	"methodname" => "gmp_com", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_com ( resource a )", 
	"snippet" => "( \${1:\$a} )", 
	"desc" => "Calculates one\'s complement", 
	"docurl" => "function.gmp-com.html" 
),
"gmp_div_q" => array( 
	"methodname" => "gmp_div_q", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_div_q ( resource a, resource b [, int round] )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Divide numbers", 
	"docurl" => "function.gmp-div-q.html" 
),
"gmp_div_qr" => array( 
	"methodname" => "gmp_div_qr", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "array gmp_div_qr ( resource n, resource d [, int round] )", 
	"snippet" => "( \${1:\$n}, \${2:\$d} )", 
	"desc" => "Divide numbers and get quotient and remainder", 
	"docurl" => "function.gmp-div-qr.html" 
),
"gmp_div_r" => array( 
	"methodname" => "gmp_div_r", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_div_r ( resource n, resource d [, int round] )", 
	"snippet" => "( \${1:\$n}, \${2:\$d} )", 
	"desc" => "Remainder of the division of numbers", 
	"docurl" => "function.gmp-div-r.html" 
),
"gmp_div" => array( 
	"methodname" => "gmp_div", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of gmp_div_q()\nDivide numbers", 
	"docurl" => "function.gmp-div.html" 
),
"gmp_divexact" => array( 
	"methodname" => "gmp_divexact", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_divexact ( resource n, resource d )", 
	"snippet" => "( \${1:\$n}, \${2:\$d} )", 
	"desc" => "Exact division of numbers", 
	"docurl" => "function.gmp-divexact.html" 
),
"gmp_fact" => array( 
	"methodname" => "gmp_fact", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_fact ( int a )", 
	"snippet" => "( \${1:\$a} )", 
	"desc" => "Factorial", 
	"docurl" => "function.gmp-fact.html" 
),
"gmp_gcd" => array( 
	"methodname" => "gmp_gcd", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_gcd ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Calculate GCD", 
	"docurl" => "function.gmp-gcd.html" 
),
"gmp_gcdext" => array( 
	"methodname" => "gmp_gcdext", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "array gmp_gcdext ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Calculate GCD and multipliers", 
	"docurl" => "function.gmp-gcdext.html" 
),
"gmp_hamdist" => array( 
	"methodname" => "gmp_hamdist", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int gmp_hamdist ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Hamming distance", 
	"docurl" => "function.gmp-hamdist.html" 
),
"gmp_init" => array( 
	"methodname" => "gmp_init", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_init ( mixed number [, int base] )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Create GMP number", 
	"docurl" => "function.gmp-init.html" 
),
"gmp_intval" => array( 
	"methodname" => "gmp_intval", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int gmp_intval ( resource gmpnumber )", 
	"snippet" => "( \${1:\$gmpnumber} )", 
	"desc" => "Convert GMP number to integer", 
	"docurl" => "function.gmp-intval.html" 
),
"gmp_invert" => array( 
	"methodname" => "gmp_invert", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_invert ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Inverse by modulo", 
	"docurl" => "function.gmp-invert.html" 
),
"gmp_jacobi" => array( 
	"methodname" => "gmp_jacobi", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int gmp_jacobi ( resource a, resource p )", 
	"snippet" => "( \${1:\$a}, \${2:\$p} )", 
	"desc" => "Jacobi symbol", 
	"docurl" => "function.gmp-jacobi.html" 
),
"gmp_legendre" => array( 
	"methodname" => "gmp_legendre", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int gmp_legendre ( resource a, resource p )", 
	"snippet" => "( \${1:\$a}, \${2:\$p} )", 
	"desc" => "Legendre symbol", 
	"docurl" => "function.gmp-legendre.html" 
),
"gmp_mod" => array( 
	"methodname" => "gmp_mod", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_mod ( resource n, resource d )", 
	"snippet" => "( \${1:\$n}, \${2:\$d} )", 
	"desc" => "Modulo operation", 
	"docurl" => "function.gmp-mod.html" 
),
"gmp_mul" => array( 
	"methodname" => "gmp_mul", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_mul ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Multiply numbers", 
	"docurl" => "function.gmp-mul.html" 
),
"gmp_neg" => array( 
	"methodname" => "gmp_neg", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_neg ( resource a )", 
	"snippet" => "( \${1:\$a} )", 
	"desc" => "Negate number", 
	"docurl" => "function.gmp-neg.html" 
),
"gmp_or" => array( 
	"methodname" => "gmp_or", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_or ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Logical OR", 
	"docurl" => "function.gmp-or.html" 
),
"gmp_perfect_square" => array( 
	"methodname" => "gmp_perfect_square", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool gmp_perfect_square ( resource a )", 
	"snippet" => "( \${1:\$a} )", 
	"desc" => "Perfect square check", 
	"docurl" => "function.gmp-perfect-square.html" 
),
"gmp_popcount" => array( 
	"methodname" => "gmp_popcount", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int gmp_popcount ( resource a )", 
	"snippet" => "( \${1:\$a} )", 
	"desc" => "Population count", 
	"docurl" => "function.gmp-popcount.html" 
),
"gmp_pow" => array( 
	"methodname" => "gmp_pow", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_pow ( resource base, int exp )", 
	"snippet" => "( \${1:\$base}, \${2:\$exp} )", 
	"desc" => "Raise number into power", 
	"docurl" => "function.gmp-pow.html" 
),
"gmp_powm" => array( 
	"methodname" => "gmp_powm", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_powm ( resource base, resource exp, resource mod )", 
	"snippet" => "( \${1:\$base}, \${2:\$exp}, \${3:\$mod} )", 
	"desc" => "Raise number into power with modulo", 
	"docurl" => "function.gmp-powm.html" 
),
"gmp_prob_prime" => array( 
	"methodname" => "gmp_prob_prime", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int gmp_prob_prime ( resource a [, int reps] )", 
	"snippet" => "( \${1:\$a} )", 
	"desc" => "Check if number is \"probably prime\"", 
	"docurl" => "function.gmp-prob-prime.html" 
),
"gmp_random" => array( 
	"methodname" => "gmp_random", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_random ( int limiter )", 
	"snippet" => "( \${1:\$limiter} )", 
	"desc" => "Random number", 
	"docurl" => "function.gmp-random.html" 
),
"gmp_scan0" => array( 
	"methodname" => "gmp_scan0", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int gmp_scan0 ( resource a, int start )", 
	"snippet" => "( \${1:\$a}, \${2:\$start} )", 
	"desc" => "Scan for 0", 
	"docurl" => "function.gmp-scan0.html" 
),
"gmp_scan1" => array( 
	"methodname" => "gmp_scan1", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int gmp_scan1 ( resource a, int start )", 
	"snippet" => "( \${1:\$a}, \${2:\$start} )", 
	"desc" => "Scan for 1", 
	"docurl" => "function.gmp-scan1.html" 
),
"gmp_setbit" => array( 
	"methodname" => "gmp_setbit", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "void gmp_setbit ( resource &a, int index [, bool set_clear] )", 
	"snippet" => "( \${1:\$a}, \${2:\$index} )", 
	"desc" => "Set bit", 
	"docurl" => "function.gmp-setbit.html" 
),
"gmp_sign" => array( 
	"methodname" => "gmp_sign", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int gmp_sign ( resource a )", 
	"snippet" => "( \${1:\$a} )", 
	"desc" => "Sign of number", 
	"docurl" => "function.gmp-sign.html" 
),
"gmp_sqrt" => array( 
	"methodname" => "gmp_sqrt", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_sqrt ( resource a )", 
	"snippet" => "( \${1:\$a} )", 
	"desc" => "Calculate square root", 
	"docurl" => "function.gmp-sqrt.html" 
),
"gmp_sqrtrem" => array( 
	"methodname" => "gmp_sqrtrem", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "array gmp_sqrtrem ( resource a )", 
	"snippet" => "( \${1:\$a} )", 
	"desc" => "Square root with remainder", 
	"docurl" => "function.gmp-sqrtrem.html" 
),
"gmp_strval" => array( 
	"methodname" => "gmp_strval", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string gmp_strval ( resource gmpnumber [, int base] )", 
	"snippet" => "( \${1:\$gmpnumber} )", 
	"desc" => "Convert GMP number to string", 
	"docurl" => "function.gmp-strval.html" 
),
"gmp_sub" => array( 
	"methodname" => "gmp_sub", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_sub ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Subtract numbers", 
	"docurl" => "function.gmp-sub.html" 
),
"gmp_xor" => array( 
	"methodname" => "gmp_xor", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource gmp_xor ( resource a, resource b )", 
	"snippet" => "( \${1:\$a}, \${2:\$b} )", 
	"desc" => "Logical XOR", 
	"docurl" => "function.gmp-xor.html" 
),
"gmstrftime" => array( 
	"methodname" => "gmstrftime", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "string gmstrftime ( string format [, int timestamp] )", 
	"snippet" => "( \${1:\$format} )", 
	"desc" => "Format a GMT/UTC time/date according to locale settings", 
	"docurl" => "function.gmstrftime.html" 
),
"gregoriantojd" => array( 
	"methodname" => "gregoriantojd", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int gregoriantojd ( int month, int day, int year )", 
	"snippet" => "( \${1:\$month}, \${2:\$day}, \${3:\$year} )", 
	"desc" => "Converts a Gregorian date to Julian Day Count", 
	"docurl" => "function.gregoriantojd.html" 
),
"gzclose" => array( 
	"methodname" => "gzclose", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool gzclose ( resource zp )", 
	"snippet" => "( \${1:\$zp} )", 
	"desc" => "Close an open gz-file pointer", 
	"docurl" => "function.gzclose.html" 
),
"gzcompress" => array( 
	"methodname" => "gzcompress", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "string gzcompress ( string data [, int level] )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Compress a string", 
	"docurl" => "function.gzcompress.html" 
),
"gzdeflate" => array( 
	"methodname" => "gzdeflate", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string gzdeflate ( string data [, int level] )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Deflate a string", 
	"docurl" => "function.gzdeflate.html" 
),
"gzencode" => array( 
	"methodname" => "gzencode", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string gzencode ( string data [, int level [, int encoding_mode]] )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Create a gzip compressed string", 
	"docurl" => "function.gzencode.html" 
),
"gzeof" => array( 
	"methodname" => "gzeof", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int gzeof ( resource zp )", 
	"snippet" => "( \${1:\$zp} )", 
	"desc" => "Test for end-of-file on a gz-file pointer", 
	"docurl" => "function.gzeof.html" 
),
"gzfile" => array( 
	"methodname" => "gzfile", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array gzfile ( string filename [, int use_include_path] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Read entire gz-file into an array", 
	"docurl" => "function.gzfile.html" 
),
"gzgetc" => array( 
	"methodname" => "gzgetc", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string gzgetc ( resource zp )", 
	"snippet" => "( \${1:\$zp} )", 
	"desc" => "Get character from gz-file pointer", 
	"docurl" => "function.gzgetc.html" 
),
"gzgets" => array( 
	"methodname" => "gzgets", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string gzgets ( resource zp, int length )", 
	"snippet" => "( \${1:\$zp}, \${2:\$length} )", 
	"desc" => "Get line from file pointer", 
	"docurl" => "function.gzgets.html" 
),
"gzgetss" => array( 
	"methodname" => "gzgetss", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string gzgetss ( resource zp, int length [, string allowable_tags] )", 
	"snippet" => "( \${1:\$zp}, \${2:\$length} )", 
	"desc" => "Get line from gz-file pointer and strip HTML tags", 
	"docurl" => "function.gzgetss.html" 
),
"gzinflate" => array( 
	"methodname" => "gzinflate", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string gzinflate ( string data [, int length] )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Inflate a deflated string", 
	"docurl" => "function.gzinflate.html" 
),
"gzopen" => array( 
	"methodname" => "gzopen", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource gzopen ( string filename, string mode [, int use_include_path] )", 
	"snippet" => "( \${1:\$filename}, \${2:\$mode} )", 
	"desc" => "Open gz-file", 
	"docurl" => "function.gzopen.html" 
),
"gzpassthru" => array( 
	"methodname" => "gzpassthru", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int gzpassthru ( resource zp )", 
	"snippet" => "( \${1:\$zp} )", 
	"desc" => "Output all remaining data on a gz-file pointer", 
	"docurl" => "function.gzpassthru.html" 
),
"gzputs" => array( 
	"methodname" => "gzputs", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of gzwrite()\n", 
	"docurl" => "function.gzputs.html" 
),
"gzread" => array( 
	"methodname" => "gzread", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string gzread ( resource zp, int length )", 
	"snippet" => "( \${1:\$zp}, \${2:\$length} )", 
	"desc" => "Binary-safe gz-file read", 
	"docurl" => "function.gzread.html" 
),
"gzrewind" => array( 
	"methodname" => "gzrewind", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool gzrewind ( resource zp )", 
	"snippet" => "( \${1:\$zp} )", 
	"desc" => "Rewind the position of a gz-file pointer", 
	"docurl" => "function.gzrewind.html" 
),
"gzseek" => array( 
	"methodname" => "gzseek", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int gzseek ( resource zp, int offset )", 
	"snippet" => "( \${1:\$zp}, \${2:\$offset} )", 
	"desc" => "Seek on a gz-file pointer", 
	"docurl" => "function.gzseek.html" 
),
"gztell" => array( 
	"methodname" => "gztell", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int gztell ( resource zp )", 
	"snippet" => "( \${1:\$zp} )", 
	"desc" => "Tell gz-file pointer read/write position", 
	"docurl" => "function.gztell.html" 
),
"gzuncompress" => array( 
	"methodname" => "gzuncompress", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "string gzuncompress ( string data [, int length] )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Uncompress a compressed string", 
	"docurl" => "function.gzuncompress.html" 
),
"gzwrite" => array( 
	"methodname" => "gzwrite", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int gzwrite ( resource zp, string string [, int length] )", 
	"snippet" => "( \${1:\$zp}, \${2:\$string} )", 
	"desc" => "Binary-safe gz-file write", 
	"docurl" => "function.gzwrite.html" 
),

); # end of main array
?>