<?php
$_LOOKUP = array( 
"var_dump" => array( 
	"methodname" => "var_dump", 
	"version" => "PHP3>= 3.0.5, PHP4, PHP5", 
	"method" => "void var_dump ( mixed expression [, mixed expression [, ...]] )", 
	"snippet" => "( \${1:\$expression} )", 
	"desc" => "Dumps information about a variable", 
	"docurl" => "function.var-dump.html" 
),
"var_export" => array( 
	"methodname" => "var_export", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "mixed var_export ( mixed expression [, bool return] )", 
	"snippet" => "( \${1:\$expression} )", 
	"desc" => "Outputs or returns a parsable string representation of a variable", 
	"docurl" => "function.var-export.html" 
),
"variant_abs" => array( 
	"methodname" => "variant_abs", 
	"version" => "PHP5", 
	"method" => "mixed variant_abs ( mixed val )", 
	"snippet" => "( \${1:\$val} )", 
	"desc" => "Returns the absolute value of a variant", 
	"docurl" => "function.variant-abs.html" 
),
"variant_add" => array( 
	"methodname" => "variant_add", 
	"version" => "PHP5", 
	"method" => "mixed variant_add ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "\"Adds\" two variant values together and returns the result", 
	"docurl" => "function.variant-add.html" 
),
"variant_and" => array( 
	"methodname" => "variant_and", 
	"version" => "PHP5", 
	"method" => "mixed variant_and ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "performs a bitwise AND operation between two variants and returns the result", 
	"docurl" => "function.variant-and.html" 
),
"variant_cast" => array( 
	"methodname" => "variant_cast", 
	"version" => "PHP5", 
	"method" => "variant variant_cast ( variant variant, int type )", 
	"snippet" => "( \${1:\$variant}, \${2:\$type} )", 
	"desc" => "Convert a variant into a new variant object of another type", 
	"docurl" => "function.variant-cast.html" 
),
"variant_cat" => array( 
	"methodname" => "variant_cat", 
	"version" => "PHP5", 
	"method" => "mixed variant_cat ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "concatenates two variant values together and returns the result", 
	"docurl" => "function.variant-cat.html" 
),
"variant_cmp" => array( 
	"methodname" => "variant_cmp", 
	"version" => "PHP5", 
	"method" => "int variant_cmp ( mixed left, mixed right [, int lcid [, int flags]] )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "Compares two variants", 
	"docurl" => "function.variant-cmp.html" 
),
"variant_date_from_timestamp" => array( 
	"methodname" => "variant_date_from_timestamp", 
	"version" => "PHP5", 
	"method" => "variant variant_date_from_timestamp ( int timestamp )", 
	"snippet" => "( \${1:\$timestamp} )", 
	"desc" => "Returns a variant date representation of a unix timestamp", 
	"docurl" => "function.variant-date-from-timestamp.html" 
),
"variant_date_to_timestamp" => array( 
	"methodname" => "variant_date_to_timestamp", 
	"version" => "PHP5", 
	"method" => "int variant_date_to_timestamp ( variant variant )", 
	"snippet" => "( \${1:\$variant} )", 
	"desc" => "Converts a variant date/time value to unix timestamp", 
	"docurl" => "function.variant-date-to-timestamp.html" 
),
"variant_div" => array( 
	"methodname" => "variant_div", 
	"version" => "PHP5", 
	"method" => "mixed variant_div ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "Returns the result from dividing two variants", 
	"docurl" => "function.variant-div.html" 
),
"variant_eqv" => array( 
	"methodname" => "variant_eqv", 
	"version" => "PHP5", 
	"method" => "mixed variant_eqv ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "Performs a bitwise equivalence on two variants", 
	"docurl" => "function.variant-eqv.html" 
),
"variant_fix" => array( 
	"methodname" => "variant_fix", 
	"version" => "PHP5", 
	"method" => "mixed variant_fix ( mixed variant )", 
	"snippet" => "( \${1:\$variant} )", 
	"desc" => "Returns the integer portion ? of a variant", 
	"docurl" => "function.variant-fix.html" 
),
"variant_get_type" => array( 
	"methodname" => "variant_get_type", 
	"version" => "PHP5", 
	"method" => "int variant_get_type ( variant variant )", 
	"snippet" => "( \${1:\$variant} )", 
	"desc" => "Returns the type of a variant object", 
	"docurl" => "function.variant-get-type.html" 
),
"variant_idiv" => array( 
	"methodname" => "variant_idiv", 
	"version" => "PHP5", 
	"method" => "mixed variant_idiv ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "Converts variants to integers and then returns the result from dividing them", 
	"docurl" => "function.variant-idiv.html" 
),
"variant_imp" => array( 
	"methodname" => "variant_imp", 
	"version" => "PHP5", 
	"method" => "mixed variant_imp ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "Performs a bitwise implication on two variants", 
	"docurl" => "function.variant-imp.html" 
),
"variant_int" => array( 
	"methodname" => "variant_int", 
	"version" => "PHP5", 
	"method" => "mixed variant_int ( mixed variant )", 
	"snippet" => "( \${1:\$variant} )", 
	"desc" => "Returns the integer portion of a variant", 
	"docurl" => "function.variant-int.html" 
),
"variant_mod" => array( 
	"methodname" => "variant_mod", 
	"version" => "PHP5", 
	"method" => "mixed variant_mod ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "Divides two variants and returns only the remainder", 
	"docurl" => "function.variant-mod.html" 
),
"variant_mul" => array( 
	"methodname" => "variant_mul", 
	"version" => "PHP5", 
	"method" => "mixed variant_mul ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "multiplies the values of the two variants and returns the result", 
	"docurl" => "function.variant-mul.html" 
),
"variant_neg" => array( 
	"methodname" => "variant_neg", 
	"version" => "PHP5", 
	"method" => "mixed variant_neg ( mixed variant )", 
	"snippet" => "( \${1:\$variant} )", 
	"desc" => "Performs logical negation on a variant", 
	"docurl" => "function.variant-neg.html" 
),
"variant_not" => array( 
	"methodname" => "variant_not", 
	"version" => "PHP5", 
	"method" => "mixed variant_not ( mixed variant )", 
	"snippet" => "( \${1:\$variant} )", 
	"desc" => "Performs bitwise not negation on a variant", 
	"docurl" => "function.variant-not.html" 
),
"variant_or" => array( 
	"methodname" => "variant_or", 
	"version" => "PHP5", 
	"method" => "mixed variant_or ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "Performs a logical disjunction on two variants", 
	"docurl" => "function.variant-or.html" 
),
"variant_pow" => array( 
	"methodname" => "variant_pow", 
	"version" => "PHP5", 
	"method" => "mixed variant_pow ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "Returns the result of performing the power function with two variants", 
	"docurl" => "function.variant-pow.html" 
),
"variant_round" => array( 
	"methodname" => "variant_round", 
	"version" => "PHP5", 
	"method" => "mixed variant_round ( mixed variant, int decimals )", 
	"snippet" => "( \${1:\$variant}, \${2:\$decimals} )", 
	"desc" => "Rounds a variant to the specified number of decimal places", 
	"docurl" => "function.variant-round.html" 
),
"variant_set_type" => array( 
	"methodname" => "variant_set_type", 
	"version" => "PHP5", 
	"method" => "void variant_set_type ( variant variant, int type )", 
	"snippet" => "( \${1:\$variant}, \${2:\$type} )", 
	"desc" => "Convert a variant into another type \"in-place\"", 
	"docurl" => "function.variant-set-type.html" 
),
"variant_set" => array( 
	"methodname" => "variant_set", 
	"version" => "PHP5", 
	"method" => "void variant_set ( variant variant, mixed value )", 
	"snippet" => "( \${1:\$variant}, \${2:\$value} )", 
	"desc" => "Assigns a new value for a variant object", 
	"docurl" => "function.variant-set.html" 
),
"variant_sub" => array( 
	"methodname" => "variant_sub", 
	"version" => "PHP5", 
	"method" => "mixed variant_sub ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "subtracts the value of the right variant from the left variant value and returns the result", 
	"docurl" => "function.variant-sub.html" 
),
"variant_xor" => array( 
	"methodname" => "variant_xor", 
	"version" => "PHP5", 
	"method" => "mixed variant_xor ( mixed left, mixed right )", 
	"snippet" => "( \${1:\$left}, \${2:\$right} )", 
	"desc" => "Performs a logical exclusion on two variants", 
	"docurl" => "function.variant-xor.html" 
),
"version_compare" => array( 
	"methodname" => "version_compare", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int version_compare ( string version1, string version2 [, string operator] )", 
	"snippet" => "( \${1:\$version1}, \${2:\$version2} )", 
	"desc" => "Compares two \"PHP-standardized\" version number strings", 
	"docurl" => "function.version-compare.html" 
),
"vfprintf" => array( 
	"methodname" => "vfprintf", 
	"version" => "PHP5", 
	"method" => "int vfprintf ( resource handle, string format, array args )", 
	"snippet" => "( \${1:\$handle}, \${2:\$format}, \${3:\$args} )", 
	"desc" => "Write a formatted string to a stream", 
	"docurl" => "function.vfprintf.html" 
),
"virtual" => array( 
	"methodname" => "virtual", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int virtual ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Perform an Apache sub-request", 
	"docurl" => "function.virtual.html" 
),
"vpopmail_add_alias_domain_ex" => array( 
	"methodname" => "vpopmail_add_alias_domain_ex", 
	"version" => "undefined", 
	"method" => "bool vpopmail_add_alias_domain_ex ( string olddomain, string newdomain )", 
	"snippet" => "( \${1:\$olddomain}, \${2:\$newdomain} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-add-alias-domain-ex.html" 
),
"vpopmail_add_alias_domain" => array( 
	"methodname" => "vpopmail_add_alias_domain", 
	"version" => "undefined", 
	"method" => "bool vpopmail_add_alias_domain ( string domain, string aliasdomain )", 
	"snippet" => "( \${1:\$domain}, \${2:\$aliasdomain} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-add-alias-domain.html" 
),
"vpopmail_add_domain_ex" => array( 
	"methodname" => "vpopmail_add_domain_ex", 
	"version" => "undefined", 
	"method" => "bool vpopmail_add_domain_ex ( string domain, string passwd [, string quota [, string bounce [, bool apop]]] )", 
	"snippet" => "( \${1:\$domain}, \${2:\$passwd} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-add-domain-ex.html" 
),
"vpopmail_add_domain" => array( 
	"methodname" => "vpopmail_add_domain", 
	"version" => "undefined", 
	"method" => "bool vpopmail_add_domain ( string domain, string dir, int uid, int gid )", 
	"snippet" => "( \${1:\$domain}, \${2:\$dir}, \${3:\$uid}, \${4:\$gid} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-add-domain.html" 
),
"vpopmail_add_user" => array( 
	"methodname" => "vpopmail_add_user", 
	"version" => "undefined", 
	"method" => "bool vpopmail_add_user ( string user, string domain, string password [, string gecos [, bool apop]] )", 
	"snippet" => "( \${1:\$user}, \${2:\$domain}, \${3:\$password} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-add-user.html" 
),
"vpopmail_alias_add" => array( 
	"methodname" => "vpopmail_alias_add", 
	"version" => "undefined", 
	"method" => "bool vpopmail_alias_add ( string user, string domain, string alias )", 
	"snippet" => "( \${1:\$user}, \${2:\$domain}, \${3:\$alias} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-alias-add.html" 
),
"vpopmail_alias_del_domain" => array( 
	"methodname" => "vpopmail_alias_del_domain", 
	"version" => "undefined", 
	"method" => "bool vpopmail_alias_del_domain ( string domain )", 
	"snippet" => "( \${1:\$domain} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-alias-del-domain.html" 
),
"vpopmail_alias_del" => array( 
	"methodname" => "vpopmail_alias_del", 
	"version" => "undefined", 
	"method" => "bool vpopmail_alias_del ( string user, string domain )", 
	"snippet" => "( \${1:\$user}, \${2:\$domain} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-alias-del.html" 
),
"vpopmail_alias_get_all" => array( 
	"methodname" => "vpopmail_alias_get_all", 
	"version" => "undefined", 
	"method" => "array vpopmail_alias_get_all ( string domain )", 
	"snippet" => "( \${1:\$domain} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-alias-get-all.html" 
),
"vpopmail_alias_get" => array( 
	"methodname" => "vpopmail_alias_get", 
	"version" => "undefined", 
	"method" => "array vpopmail_alias_get ( string alias, string domain )", 
	"snippet" => "( \${1:\$alias}, \${2:\$domain} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-alias-get.html" 
),
"vpopmail_auth_user" => array( 
	"methodname" => "vpopmail_auth_user", 
	"version" => "undefined", 
	"method" => "bool vpopmail_auth_user ( string user, string domain, string password [, string apop] )", 
	"snippet" => "( \${1:\$user}, \${2:\$domain}, \${3:\$password} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-auth-user.html" 
),
"vpopmail_del_domain_ex" => array( 
	"methodname" => "vpopmail_del_domain_ex", 
	"version" => "undefined", 
	"method" => "bool vpopmail_del_domain_ex ( string domain )", 
	"snippet" => "( \${1:\$domain} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-del-domain-ex.html" 
),
"vpopmail_del_domain" => array( 
	"methodname" => "vpopmail_del_domain", 
	"version" => "undefined", 
	"method" => "bool vpopmail_del_domain ( string domain )", 
	"snippet" => "( \${1:\$domain} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-del-domain.html" 
),
"vpopmail_del_user" => array( 
	"methodname" => "vpopmail_del_user", 
	"version" => "undefined", 
	"method" => "bool vpopmail_del_user ( string user, string domain )", 
	"snippet" => "( \${1:\$user}, \${2:\$domain} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-del-user.html" 
),
"vpopmail_error" => array( 
	"methodname" => "vpopmail_error", 
	"version" => "undefined", 
	"method" => "string vpopmail_error ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-error.html" 
),
"vpopmail_passwd" => array( 
	"methodname" => "vpopmail_passwd", 
	"version" => "undefined", 
	"method" => "bool vpopmail_passwd ( string user, string domain, string password [, bool apop] )", 
	"snippet" => "( \${1:\$user}, \${2:\$domain}, \${3:\$password} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-passwd.html" 
),
"vpopmail_set_user_quota" => array( 
	"methodname" => "vpopmail_set_user_quota", 
	"version" => "undefined", 
	"method" => "bool vpopmail_set_user_quota ( string user, string domain, string quota )", 
	"snippet" => "( \${1:\$user}, \${2:\$domain}, \${3:\$quota} )", 
	"desc" => "", 
	"docurl" => "function.vpopmail-set-user-quota.html" 
),
"vprintf" => array( 
	"methodname" => "vprintf", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int vprintf ( string format, array args )", 
	"snippet" => "( \${1:\$format}, \${2:\$args} )", 
	"desc" => "Output a formatted string", 
	"docurl" => "function.vprintf.html" 
),
"vsprintf" => array( 
	"methodname" => "vsprintf", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string vsprintf ( string format, array args )", 
	"snippet" => "( \${1:\$format}, \${2:\$args} )", 
	"desc" => "Return a formatted string", 
	"docurl" => "function.vsprintf.html" 
),

); # end of main array
?>