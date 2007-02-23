<?php
$_LOOKUP = array( 
"xattr_get" => array( 
	"methodname" => "xattr_get", 
	"version" => "undefined", 
	"method" => "string xattr_get ( string filename, string name [, int flags] )", 
	"snippet" => "( \${1:\$filename}, \${2:\$name} )", 
	"desc" => "", 
	"docurl" => "function.xattr-get.html" 
),
"xattr_list" => array( 
	"methodname" => "xattr_list", 
	"version" => "undefined", 
	"method" => "array xattr_list ( string filename [, int flags] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.xattr-list.html" 
),
"xattr_remove" => array( 
	"methodname" => "xattr_remove", 
	"version" => "undefined", 
	"method" => "bool xattr_remove ( string filename, string name [, int flags] )", 
	"snippet" => "( \${1:\$filename}, \${2:\$name} )", 
	"desc" => "", 
	"docurl" => "function.xattr-remove.html" 
),
"xattr_set" => array( 
	"methodname" => "xattr_set", 
	"version" => "undefined", 
	"method" => "bool xattr_set ( string filename, string name, string value [, int flags] )", 
	"snippet" => "( \${1:\$filename}, \${2:\$name}, \${3:\$value} )", 
	"desc" => "", 
	"docurl" => "function.xattr-set.html" 
),
"xattr_supported" => array( 
	"methodname" => "xattr_supported", 
	"version" => "undefined", 
	"method" => "bool xattr_supported ( string filename [, int flags] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "", 
	"docurl" => "function.xattr-supported.html" 
),
"xdiff_file_diff_binary" => array( 
	"methodname" => "xdiff_file_diff_binary", 
	"version" => "undefined", 
	"method" => "bool xdiff_file_diff_binary ( string file1, string file2, string dest )", 
	"snippet" => "( \${1:\$file1}, \${2:\$file2}, \${3:\$dest} )", 
	"desc" => "", 
	"docurl" => "function.xdiff-file-diff-binary.html" 
),
"xdiff_file_diff" => array( 
	"methodname" => "xdiff_file_diff", 
	"version" => "undefined", 
	"method" => "bool xdiff_file_diff ( string file1, string file2, string dest [, int context [, bool minimal]] )", 
	"snippet" => "( \${1:\$file1}, \${2:\$file2}, \${3:\$dest} )", 
	"desc" => "", 
	"docurl" => "function.xdiff-file-diff.html" 
),
"xdiff_file_merge3" => array( 
	"methodname" => "xdiff_file_merge3", 
	"version" => "undefined", 
	"method" => "mixed xdiff_file_merge3 ( string file1, string file2, string file3, string dest )", 
	"snippet" => "( \${1:\$file1}, \${2:\$file2}, \${3:\$file3}, \${4:\$dest} )", 
	"desc" => "", 
	"docurl" => "function.xdiff-file-merge3.html" 
),
"xdiff_file_patch_binary" => array( 
	"methodname" => "xdiff_file_patch_binary", 
	"version" => "undefined", 
	"method" => "bool xdiff_file_patch_binary ( string file, string patch, string dest )", 
	"snippet" => "( \${1:\$file}, \${2:\$patch}, \${3:\$dest} )", 
	"desc" => "", 
	"docurl" => "function.xdiff-file-patch-binary.html" 
),
"xdiff_file_patch" => array( 
	"methodname" => "xdiff_file_patch", 
	"version" => "undefined", 
	"method" => "mixed xdiff_file_patch ( string file, string patch, string dest [, int flags] )", 
	"snippet" => "( \${1:\$file}, \${2:\$patch}, \${3:\$dest} )", 
	"desc" => "", 
	"docurl" => "function.xdiff-file-patch.html" 
),
"xdiff_string_diff_binary" => array( 
	"methodname" => "xdiff_string_diff_binary", 
	"version" => "undefined", 
	"method" => "mixed xdiff_string_diff_binary ( string str1, string str2 )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2} )", 
	"desc" => "", 
	"docurl" => "function.xdiff-string-diff-binary.html" 
),
"xdiff_string_diff" => array( 
	"methodname" => "xdiff_string_diff", 
	"version" => "undefined", 
	"method" => "mixed xdiff_string_diff ( string str1, string str2 [, int context [, bool minimal]] )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2} )", 
	"desc" => "", 
	"docurl" => "function.xdiff-string-diff.html" 
),
"xdiff_string_merge3" => array( 
	"methodname" => "xdiff_string_merge3", 
	"version" => "undefined", 
	"method" => "string xdiff_string_merge3 ( string str1, string str2, string str3 [, string &error] )", 
	"snippet" => "( \${1:\$str1}, \${2:\$str2}, \${3:\$str3} )", 
	"desc" => "", 
	"docurl" => "function.xdiff-string-merge3.html" 
),
"xdiff_string_patch_binary" => array( 
	"methodname" => "xdiff_string_patch_binary", 
	"version" => "undefined", 
	"method" => "string xdiff_string_patch_binary ( string str, string patch )", 
	"snippet" => "( \${1:\$str}, \${2:\$patch} )", 
	"desc" => "", 
	"docurl" => "function.xdiff-string-patch-binary.html" 
),
"xdiff_string_patch" => array( 
	"methodname" => "xdiff_string_patch", 
	"version" => "undefined", 
	"method" => "string xdiff_string_patch ( string str, string patch [, int flags [, string &error]] )", 
	"snippet" => "( \${1:\$str}, \${2:\$patch} )", 
	"desc" => "", 
	"docurl" => "function.xdiff-string-patch.html" 
),
"xml_error_string" => array( 
	"methodname" => "xml_error_string", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "string xml_error_string ( int code )", 
	"snippet" => "( \${1:\$code} )", 
	"desc" => "Get XML parser error string", 
	"docurl" => "function.xml-error-string.html" 
),
"xml_get_current_byte_index" => array( 
	"methodname" => "xml_get_current_byte_index", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int xml_get_current_byte_index ( resource parser )", 
	"snippet" => "( \${1:\$parser} )", 
	"desc" => "Get current byte index for an XML parser", 
	"docurl" => "function.xml-get-current-byte-index.html" 
),
"xml_get_current_column_number" => array( 
	"methodname" => "xml_get_current_column_number", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int xml_get_current_column_number ( resource parser )", 
	"snippet" => "( \${1:\$parser} )", 
	"desc" => "Get current column number for an XML parser", 
	"docurl" => "function.xml-get-current-column-number.html" 
),
"xml_get_current_line_number" => array( 
	"methodname" => "xml_get_current_line_number", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int xml_get_current_line_number ( resource parser )", 
	"snippet" => "( \${1:\$parser} )", 
	"desc" => "Get current line number for an XML parser", 
	"docurl" => "function.xml-get-current-line-number.html" 
),
"xml_get_error_code" => array( 
	"methodname" => "xml_get_error_code", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "int xml_get_error_code ( resource parser )", 
	"snippet" => "( \${1:\$parser} )", 
	"desc" => "Get XML parser error code", 
	"docurl" => "function.xml-get-error-code.html" 
),
"xml_parse_into_struct" => array( 
	"methodname" => "xml_parse_into_struct", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "int xml_parse_into_struct ( resource parser, string data, array &values [, array &index] )", 
	"snippet" => "( \${1:\$parser}, \${2:\$data}, \${3:\$values} )", 
	"desc" => "Parse XML data into an array structure", 
	"docurl" => "function.xml-parse-into-struct.html" 
),
"xml_parse" => array( 
	"methodname" => "xml_parse", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool xml_parse ( resource parser, string data [, bool is_final] )", 
	"snippet" => "( \${1:\$parser}, \${2:\$data} )", 
	"desc" => "Start parsing an XML document", 
	"docurl" => "function.xml-parse.html" 
),
"xml_parser_create_ns" => array( 
	"methodname" => "xml_parser_create_ns", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "resource xml_parser_create_ns ( [string encoding [, string separator]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Create an XML parser with namespace support", 
	"docurl" => "function.xml-parser-create-ns.html" 
),
"xml_parser_create" => array( 
	"methodname" => "xml_parser_create", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "resource xml_parser_create ( [string encoding] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Create an XML parser", 
	"docurl" => "function.xml-parser-create.html" 
),
"xml_parser_free" => array( 
	"methodname" => "xml_parser_free", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool xml_parser_free ( resource parser )", 
	"snippet" => "( \${1:\$parser} )", 
	"desc" => "Free an XML parser", 
	"docurl" => "function.xml-parser-free.html" 
),
"xml_parser_get_option" => array( 
	"methodname" => "xml_parser_get_option", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "mixed xml_parser_get_option ( resource parser, int option )", 
	"snippet" => "( \${1:\$parser}, \${2:\$option} )", 
	"desc" => "Get options from an XML parser", 
	"docurl" => "function.xml-parser-get-option.html" 
),
"xml_parser_set_option" => array( 
	"methodname" => "xml_parser_set_option", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool xml_parser_set_option ( resource parser, int option, mixed value )", 
	"snippet" => "( \${1:\$parser}, \${2:\$option}, \${3:\$value} )", 
	"desc" => "Set options in an XML parser", 
	"docurl" => "function.xml-parser-set-option.html" 
),
"xml_set_character_data_handler" => array( 
	"methodname" => "xml_set_character_data_handler", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool xml_set_character_data_handler ( resource parser, callback handler )", 
	"snippet" => "( \${1:\$parser}, \${2:\$handler} )", 
	"desc" => "Set up character data handler", 
	"docurl" => "function.xml-set-character-data-handler.html" 
),
"xml_set_default_handler" => array( 
	"methodname" => "xml_set_default_handler", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool xml_set_default_handler ( resource parser, callback handler )", 
	"snippet" => "( \${1:\$parser}, \${2:\$handler} )", 
	"desc" => "Set up default handler", 
	"docurl" => "function.xml-set-default-handler.html" 
),
"xml_set_element_handler" => array( 
	"methodname" => "xml_set_element_handler", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool xml_set_element_handler ( resource parser, callback start_element_handler, callback end_element_handler )", 
	"snippet" => "( \${1:\$parser}, \${2:\$start_element_handler}, \${3:\$end_element_handler} )", 
	"desc" => "Set up start and end element handlers", 
	"docurl" => "function.xml-set-element-handler.html" 
),
"xml_set_end_namespace_decl_handler" => array( 
	"methodname" => "xml_set_end_namespace_decl_handler", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool xml_set_end_namespace_decl_handler ( resource parser, callback handler )", 
	"snippet" => "( \${1:\$parser}, \${2:\$handler} )", 
	"desc" => "Set up end namespace declaration handler", 
	"docurl" => "function.xml-set-end-namespace-decl-handler.html" 
),
"xml_set_external_entity_ref_handler" => array( 
	"methodname" => "xml_set_external_entity_ref_handler", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool xml_set_external_entity_ref_handler ( resource parser, callback handler )", 
	"snippet" => "( \${1:\$parser}, \${2:\$handler} )", 
	"desc" => "Set up external entity reference handler", 
	"docurl" => "function.xml-set-external-entity-ref-handler.html" 
),
"xml_set_notation_decl_handler" => array( 
	"methodname" => "xml_set_notation_decl_handler", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool xml_set_notation_decl_handler ( resource parser, callback handler )", 
	"snippet" => "( \${1:\$parser}, \${2:\$handler} )", 
	"desc" => "Set up notation declaration handler", 
	"docurl" => "function.xml-set-notation-decl-handler.html" 
),
"xml_set_object" => array( 
	"methodname" => "xml_set_object", 
	"version" => "PHP4, PHP5", 
	"method" => "void xml_set_object ( resource parser, object &object )", 
	"snippet" => "( \${1:\$parser}, \${2:\$object} )", 
	"desc" => "Use XML Parser within an object", 
	"docurl" => "function.xml-set-object.html" 
),
"xml_set_processing_instruction_handler" => array( 
	"methodname" => "xml_set_processing_instruction_handler", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool xml_set_processing_instruction_handler ( resource parser, callback handler )", 
	"snippet" => "( \${1:\$parser}, \${2:\$handler} )", 
	"desc" => "Set up processing instruction (PI) handler", 
	"docurl" => "function.xml-set-processing-instruction-handler.html" 
),
"xml_set_start_namespace_decl_handler" => array( 
	"methodname" => "xml_set_start_namespace_decl_handler", 
	"version" => "PHP4 >= 4.0.5, PHP5", 
	"method" => "bool xml_set_start_namespace_decl_handler ( resource parser, callback handler )", 
	"snippet" => "( \${1:\$parser}, \${2:\$handler} )", 
	"desc" => "Set up start namespace declaration handler", 
	"docurl" => "function.xml-set-start-namespace-decl-handler.html" 
),
"xml_set_unparsed_entity_decl_handler" => array( 
	"methodname" => "xml_set_unparsed_entity_decl_handler", 
	"version" => "PHP3>= 3.0.6, PHP4, PHP5", 
	"method" => "bool xml_set_unparsed_entity_decl_handler ( resource parser, callback handler )", 
	"snippet" => "( \${1:\$parser}, \${2:\$handler} )", 
	"desc" => "Set up unparsed entity declaration handler", 
	"docurl" => "function.xml-set-unparsed-entity-decl-handler.html" 
),
"xmlrpc_decode_request" => array( 
	"methodname" => "xmlrpc_decode_request", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array xmlrpc_decode_request ( string xml, string &method [, string encoding] )", 
	"snippet" => "( \${1:\$xml}, \${2:\$method} )", 
	"desc" => "Decodes XML into native PHP types", 
	"docurl" => "function.xmlrpc-decode-request.html" 
),
"xmlrpc_decode" => array( 
	"methodname" => "xmlrpc_decode", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array xmlrpc_decode ( string xml [, string encoding] )", 
	"snippet" => "( \${1:\$xml} )", 
	"desc" => "Decodes XML into native PHP types", 
	"docurl" => "function.xmlrpc-decode.html" 
),
"xmlrpc_encode_request" => array( 
	"methodname" => "xmlrpc_encode_request", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string xmlrpc_encode_request ( string method, mixed params [, array output_options] )", 
	"snippet" => "( \${1:\$method}, \${2:\$params} )", 
	"desc" => "Generates XML for a method request", 
	"docurl" => "function.xmlrpc-encode-request.html" 
),
"xmlrpc_encode" => array( 
	"methodname" => "xmlrpc_encode", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string xmlrpc_encode ( mixed value )", 
	"snippet" => "( \${1:\$value} )", 
	"desc" => "Generates XML for a PHP value", 
	"docurl" => "function.xmlrpc-encode.html" 
),
"xmlrpc_get_type" => array( 
	"methodname" => "xmlrpc_get_type", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "string xmlrpc_get_type ( mixed value )", 
	"snippet" => "( \${1:\$value} )", 
	"desc" => "Gets xmlrpc type for a PHP value", 
	"docurl" => "function.xmlrpc-get-type.html" 
),
"xmlrpc_is_fault" => array( 
	"methodname" => "xmlrpc_is_fault", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "bool xmlrpc_is_fault ( array arg )", 
	"snippet" => "( \${1:\$arg} )", 
	"desc" => "Determines if an array value represents an XMLRPC fault", 
	"docurl" => "function.xmlrpc-is-fault.html" 
),
"xmlrpc_parse_method_descriptions" => array( 
	"methodname" => "xmlrpc_parse_method_descriptions", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "array xmlrpc_parse_method_descriptions ( string xml )", 
	"snippet" => "( \${1:\$xml} )", 
	"desc" => "Decodes XML into a list of method descriptions", 
	"docurl" => "function.xmlrpc-parse-method-descriptions.html" 
),
"xmlrpc_server_add_introspection_data" => array( 
	"methodname" => "xmlrpc_server_add_introspection_data", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int xmlrpc_server_add_introspection_data ( resource server, array desc )", 
	"snippet" => "( \${1:\$server}, \${2:\$desc} )", 
	"desc" => "Adds introspection documentation", 
	"docurl" => "function.xmlrpc-server-add-introspection-data.html" 
),
"xmlrpc_server_call_method" => array( 
	"methodname" => "xmlrpc_server_call_method", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "mixed xmlrpc_server_call_method ( resource server, string xml, mixed user_data [, array output_options] )", 
	"snippet" => "( \${1:\$server}, \${2:\$xml}, \${3:\$user_data} )", 
	"desc" => "Parses XML requests and call methods", 
	"docurl" => "function.xmlrpc-server-call-method.html" 
),
"xmlrpc_server_create" => array( 
	"methodname" => "xmlrpc_server_create", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "resource xmlrpc_server_create ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Creates an xmlrpc server", 
	"docurl" => "function.xmlrpc-server-create.html" 
),
"xmlrpc_server_destroy" => array( 
	"methodname" => "xmlrpc_server_destroy", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "int xmlrpc_server_destroy ( resource server )", 
	"snippet" => "( \${1:\$server} )", 
	"desc" => "Destroys server resources", 
	"docurl" => "function.xmlrpc-server-destroy.html" 
),
"xmlrpc_server_register_introspection_callback" => array( 
	"methodname" => "xmlrpc_server_register_introspection_callback", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool xmlrpc_server_register_introspection_callback ( resource server, string function )", 
	"snippet" => "( \${1:\$server}, \${2:\$function} )", 
	"desc" => "Register a PHP function to generate documentation", 
	"docurl" => "function.xmlrpc-server-register-introspection-callback.html" 
),
"xmlrpc_server_register_method" => array( 
	"methodname" => "xmlrpc_server_register_method", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool xmlrpc_server_register_method ( resource server, string method_name, string function )", 
	"snippet" => "( \${1:\$server}, \${2:\$method_name}, \${3:\$function} )", 
	"desc" => "Register a PHP function to resource method matching method_name", 
	"docurl" => "function.xmlrpc-server-register-method.html" 
),
"xmlrpc_set_type" => array( 
	"methodname" => "xmlrpc_set_type", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "bool xmlrpc_set_type ( string &value, string type )", 
	"snippet" => "( \${1:\$value}, \${2:\$type} )", 
	"desc" => "Sets xmlrpc type, base64 or datetime, for a PHP string value", 
	"docurl" => "function.xmlrpc-set-type.html" 
),
"xpath_eval_expression" => array( 
	"methodname" => "xpath_eval_expression", 
	"version" => "PHP4 >= 4.0.4", 
	"method" => "XPathObject xpath_eval_expression ( XPathContext xpath_context, string expression )", 
	"snippet" => "( \${1:\$xpath_context}, \${2:\$expression} )", 
	"desc" => "Evaluates the XPath Location Path in the given string", 
	"docurl" => "function.xpath-eval-expression.html" 
),
"xpath_eval" => array( 
	"methodname" => "xpath_eval", 
	"version" => "PHP4 >= 4.0.4", 
	"method" => "array xpath_eval ( XPathContext xpath_context, string xpath_expression [, domnode contextnode] )", 
	"snippet" => "( \${1:\$xpath_context}, \${2:\$xpath_expression} )", 
	"desc" => "Evaluates the XPath Location Path in the given string", 
	"docurl" => "function.xpath-eval.html" 
),
"xpath_new_context" => array( 
	"methodname" => "xpath_new_context", 
	"version" => "PHP4 >= 4.0.4", 
	"method" => "XPathContext xpath_new_context ( domdocument dom_document )", 
	"snippet" => "( \${1:\$dom_document} )", 
	"desc" => "Creates new xpath context", 
	"docurl" => "function.xpath-new-context.html" 
),
"xptr_eval" => array( 
	"methodname" => "xptr_eval", 
	"version" => "PHP4 >= 4.0.4", 
	"method" => "int xptr_eval ( [XPathContext xpath_context, string eval_str] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Evaluate the XPtr Location Path in the given string", 
	"docurl" => "function.xptr-eval.html" 
),
"xptr_new_context" => array( 
	"methodname" => "xptr_new_context", 
	"version" => "PHP4 >= 4.0.4", 
	"method" => "XPathContext xptr_new_context ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Create new XPath Context", 
	"docurl" => "function.xptr-new-context.html" 
),
"xsl_xsltprocessor_construct" => array( 
	"methodname" => "xsl_xsltprocessor_construct", 
	"version" => "undefined", 
	"method" => "class XSLTProcessor { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.xsl-xsltprocessor-construct.html" 
),
"xsl_xsltprocessor_get_parameter" => array( 
	"methodname" => "xsl_xsltprocessor_get_parameter", 
	"version" => "undefined", 
	"method" => "class XSLTProcessor { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.xsl-xsltprocessor-get-parameter.html" 
),
"xsl_xsltprocessor_has_exslt_support" => array( 
	"methodname" => "xsl_xsltprocessor_has_exslt_support", 
	"version" => "undefined", 
	"method" => "class XSLTProcessor { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.xsl-xsltprocessor-has-exslt-support.html" 
),
"xsl_xsltprocessor_import_stylesheet" => array( 
	"methodname" => "xsl_xsltprocessor_import_stylesheet", 
	"version" => "undefined", 
	"method" => "class XSLTProcessor { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.xsl-xsltprocessor-import-stylesheet.html" 
),
"xsl_xsltprocessor_register_php_functions" => array( 
	"methodname" => "xsl_xsltprocessor_register_php_functions", 
	"version" => "undefined", 
	"method" => "class XSLTProcessor { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.xsl-xsltprocessor-register-php-functions.html" 
),
"xsl_xsltprocessor_remove_parameter" => array( 
	"methodname" => "xsl_xsltprocessor_remove_parameter", 
	"version" => "undefined", 
	"method" => "class XSLTProcessor { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.xsl-xsltprocessor-remove-parameter.html" 
),
"xsl_xsltprocessor_set_parameter" => array( 
	"methodname" => "xsl_xsltprocessor_set_parameter", 
	"version" => "undefined", 
	"method" => "class XSLTProcessor { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.xsl-xsltprocessor-set-parameter.html" 
),
"xsl_xsltprocessor_transform_to_doc" => array( 
	"methodname" => "xsl_xsltprocessor_transform_to_doc", 
	"version" => "undefined", 
	"method" => "class XSLTProcessor { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.xsl-xsltprocessor-transform-to-doc.html" 
),
"xsl_xsltprocessor_transform_to_uri" => array( 
	"methodname" => "xsl_xsltprocessor_transform_to_uri", 
	"version" => "undefined", 
	"method" => "class XSLTProcessor { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.xsl-xsltprocessor-transform-to-uri.html" 
),
"xsl_xsltprocessor_transform_to_xml" => array( 
	"methodname" => "xsl_xsltprocessor_transform_to_xml", 
	"version" => "undefined", 
	"method" => "class XSLTProcessor { ", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.xsl-xsltprocessor-transform-to-xml.html" 
),
"xslt_backend_info" => array( 
	"methodname" => "xslt_backend_info", 
	"version" => "PHP4 >= 4.3.0", 
	"method" => "string xslt_backend_info ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the information on the compilation settings of the backend", 
	"docurl" => "function.xslt-backend-info.html" 
),
"xslt_backend_name" => array( 
	"methodname" => "xslt_backend_name", 
	"version" => "PHP4 >= 4.3.0", 
	"method" => "string xslt_backend_name ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the name of the backend", 
	"docurl" => "function.xslt-backend-name.html" 
),
"xslt_backend_version" => array( 
	"methodname" => "xslt_backend_version", 
	"version" => "PHP4 >= 4.3.0", 
	"method" => "string xslt_backend_version ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns the version number of Sablotron", 
	"docurl" => "function.xslt-backend-version.html" 
),
"xslt_create" => array( 
	"methodname" => "xslt_create", 
	"version" => "PHP4 >= 4.0.3", 
	"method" => "resource xslt_create ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Create a new XSLT processor", 
	"docurl" => "function.xslt-create.html" 
),
"xslt_errno" => array( 
	"methodname" => "xslt_errno", 
	"version" => "PHP4 >= 4.0.3", 
	"method" => "int xslt_errno ( resource xh )", 
	"snippet" => "( \${1:\$xh} )", 
	"desc" => "Returns an error number", 
	"docurl" => "function.xslt-errno.html" 
),
"xslt_error" => array( 
	"methodname" => "xslt_error", 
	"version" => "PHP4 >= 4.0.3", 
	"method" => "mixed xslt_error ( resource xh )", 
	"snippet" => "( \${1:\$xh} )", 
	"desc" => "Returns an error string", 
	"docurl" => "function.xslt-error.html" 
),
"xslt_free" => array( 
	"methodname" => "xslt_free", 
	"version" => "PHP4 >= 4.0.3", 
	"method" => "void xslt_free ( resource xh )", 
	"snippet" => "( \${1:\$xh} )", 
	"desc" => "Free XSLT processor", 
	"docurl" => "function.xslt-free.html" 
),
"xslt_getopt" => array( 
	"methodname" => "xslt_getopt", 
	"version" => "PHP4 >= 4.3.0", 
	"method" => "int xslt_getopt ( resource processor )", 
	"snippet" => "( \${1:\$processor} )", 
	"desc" => "Get options on a given xsl processor", 
	"docurl" => "function.xslt-getopt.html" 
),
"xslt_process" => array( 
	"methodname" => "xslt_process", 
	"version" => "PHP4 >= 4.0.3", 
	"method" => "mixed xslt_process ( resource xh, string xmlcontainer, string xslcontainer [, string resultcontainer [, array arguments [, array parameters]]] )", 
	"snippet" => "( \${1:\$xh}, \${2:\$xmlcontainer}, \${3:\$xslcontainer} )", 
	"desc" => "Perform an XSLT transformation", 
	"docurl" => "function.xslt-process.html" 
),
"xslt_set_base" => array( 
	"methodname" => "xslt_set_base", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "void xslt_set_base ( resource xh, string uri )", 
	"snippet" => "( \${1:\$xh}, \${2:\$uri} )", 
	"desc" => "Set the base URI for all XSLT transformations", 
	"docurl" => "function.xslt-set-base.html" 
),
"xslt_set_encoding" => array( 
	"methodname" => "xslt_set_encoding", 
	"version" => "PHP4 >= 4.0.5", 
	"method" => "void xslt_set_encoding ( resource xh, string encoding )", 
	"snippet" => "( \${1:\$xh}, \${2:\$encoding} )", 
	"desc" => "Set the encoding for the parsing of XML documents", 
	"docurl" => "function.xslt-set-encoding.html" 
),
"xslt_set_error_handler" => array( 
	"methodname" => "xslt_set_error_handler", 
	"version" => "PHP4 >= 4.0.4", 
	"method" => "void xslt_set_error_handler ( resource xh, mixed handler )", 
	"snippet" => "( \${1:\$xh}, \${2:\$handler} )", 
	"desc" => "Set an error handler for a XSLT processor", 
	"docurl" => "function.xslt-set-error-handler.html" 
),
"xslt_set_log" => array( 
	"methodname" => "xslt_set_log", 
	"version" => "PHP4 >= 4.0.6", 
	"method" => "void xslt_set_log ( resource xh [, mixed log] )", 
	"snippet" => "( \${1:\$xh} )", 
	"desc" => "Set the log file to write log messages to", 
	"docurl" => "function.xslt-set-log.html" 
),
"xslt_set_object" => array( 
	"methodname" => "xslt_set_object", 
	"version" => "PHP4 >= 4.3.0", 
	"method" => "int xslt_set_object ( resource processor, object &obj )", 
	"snippet" => "( \${1:\$processor}, \${2:\$obj} )", 
	"desc" => "Sets the object in which to resolve callback functions", 
	"docurl" => "function.xslt-set-object.html" 
),
"xslt_set_sax_handler" => array( 
	"methodname" => "xslt_set_sax_handler", 
	"version" => "undefined", 
	"method" => "void xslt_set_sax_handler ( resource xh, array handlers )", 
	"snippet" => "( \${1:\$xh}, \${2:\$handlers} )", 
	"desc" => "", 
	"docurl" => "function.xslt-set-sax-handler.html" 
),
"xslt_set_sax_handlers" => array( 
	"methodname" => "xslt_set_sax_handlers", 
	"version" => "PHP4 >= 4.0.6", 
	"method" => "void xslt_set_sax_handlers ( resource processor, array handlers )", 
	"snippet" => "( \${1:\$processor}, \${2:\$handlers} )", 
	"desc" => "Set the SAX handlers to be called when the XML document gets processed", 
	"docurl" => "function.xslt-set-sax-handlers.html" 
),
"xslt_set_scheme_handler" => array( 
	"methodname" => "xslt_set_scheme_handler", 
	"version" => "undefined", 
	"method" => "void xslt_set_scheme_handler ( resource xh, array handlers )", 
	"snippet" => "( \${1:\$xh}, \${2:\$handlers} )", 
	"desc" => "", 
	"docurl" => "function.xslt-set-scheme-handler.html" 
),
"xslt_set_scheme_handlers" => array( 
	"methodname" => "xslt_set_scheme_handlers", 
	"version" => "PHP4 >= 4.0.6", 
	"method" => "void xslt_set_scheme_handlers ( resource processor, array handlers )", 
	"snippet" => "( \${1:\$processor}, \${2:\$handlers} )", 
	"desc" => "Set the scheme handlers for the XSLT processor", 
	"docurl" => "function.xslt-set-scheme-handlers.html" 
),
"xslt_setopt" => array( 
	"methodname" => "xslt_setopt", 
	"version" => "PHP4 >= 4.3.0", 
	"method" => "int xslt_setopt ( resource processor, int newmask )", 
	"snippet" => "( \${1:\$processor}, \${2:\$newmask} )", 
	"desc" => "Set options on a given xsl processor", 
	"docurl" => "function.xslt-setopt.html" 
),

); # end of main array
?>