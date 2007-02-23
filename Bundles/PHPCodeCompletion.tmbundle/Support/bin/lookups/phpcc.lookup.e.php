<?php
$_LOOKUP = array( 
"each" => array( 
	"methodname" => "each", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array each ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Return the current key and value pair from an array and advance   the array cursor", 
	"docurl" => "function.each.html" 
),
"easter_date" => array( 
	"methodname" => "easter_date", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "int easter_date ( [int year] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get Unix timestamp for midnight on Easter of a given year", 
	"docurl" => "function.easter-date.html" 
),
"easter_days" => array( 
	"methodname" => "easter_days", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "int easter_days ( [int year [, int method]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get number of days after March 21 on which Easter falls for a   given year", 
	"docurl" => "function.easter-days.html" 
),
"ebcdic2ascii" => array( 
	"methodname" => "ebcdic2ascii", 
	"version" => "PHP3>= 3.0.17", 
	"method" => "int ebcdic2ascii ( string ebcdic_str )", 
	"snippet" => "( \${1:\$ebcdic_str} )", 
	"desc" => "Translate string from EBCDIC to ASCII", 
	"docurl" => "function.ebcdic2ascii.html" 
),
"echo" => array( 
	"methodname" => "echo", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void echo ( string arg1 [, string ...] )", 
	"snippet" => "( \${1:\$arg1} )", 
	"desc" => "Output one or more strings", 
	"docurl" => "function.echo.html" 
),
"empty" => array( 
	"methodname" => "empty", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool empty ( mixed var )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Determine whether a variable is empty", 
	"docurl" => "function.empty.html" 
),
"end" => array( 
	"methodname" => "end", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed end ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Set the internal pointer of an array to its last element", 
	"docurl" => "function.end.html" 
),
"ereg_replace" => array( 
	"methodname" => "ereg_replace", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string ereg_replace ( string pattern, string replacement, string string )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$replacement}, \${3:\$string} )", 
	"desc" => "Replace regular expression", 
	"docurl" => "function.ereg-replace.html" 
),
"ereg" => array( 
	"methodname" => "ereg", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int ereg ( string pattern, string string [, array &regs] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$string} )", 
	"desc" => "Regular expression match", 
	"docurl" => "function.ereg.html" 
),
"eregi_replace" => array( 
	"methodname" => "eregi_replace", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string eregi_replace ( string pattern, string replacement, string string )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$replacement}, \${3:\$string} )", 
	"desc" => "Replace regular expression case insensitive", 
	"docurl" => "function.eregi-replace.html" 
),
"eregi" => array( 
	"methodname" => "eregi", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int eregi ( string pattern, string string [, array &regs] )", 
	"snippet" => "( \${1:\$pattern}, \${2:\$string} )", 
	"desc" => "Case insensitive regular expression match", 
	"docurl" => "function.eregi.html" 
),
"error_log" => array( 
	"methodname" => "error_log", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int error_log ( string message [, int message_type [, string destination [, string extra_headers]]] )", 
	"snippet" => "( \${1:\$message} )", 
	"desc" => "Send an error message somewhere", 
	"docurl" => "function.error-log.html" 
),
"error_reporting" => array( 
	"methodname" => "error_reporting", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int error_reporting ( [int level] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Sets which PHP errors are reported", 
	"docurl" => "function.error-reporting.html" 
),
"escapeshellarg" => array( 
	"methodname" => "escapeshellarg", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "string escapeshellarg ( string arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Escape a string to be used as a shell argument", 
	"docurl" => "function.escapeshellarg.html" 
),
"escapeshellcmd" => array( 
	"methodname" => "escapeshellcmd", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string escapeshellcmd ( string command )", 
	"snippet" => "( \${1:\$command} )", 
	"desc" => "Escape shell metacharacters", 
	"docurl" => "function.escapeshellcmd.html" 
),
"eval" => array( 
	"methodname" => "eval", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed eval ( string code_str )", 
	"snippet" => "( \${1:\$code_str} )", 
	"desc" => "Evaluate a string as PHP code", 
	"docurl" => "function.eval.html" 
),
"exec" => array( 
	"methodname" => "exec", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string exec ( string command [, array &output [, int &return_var]] )", 
	"snippet" => "( \${1:\$command} )", 
	"desc" => "Execute an external program", 
	"docurl" => "function.exec.html" 
),
"exif_imagetype" => array( 
	"methodname" => "exif_imagetype", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "int exif_imagetype ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Determine the type of an image", 
	"docurl" => "function.exif-imagetype.html" 
),
"exif_read_data" => array( 
	"methodname" => "exif_read_data", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "array exif_read_data ( string filename [, string sections [, bool arrays [, bool thumbnail]]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Reads the EXIF headers from JPEG or TIFF", 
	"docurl" => "function.exif-read-data.html" 
),
"exif_tagname" => array( 
	"methodname" => "exif_tagname", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string exif_tagname ( string index )", 
	"snippet" => "( \${1:\$index} )", 
	"desc" => "Get the header name for an index", 
	"docurl" => "function.exif-tagname.html" 
),
"exif_thumbnail" => array( 
	"methodname" => "exif_thumbnail", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string exif_thumbnail ( string filename [, int &width [, int &height [, int &imagetype]]] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Retrieve the embedded thumbnail of a TIFF or JPEG image", 
	"docurl" => "function.exif-thumbnail.html" 
),
"exit" => array( 
	"methodname" => "exit", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void exit ( [string status] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Output a message and terminate the current script", 
	"docurl" => "function.exit.html" 
),
"exp" => array( 
	"methodname" => "exp", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float exp ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Calculates the exponent of e (the   Neperian or Natural logarithm base)", 
	"docurl" => "function.exp.html" 
),
"explode" => array( 
	"methodname" => "explode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array explode ( string separator, string string [, int limit] )", 
	"snippet" => "( \${1:\$separator}, \${2:\$string} )", 
	"desc" => "Split a string by string", 
	"docurl" => "function.explode.html" 
),
"expm1" => array( 
	"methodname" => "expm1", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float expm1 ( float number )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Returns exp(number) - 1, computed in a way that is accurate even   when the value of number is close to zero", 
	"docurl" => "function.expm1.html" 
),
"extension_loaded" => array( 
	"methodname" => "extension_loaded", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "bool extension_loaded ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Find out whether an extension is loaded", 
	"docurl" => "function.extension-loaded.html" 
),
"extract" => array( 
	"methodname" => "extract", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int extract ( array var_array [, int extract_type [, string prefix]] )", 
	"snippet" => "( \${1:\$var_array} )", 
	"desc" => "Import variables into the current symbol table from an array", 
	"docurl" => "function.extract.html" 
),
"ezmlm_hash" => array( 
	"methodname" => "ezmlm_hash", 
	"version" => "PHP3>= 3.0.17, PHP4 >= 4.0.2, PHP5", 
	"method" => "int ezmlm_hash ( string addr )", 
	"snippet" => "( \${1:\$addr} )", 
	"desc" => "Calculate the hash value needed by EZMLM", 
	"docurl" => "function.ezmlm-hash.html" 
),

); # end of main array
?>