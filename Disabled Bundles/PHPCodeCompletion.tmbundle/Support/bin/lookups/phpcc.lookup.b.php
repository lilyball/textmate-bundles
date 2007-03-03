<?php
$_LOOKUP = array( 
"base_convert" => array( 
	"methodname" => "base_convert", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string base_convert ( string number, int frombase, int tobase )", 
	"snippet" => "( \${1:\$number}, \${2:\$frombase}, \${3:\$tobase} )", 
	"desc" => "Convert a number between arbitrary bases", 
	"docurl" => "function.base-convert.html" 
),
"base64_decode" => array( 
	"methodname" => "base64_decode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string base64_decode ( string encoded_data )", 
	"snippet" => "( \${1:\$encoded_data} )", 
	"desc" => "Decodes data encoded with MIME base64", 
	"docurl" => "function.base64-decode.html" 
),
"base64_encode" => array( 
	"methodname" => "base64_encode", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string base64_encode ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Encodes data with MIME base64", 
	"docurl" => "function.base64-encode.html" 
),
"basename" => array( 
	"methodname" => "basename", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string basename ( string path [, string suffix] )", 
	"snippet" => "( \${1:\$path} )", 
	"desc" => "Returns filename component of path", 
	"docurl" => "function.basename.html" 
),
"bcadd" => array( 
	"methodname" => "bcadd", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string bcadd ( string left_operand, string right_operand [, int scale] )", 
	"snippet" => "( \${1:\$left_operand}, \${2:\$right_operand} )", 
	"desc" => "Add two arbitrary precision numbers", 
	"docurl" => "function.bcadd.html" 
),
"bccomp" => array( 
	"methodname" => "bccomp", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int bccomp ( string left_operand, string right_operand [, int scale] )", 
	"snippet" => "( \${1:\$left_operand}, \${2:\$right_operand} )", 
	"desc" => "Compare two arbitrary precision numbers", 
	"docurl" => "function.bccomp.html" 
),
"bcdiv" => array( 
	"methodname" => "bcdiv", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string bcdiv ( string left_operand, string right_operand [, int scale] )", 
	"snippet" => "( \${1:\$left_operand}, \${2:\$right_operand} )", 
	"desc" => "Divide two arbitrary precision numbers", 
	"docurl" => "function.bcdiv.html" 
),
"bcmod" => array( 
	"methodname" => "bcmod", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string bcmod ( string left_operand, string modulus )", 
	"snippet" => "( \${1:\$left_operand}, \${2:\$modulus} )", 
	"desc" => "Get modulus of an arbitrary precision number", 
	"docurl" => "function.bcmod.html" 
),
"bcmul" => array( 
	"methodname" => "bcmul", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string bcmul ( string left_operand, string right_operand [, int scale] )", 
	"snippet" => "( \${1:\$left_operand}, \${2:\$right_operand} )", 
	"desc" => "Multiply two arbitrary precision number", 
	"docurl" => "function.bcmul.html" 
),
"bcompiler_load_exe" => array( 
	"methodname" => "bcompiler_load_exe", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_load_exe ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Reads and creates classes from a bcompiler exe file", 
	"docurl" => "function.bcompiler-load-exe.html" 
),
"bcompiler_load" => array( 
	"methodname" => "bcompiler_load", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_load ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Reads and creates classes from a bz compressed file", 
	"docurl" => "function.bcompiler-load.html" 
),
"bcompiler_parse_class" => array( 
	"methodname" => "bcompiler_parse_class", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_parse_class ( string class, string callback )", 
	"snippet" => "( \${1:\$class}, \${2:\$callback} )", 
	"desc" => "Reads the bytecodes of a class and calls back to a user function", 
	"docurl" => "function.bcompiler-parse-class.html" 
),
"bcompiler_read" => array( 
	"methodname" => "bcompiler_read", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_read ( resource filehandle )", 
	"snippet" => "( \${1:\$filehandle} )", 
	"desc" => "Reads and creates classes from a filehandle", 
	"docurl" => "function.bcompiler-read.html" 
),
"bcompiler_write_class" => array( 
	"methodname" => "bcompiler_write_class", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_write_class ( resource filehandle, string className [, string extends] )", 
	"snippet" => "( \${1:\$filehandle}, \${2:\$className} )", 
	"desc" => "Writes an defined class as bytecodes", 
	"docurl" => "function.bcompiler-write-class.html" 
),
"bcompiler_write_constant" => array( 
	"methodname" => "bcompiler_write_constant", 
	"version" => "undefined", 
	"method" => "bool bcompiler_write_constant ( resource filehandle, string constantName )", 
	"snippet" => "( \${1:\$filehandle}, \${2:\$constantName} )", 
	"desc" => "", 
	"docurl" => "function.bcompiler-write-constant.html" 
),
"bcompiler_write_exe_footer" => array( 
	"methodname" => "bcompiler_write_exe_footer", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_write_exe_footer ( resource filehandle, int startpos )", 
	"snippet" => "( \${1:\$filehandle}, \${2:\$startpos} )", 
	"desc" => "", 
	"docurl" => "function.bcompiler-write-exe-footer.html" 
),
"bcompiler_write_file" => array( 
	"methodname" => "bcompiler_write_file", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_write_file ( resource filehandle, string filename )", 
	"snippet" => "( \${1:\$filehandle}, \${2:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.bcompiler-write-file.html" 
),
"bcompiler_write_footer" => array( 
	"methodname" => "bcompiler_write_footer", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_write_footer ( resource filehandle )", 
	"snippet" => "( \${1:\$filehandle} )", 
	"desc" => "", 
	"docurl" => "function.bcompiler-write-footer.html" 
),
"bcompiler_write_function" => array( 
	"methodname" => "bcompiler_write_function", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_write_function ( resource filehandle, string functionName )", 
	"snippet" => "( \${1:\$filehandle}, \${2:\$functionName} )", 
	"desc" => "", 
	"docurl" => "function.bcompiler-write-function.html" 
),
"bcompiler_write_functions_from_file" => array( 
	"methodname" => "bcompiler_write_functions_from_file", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_write_functions_from_file ( resource filehandle, string fileName )", 
	"snippet" => "( \${1:\$filehandle}, \${2:\$fileName} )", 
	"desc" => "", 
	"docurl" => "function.bcompiler-write-functions-from-file.html" 
),
"bcompiler_write_header" => array( 
	"methodname" => "bcompiler_write_header", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool bcompiler_write_header ( resource filehandle [, string write_ver] )", 
	"snippet" => "( \${1:\$filehandle} )", 
	"desc" => "", 
	"docurl" => "function.bcompiler-write-header.html" 
),
"bcpow" => array( 
	"methodname" => "bcpow", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string bcpow ( string x, string y [, int scale] )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "Raise an arbitrary precision number to another", 
	"docurl" => "function.bcpow.html" 
),
"bcpowmod" => array( 
	"methodname" => "bcpowmod", 
	"version" => "PHP5", 
	"method" => "string bcpowmod ( string x, string y, string modulus [, int scale] )", 
	"snippet" => "( \${1:\$x}, \${2:\$y}, \${3:\$modulus} )", 
	"desc" => "Raise an arbitrary precision number to another, reduced by a specified modulus", 
	"docurl" => "function.bcpowmod.html" 
),
"bcscale" => array( 
	"methodname" => "bcscale", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool bcscale ( int scale )", 
	"snippet" => "( \${1:\$scale} )", 
	"desc" => "Set default scale parameter for all bc math functions", 
	"docurl" => "function.bcscale.html" 
),
"bcsqrt" => array( 
	"methodname" => "bcsqrt", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string bcsqrt ( string operand [, int scale] )", 
	"snippet" => "( \${1:\$operand} )", 
	"desc" => "Get the square root of an arbitrary precision number", 
	"docurl" => "function.bcsqrt.html" 
),
"bcsub" => array( 
	"methodname" => "bcsub", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string bcsub ( string left_operand, string right_operand [, int scale] )", 
	"snippet" => "( \${1:\$left_operand}, \${2:\$right_operand} )", 
	"desc" => "Subtract one arbitrary precision number from another", 
	"docurl" => "function.bcsub.html" 
),
"bin2hex" => array( 
	"methodname" => "bin2hex", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "string bin2hex ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Convert binary data into hexadecimal representation", 
	"docurl" => "function.bin2hex.html" 
),
"bind_textdomain_codeset" => array( 
	"methodname" => "bind_textdomain_codeset", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "string bind_textdomain_codeset ( string domain, string codeset )", 
	"snippet" => "( \${1:\$domain}, \${2:\$codeset} )", 
	"desc" => "Specify the character encoding in which the messages from the   DOMAIN message catalog will be returned", 
	"docurl" => "function.bind-textdomain-codeset.html" 
),
"bindec" => array( 
	"methodname" => "bindec", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "number bindec ( string binary_string )", 
	"snippet" => "( \${1:\$binary_string} )", 
	"desc" => "Binary to decimal", 
	"docurl" => "function.bindec.html" 
),
"bindtextdomain" => array( 
	"methodname" => "bindtextdomain", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "string bindtextdomain ( string domain, string directory )", 
	"snippet" => "( \${1:\$domain}, \${2:\$directory} )", 
	"desc" => "Sets the path for a domain", 
	"docurl" => "function.bindtextdomain.html" 
),
"bzclose" => array( 
	"methodname" => "bzclose", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int bzclose ( resource bz )", 
	"snippet" => "( \${1:\$bz} )", 
	"desc" => "Close a bzip2 file", 
	"docurl" => "function.bzclose.html" 
),
"bzcompress" => array( 
	"methodname" => "bzcompress", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string bzcompress ( string source [, int blocksize [, int workfactor]] )", 
	"snippet" => "( \${1:\$source} )", 
	"desc" => "Compress a string into bzip2 encoded data", 
	"docurl" => "function.bzcompress.html" 
),
"bzdecompress" => array( 
	"methodname" => "bzdecompress", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string bzdecompress ( string source [, int small] )", 
	"snippet" => "( \${1:\$source} )", 
	"desc" => "Decompresses bzip2 encoded data", 
	"docurl" => "function.bzdecompress.html" 
),
"bzerrno" => array( 
	"methodname" => "bzerrno", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int bzerrno ( resource bz )", 
	"snippet" => "( \${1:\$bz} )", 
	"desc" => "Returns a bzip2 error number", 
	"docurl" => "function.bzerrno.html" 
),
"bzerror" => array( 
	"methodname" => "bzerror", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "array bzerror ( resource bz )", 
	"snippet" => "( \${1:\$bz} )", 
	"desc" => "Returns the bzip2 error number and error string in an array", 
	"docurl" => "function.bzerror.html" 
),
"bzerrstr" => array( 
	"methodname" => "bzerrstr", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string bzerrstr ( resource bz )", 
	"snippet" => "( \${1:\$bz} )", 
	"desc" => "Returns a bzip2 error string", 
	"docurl" => "function.bzerrstr.html" 
),
"bzflush" => array( 
	"methodname" => "bzflush", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int bzflush ( resource bz )", 
	"snippet" => "( \${1:\$bz} )", 
	"desc" => "Force a write of all buffered data", 
	"docurl" => "function.bzflush.html" 
),
"bzopen" => array( 
	"methodname" => "bzopen", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "resource bzopen ( string filename, string mode )", 
	"snippet" => "( \${1:\$filename}, \${2:\$mode} )", 
	"desc" => "Opens a bzip2 compressed file", 
	"docurl" => "function.bzopen.html" 
),
"bzread" => array( 
	"methodname" => "bzread", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string bzread ( resource bz [, int length] )", 
	"snippet" => "( \${1:\$bz} )", 
	"desc" => "Binary safe bzip2 file read", 
	"docurl" => "function.bzread.html" 
),
"bzwrite" => array( 
	"methodname" => "bzwrite", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "int bzwrite ( resource bz, string data [, int length] )", 
	"snippet" => "( \${1:\$bz}, \${2:\$data} )", 
	"desc" => "Binary safe bzip2 file write", 
	"docurl" => "function.bzwrite.html" 
)
); # end of main array
?>