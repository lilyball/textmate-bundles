<?php
$_LOOKUP = array( 
"cal_days_in_month" => array( 
	"methodname" => "cal_days_in_month", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int cal_days_in_month ( int calendar, int month, int year )", 
	"snippet" => "( \${1:\$calendar}, \${2:\$month}, \${3:\$year} )", 
	"desc" => "Return the number of days in a month for a given year and calendar", 
	"docurl" => "function.cal-days-in-month.html" 
),
"cal_from_jd" => array( 
	"methodname" => "cal_from_jd", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array cal_from_jd ( int jd, int calendar )", 
	"snippet" => "( \${1:\$jd}, \${2:\$calendar} )", 
	"desc" => "Converts from Julian Day Count to a supported calendar", 
	"docurl" => "function.cal-from-jd.html" 
),
"cal_info" => array( 
	"methodname" => "cal_info", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array cal_info ( [int calendar] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Returns information about a particular calendar", 
	"docurl" => "function.cal-info.html" 
),
"cal_to_jd" => array( 
	"methodname" => "cal_to_jd", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int cal_to_jd ( int calendar, int month, int day, int year )", 
	"snippet" => "( \${1:\$calendar}, \${2:\$month}, \${3:\$day}, \${4:\$year} )", 
	"desc" => "Converts from a supported calendar to Julian Day Count", 
	"docurl" => "function.cal-to-jd.html" 
),
"call_user_func_array" => array( 
	"methodname" => "call_user_func_array", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "mixed call_user_func_array ( callback function, array param_arr )", 
	"snippet" => "( \${1:\$function}, \${2:\$param_arr} )", 
	"desc" => "Call a user function given with an array of parameters", 
	"docurl" => "function.call-user-func-array.html" 
),
"call_user_func" => array( 
	"methodname" => "call_user_func", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "mixed call_user_func ( callback function [, mixed parameter [, mixed ...]] )", 
	"snippet" => "( \${1:\$function} )", 
	"desc" => "Call a user function given by the first parameter", 
	"docurl" => "function.call-user-func.html" 
),
"call_user_method_array" => array( 
	"methodname" => "call_user_method_array", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "mixed call_user_method_array ( string method_name, object &obj, array paramarr )", 
	"snippet" => "( \${1:\$method_name}, \${2:\$obj}, \${3:\$paramarr} )", 
	"desc" => "Call a user method given with an array of parameters [deprecated]", 
	"docurl" => "function.call-user-method-array.html" 
),
"call_user_method" => array( 
	"methodname" => "call_user_method", 
	"version" => "PHP3>= 3.0.3, PHP4, PHP5", 
	"method" => "mixed call_user_method ( string method_name, object &obj [, mixed parameter [, mixed ...]] )", 
	"snippet" => "( \${1:\$method_name}, \${2:\$obj} )", 
	"desc" => "Call a user method on an specific object [deprecated]", 
	"docurl" => "function.call-user-method.html" 
),
"ccvs_add" => array( 
	"methodname" => "ccvs_add", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_add ( string session, string invoice, string argtype, string argval )", 
	"snippet" => "( \${1:\$session}, \${2:\$invoice}, \${3:\$argtype}, \${4:\$argval} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-add.html" 
),
"ccvs_auth" => array( 
	"methodname" => "ccvs_auth", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_auth ( string session, string invoice )", 
	"snippet" => "( \${1:\$session}, \${2:\$invoice} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-auth.html" 
),
"ccvs_command" => array( 
	"methodname" => "ccvs_command", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_command ( string session, string type, string argval )", 
	"snippet" => "( \${1:\$session}, \${2:\$type}, \${3:\$argval} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-command.html" 
),
"ccvs_count" => array( 
	"methodname" => "ccvs_count", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "int ccvs_count ( string session, string type )", 
	"snippet" => "( \${1:\$session}, \${2:\$type} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-count.html" 
),
"ccvs_delete" => array( 
	"methodname" => "ccvs_delete", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_delete ( string session, string invoice )", 
	"snippet" => "( \${1:\$session}, \${2:\$invoice} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-delete.html" 
),
"ccvs_done" => array( 
	"methodname" => "ccvs_done", 
	"version" => "undefined", 
	"method" => "string ccvs_done ( string sess )", 
	"snippet" => "( \${1:\$sess} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-done.html" 
),
"ccvs_init" => array( 
	"methodname" => "ccvs_init", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_init ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-init.html" 
),
"ccvs_lookup" => array( 
	"methodname" => "ccvs_lookup", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_lookup ( string session, string invoice, int inum )", 
	"snippet" => "( \${1:\$session}, \${2:\$invoice}, \${3:\$inum} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-lookup.html" 
),
"ccvs_new" => array( 
	"methodname" => "ccvs_new", 
	"version" => "undefined", 
	"method" => "string ccvs_new ( string session, string invoice )", 
	"snippet" => "( \${1:\$session}, \${2:\$invoice} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-new.html" 
),
"ccvs_report" => array( 
	"methodname" => "ccvs_report", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_report ( string session, string type )", 
	"snippet" => "( \${1:\$session}, \${2:\$type} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-report.html" 
),
"ccvs_return" => array( 
	"methodname" => "ccvs_return", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_return ( string session, string invoice )", 
	"snippet" => "( \${1:\$session}, \${2:\$invoice} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-return.html" 
),
"ccvs_reverse" => array( 
	"methodname" => "ccvs_reverse", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_reverse ( string session, string invoice )", 
	"snippet" => "( \${1:\$session}, \${2:\$invoice} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-reverse.html" 
),
"ccvs_sale" => array( 
	"methodname" => "ccvs_sale", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_sale ( string session, string invoice )", 
	"snippet" => "( \${1:\$session}, \${2:\$invoice} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-sale.html" 
),
"ccvs_status" => array( 
	"methodname" => "ccvs_status", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_status ( string session, string invoice )", 
	"snippet" => "( \${1:\$session}, \${2:\$invoice} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-status.html" 
),
"ccvs_textvalue" => array( 
	"methodname" => "ccvs_textvalue", 
	"version" => "undefined", 
	"method" => "string ccvs_textvalue ( string session )", 
	"snippet" => "( \${1:\$session} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-textvalue.html" 
),
"ccvs_void" => array( 
	"methodname" => "ccvs_void", 
	"version" => "4.0.2 - 4.2.3 only", 
	"method" => "string ccvs_void ( string session, string invoice )", 
	"snippet" => "( \${1:\$session}, \${2:\$invoice} )", 
	"desc" => "", 
	"docurl" => "function.ccvs-void.html" 
),
"ceil" => array( 
	"methodname" => "ceil", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float ceil ( float value )", 
	"snippet" => "( \${1:\$value} )", 
	"desc" => "Round fractions up", 
	"docurl" => "function.ceil.html" 
),
"chdir" => array( 
	"methodname" => "chdir", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool chdir ( string directory )", 
	"snippet" => "( \${1:\$directory} )", 
	"desc" => "Change directory", 
	"docurl" => "function.chdir.html" 
),
"checkdate" => array( 
	"methodname" => "checkdate", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool checkdate ( int month, int day, int year )", 
	"snippet" => "( \${1:\$month}, \${2:\$day}, \${3:\$year} )", 
	"desc" => "Validate a Gregorian date", 
	"docurl" => "function.checkdate.html" 
),
"checkdnsrr" => array( 
	"methodname" => "checkdnsrr", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int checkdnsrr ( string host [, string type] )", 
	"snippet" => "( \${1:\$host} )", 
	"desc" => "Check DNS records corresponding to a given Internet host name or   IP address", 
	"docurl" => "function.checkdnsrr.html" 
),
"chgrp" => array( 
	"methodname" => "chgrp", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool chgrp ( string filename, mixed group )", 
	"snippet" => "( \${1:\$filename}, \${2:\$group} )", 
	"desc" => "Changes file group", 
	"docurl" => "function.chgrp.html" 
),
"chmod" => array( 
	"methodname" => "chmod", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool chmod ( string filename, int mode )", 
	"snippet" => "( \${1:\$filename}, \${2:\$mode} )", 
	"desc" => "Changes file mode", 
	"docurl" => "function.chmod.html" 
),
"chop" => array( 
	"methodname" => "chop", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "Alias of rtrim()", 
	"snippet" => "( \$1 )", 
	"desc" => "Alias of rtrim()\nNote: chop() is different than the Perl chop() function, which removes the last character in the string.", 
	"docurl" => "function.chop.html" 
),
"chown" => array( 
	"methodname" => "chown", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool chown ( string filename, mixed user )", 
	"snippet" => "( \${1:\$filename}, \${2:\$user} )", 
	"desc" => "Changes file owner", 
	"docurl" => "function.chown.html" 
),
"chr" => array( 
	"methodname" => "chr", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string chr ( int ascii )", 
	"snippet" => "( \${1:\$ascii} )", 
	"desc" => "Return a specific character", 
	"docurl" => "function.chr.html" 
),
"chroot" => array( 
	"methodname" => "chroot", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool chroot ( string directory )", 
	"snippet" => "( \${1:\$directory} )", 
	"desc" => "Change the root directory", 
	"docurl" => "function.chroot.html" 
),
"chunk_split" => array( 
	"methodname" => "chunk_split", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string chunk_split ( string body [, int chunklen [, string end]] )", 
	"snippet" => "( \${1:\$body} )", 
	"desc" => "Split a string into smaller chunks", 
	"docurl" => "function.chunk-split.html" 
),
"class_exists" => array( 
	"methodname" => "class_exists", 
	"version" => "PHP4, PHP5", 
	"method" => "bool class_exists ( string class_name [, bool autoload] )", 
	"snippet" => "( \${1:\$class_name} )", 
	"desc" => "Checks if the class has been defined", 
	"docurl" => "function.class-exists.html" 
),
"class_implements" => array( 
	"methodname" => "class_implements", 
	"version" => "PHP5", 
	"method" => "array class_implements ( object class )", 
	"snippet" => "( \${1:\$class} )", 
	"desc" => "Return the interfaces which are implemented by the given class", 
	"docurl" => "function.class-implements.html" 
),
"class_parents" => array( 
	"methodname" => "class_parents", 
	"version" => "PHP5", 
	"method" => "array class_parents ( object class )", 
	"snippet" => "( \${1:\$class} )", 
	"desc" => "Return the parent classes of the given class", 
	"docurl" => "function.class-parents.html" 
),
"classkit_import" => array( 
	"methodname" => "classkit_import", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "array classkit_import ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Import new class method definitions from a file\nNote: This function cannot be used to manipulate the currently running (or chained) method.", 
	"docurl" => "function.classkit-import.html" 
),
"classkit_method_add" => array( 
	"methodname" => "classkit_method_add", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool classkit_method_add ( string classname, string methodname, string args, string code [, int flags] )", 
	"snippet" => "( \${1:\$classname}, \${2:\$methodname}, \${3:\$args}, \${4:\$code} )", 
	"desc" => "Dynamically adds a new method to a given class", 
	"docurl" => "function.classkit-method-add.html" 
),
"classkit_method_copy" => array( 
	"methodname" => "classkit_method_copy", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool classkit_method_copy ( string dClass, string dMethod, string sClass [, string sMethod] )", 
	"snippet" => "( \${1:\$dClass}, \${2:\$dMethod}, \${3:\$sClass} )", 
	"desc" => "Copies a method from class to another", 
	"docurl" => "function.classkit-method-copy.html" 
),
"classkit_method_redefine" => array( 
	"methodname" => "classkit_method_redefine", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool classkit_method_redefine ( string classname, string methodname, string args, string code [, int flags] )", 
	"snippet" => "( \${1:\$classname}, \${2:\$methodname}, \${3:\$args}, \${4:\$code} )", 
	"desc" => "Dynamically changes the code of the given method", 
	"docurl" => "function.classkit-method-redefine.html" 
),
"classkit_method_remove" => array( 
	"methodname" => "classkit_method_remove", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool classkit_method_remove ( string classname, string methodname )", 
	"snippet" => "( \${1:\$classname}, \${2:\$methodname} )", 
	"desc" => "Dynamically removes the given method", 
	"docurl" => "function.classkit-method-remove.html" 
),
"classkit_method_rename" => array( 
	"methodname" => "classkit_method_rename", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "bool classkit_method_rename ( string classname, string methodname, string newname )", 
	"snippet" => "( \${1:\$classname}, \${2:\$methodname}, \${3:\$newname} )", 
	"desc" => "Dynamically changes the name of the given method", 
	"docurl" => "function.classkit-method-rename.html" 
),
"clearstatcache" => array( 
	"methodname" => "clearstatcache", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void clearstatcache ( void  )", 
	"snippet" => "( )", 
	"desc" => "Clears file status cache", 
	"docurl" => "function.clearstatcache.html" 
),
"closedir" => array( 
	"methodname" => "closedir", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void closedir ( resource dir_handle )", 
	"snippet" => "( \${1:\$dir_handle} )", 
	"desc" => "Close directory handle", 
	"docurl" => "function.closedir.html" 
),
"closelog" => array( 
	"methodname" => "closelog", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int closelog ( void  )", 
	"snippet" => "( )", 
	"desc" => "Close connection to system logger", 
	"docurl" => "function.closelog.html" 
),
"com_addref" => array( 
	"methodname" => "com_addref", 
	"version" => "PHP4 >= 4.1.0", 
	"method" => "void com_addref ( void  )", 
	"snippet" => "( )", 
	"desc" => "Increases the components reference counter [deprecated]", 
	"docurl" => "function.com-addref.html" 
),
"com_create_guid" => array( 
	"methodname" => "com_create_guid", 
	"version" => "PHP5", 
	"method" => "string com_create_guid ( void  )", 
	"snippet" => "( )", 
	"desc" => "Generate a globally unique identifier (GUID)", 
	"docurl" => "function.com-create-guid.html" 
),
"com_event_sink" => array( 
	"methodname" => "com_event_sink", 
	"version" => "PHP4 >= 4.2.3, PHP5", 
	"method" => "bool com_event_sink ( variant comobject, object sinkobject [, mixed sinkinterface] )", 
	"snippet" => "( \${1:\$comobject}, \${2:\$sinkobject} )", 
	"desc" => "Connect events from a COM object to a PHP object", 
	"docurl" => "function.com-event-sink.html" 
),
"com_get_active_object" => array( 
	"methodname" => "com_get_active_object", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "variant com_get_active_object ( string progid [, int code_page] )", 
	"snippet" => "( \${1:\$progid} )", 
	"desc" => "Returns a handle to an already running instance of a COM object", 
	"docurl" => "function.com-get-active-object.html" 
),
"com_get" => array( 
	"methodname" => "com_get", 
	"version" => "PHP3>= 3.0.3, PHP4 >= 4.0.5", 
	"method" => "mixed com_get ( resource com_object, string property )", 
	"snippet" => "( \${1:\$com_object}, \${2:\$property} )", 
	"desc" => "Gets the value of a COM Component\'s property [deprecated]", 
	"docurl" => "function.com-get.html" 
),
"com_invoke" => array( 
	"methodname" => "com_invoke", 
	"version" => "PHP3>= 3.0.3", 
	"method" => "mixed com_invoke ( resource com_object, string function_name [, mixed function_parameters] )", 
	"snippet" => "( \${1:\$com_object}, \${2:\$function_name} )", 
	"desc" => "Calls a COM component\'s method [deprecated]", 
	"docurl" => "function.com-invoke.html" 
),
"com_isenum" => array( 
	"methodname" => "com_isenum", 
	"version" => "PHP4 >= 4.1.0", 
	"method" => "bool com_isenum ( variant com_module )", 
	"snippet" => "( \${1:\$com_module} )", 
	"desc" => "Indicates if a COM object has an IEnumVariant interface for iteration [deprecated]", 
	"docurl" => "function.com-isenum.html" 
),
"com_load_typelib" => array( 
	"methodname" => "com_load_typelib", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool com_load_typelib ( string typelib_name [, bool case_insensitive] )", 
	"snippet" => "( \${1:\$typelib_name} )", 
	"desc" => "Loads a Typelib", 
	"docurl" => "function.com-load-typelib.html" 
),
"com_load" => array( 
	"methodname" => "com_load", 
	"version" => "PHP3>= 3.0.3", 
	"method" => "resource com_load ( string module_name [, string server_name [, int codepage]] )", 
	"snippet" => "( \${1:\$module_name} )", 
	"desc" => "Creates a new reference to a COM component [deprecated]", 
	"docurl" => "function.com-load.html" 
),
"com_message_pump" => array( 
	"methodname" => "com_message_pump", 
	"version" => "PHP4 >= 4.2.3, PHP5", 
	"method" => "bool com_message_pump ( [int timeoutms] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Process COM messages, sleeping for up to timeoutms milliseconds", 
	"docurl" => "function.com-message-pump.html" 
),
"com_print_typeinfo" => array( 
	"methodname" => "com_print_typeinfo", 
	"version" => "PHP4 >= 4.2.3, PHP5", 
	"method" => "bool com_print_typeinfo ( object comobject [, string dispinterface [, bool wantsink]] )", 
	"snippet" => "( \${1:\$comobject} )", 
	"desc" => "Print out a PHP class definition for a dispatchable interface", 
	"docurl" => "function.com-print-typeinfo.html" 
),
"com_propget" => array( 
	"methodname" => "com_propget", 
	"version" => "(PHP3>= 3.0.3, PHP4 >= 4.0.5)", 
	"method" => "Alias of com_get()", 
	"snippet" => "( \$1 )", 
	"desc" => "This function is an alias for com_get().", 
	"docurl" => "function.com-propget.html" 
),
"com_propput" => array( 
	"methodname" => "com_propput", 
	"version" => "(PHP3>= 3.0.3, PHP4 >= 4.0.5)", 
	"method" => "Alias of com_set()", 
	"snippet" => "( \$1 )", 
	"desc" => "This function is an alias for com_set().", 
	"docurl" => "function.com-propput.html" 
),
"com_propset" => array( 
	"methodname" => "com_propset", 
	"version" => "(PHP3>= 3.0.3, PHP4 >= 4.0.5)", 
	"method" => "Alias of com_set()", 
	"snippet" => "( \$1 )", 
	"desc" => "This function is an alias for com_set().", 
	"docurl" => "function.com-propset.html" 
),
"com_release" => array( 
	"methodname" => "com_release", 
	"version" => "PHP4 >= 4.1.0", 
	"method" => "void com_release ( void  )", 
	"snippet" => "( )", 
	"desc" => "Decreases the components reference counter [deprecated]", 
	"docurl" => "function.com-release.html" 
),
"com_set" => array( 
	"methodname" => "com_set", 
	"version" => "PHP3>= 3.0.3, PHP4 >= 4.0.5", 
	"method" => "void com_set ( resource com_object, string property, mixed value )", 
	"snippet" => "( \${1:\$com_object}, \${2:\$property}, \${3:\$value} )", 
	"desc" => "Assigns a value to a COM component\'s property", 
	"docurl" => "function.com-set.html" 
),
"compact" => array( 
	"methodname" => "compact", 
	"version" => "PHP4, PHP5", 
	"method" => "array compact ( mixed varname [, mixed ...] )", 
	"snippet" => "( \${1:\$varname} )", 
	"desc" => "Create array containing variables and their values", 
	"docurl" => "function.compact.html" 
),
"connection_aborted" => array( 
	"methodname" => "connection_aborted", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int connection_aborted ( void  )", 
	"snippet" => "( )", 
	"desc" => "Returns TRUE if client disconnected", 
	"docurl" => "function.connection-aborted.html" 
),
"connection_status" => array( 
	"methodname" => "connection_status", 
	"version" => "PHP3>= 3.0.7, PHP4, PHP5", 
	"method" => "int connection_status ( void  )", 
	"snippet" => "( )", 
	"desc" => "Returns connection status bitfield", 
	"docurl" => "function.connection-status.html" 
),
"connection_timeout" => array( 
	"methodname" => "connection_timeout", 
	"version" => "PHP3>= 3.0.7, PHP4  <= 4.0.4", 
	"method" => "bool connection_timeout ( void  )", 
	"snippet" => "( )", 
	"desc" => "Return TRUE if script timed out", 
	"docurl" => "function.connection-timeout.html" 
),
"constant" => array( 
	"methodname" => "constant", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "mixed constant ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "Returns the value of a constant", 
	"docurl" => "function.constant.html" 
),
"convert_cyr_string" => array( 
	"methodname" => "convert_cyr_string", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string convert_cyr_string ( string str, string from, string to )", 
	"snippet" => "( \${1:\$str}, \${2:\$from}, \${3:\$to} )", 
	"desc" => "Convert from one Cyrillic character set to another", 
	"docurl" => "function.convert-cyr-string.html" 
),
"convert_uudecode" => array( 
	"methodname" => "convert_uudecode", 
	"version" => "PHP5", 
	"method" => "string convert_uudecode ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Decode a uuencoded string", 
	"docurl" => "function.convert-uudecode.html" 
),
"convert_uuencode" => array( 
	"methodname" => "convert_uuencode", 
	"version" => "PHP5", 
	"method" => "string convert_uuencode ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "Uuencode a string", 
	"docurl" => "function.convert-uuencode.html" 
),
"copy" => array( 
	"methodname" => "copy", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool copy ( string source, string dest )", 
	"snippet" => "( \${1:\$source}, \${2:\$dest} )", 
	"desc" => "Copies file", 
	"docurl" => "function.copy.html" 
),
"cos" => array( 
	"methodname" => "cos", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float cos ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Cosine", 
	"docurl" => "function.cos.html" 
),
"cosh" => array( 
	"methodname" => "cosh", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float cosh ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Hyperbolic cosine", 
	"docurl" => "function.cosh.html" 
),
"count_chars" => array( 
	"methodname" => "count_chars", 
	"version" => "PHP4, PHP5", 
	"method" => "mixed count_chars ( string string [, int mode] )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Return information about characters used in a string", 
	"docurl" => "function.count-chars.html" 
),
"count" => array( 
	"methodname" => "count", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int count ( mixed var [, int mode] )", 
	"snippet" => "( \${1:\$var} )", 
	"desc" => "Count elements in an array, or properties in an object", 
	"docurl" => "function.count.html" 
),
"cpdf_add_annotation" => array( 
	"methodname" => "cpdf_add_annotation", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "bool cpdf_add_annotation ( int pdf_document, float llx, float lly, float urx, float ury, string title, string content [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$llx}, \${3:\$lly}, \${4:\$urx}, \${5:\$ury}, \${6:\$title}, \${7:\$content} )", 
	"desc" => "Adds annotation", 
	"docurl" => "function.cpdf-add-annotation.html" 
),
"cpdf_add_outline" => array( 
	"methodname" => "cpdf_add_outline", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "int cpdf_add_outline ( int pdf_document, int lastoutline, int sublevel, int open, int pagenr, string text )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$lastoutline}, \${3:\$sublevel}, \${4:\$open}, \${5:\$pagenr}, \${6:\$text} )", 
	"desc" => "Adds bookmark for current page", 
	"docurl" => "function.cpdf-add-outline.html" 
),
"cpdf_arc" => array( 
	"methodname" => "cpdf_arc", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_arc ( int pdf_document, float x_coor, float y_coor, float radius, float start, float end [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x_coor}, \${3:\$y_coor}, \${4:\$radius}, \${5:\$start}, \${6:\$end} )", 
	"desc" => "Draws an arc", 
	"docurl" => "function.cpdf-arc.html" 
),
"cpdf_begin_text" => array( 
	"methodname" => "cpdf_begin_text", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_begin_text ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Starts text section", 
	"docurl" => "function.cpdf-begin-text.html" 
),
"cpdf_circle" => array( 
	"methodname" => "cpdf_circle", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_circle ( int pdf_document, float x_coor, float y_coor, float radius [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x_coor}, \${3:\$y_coor}, \${4:\$radius} )", 
	"desc" => "Draw a circle", 
	"docurl" => "function.cpdf-circle.html" 
),
"cpdf_clip" => array( 
	"methodname" => "cpdf_clip", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_clip ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Clips to current path", 
	"docurl" => "function.cpdf-clip.html" 
),
"cpdf_close" => array( 
	"methodname" => "cpdf_close", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_close ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Closes the pdf document", 
	"docurl" => "function.cpdf-close.html" 
),
"cpdf_closepath_fill_stroke" => array( 
	"methodname" => "cpdf_closepath_fill_stroke", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_closepath_fill_stroke ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Close, fill and stroke current path", 
	"docurl" => "function.cpdf-closepath-fill-stroke.html" 
),
"cpdf_closepath_stroke" => array( 
	"methodname" => "cpdf_closepath_stroke", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_closepath_stroke ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Close path and draw line along path", 
	"docurl" => "function.cpdf-closepath-stroke.html" 
),
"cpdf_closepath" => array( 
	"methodname" => "cpdf_closepath", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_closepath ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Close path", 
	"docurl" => "function.cpdf-closepath.html" 
),
"cpdf_continue_text" => array( 
	"methodname" => "cpdf_continue_text", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_continue_text ( int pdf_document, string text )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$text} )", 
	"desc" => "Output text in next line", 
	"docurl" => "function.cpdf-continue-text.html" 
),
"cpdf_curveto" => array( 
	"methodname" => "cpdf_curveto", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_curveto ( int pdf_document, float x1, float y1, float x2, float y2, float x3, float y3 [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x1}, \${3:\$y1}, \${4:\$x2}, \${5:\$y2}, \${6:\$x3}, \${7:\$y3} )", 
	"desc" => "Draws a curve", 
	"docurl" => "function.cpdf-curveto.html" 
),
"cpdf_end_text" => array( 
	"methodname" => "cpdf_end_text", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_end_text ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Ends text section", 
	"docurl" => "function.cpdf-end-text.html" 
),
"cpdf_fill_stroke" => array( 
	"methodname" => "cpdf_fill_stroke", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_fill_stroke ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Fill and stroke current path", 
	"docurl" => "function.cpdf-fill-stroke.html" 
),
"cpdf_fill" => array( 
	"methodname" => "cpdf_fill", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_fill ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Fill current path", 
	"docurl" => "function.cpdf-fill.html" 
),
"cpdf_finalize_page" => array( 
	"methodname" => "cpdf_finalize_page", 
	"version" => "PHP3>= 3.0.10, PHP4, PHP5", 
	"method" => "bool cpdf_finalize_page ( int pdf_document, int page_number )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$page_number} )", 
	"desc" => "Ends page", 
	"docurl" => "function.cpdf-finalize-page.html" 
),
"cpdf_finalize" => array( 
	"methodname" => "cpdf_finalize", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_finalize ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Ends document", 
	"docurl" => "function.cpdf-finalize.html" 
),
"cpdf_global_set_document_limits" => array( 
	"methodname" => "cpdf_global_set_document_limits", 
	"version" => "PHP4, PHP5", 
	"method" => "bool cpdf_global_set_document_limits ( int maxpages, int maxfonts, int maximages, int maxannotations, int maxobjects )", 
	"snippet" => "( \${1:\$maxpages}, \${2:\$maxfonts}, \${3:\$maximages}, \${4:\$maxannotations}, \${5:\$maxobjects} )", 
	"desc" => "Sets document limits for any pdf document", 
	"docurl" => "function.cpdf-global-set-document-limits.html" 
),
"cpdf_import_jpeg" => array( 
	"methodname" => "cpdf_import_jpeg", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "int cpdf_import_jpeg ( int pdf_document, string file_name, float x_coor, float y_coor, float angle, float width, float height, float x_scale, float y_scale, int gsave [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$file_name}, \${3:\$x_coor}, \${4:\$y_coor}, \${5:\$angle}, \${6:\$width}, \${7:\$height}, \${8:\$x_scale}, \${9:\$y_scale}, \${10:\$gsave} )", 
	"desc" => "Opens a JPEG image", 
	"docurl" => "function.cpdf-import-jpeg.html" 
),
"cpdf_lineto" => array( 
	"methodname" => "cpdf_lineto", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_lineto ( int pdf_document, float x_coor, float y_coor [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x_coor}, \${3:\$y_coor} )", 
	"desc" => "Draws a line", 
	"docurl" => "function.cpdf-lineto.html" 
),
"cpdf_moveto" => array( 
	"methodname" => "cpdf_moveto", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_moveto ( int pdf_document, float x_coor, float y_coor [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x_coor}, \${3:\$y_coor} )", 
	"desc" => "Sets current point", 
	"docurl" => "function.cpdf-moveto.html" 
),
"cpdf_newpath" => array( 
	"methodname" => "cpdf_newpath", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool cpdf_newpath ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Starts a new path", 
	"docurl" => "function.cpdf-newpath.html" 
),
"cpdf_open" => array( 
	"methodname" => "cpdf_open", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "int cpdf_open ( int compression [, string filename [, array doc_limits]] )", 
	"snippet" => "( \${1:\$compression} )", 
	"desc" => "Opens a new pdf document", 
	"docurl" => "function.cpdf-open.html" 
),
"cpdf_output_buffer" => array( 
	"methodname" => "cpdf_output_buffer", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool cpdf_output_buffer ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Outputs the pdf document in memory buffer", 
	"docurl" => "function.cpdf-output-buffer.html" 
),
"cpdf_page_init" => array( 
	"methodname" => "cpdf_page_init", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_page_init ( int pdf_document, int page_number, int orientation, float height, float width [, float unit] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$page_number}, \${3:\$orientation}, \${4:\$height}, \${5:\$width} )", 
	"desc" => "Starts new page", 
	"docurl" => "function.cpdf-page-init.html" 
),
"cpdf_place_inline_image" => array( 
	"methodname" => "cpdf_place_inline_image", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool cpdf_place_inline_image ( int pdf_document, int image, float x_coor, float y_coor, float angle, float width, float height, int gsave [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$image}, \${3:\$x_coor}, \${4:\$y_coor}, \${5:\$angle}, \${6:\$width}, \${7:\$height}, \${8:\$gsave} )", 
	"desc" => "Places an image on the page", 
	"docurl" => "function.cpdf-place-inline-image.html" 
),
"cpdf_rect" => array( 
	"methodname" => "cpdf_rect", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_rect ( int pdf_document, float x_coor, float y_coor, float width, float height [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x_coor}, \${3:\$y_coor}, \${4:\$width}, \${5:\$height} )", 
	"desc" => "Draw a rectangle", 
	"docurl" => "function.cpdf-rect.html" 
),
"cpdf_restore" => array( 
	"methodname" => "cpdf_restore", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_restore ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Restores formerly saved environment", 
	"docurl" => "function.cpdf-restore.html" 
),
"cpdf_rlineto" => array( 
	"methodname" => "cpdf_rlineto", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool cpdf_rlineto ( int pdf_document, float x_coor, float y_coor [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x_coor}, \${3:\$y_coor} )", 
	"desc" => "Draws a line", 
	"docurl" => "function.cpdf-rlineto.html" 
),
"cpdf_rmoveto" => array( 
	"methodname" => "cpdf_rmoveto", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool cpdf_rmoveto ( int pdf_document, float x_coor, float y_coor [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x_coor}, \${3:\$y_coor} )", 
	"desc" => "Sets current point", 
	"docurl" => "function.cpdf-rmoveto.html" 
),
"cpdf_rotate_text" => array( 
	"methodname" => "cpdf_rotate_text", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool cpdf_rotate_text ( int pdfdoc, float angle )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$angle} )", 
	"desc" => "Sets text rotation angle", 
	"docurl" => "function.cpdf-rotate-text.html" 
),
"cpdf_rotate" => array( 
	"methodname" => "cpdf_rotate", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_rotate ( int pdf_document, float angle )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$angle} )", 
	"desc" => "Sets rotation", 
	"docurl" => "function.cpdf-rotate.html" 
),
"cpdf_save_to_file" => array( 
	"methodname" => "cpdf_save_to_file", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_save_to_file ( int pdf_document, string filename )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$filename} )", 
	"desc" => "Writes the pdf document into a file", 
	"docurl" => "function.cpdf-save-to-file.html" 
),
"cpdf_save" => array( 
	"methodname" => "cpdf_save", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_save ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Saves current environment", 
	"docurl" => "function.cpdf-save.html" 
),
"cpdf_scale" => array( 
	"methodname" => "cpdf_scale", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_scale ( int pdf_document, float x_scale, float y_scale )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x_scale}, \${3:\$y_scale} )", 
	"desc" => "Sets scaling", 
	"docurl" => "function.cpdf-scale.html" 
),
"cpdf_set_action_url" => array( 
	"methodname" => "cpdf_set_action_url", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool cpdf_set_action_url ( int pdfdoc, float xll, float yll, float xur, float xur, string url [, int mode] )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$xll}, \${3:\$yll}, \${4:\$xur}, \${5:\$xur}, \${6:\$url} )", 
	"desc" => "Sets hyperlink", 
	"docurl" => "function.cpdf-set-action-url.html" 
),
"cpdf_set_char_spacing" => array( 
	"methodname" => "cpdf_set_char_spacing", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_char_spacing ( int pdf_document, float space )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$space} )", 
	"desc" => "Sets character spacing", 
	"docurl" => "function.cpdf-set-char-spacing.html" 
),
"cpdf_set_creator" => array( 
	"methodname" => "cpdf_set_creator", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_creator ( int pdf_document, string creator )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$creator} )", 
	"desc" => "Sets the creator field in the pdf document", 
	"docurl" => "function.cpdf-set-creator.html" 
),
"cpdf_set_current_page" => array( 
	"methodname" => "cpdf_set_current_page", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool cpdf_set_current_page ( int pdf_document, int page_number )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$page_number} )", 
	"desc" => "Sets current page", 
	"docurl" => "function.cpdf-set-current-page.html" 
),
"cpdf_set_font_directories" => array( 
	"methodname" => "cpdf_set_font_directories", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool cpdf_set_font_directories ( int pdfdoc, string pfmdir, string pfbdir )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$pfmdir}, \${3:\$pfbdir} )", 
	"desc" => "Sets directories to search when using external fonts", 
	"docurl" => "function.cpdf-set-font-directories.html" 
),
"cpdf_set_font_map_file" => array( 
	"methodname" => "cpdf_set_font_map_file", 
	"version" => "PHP4 >= 4.0.6, PHP5", 
	"method" => "bool cpdf_set_font_map_file ( int pdfdoc, string filename )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$filename} )", 
	"desc" => "Sets fontname to filename translation map when using external fonts", 
	"docurl" => "function.cpdf-set-font-map-file.html" 
),
"cpdf_set_font" => array( 
	"methodname" => "cpdf_set_font", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_font ( int pdf_document, string font_name, float size, string encoding )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$font_name}, \${3:\$size}, \${4:\$encoding} )", 
	"desc" => "Select the current font face and size", 
	"docurl" => "function.cpdf-set-font.html" 
),
"cpdf_set_horiz_scaling" => array( 
	"methodname" => "cpdf_set_horiz_scaling", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_horiz_scaling ( int pdf_document, float scale )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$scale} )", 
	"desc" => "Sets horizontal scaling of text", 
	"docurl" => "function.cpdf-set-horiz-scaling.html" 
),
"cpdf_set_keywords" => array( 
	"methodname" => "cpdf_set_keywords", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_keywords ( int pdf_document, string keywords )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$keywords} )", 
	"desc" => "Sets the keywords field of the pdf document", 
	"docurl" => "function.cpdf-set-keywords.html" 
),
"cpdf_set_leading" => array( 
	"methodname" => "cpdf_set_leading", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_leading ( int pdf_document, float distance )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$distance} )", 
	"desc" => "Sets distance between text lines", 
	"docurl" => "function.cpdf-set-leading.html" 
),
"cpdf_set_page_animation" => array( 
	"methodname" => "cpdf_set_page_animation", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool cpdf_set_page_animation ( int pdf_document, int transition, float duration, float direction, int orientation, int inout )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$transition}, \${3:\$duration}, \${4:\$direction}, \${5:\$orientation}, \${6:\$inout} )", 
	"desc" => "Sets duration between pages", 
	"docurl" => "function.cpdf-set-page-animation.html" 
),
"cpdf_set_subject" => array( 
	"methodname" => "cpdf_set_subject", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_subject ( int pdf_document, string subject )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$subject} )", 
	"desc" => "Sets the subject field of the pdf document", 
	"docurl" => "function.cpdf-set-subject.html" 
),
"cpdf_set_text_matrix" => array( 
	"methodname" => "cpdf_set_text_matrix", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_text_matrix ( int pdf_document, array matrix )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$matrix} )", 
	"desc" => "Sets the text matrix", 
	"docurl" => "function.cpdf-set-text-matrix.html" 
),
"cpdf_set_text_pos" => array( 
	"methodname" => "cpdf_set_text_pos", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_text_pos ( int pdf_document, float x_coor, float y_coor [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x_coor}, \${3:\$y_coor} )", 
	"desc" => "Sets text position", 
	"docurl" => "function.cpdf-set-text-pos.html" 
),
"cpdf_set_text_rendering" => array( 
	"methodname" => "cpdf_set_text_rendering", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_text_rendering ( int pdf_document, int rendermode )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$rendermode} )", 
	"desc" => "Determines how text is rendered", 
	"docurl" => "function.cpdf-set-text-rendering.html" 
),
"cpdf_set_text_rise" => array( 
	"methodname" => "cpdf_set_text_rise", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_text_rise ( int pdf_document, float value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$value} )", 
	"desc" => "Sets the text rise", 
	"docurl" => "function.cpdf-set-text-rise.html" 
),
"cpdf_set_title" => array( 
	"methodname" => "cpdf_set_title", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_title ( int pdf_document, string title )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$title} )", 
	"desc" => "Sets the title field of the pdf document", 
	"docurl" => "function.cpdf-set-title.html" 
),
"cpdf_set_viewer_preferences" => array( 
	"methodname" => "cpdf_set_viewer_preferences", 
	"version" => "PHP3>= 3.0.9, PHP4, PHP5", 
	"method" => "bool cpdf_set_viewer_preferences ( int pdfdoc, array preferences )", 
	"snippet" => "( \${1:\$pdfdoc}, \${2:\$preferences} )", 
	"desc" => "How to show the document in the viewer", 
	"docurl" => "function.cpdf-set-viewer-preferences.html" 
),
"cpdf_set_word_spacing" => array( 
	"methodname" => "cpdf_set_word_spacing", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_set_word_spacing ( int pdf_document, float space )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$space} )", 
	"desc" => "Sets spacing between words", 
	"docurl" => "function.cpdf-set-word-spacing.html" 
),
"cpdf_setdash" => array( 
	"methodname" => "cpdf_setdash", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setdash ( int pdf_document, float white, float black )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$white}, \${3:\$black} )", 
	"desc" => "Sets dash pattern", 
	"docurl" => "function.cpdf-setdash.html" 
),
"cpdf_setflat" => array( 
	"methodname" => "cpdf_setflat", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setflat ( int pdf_document, float value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$value} )", 
	"desc" => "Sets flatness", 
	"docurl" => "function.cpdf-setflat.html" 
),
"cpdf_setgray_fill" => array( 
	"methodname" => "cpdf_setgray_fill", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setgray_fill ( int pdf_document, float value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$value} )", 
	"desc" => "Sets filling color to gray value", 
	"docurl" => "function.cpdf-setgray-fill.html" 
),
"cpdf_setgray_stroke" => array( 
	"methodname" => "cpdf_setgray_stroke", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setgray_stroke ( int pdf_document, float gray_value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$gray_value} )", 
	"desc" => "Sets drawing color to gray value", 
	"docurl" => "function.cpdf-setgray-stroke.html" 
),
"cpdf_setgray" => array( 
	"methodname" => "cpdf_setgray", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setgray ( int pdf_document, float gray_value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$gray_value} )", 
	"desc" => "Sets drawing and filling color to gray value", 
	"docurl" => "function.cpdf-setgray.html" 
),
"cpdf_setlinecap" => array( 
	"methodname" => "cpdf_setlinecap", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setlinecap ( int pdf_document, int value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$value} )", 
	"desc" => "Sets linecap parameter", 
	"docurl" => "function.cpdf-setlinecap.html" 
),
"cpdf_setlinejoin" => array( 
	"methodname" => "cpdf_setlinejoin", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setlinejoin ( int pdf_document, int value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$value} )", 
	"desc" => "Sets linejoin parameter", 
	"docurl" => "function.cpdf-setlinejoin.html" 
),
"cpdf_setlinewidth" => array( 
	"methodname" => "cpdf_setlinewidth", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setlinewidth ( int pdf_document, float width )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$width} )", 
	"desc" => "Sets line width", 
	"docurl" => "function.cpdf-setlinewidth.html" 
),
"cpdf_setmiterlimit" => array( 
	"methodname" => "cpdf_setmiterlimit", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setmiterlimit ( int pdf_document, float value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$value} )", 
	"desc" => "Sets miter limit", 
	"docurl" => "function.cpdf-setmiterlimit.html" 
),
"cpdf_setrgbcolor_fill" => array( 
	"methodname" => "cpdf_setrgbcolor_fill", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setrgbcolor_fill ( int pdf_document, float red_value, float green_value, float blue_value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$red_value}, \${3:\$green_value}, \${4:\$blue_value} )", 
	"desc" => "Sets filling color to rgb color value", 
	"docurl" => "function.cpdf-setrgbcolor-fill.html" 
),
"cpdf_setrgbcolor_stroke" => array( 
	"methodname" => "cpdf_setrgbcolor_stroke", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setrgbcolor_stroke ( int pdf_document, float red_value, float green_value, float blue_value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$red_value}, \${3:\$green_value}, \${4:\$blue_value} )", 
	"desc" => "Sets drawing color to rgb color value", 
	"docurl" => "function.cpdf-setrgbcolor-stroke.html" 
),
"cpdf_setrgbcolor" => array( 
	"methodname" => "cpdf_setrgbcolor", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_setrgbcolor ( int pdf_document, float red_value, float green_value, float blue_value )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$red_value}, \${3:\$green_value}, \${4:\$blue_value} )", 
	"desc" => "Sets drawing and filling color to rgb color value", 
	"docurl" => "function.cpdf-setrgbcolor.html" 
),
"cpdf_show_xy" => array( 
	"methodname" => "cpdf_show_xy", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_show_xy ( int pdf_document, string text, float x_coor, float y_coor [, int mode] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$text}, \${3:\$x_coor}, \${4:\$y_coor} )", 
	"desc" => "Output text at position", 
	"docurl" => "function.cpdf-show-xy.html" 
),
"cpdf_show" => array( 
	"methodname" => "cpdf_show", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_show ( int pdf_document, string text )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$text} )", 
	"desc" => "Output text at current position", 
	"docurl" => "function.cpdf-show.html" 
),
"cpdf_stringwidth" => array( 
	"methodname" => "cpdf_stringwidth", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "float cpdf_stringwidth ( int pdf_document, string text )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$text} )", 
	"desc" => "Returns width of text in current font", 
	"docurl" => "function.cpdf-stringwidth.html" 
),
"cpdf_stroke" => array( 
	"methodname" => "cpdf_stroke", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_stroke ( int pdf_document )", 
	"snippet" => "( \${1:\$pdf_document} )", 
	"desc" => "Draw line along path", 
	"docurl" => "function.cpdf-stroke.html" 
),
"cpdf_text" => array( 
	"methodname" => "cpdf_text", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_text ( int pdf_document, string text [, float x_coor, float y_coor [, int mode [, float orientation [, int alignmode]]]] )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$text} )", 
	"desc" => "Output text with parameters", 
	"docurl" => "function.cpdf-text.html" 
),
"cpdf_translate" => array( 
	"methodname" => "cpdf_translate", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool cpdf_translate ( int pdf_document, float x_coor, float y_coor )", 
	"snippet" => "( \${1:\$pdf_document}, \${2:\$x_coor}, \${3:\$y_coor} )", 
	"desc" => "Sets origin of coordinate system", 
	"docurl" => "function.cpdf-translate.html" 
),
"crack_check" => array( 
	"methodname" => "crack_check", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "bool crack_check ( resource dictionary, string password )", 
	"snippet" => "( \${1:\$dictionary}, \${2:\$password} )", 
	"desc" => "Performs an obscure check with the given password", 
	"docurl" => "function.crack-check.html" 
),
"crack_closedict" => array( 
	"methodname" => "crack_closedict", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "bool crack_closedict ( [resource dictionary] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Closes an open CrackLib dictionary", 
	"docurl" => "function.crack-closedict.html" 
),
"crack_getlastmessage" => array( 
	"methodname" => "crack_getlastmessage", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "string crack_getlastmessage ( void  )", 
	"snippet" => "( )", 
	"desc" => "Returns the message from the last obscure check", 
	"docurl" => "function.crack-getlastmessage.html" 
),
"crack_opendict" => array( 
	"methodname" => "crack_opendict", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "resource crack_opendict ( string dictionary )", 
	"snippet" => "( \${1:\$dictionary} )", 
	"desc" => "Opens a new CrackLib dictionary", 
	"docurl" => "function.crack-opendict.html" 
),
"crc32" => array( 
	"methodname" => "crc32", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "int crc32 ( string str )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Calculates the crc32 polynomial of a string", 
	"docurl" => "function.crc32.html" 
),
"create_function" => array( 
	"methodname" => "create_function", 
	"version" => "PHP4 >= 4.0.1, PHP5", 
	"method" => "string create_function ( string args, string code )", 
	"snippet" => "( \${1:\$args}, \${2:\$code} )", 
	"desc" => "Create an anonymous (lambda-style) function", 
	"docurl" => "function.create-function.html" 
),
"crypt" => array( 
	"methodname" => "crypt", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string crypt ( string str [, string salt] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "One-way string encryption (hashing)", 
	"docurl" => "function.crypt.html" 
),
"ctype_alnum" => array( 
	"methodname" => "ctype_alnum", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_alnum ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for alphanumeric character(s)", 
	"docurl" => "function.ctype-alnum.html" 
),
"ctype_alpha" => array( 
	"methodname" => "ctype_alpha", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_alpha ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for alphabetic character(s)", 
	"docurl" => "function.ctype-alpha.html" 
),
"ctype_cntrl" => array( 
	"methodname" => "ctype_cntrl", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_cntrl ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for control character(s)", 
	"docurl" => "function.ctype-cntrl.html" 
),
"ctype_digit" => array( 
	"methodname" => "ctype_digit", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_digit ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for numeric character(s)", 
	"docurl" => "function.ctype-digit.html" 
),
"ctype_graph" => array( 
	"methodname" => "ctype_graph", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_graph ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for any printable character(s) except space", 
	"docurl" => "function.ctype-graph.html" 
),
"ctype_lower" => array( 
	"methodname" => "ctype_lower", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_lower ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for lowercase character(s)", 
	"docurl" => "function.ctype-lower.html" 
),
"ctype_print" => array( 
	"methodname" => "ctype_print", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_print ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for printable character(s)", 
	"docurl" => "function.ctype-print.html" 
),
"ctype_punct" => array( 
	"methodname" => "ctype_punct", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_punct ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for any printable character which is not whitespace or an  alphanumeric character", 
	"docurl" => "function.ctype-punct.html" 
),
"ctype_space" => array( 
	"methodname" => "ctype_space", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_space ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for whitespace character(s)", 
	"docurl" => "function.ctype-space.html" 
),
"ctype_upper" => array( 
	"methodname" => "ctype_upper", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_upper ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for uppercase character(s)", 
	"docurl" => "function.ctype-upper.html" 
),
"ctype_xdigit" => array( 
	"methodname" => "ctype_xdigit", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ctype_xdigit ( string text )", 
	"snippet" => "( \${1:\$text} )", 
	"desc" => "Check for character(s) representing a hexadecimal digit", 
	"docurl" => "function.ctype-xdigit.html" 
),
"curl_close" => array( 
	"methodname" => "curl_close", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "void curl_close ( resource ch )", 
	"snippet" => "( \${1:\$ch} )", 
	"desc" => "Close a CURL session", 
	"docurl" => "function.curl-close.html" 
),
"curl_copy_handle" => array( 
	"methodname" => "curl_copy_handle", 
	"version" => "PHP5", 
	"method" => "resource curl_copy_handle ( resource ch )", 
	"snippet" => "( \${1:\$ch} )", 
	"desc" => "Copy a cURL handle along with all of it\'s preferences", 
	"docurl" => "function.curl-copy-handle.html" 
),
"curl_errno" => array( 
	"methodname" => "curl_errno", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "int curl_errno ( resource ch )", 
	"snippet" => "( \${1:\$ch} )", 
	"desc" => "Return the last error number", 
	"docurl" => "function.curl-errno.html" 
),
"curl_error" => array( 
	"methodname" => "curl_error", 
	"version" => "PHP4 >= 4.0.3, PHP5", 
	"method" => "string curl_error ( resource ch )", 
	"snippet" => "( \${1:\$ch} )", 
	"desc" => "Return a string containing the last error for the current session", 
	"docurl" => "function.curl-error.html" 
),
"curl_exec" => array( 
	"methodname" => "curl_exec", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "mixed curl_exec ( resource ch )", 
	"snippet" => "( \${1:\$ch} )", 
	"desc" => "Perform a CURL session", 
	"docurl" => "function.curl-exec.html" 
),
"curl_getinfo" => array( 
	"methodname" => "curl_getinfo", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "string curl_getinfo ( resource ch [, int opt] )", 
	"snippet" => "( \${1:\$ch} )", 
	"desc" => "Get information regarding a specific transfer", 
	"docurl" => "function.curl-getinfo.html" 
),
"curl_init" => array( 
	"methodname" => "curl_init", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "resource curl_init ( [string url] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Initialize a CURL session", 
	"docurl" => "function.curl-init.html" 
),
"curl_multi_add_handle" => array( 
	"methodname" => "curl_multi_add_handle", 
	"version" => "PHP5", 
	"method" => "int curl_multi_add_handle ( resource mh, resource ch )", 
	"snippet" => "( \${1:\$mh}, \${2:\$ch} )", 
	"desc" => "Add a normal cURL handle to a cURL multi handle", 
	"docurl" => "function.curl-multi-add-handle.html" 
),
"curl_multi_close" => array( 
	"methodname" => "curl_multi_close", 
	"version" => "PHP5", 
	"method" => "void curl_multi_close ( resource mh )", 
	"snippet" => "( \${1:\$mh} )", 
	"desc" => "Close a set of cURL handles", 
	"docurl" => "function.curl-multi-close.html" 
),
"curl_multi_exec" => array( 
	"methodname" => "curl_multi_exec", 
	"version" => "PHP5", 
	"method" => "int curl_multi_exec ( resource mh, int &still_running )", 
	"snippet" => "( \${1:\$mh}, \${2:\$still_running} )", 
	"desc" => "Run the sub-connections of the current cURL handle", 
	"docurl" => "function.curl-multi-exec.html" 
),
"curl_multi_getcontent" => array( 
	"methodname" => "curl_multi_getcontent", 
	"version" => "PHP5", 
	"method" => "string curl_multi_getcontent ( resource ch )", 
	"snippet" => "( \${1:\$ch} )", 
	"desc" => "Return the content of a cURL handle if CURLOPT_RETURNTRANSFER is set", 
	"docurl" => "function.curl-multi-getcontent.html" 
),
"curl_multi_info_read" => array( 
	"methodname" => "curl_multi_info_read", 
	"version" => "PHP5", 
	"method" => "array curl_multi_info_read ( resource mh )", 
	"snippet" => "( \${1:\$mh} )", 
	"desc" => "Get information about the current transfers", 
	"docurl" => "function.curl-multi-info-read.html" 
),
"curl_multi_init" => array( 
	"methodname" => "curl_multi_init", 
	"version" => "PHP5", 
	"method" => "resource curl_multi_init ( void  )", 
	"snippet" => "( )", 
	"desc" => "Returns a new cURL multi handle", 
	"docurl" => "function.curl-multi-init.html" 
),
"curl_multi_remove_handle" => array( 
	"methodname" => "curl_multi_remove_handle", 
	"version" => "PHP5", 
	"method" => "int curl_multi_remove_handle ( resource mh, resource ch )", 
	"snippet" => "( \${1:\$mh}, \${2:\$ch} )", 
	"desc" => "Remove a multi handle from a set of cURL handles", 
	"docurl" => "function.curl-multi-remove-handle.html" 
),
"curl_multi_select" => array( 
	"methodname" => "curl_multi_select", 
	"version" => "PHP5", 
	"method" => "int curl_multi_select ( resource mh [, float timeout] )", 
	"snippet" => "( \${1:\$mh} )", 
	"desc" => "Get all the sockets associated with the cURL extension, which can then    be \"selected\"", 
	"docurl" => "function.curl-multi-select.html" 
),
"curl_setopt" => array( 
	"methodname" => "curl_setopt", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool curl_setopt ( resource ch, int option, mixed value )", 
	"snippet" => "( \${1:\$ch}, \${2:\$option}, \${3:\$value} )", 
	"desc" => "Set an option for a CURL transfer", 
	"docurl" => "function.curl-setopt.html" 
),
"curl_version" => array( 
	"methodname" => "curl_version", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string curl_version ( [int version] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Return the current CURL version", 
	"docurl" => "function.curl-version.html" 
),
"current" => array( 
	"methodname" => "current", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "mixed current ( array &array )", 
	"snippet" => "( \${1:\$array} )", 
	"desc" => "Return the current element in an array", 
	"docurl" => "function.current.html" 
),
"cybercash_base64_decode" => array( 
	"methodname" => "cybercash_base64_decode", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "string cybercash_base64_decode ( string inbuff )", 
	"snippet" => "( \${1:\$inbuff} )", 
	"desc" => "base64 decode data for Cybercash", 
	"docurl" => "function.cybercash-base64-decode.html" 
),
"cybercash_base64_encode" => array( 
	"methodname" => "cybercash_base64_encode", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "string cybercash_base64_encode ( string inbuff )", 
	"snippet" => "( \${1:\$inbuff} )", 
	"desc" => "base64 encode data for Cybercash", 
	"docurl" => "function.cybercash-base64-encode.html" 
),
"cybercash_decr" => array( 
	"methodname" => "cybercash_decr", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "array cybercash_decr ( string wmk, string sk, string inbuff )", 
	"snippet" => "( \${1:\$wmk}, \${2:\$sk}, \${3:\$inbuff} )", 
	"desc" => "Cybercash decrypt", 
	"docurl" => "function.cybercash-decr.html" 
),
"cybercash_encr" => array( 
	"methodname" => "cybercash_encr", 
	"version" => "PHP4  <= 4.2.3", 
	"method" => "array cybercash_encr ( string wmk, string sk, string inbuff )", 
	"snippet" => "( \${1:\$wmk}, \${2:\$sk}, \${3:\$inbuff} )", 
	"desc" => "Cybercash encrypt", 
	"docurl" => "function.cybercash-encr.html" 
),
"cyrus_authenticate" => array( 
	"methodname" => "cyrus_authenticate", 
	"version" => "PHP4 >= 4.1.0", 
	"method" => "bool cyrus_authenticate ( resource connection [, string mechlist [, string service [, string user [, int minssf [, int maxssf [, string authname [, string password]]]]]]] )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Authenticate against a Cyrus IMAP server", 
	"docurl" => "function.cyrus-authenticate.html" 
),
"cyrus_bind" => array( 
	"methodname" => "cyrus_bind", 
	"version" => "PHP4 >= 4.1.0", 
	"method" => "bool cyrus_bind ( resource connection, array callbacks )", 
	"snippet" => "( \${1:\$connection}, \${2:\$callbacks} )", 
	"desc" => "Bind callbacks to a Cyrus IMAP connection", 
	"docurl" => "function.cyrus-bind.html" 
),
"cyrus_close" => array( 
	"methodname" => "cyrus_close", 
	"version" => "PHP4 >= 4.1.0", 
	"method" => "bool cyrus_close ( resource connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Close connection to a Cyrus IMAP server", 
	"docurl" => "function.cyrus-close.html" 
),
"cyrus_connect" => array( 
	"methodname" => "cyrus_connect", 
	"version" => "PHP4 >= 4.1.0", 
	"method" => "resource cyrus_connect ( [string host [, string port [, int flags]]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Connect to a Cyrus IMAP server", 
	"docurl" => "function.cyrus-connect.html" 
),
"cyrus_query" => array( 
	"methodname" => "cyrus_query", 
	"version" => "PHP4 >= 4.1.0", 
	"method" => "bool cyrus_query ( resource connection, string query )", 
	"snippet" => "( \${1:\$connection}, \${2:\$query} )", 
	"desc" => "Send a query to a Cyrus IMAP server", 
	"docurl" => "function.cyrus-query.html" 
),
"cyrus_unbind" => array( 
	"methodname" => "cyrus_unbind", 
	"version" => "PHP4 >= 4.1.0", 
	"method" => "bool cyrus_unbind ( resource connection, string trigger_name )", 
	"snippet" => "( \${1:\$connection}, \${2:\$trigger_name} )", 
	"desc" => "Unbind ...", 
	"docurl" => "function.cyrus-unbind.html" 
)
); # end of main array
?>