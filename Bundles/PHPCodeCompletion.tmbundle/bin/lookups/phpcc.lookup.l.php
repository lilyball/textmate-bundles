<?php
$_LOOKUP = array( 
"lcg_value" => array( 
	"methodname" => "lcg_value", 
	"version" => "PHP4, PHP5", 
	"method" => "float lcg_value ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Combined linear congruential generator", 
	"docurl" => "function.lcg-value.html" 
),
"ldap_8859_to_t61" => array( 
	"methodname" => "ldap_8859_to_t61", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string ldap_8859_to_t61 ( string value )", 
	"snippet" => "( \${1:\$value} )", 
	"desc" => "Translate 8859 characters to t61 characters", 
	"docurl" => "function.ldap-8859-to-t61.html" 
),
"ldap_add" => array( 
	"methodname" => "ldap_add", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ldap_add ( resource link_identifier, string dn, array entry )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$dn}, \${3:\$entry} )", 
	"desc" => "Add entries to LDAP directory", 
	"docurl" => "function.ldap-add.html" 
),
"ldap_bind" => array( 
	"methodname" => "ldap_bind", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ldap_bind ( resource link_identifier [, string bind_rdn [, string bind_password]] )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Bind to LDAP directory", 
	"docurl" => "function.ldap-bind.html" 
),
"ldap_close" => array( 
	"methodname" => "ldap_close", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ldap_close ( resource link_identifier )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Close link to LDAP server", 
	"docurl" => "function.ldap-close.html" 
),
"ldap_compare" => array( 
	"methodname" => "ldap_compare", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "bool ldap_compare ( resource link_identifier, string dn, string attribute, string value )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$dn}, \${3:\$attribute}, \${4:\$value} )", 
	"desc" => "Compare value of attribute found in entry specified with DN", 
	"docurl" => "function.ldap-compare.html" 
),
"ldap_connect" => array( 
	"methodname" => "ldap_connect", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource ldap_connect ( [string hostname [, int port]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Connect to an LDAP server", 
	"docurl" => "function.ldap-connect.html" 
),
"ldap_count_entries" => array( 
	"methodname" => "ldap_count_entries", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int ldap_count_entries ( resource link_identifier, resource result_identifier )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$result_identifier} )", 
	"desc" => "Count the number of entries in a search", 
	"docurl" => "function.ldap-count-entries.html" 
),
"ldap_delete" => array( 
	"methodname" => "ldap_delete", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ldap_delete ( resource link_identifier, string dn )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$dn} )", 
	"desc" => "Delete an entry from a directory", 
	"docurl" => "function.ldap-delete.html" 
),
"ldap_dn2ufn" => array( 
	"methodname" => "ldap_dn2ufn", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string ldap_dn2ufn ( string dn )", 
	"snippet" => "( \${1:\$dn} )", 
	"desc" => "Convert DN to User Friendly Naming format", 
	"docurl" => "function.ldap-dn2ufn.html" 
),
"ldap_err2str" => array( 
	"methodname" => "ldap_err2str", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "string ldap_err2str ( int errno )", 
	"snippet" => "( \${1:\$errno} )", 
	"desc" => "Convert LDAP error number into string error message", 
	"docurl" => "function.ldap-err2str.html" 
),
"ldap_errno" => array( 
	"methodname" => "ldap_errno", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "int ldap_errno ( resource link_identifier )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Return the LDAP error number of the last LDAP command", 
	"docurl" => "function.ldap-errno.html" 
),
"ldap_error" => array( 
	"methodname" => "ldap_error", 
	"version" => "PHP3>= 3.0.12, PHP4, PHP5", 
	"method" => "string ldap_error ( resource link_identifier )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Return the LDAP error message of the last LDAP command", 
	"docurl" => "function.ldap-error.html" 
),
"ldap_explode_dn" => array( 
	"methodname" => "ldap_explode_dn", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array ldap_explode_dn ( string dn, int with_attrib )", 
	"snippet" => "( \${1:\$dn}, \${2:\$with_attrib} )", 
	"desc" => "Splits DN into its component parts", 
	"docurl" => "function.ldap-explode-dn.html" 
),
"ldap_first_attribute" => array( 
	"methodname" => "ldap_first_attribute", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string ldap_first_attribute ( resource link_identifier, resource result_entry_identifier, int &ber_identifier )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$result_entry_identifier}, \${3:\$ber_identifier} )", 
	"desc" => "Return first attribute", 
	"docurl" => "function.ldap-first-attribute.html" 
),
"ldap_first_entry" => array( 
	"methodname" => "ldap_first_entry", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource ldap_first_entry ( resource link_identifier, resource result_identifier )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$result_identifier} )", 
	"desc" => "Return first result id", 
	"docurl" => "function.ldap-first-entry.html" 
),
"ldap_first_reference" => array( 
	"methodname" => "ldap_first_reference", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "resource ldap_first_reference ( resource link, resource result )", 
	"snippet" => "( \${1:\$link}, \${2:\$result} )", 
	"desc" => "Return first reference", 
	"docurl" => "function.ldap-first-reference.html" 
),
"ldap_free_result" => array( 
	"methodname" => "ldap_free_result", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ldap_free_result ( resource result_identifier )", 
	"snippet" => "( \${1:\$result_identifier} )", 
	"desc" => "Free result memory", 
	"docurl" => "function.ldap-free-result.html" 
),
"ldap_get_attributes" => array( 
	"methodname" => "ldap_get_attributes", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array ldap_get_attributes ( resource link_identifier, resource result_entry_identifier )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$result_entry_identifier} )", 
	"desc" => "Get attributes from a search result entry", 
	"docurl" => "function.ldap-get-attributes.html" 
),
"ldap_get_dn" => array( 
	"methodname" => "ldap_get_dn", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string ldap_get_dn ( resource link_identifier, resource result_entry_identifier )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$result_entry_identifier} )", 
	"desc" => "Get the DN of a result entry", 
	"docurl" => "function.ldap-get-dn.html" 
),
"ldap_get_entries" => array( 
	"methodname" => "ldap_get_entries", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array ldap_get_entries ( resource link_identifier, resource result_identifier )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$result_identifier} )", 
	"desc" => "Get all result entries", 
	"docurl" => "function.ldap-get-entries.html" 
),
"ldap_get_option" => array( 
	"methodname" => "ldap_get_option", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ldap_get_option ( resource link_identifier, int option, mixed &retval )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$option}, \${3:\$retval} )", 
	"desc" => "Get the current value for given option", 
	"docurl" => "function.ldap-get-option.html" 
),
"ldap_get_values_len" => array( 
	"methodname" => "ldap_get_values_len", 
	"version" => "PHP3>= 3.0.13, PHP4, PHP5", 
	"method" => "array ldap_get_values_len ( resource link_identifier, resource result_entry_identifier, string attribute )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$result_entry_identifier}, \${3:\$attribute} )", 
	"desc" => "Get all binary values from a result entry", 
	"docurl" => "function.ldap-get-values-len.html" 
),
"ldap_get_values" => array( 
	"methodname" => "ldap_get_values", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "array ldap_get_values ( resource link_identifier, resource result_entry_identifier, string attribute )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$result_entry_identifier}, \${3:\$attribute} )", 
	"desc" => "Get all values from a result entry", 
	"docurl" => "function.ldap-get-values.html" 
),
"ldap_list" => array( 
	"methodname" => "ldap_list", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource ldap_list ( resource link_identifier, string base_dn, string filter [, array attributes [, int attrsonly [, int sizelimit [, int timelimit [, int deref]]]]] )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$base_dn}, \${3:\$filter} )", 
	"desc" => "Single-level search", 
	"docurl" => "function.ldap-list.html" 
),
"ldap_mod_add" => array( 
	"methodname" => "ldap_mod_add", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool ldap_mod_add ( resource link_identifier, string dn, array entry )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$dn}, \${3:\$entry} )", 
	"desc" => "Add attribute values to current attributes", 
	"docurl" => "function.ldap-mod-add.html" 
),
"ldap_mod_del" => array( 
	"methodname" => "ldap_mod_del", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool ldap_mod_del ( resource link_identifier, string dn, array entry )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$dn}, \${3:\$entry} )", 
	"desc" => "Delete attribute values from current attributes", 
	"docurl" => "function.ldap-mod-del.html" 
),
"ldap_mod_replace" => array( 
	"methodname" => "ldap_mod_replace", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool ldap_mod_replace ( resource link_identifier, string dn, array entry )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$dn}, \${3:\$entry} )", 
	"desc" => "Replace attribute values with new ones", 
	"docurl" => "function.ldap-mod-replace.html" 
),
"ldap_modify" => array( 
	"methodname" => "ldap_modify", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ldap_modify ( resource link_identifier, string dn, array entry )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$dn}, \${3:\$entry} )", 
	"desc" => "Modify an LDAP entry", 
	"docurl" => "function.ldap-modify.html" 
),
"ldap_next_attribute" => array( 
	"methodname" => "ldap_next_attribute", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string ldap_next_attribute ( resource link_identifier, resource result_entry_identifier, resource &ber_identifier )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$result_entry_identifier}, \${3:\$ber_identifier} )", 
	"desc" => "Get the next attribute in result", 
	"docurl" => "function.ldap-next-attribute.html" 
),
"ldap_next_entry" => array( 
	"methodname" => "ldap_next_entry", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource ldap_next_entry ( resource link_identifier, resource result_entry_identifier )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$result_entry_identifier} )", 
	"desc" => "Get next result entry", 
	"docurl" => "function.ldap-next-entry.html" 
),
"ldap_next_reference" => array( 
	"methodname" => "ldap_next_reference", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "resource ldap_next_reference ( resource link, resource entry )", 
	"snippet" => "( \${1:\$link}, \${2:\$entry} )", 
	"desc" => "Get next reference", 
	"docurl" => "function.ldap-next-reference.html" 
),
"ldap_parse_reference" => array( 
	"methodname" => "ldap_parse_reference", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ldap_parse_reference ( resource link, resource entry, array &referrals )", 
	"snippet" => "( \${1:\$link}, \${2:\$entry}, \${3:\$referrals} )", 
	"desc" => "Extract information from reference entry", 
	"docurl" => "function.ldap-parse-reference.html" 
),
"ldap_parse_result" => array( 
	"methodname" => "ldap_parse_result", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ldap_parse_result ( resource link, resource result, int &errcode [, string &matcheddn [, string &errmsg [, array &referrals]]] )", 
	"snippet" => "( \${1:\$link}, \${2:\$result}, \${3:\$errcode} )", 
	"desc" => "Extract information from result", 
	"docurl" => "function.ldap-parse-result.html" 
),
"ldap_read" => array( 
	"methodname" => "ldap_read", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource ldap_read ( resource link_identifier, string base_dn, string filter [, array attributes [, int attrsonly [, int sizelimit [, int timelimit [, int deref]]]]] )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$base_dn}, \${3:\$filter} )", 
	"desc" => "Read an entry", 
	"docurl" => "function.ldap-read.html" 
),
"ldap_rename" => array( 
	"methodname" => "ldap_rename", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool ldap_rename ( resource link_identifier, string dn, string newrdn, string newparent, bool deleteoldrdn )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$dn}, \${3:\$newrdn}, \${4:\$newparent}, \${5:\$deleteoldrdn} )", 
	"desc" => "Modify the name of an entry", 
	"docurl" => "function.ldap-rename.html" 
),
"ldap_sasl_bind" => array( 
	"methodname" => "ldap_sasl_bind", 
	"version" => "PHP5", 
	"method" => "bool ldap_sasl_bind ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Bind to LDAP directory using SASL", 
	"docurl" => "function.ldap-sasl-bind.html" 
),
"ldap_search" => array( 
	"methodname" => "ldap_search", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "resource ldap_search ( resource link_identifier, string base_dn, string filter [, array attributes [, int attrsonly [, int sizelimit [, int timelimit [, int deref]]]]] )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$base_dn}, \${3:\$filter} )", 
	"desc" => "Search LDAP tree", 
	"docurl" => "function.ldap-search.html" 
),
"ldap_set_option" => array( 
	"methodname" => "ldap_set_option", 
	"version" => "PHP4 >= 4.0.4, PHP5", 
	"method" => "bool ldap_set_option ( resource link_identifier, int option, mixed newval )", 
	"snippet" => "( \${1:\$link_identifier}, \${2:\$option}, \${3:\$newval} )", 
	"desc" => "Set the value of the given option", 
	"docurl" => "function.ldap-set-option.html" 
),
"ldap_set_rebind_proc" => array( 
	"methodname" => "ldap_set_rebind_proc", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ldap_set_rebind_proc ( resource link, callback callback )", 
	"snippet" => "( \${1:\$link}, \${2:\$callback} )", 
	"desc" => "Set a callback function to do re-binds on referral chasing", 
	"docurl" => "function.ldap-set-rebind-proc.html" 
),
"ldap_sort" => array( 
	"methodname" => "ldap_sort", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ldap_sort ( resource link, resource result, string sortfilter )", 
	"snippet" => "( \${1:\$link}, \${2:\$result}, \${3:\$sortfilter} )", 
	"desc" => "Sort LDAP result entries", 
	"docurl" => "function.ldap-sort.html" 
),
"ldap_start_tls" => array( 
	"methodname" => "ldap_start_tls", 
	"version" => "PHP4 >= 4.2.0, PHP5", 
	"method" => "bool ldap_start_tls ( resource link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Start TLS", 
	"docurl" => "function.ldap-start-tls.html" 
),
"ldap_t61_to_8859" => array( 
	"methodname" => "ldap_t61_to_8859", 
	"version" => "PHP4 >= 4.0.2, PHP5", 
	"method" => "string ldap_t61_to_8859 ( string value )", 
	"snippet" => "( \${1:\$value} )", 
	"desc" => "Translate t61 characters to 8859 characters", 
	"docurl" => "function.ldap-t61-to-8859.html" 
),
"ldap_unbind" => array( 
	"methodname" => "ldap_unbind", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool ldap_unbind ( resource link_identifier )", 
	"snippet" => "( \${1:\$link_identifier} )", 
	"desc" => "Unbind from LDAP directory", 
	"docurl" => "function.ldap-unbind.html" 
),
"levenshtein" => array( 
	"methodname" => "levenshtein", 
	"version" => "PHP3>= 3.0.17, PHP4 >= 4.0.1, PHP5", 
	"method" => "int levenshtein ( string str1, string str2 [, int cost_ins [, int cost_rep, int cost_del]] )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2} )", 
	"desc" => "Calculate Levenshtein distance between two strings", 
	"docurl" => "function.levenshtein.html" 
),
"libxml_clear_errors" => array( 
	"methodname" => "libxml_clear_errors", 
	"version" => "undefined", 
	"method" => "void libxml_clear_errors ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.libxml-clear-errors.html" 
),
"libxml_get_errors" => array( 
	"methodname" => "libxml_get_errors", 
	"version" => "undefined", 
	"method" => "array libxml_get_errors ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.libxml-get-errors.html" 
),
"libxml_get_last_error" => array( 
	"methodname" => "libxml_get_last_error", 
	"version" => "undefined", 
	"method" => "LibXMLError libxml_get_last_error ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.libxml-get-last-error.html" 
),
"libxml_set_streams_context" => array( 
	"methodname" => "libxml_set_streams_context", 
	"version" => "PHP5", 
	"method" => "void libxml_set_streams_context ( resource streams_context )", 
	"snippet" => "( \${1:\$streams_context} )", 
	"desc" => "Set the streams context for the next libxml document load or write", 
	"docurl" => "function.libxml-set-streams-context.html" 
),
"libxml_use_internal_errors" => array( 
	"methodname" => "libxml_use_internal_errors", 
	"version" => "undefined", 
	"method" => "bool libxml_use_internal_errors ( [bool use_errors] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.libxml-use-internal-errors.html" 
),
"link" => array( 
	"methodname" => "link", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "bool link ( string target, string link )", 
	"snippet" => "( \${1:\$target}, \${2:\$link} )", 
	"desc" => "Create a hard link", 
	"docurl" => "function.link.html" 
),
"linkinfo" => array( 
	"methodname" => "linkinfo", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "int linkinfo ( string path )", 
	"snippet" => "( \${1:\$path} )", 
	"desc" => "Gets information about a link", 
	"docurl" => "function.linkinfo.html" 
),
"list" => array( 
	"methodname" => "list", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void list ( mixed varname, mixed ... )", 
	"snippet" => "( \${1:\$varname}, \${2:\$...} )", 
	"desc" => "Assign variables as if they were an array", 
	"docurl" => "function.list.html" 
),
"localeconv" => array( 
	"methodname" => "localeconv", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "array localeconv ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Get numeric formatting information", 
	"docurl" => "function.localeconv.html" 
),
"localtime" => array( 
	"methodname" => "localtime", 
	"version" => "PHP4, PHP5", 
	"method" => "array localtime ( [int timestamp [, bool is_associative]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Get the local time", 
	"docurl" => "function.localtime.html" 
),
"log" => array( 
	"methodname" => "log", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float log ( float arg [, float base] )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Natural logarithm", 
	"docurl" => "function.log.html" 
),
"log10" => array( 
	"methodname" => "log10", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "float log10 ( float arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Base-10 logarithm", 
	"docurl" => "function.log10.html" 
),
"log1p" => array( 
	"methodname" => "log1p", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float log1p ( float number )", 
	"snippet" => "( \${1:\$number} )", 
	"desc" => "Returns log(1 + number), computed in a way that is accurate even when   the value of number is close to zero", 
	"docurl" => "function.log1p.html" 
),
"long2ip" => array( 
	"methodname" => "long2ip", 
	"version" => "PHP4, PHP5", 
	"method" => "string long2ip ( int proper_address )", 
	"snippet" => "( \${1:\$proper_address} )", 
	"desc" => "Converts an (IPv4) Internet network address into a string in Internet    standard dotted format", 
	"docurl" => "function.long2ip.html" 
),
"lstat" => array( 
	"methodname" => "lstat", 
	"version" => "PHP3>= 3.0.4, PHP4, PHP5", 
	"method" => "array lstat ( string filename )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Gives information about a file or symbolic link", 
	"docurl" => "function.lstat.html" 
),
"ltrim" => array( 
	"methodname" => "ltrim", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string ltrim ( string str [, string charlist] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Strip whitespace (or other characters) from the beginning of a string", 
	"docurl" => "function.ltrim.html" 
),
"lzf_compress" => array( 
	"methodname" => "lzf_compress", 
	"version" => "undefined", 
	"method" => "string lzf_compress ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "", 
	"docurl" => "function.lzf-compress.html" 
),
"lzf_decompress" => array( 
	"methodname" => "lzf_decompress", 
	"version" => "undefined", 
	"method" => "string lzf_decompress ( string data )", 
	"snippet" => "( \${1:\$data} )", 
	"desc" => "", 
	"docurl" => "function.lzf-decompress.html" 
),
"lzf_optimized_for" => array( 
	"methodname" => "lzf_optimized_for", 
	"version" => "undefined", 
	"method" => "int lzf_optimized_for ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.lzf-optimized-for.html" 
),
); # end of main array
?>