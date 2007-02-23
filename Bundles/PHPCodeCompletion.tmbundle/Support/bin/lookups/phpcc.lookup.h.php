<?php
$_LOOKUP = array( 
"header" => array( 
	"methodname" => "header", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "void header ( string string [, bool replace [, int http_response_code]] )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Send a raw HTTP header", 
	"docurl" => "function.header.html" 
),
"headers_list" => array( 
	"methodname" => "headers_list", 
	"version" => "PHP5", 
	"method" => "array headers_list ( void  )", 
	"snippet" => "(  )", 
	"desc" => "Returns a list of response headers sent (or ready to send)", 
	"docurl" => "function.headers-list.html" 
),
"headers_sent" => array( 
	"methodname" => "headers_sent", 
	"version" => "PHP3>= 3.0.8, PHP4, PHP5", 
	"method" => "bool headers_sent ( [string &file [, int &line]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "Checks if or where headers have been sent", 
	"docurl" => "function.headers-sent.html" 
),
"hebrev" => array( 
	"methodname" => "hebrev", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string hebrev ( string hebrew_text [, int max_chars_per_line] )", 
	"snippet" => "( \${1:\$hebrew_text} )", 
	"desc" => "Convert logical Hebrew text to visual text", 
	"docurl" => "function.hebrev.html" 
),
"hebrevc" => array( 
	"methodname" => "hebrevc", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string hebrevc ( string hebrew_text [, int max_chars_per_line] )", 
	"snippet" => "( \${1:\$hebrew_text} )", 
	"desc" => "Convert logical Hebrew text to visual text with newline conversion", 
	"docurl" => "function.hebrevc.html" 
),
"hexdec" => array( 
	"methodname" => "hexdec", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "number hexdec ( string hex_string )", 
	"snippet" => "( \${1:\$hex_string} )", 
	"desc" => "Hexadecimal to decimal", 
	"docurl" => "function.hexdec.html" 
),
"highlight_file" => array( 
	"methodname" => "highlight_file", 
	"version" => "PHP4, PHP5", 
	"method" => "mixed highlight_file ( string filename [, bool return] )", 
	"snippet" => "( \${1:\$filename} )", 
	"desc" => "Syntax highlighting of a file", 
	"docurl" => "function.highlight-file.html" 
),
"highlight_string" => array( 
	"methodname" => "highlight_string", 
	"version" => "PHP4, PHP5", 
	"method" => "mixed highlight_string ( string str [, bool return] )", 
	"snippet" => "( \${1:\$str} )", 
	"desc" => "Syntax highlighting of a string", 
	"docurl" => "function.highlight-string.html" 
),
"html_entity_decode" => array( 
	"methodname" => "html_entity_decode", 
	"version" => "PHP4 >= 4.3.0, PHP5", 
	"method" => "string html_entity_decode ( string string [, int quote_style [, string charset]] )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Convert all HTML entities to their applicable characters", 
	"docurl" => "function.html-entity-decode.html" 
),
"htmlentities" => array( 
	"methodname" => "htmlentities", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string htmlentities ( string string [, int quote_style [, string charset]] )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Convert all applicable characters to HTML entities", 
	"docurl" => "function.htmlentities.html" 
),
"htmlspecialchars_decode" => array( 
	"methodname" => "htmlspecialchars_decode", 
	"version" => "(no version information, might be only in CVS)", 
	"method" => "string htmlspecialchars_decode ( string string [, int quote_style] )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Convert special HTML entities back to characters", 
	"docurl" => "function.htmlspecialchars-decode.html" 
),
"htmlspecialchars" => array( 
	"methodname" => "htmlspecialchars", 
	"version" => "PHP3, PHP4, PHP5", 
	"method" => "string htmlspecialchars ( string string [, int quote_style [, string charset]] )", 
	"snippet" => "( \${1:\$string} )", 
	"desc" => "Convert special characters to HTML entities", 
	"docurl" => "function.htmlspecialchars.html" 
),
"http_build_query" => array( 
	"methodname" => "http_build_query", 
	"version" => "PHP5", 
	"method" => "string http_build_query ( array formdata [, string numeric_prefix] )", 
	"snippet" => "( \${1:\$formdata} )", 
	"desc" => "Generate URL-encoded query string", 
	"docurl" => "function.http-build-query.html" 
),
"hw_array2objrec" => array( 
	"methodname" => "hw_array2objrec", 
	"version" => "PHP3>= 3.0.4, PHP4", 
	"method" => "string hw_array2objrec ( array object_array )", 
	"snippet" => "( \${1:\$object_array} )", 
	"desc" => "Convert attributes from object array to object record", 
	"docurl" => "function.hw-array2objrec.html" 
),
"hw_changeobject" => array( 
	"methodname" => "hw_changeobject", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "void hw_changeobject ( int link, int objid, array attributes )", 
	"snippet" => "( \${1:\$link}, \${2:\$objid}, \${3:\$attributes} )", 
	"desc" => "Changes attributes of an object (obsolete)", 
	"docurl" => "function.hw-changeobject.html" 
),
"hw_children" => array( 
	"methodname" => "hw_children", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_children ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object ids of children", 
	"docurl" => "function.hw-children.html" 
),
"hw_childrenobj" => array( 
	"methodname" => "hw_childrenobj", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_childrenobj ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object records of children", 
	"docurl" => "function.hw-childrenobj.html" 
),
"hw_close" => array( 
	"methodname" => "hw_close", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_close ( int connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Closes the Hyperwave connection", 
	"docurl" => "function.hw-close.html" 
),
"hw_connect" => array( 
	"methodname" => "hw_connect", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_connect ( string host, int port, string username, string password )", 
	"snippet" => "( \${1:\$host}, \${2:\$port}, \${3:\$username}, \${4:\$password} )", 
	"desc" => "Opens a connection", 
	"docurl" => "function.hw-connect.html" 
),
"hw_connection_info" => array( 
	"methodname" => "hw_connection_info", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "void hw_connection_info ( int link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Prints information about the connection to Hyperwave server", 
	"docurl" => "function.hw-connection-info.html" 
),
"hw_cp" => array( 
	"methodname" => "hw_cp", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_cp ( int connection, array object_id_array, int destination_id )", 
	"snippet" => "( \${1:\$connection}, \${2:\$object_id_array}, \${3:\$destination_id} )", 
	"desc" => "Copies objects", 
	"docurl" => "function.hw-cp.html" 
),
"hw_deleteobject" => array( 
	"methodname" => "hw_deleteobject", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_deleteobject ( int connection, int object_to_delete )", 
	"snippet" => "( \${1:\$connection}, \${2:\$object_to_delete} )", 
	"desc" => "Deletes object", 
	"docurl" => "function.hw-deleteobject.html" 
),
"hw_docbyanchor" => array( 
	"methodname" => "hw_docbyanchor", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_docbyanchor ( int connection, int anchorID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$anchorID} )", 
	"desc" => "Object id object belonging to anchor", 
	"docurl" => "function.hw-docbyanchor.html" 
),
"hw_docbyanchorobj" => array( 
	"methodname" => "hw_docbyanchorobj", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_docbyanchorobj ( int connection, int anchorID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$anchorID} )", 
	"desc" => "Object record object belonging to anchor", 
	"docurl" => "function.hw-docbyanchorobj.html" 
),
"hw_document_attributes" => array( 
	"methodname" => "hw_document_attributes", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_document_attributes ( int hw_document )", 
	"snippet" => "( \${1:\$hw_document} )", 
	"desc" => "Object record of hw_document", 
	"docurl" => "function.hw-document-attributes.html" 
),
"hw_document_bodytag" => array( 
	"methodname" => "hw_document_bodytag", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_document_bodytag ( int hw_document [, string prefix] )", 
	"snippet" => "( \${1:\$hw_document} )", 
	"desc" => "Body tag of hw_document", 
	"docurl" => "function.hw-document-bodytag.html" 
),
"hw_document_content" => array( 
	"methodname" => "hw_document_content", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_document_content ( int hw_document )", 
	"snippet" => "( \${1:\$hw_document} )", 
	"desc" => "Returns content of hw_document", 
	"docurl" => "function.hw-document-content.html" 
),
"hw_document_setcontent" => array( 
	"methodname" => "hw_document_setcontent", 
	"version" => "PHP4", 
	"method" => "string hw_document_setcontent ( int hw_document, string content )", 
	"snippet" => "( \${1:\$hw_document}, \${2:\$content} )", 
	"desc" => "Sets/replaces content of hw_document", 
	"docurl" => "function.hw-document-setcontent.html" 
),
"hw_document_size" => array( 
	"methodname" => "hw_document_size", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_document_size ( int hw_document )", 
	"snippet" => "( \${1:\$hw_document} )", 
	"desc" => "Size of hw_document", 
	"docurl" => "function.hw-document-size.html" 
),
"hw_dummy" => array( 
	"methodname" => "hw_dummy", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_dummy ( int link, int id, int msgid )", 
	"snippet" => "( \${1:\$link}, \${2:\$id}, \${3:\$msgid} )", 
	"desc" => "Hyperwave dummy function", 
	"docurl" => "function.hw-dummy.html" 
),
"hw_edittext" => array( 
	"methodname" => "hw_edittext", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_edittext ( int connection, int hw_document )", 
	"snippet" => "( \${1:\$connection}, \${2:\$hw_document} )", 
	"desc" => "Retrieve text document", 
	"docurl" => "function.hw-edittext.html" 
),
"hw_error" => array( 
	"methodname" => "hw_error", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_error ( int connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Error number", 
	"docurl" => "function.hw-error.html" 
),
"hw_errormsg" => array( 
	"methodname" => "hw_errormsg", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_errormsg ( int connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Returns error message", 
	"docurl" => "function.hw-errormsg.html" 
),
"hw_free_document" => array( 
	"methodname" => "hw_free_document", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_free_document ( int hw_document )", 
	"snippet" => "( \${1:\$hw_document} )", 
	"desc" => "Frees hw_document", 
	"docurl" => "function.hw-free-document.html" 
),
"hw_getanchors" => array( 
	"methodname" => "hw_getanchors", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getanchors ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object ids of anchors of document", 
	"docurl" => "function.hw-getanchors.html" 
),
"hw_getanchorsobj" => array( 
	"methodname" => "hw_getanchorsobj", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getanchorsobj ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object records of anchors of document", 
	"docurl" => "function.hw-getanchorsobj.html" 
),
"hw_getandlock" => array( 
	"methodname" => "hw_getandlock", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_getandlock ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Return object record and lock object", 
	"docurl" => "function.hw-getandlock.html" 
),
"hw_getchildcoll" => array( 
	"methodname" => "hw_getchildcoll", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getchildcoll ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object ids of child collections", 
	"docurl" => "function.hw-getchildcoll.html" 
),
"hw_getchildcollobj" => array( 
	"methodname" => "hw_getchildcollobj", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getchildcollobj ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object records of child collections", 
	"docurl" => "function.hw-getchildcollobj.html" 
),
"hw_getchilddoccoll" => array( 
	"methodname" => "hw_getchilddoccoll", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getchilddoccoll ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object ids of child documents of collection", 
	"docurl" => "function.hw-getchilddoccoll.html" 
),
"hw_getchilddoccollobj" => array( 
	"methodname" => "hw_getchilddoccollobj", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getchilddoccollobj ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object records of child documents of collection", 
	"docurl" => "function.hw-getchilddoccollobj.html" 
),
"hw_getobject" => array( 
	"methodname" => "hw_getobject", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getobject ( int connection, mixed objectID [, string query] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object record", 
	"docurl" => "function.hw-getobject.html" 
),
"hw_getobjectbyquery" => array( 
	"methodname" => "hw_getobjectbyquery", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getobjectbyquery ( int connection, string query, int max_hits )", 
	"snippet" => "( \${1:\$connection}, \${2:\$query}, \${3:\$max_hits} )", 
	"desc" => "Search object", 
	"docurl" => "function.hw-getobjectbyquery.html" 
),
"hw_getobjectbyquerycoll" => array( 
	"methodname" => "hw_getobjectbyquerycoll", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getobjectbyquerycoll ( int connection, int objectID, string query, int max_hits )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID}, \${3:\$query}, \${4:\$max_hits} )", 
	"desc" => "Search object in collection", 
	"docurl" => "function.hw-getobjectbyquerycoll.html" 
),
"hw_getobjectbyquerycollobj" => array( 
	"methodname" => "hw_getobjectbyquerycollobj", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getobjectbyquerycollobj ( int connection, int objectID, string query, int max_hits )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID}, \${3:\$query}, \${4:\$max_hits} )", 
	"desc" => "Search object in collection", 
	"docurl" => "function.hw-getobjectbyquerycollobj.html" 
),
"hw_getobjectbyqueryobj" => array( 
	"methodname" => "hw_getobjectbyqueryobj", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getobjectbyqueryobj ( int connection, string query, int max_hits )", 
	"snippet" => "( \${1:\$connection}, \${2:\$query}, \${3:\$max_hits} )", 
	"desc" => "Search object", 
	"docurl" => "function.hw-getobjectbyqueryobj.html" 
),
"hw_getparents" => array( 
	"methodname" => "hw_getparents", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getparents ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object ids of parents", 
	"docurl" => "function.hw-getparents.html" 
),
"hw_getparentsobj" => array( 
	"methodname" => "hw_getparentsobj", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getparentsobj ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Object records of parents", 
	"docurl" => "function.hw-getparentsobj.html" 
),
"hw_getrellink" => array( 
	"methodname" => "hw_getrellink", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_getrellink ( int link, int rootid, int sourceid, int destid )", 
	"snippet" => "( \${1:\$link}, \${2:\$rootid}, \${3:\$sourceid}, \${4:\$destid} )", 
	"desc" => "Get link from source to dest relative to rootid", 
	"docurl" => "function.hw-getrellink.html" 
),
"hw_getremote" => array( 
	"methodname" => "hw_getremote", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_getremote ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Gets a remote document", 
	"docurl" => "function.hw-getremote.html" 
),
"hw_getremotechildren" => array( 
	"methodname" => "hw_getremotechildren", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_getremotechildren ( int connection, string object_record )", 
	"snippet" => "( \${1:\$connection}, \${2:\$object_record} )", 
	"desc" => "Gets children of remote document", 
	"docurl" => "function.hw-getremotechildren.html" 
),
"hw_getsrcbydestobj" => array( 
	"methodname" => "hw_getsrcbydestobj", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_getsrcbydestobj ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Returns anchors pointing at object", 
	"docurl" => "function.hw-getsrcbydestobj.html" 
),
"hw_gettext" => array( 
	"methodname" => "hw_gettext", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_gettext ( int connection, int objectID [, mixed rootID/prefix] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Retrieve text document", 
	"docurl" => "function.hw-gettext.html" 
),
"hw_getusername" => array( 
	"methodname" => "hw_getusername", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_getusername ( int connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Name of currently logged in user", 
	"docurl" => "function.hw-getusername.html" 
),
"hw_identify" => array( 
	"methodname" => "hw_identify", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_identify ( int link, string username, string password )", 
	"snippet" => "( \${1:\$link}, \${2:\$username}, \${3:\$password} )", 
	"desc" => "Identifies as user", 
	"docurl" => "function.hw-identify.html" 
),
"hw_incollections" => array( 
	"methodname" => "hw_incollections", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_incollections ( int connection, array object_id_array, array collection_id_array, int return_collections )", 
	"snippet" => "( \${1:\$connection}, \${2:\$object_id_array}, \${3:\$collection_id_array}, \${4:\$return_collections} )", 
	"desc" => "Check if object ids in collections", 
	"docurl" => "function.hw-incollections.html" 
),
"hw_info" => array( 
	"methodname" => "hw_info", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_info ( int connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "Info about connection", 
	"docurl" => "function.hw-info.html" 
),
"hw_inscoll" => array( 
	"methodname" => "hw_inscoll", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_inscoll ( int connection, int objectID, array object_array )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID}, \${3:\$object_array} )", 
	"desc" => "Insert collection", 
	"docurl" => "function.hw-inscoll.html" 
),
"hw_insdoc" => array( 
	"methodname" => "hw_insdoc", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_insdoc ( resource connection, int parentID, string object_record [, string text] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$parentID}, \${3:\$object_record} )", 
	"desc" => "Insert document", 
	"docurl" => "function.hw-insdoc.html" 
),
"hw_insertanchors" => array( 
	"methodname" => "hw_insertanchors", 
	"version" => "PHP4 >= 4.0.4", 
	"method" => "string hw_insertanchors ( int hwdoc, array anchorecs, array dest [, array urlprefixes] )", 
	"snippet" => "( \${1:\$hwdoc}, \${2:\$anchorecs}, \${3:\$dest} )", 
	"desc" => "Inserts only anchors into text", 
	"docurl" => "function.hw-insertanchors.html" 
),
"hw_insertdocument" => array( 
	"methodname" => "hw_insertdocument", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_insertdocument ( int connection, int parent_id, int hw_document )", 
	"snippet" => "( \${1:\$connection}, \${2:\$parent_id}, \${3:\$hw_document} )", 
	"desc" => "Upload any document", 
	"docurl" => "function.hw-insertdocument.html" 
),
"hw_insertobject" => array( 
	"methodname" => "hw_insertobject", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_insertobject ( int connection, string object_rec, string parameter )", 
	"snippet" => "( \${1:\$connection}, \${2:\$object_rec}, \${3:\$parameter} )", 
	"desc" => "Inserts an object record", 
	"docurl" => "function.hw-insertobject.html" 
),
"hw_mapid" => array( 
	"methodname" => "hw_mapid", 
	"version" => "PHP3>= 3.0.13, PHP4", 
	"method" => "int hw_mapid ( int connection, int server_id, int object_id )", 
	"snippet" => "( \${1:\$connection}, \${2:\$server_id}, \${3:\$object_id} )", 
	"desc" => "Maps global id on virtual local id", 
	"docurl" => "function.hw-mapid.html" 
),
"hw_modifyobject" => array( 
	"methodname" => "hw_modifyobject", 
	"version" => "PHP3>= 3.0.7, PHP4", 
	"method" => "int hw_modifyobject ( int connection, int object_to_change, array remove, array add [, int mode] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$object_to_change}, \${3:\$remove}, \${4:\$add} )", 
	"desc" => "Modifies object record", 
	"docurl" => "function.hw-modifyobject.html" 
),
"hw_mv" => array( 
	"methodname" => "hw_mv", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_mv ( int connection, array object_id_array, int source_id, int destination_id )", 
	"snippet" => "( \${1:\$connection}, \${2:\$object_id_array}, \${3:\$source_id}, \${4:\$destination_id} )", 
	"desc" => "Moves objects", 
	"docurl" => "function.hw-mv.html" 
),
"hw_new_document" => array( 
	"methodname" => "hw_new_document", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_new_document ( string object_record, string document_data, int document_size )", 
	"snippet" => "( \${1:\$object_record}, \${2:\$document_data}, \${3:\$document_size} )", 
	"desc" => "Create new document", 
	"docurl" => "function.hw-new-document.html" 
),
"hw_objrec2array" => array( 
	"methodname" => "hw_objrec2array", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "array hw_objrec2array ( string object_record [, array format] )", 
	"snippet" => "( \${1:\$object_record} )", 
	"desc" => "Convert attributes from object record to object array", 
	"docurl" => "function.hw-objrec2array.html" 
),
"hw_output_document" => array( 
	"methodname" => "hw_output_document", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_output_document ( int hw_document )", 
	"snippet" => "( \${1:\$hw_document} )", 
	"desc" => "Prints hw_document", 
	"docurl" => "function.hw-output-document.html" 
),
"hw_pconnect" => array( 
	"methodname" => "hw_pconnect", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_pconnect ( string host, int port, string username, string password )", 
	"snippet" => "( \${1:\$host}, \${2:\$port}, \${3:\$username}, \${4:\$password} )", 
	"desc" => "Make a persistent database connection", 
	"docurl" => "function.hw-pconnect.html" 
),
"hw_pipedocument" => array( 
	"methodname" => "hw_pipedocument", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_pipedocument ( int connection, int objectID [, array url_prefixes] )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Retrieve any document", 
	"docurl" => "function.hw-pipedocument.html" 
),
"hw_root" => array( 
	"methodname" => "hw_root", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_root (  )", 
	"snippet" => "( \$1 )", 
	"desc" => "Root object id", 
	"docurl" => "function.hw-root.html" 
),
"hw_setlinkroot" => array( 
	"methodname" => "hw_setlinkroot", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "void hw_setlinkroot ( int link, int rootid )", 
	"snippet" => "( \${1:\$link}, \${2:\$rootid} )", 
	"desc" => "Set the id to which links are calculated", 
	"docurl" => "function.hw-setlinkroot.html" 
),
"hw_stat" => array( 
	"methodname" => "hw_stat", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "string hw_stat ( int link )", 
	"snippet" => "( \${1:\$link} )", 
	"desc" => "Returns status string", 
	"docurl" => "function.hw-stat.html" 
),
"hw_unlock" => array( 
	"methodname" => "hw_unlock", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_unlock ( int connection, int objectID )", 
	"snippet" => "( \${1:\$connection}, \${2:\$objectID} )", 
	"desc" => "Unlock object", 
	"docurl" => "function.hw-unlock.html" 
),
"hw_who" => array( 
	"methodname" => "hw_who", 
	"version" => "PHP3>= 3.0.3, PHP4", 
	"method" => "int hw_who ( int connection )", 
	"snippet" => "( \${1:\$connection} )", 
	"desc" => "List of currently logged in users", 
	"docurl" => "function.hw-who.html" 
),
"hwapi_attribute_key" => array( 
	"methodname" => "hwapi_attribute_key", 
	"version" => "undefined", 
	"method" => "string hw_api_attribute-&#62;key ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.hwapi-attribute-key.html" 
),
"hwapi_attribute_langdepvalue" => array( 
	"methodname" => "hwapi_attribute_langdepvalue", 
	"version" => "undefined", 
	"method" => "string hw_api_attribute-&#62;langdepvalue ( string language )", 
	"snippet" => "( \${1:\$language} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-attribute-langdepvalue.html" 
),
"hwapi_attribute_value" => array( 
	"methodname" => "hwapi_attribute_value", 
	"version" => "undefined", 
	"method" => "string hw_api_attribute-&#62;value ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.hwapi-attribute-value.html" 
),
"hwapi_attribute_values" => array( 
	"methodname" => "hwapi_attribute_values", 
	"version" => "undefined", 
	"method" => "array hw_api_attribute-&#62;values ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.hwapi-attribute-values.html" 
),
"hwapi_attribute" => array( 
	"methodname" => "hwapi_attribute", 
	"version" => "undefined", 
	"method" => "HW_API_Attribute hw_api_attribute ( [string name [, string value]] )", 
	"snippet" => "( \$1 )", 
	"desc" => "", 
	"docurl" => "function.hwapi-attribute.html" 
),
"hwapi_checkin" => array( 
	"methodname" => "hwapi_checkin", 
	"version" => "undefined", 
	"method" => "bool hw_api-&#62;checkin ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-checkin.html" 
),
"hwapi_checkout" => array( 
	"methodname" => "hwapi_checkout", 
	"version" => "undefined", 
	"method" => "bool hw_api-&#62;checkout ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-checkout.html" 
),
"hwapi_children" => array( 
	"methodname" => "hwapi_children", 
	"version" => "undefined", 
	"method" => "array hw_api-&#62;children ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-children.html" 
),
"hwapi_content_mimetype" => array( 
	"methodname" => "hwapi_content_mimetype", 
	"version" => "undefined", 
	"method" => "string hw_api_content-&#62;mimetype ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.hwapi-content-mimetype.html" 
),
"hwapi_content_read" => array( 
	"methodname" => "hwapi_content_read", 
	"version" => "undefined", 
	"method" => "string hw_api_content-&#62;read ( string buffer, integer len )", 
	"snippet" => "( \${1:\$buffer}, \${2:\$len} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-content-read.html" 
),
"hwapi_content" => array( 
	"methodname" => "hwapi_content", 
	"version" => "undefined", 
	"method" => "HW_API_Content hw_api-&#62;content ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-content.html" 
),
"hwapi_copy" => array( 
	"methodname" => "hwapi_copy", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;copy ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-copy.html" 
),
"hwapi_dbstat" => array( 
	"methodname" => "hwapi_dbstat", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;dbstat ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-dbstat.html" 
),
"hwapi_dcstat" => array( 
	"methodname" => "hwapi_dcstat", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;dcstat ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-dcstat.html" 
),
"hwapi_dstanchors" => array( 
	"methodname" => "hwapi_dstanchors", 
	"version" => "undefined", 
	"method" => "array hw_api-&#62;dstanchors ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-dstanchors.html" 
),
"hwapi_dstofsrcanchor" => array( 
	"methodname" => "hwapi_dstofsrcanchor", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;dstofsrcanchor ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-dstofsrcanchor.html" 
),
"hwapi_error_count" => array( 
	"methodname" => "hwapi_error_count", 
	"version" => "undefined", 
	"method" => "int hw_api_error-&#62;count ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.hwapi-error-count.html" 
),
"hwapi_error_reason" => array( 
	"methodname" => "hwapi_error_reason", 
	"version" => "undefined", 
	"method" => "HW_API_Reason hw_api_error-&#62;reason ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.hwapi-error-reason.html" 
),
"hwapi_find" => array( 
	"methodname" => "hwapi_find", 
	"version" => "undefined", 
	"method" => "array hw_api-&#62;find ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-find.html" 
),
"hwapi_ftstat" => array( 
	"methodname" => "hwapi_ftstat", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;ftstat ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-ftstat.html" 
),
"hwapi_hgcsp" => array( 
	"methodname" => "hwapi_hgcsp", 
	"version" => "undefined", 
	"method" => "HW_API hwapi_hgcsp ( string hostname [, int port] )", 
	"snippet" => "( \${1:\$hostname} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-hgcsp.html" 
),
"hwapi_hwstat" => array( 
	"methodname" => "hwapi_hwstat", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;hwstat ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-hwstat.html" 
),
"hwapi_identify" => array( 
	"methodname" => "hwapi_identify", 
	"version" => "undefined", 
	"method" => "bool hw_api-&#62;identify ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-identify.html" 
),
"hwapi_info" => array( 
	"methodname" => "hwapi_info", 
	"version" => "undefined", 
	"method" => "array hw_api-&#62;info ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-info.html" 
),
"hwapi_insert" => array( 
	"methodname" => "hwapi_insert", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;insert ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-insert.html" 
),
"hwapi_insertanchor" => array( 
	"methodname" => "hwapi_insertanchor", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;insertanchor ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-insertanchor.html" 
),
"hwapi_insertcollection" => array( 
	"methodname" => "hwapi_insertcollection", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;insertcollection ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-insertcollection.html" 
),
"hwapi_insertdocument" => array( 
	"methodname" => "hwapi_insertdocument", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;insertdocument ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-insertdocument.html" 
),
"hwapi_link" => array( 
	"methodname" => "hwapi_link", 
	"version" => "undefined", 
	"method" => "bool hw_api-&#62;link ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-link.html" 
),
"hwapi_lock" => array( 
	"methodname" => "hwapi_lock", 
	"version" => "undefined", 
	"method" => "bool hw_api-&#62;lock ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-lock.html" 
),
"hwapi_move" => array( 
	"methodname" => "hwapi_move", 
	"version" => "undefined", 
	"method" => "bool hw_api-&#62;move ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-move.html" 
),
"hwapi_new_content" => array( 
	"methodname" => "hwapi_new_content", 
	"version" => "undefined", 
	"method" => "HW_API_Content hw_api_content ( string content, string mimetype )", 
	"snippet" => "( \${1:\$content}, \${2:\$mimetype} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-new-content.html" 
),
"hwapi_object_assign" => array( 
	"methodname" => "hwapi_object_assign", 
	"version" => "undefined", 
	"method" => "bool hw_api_object-&#62;assign ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-object-assign.html" 
),
"hwapi_object_attreditable" => array( 
	"methodname" => "hwapi_object_attreditable", 
	"version" => "undefined", 
	"method" => "bool hw_api_object-&#62;attreditable ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-object-attreditable.html" 
),
"hwapi_object_count" => array( 
	"methodname" => "hwapi_object_count", 
	"version" => "undefined", 
	"method" => "int hw_api_object-&#62;count ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-object-count.html" 
),
"hwapi_object_insert" => array( 
	"methodname" => "hwapi_object_insert", 
	"version" => "undefined", 
	"method" => "bool hw_api_object-&#62;insert ( HW_API_Attribute attribute )", 
	"snippet" => "( \${1:\$attribute} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-object-insert.html" 
),
"hwapi_object_new" => array( 
	"methodname" => "hwapi_object_new", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api_object ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-object-new.html" 
),
"hwapi_object_remove" => array( 
	"methodname" => "hwapi_object_remove", 
	"version" => "undefined", 
	"method" => "bool hw_api_object-&#62;remove ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-object-remove.html" 
),
"hwapi_object_title" => array( 
	"methodname" => "hwapi_object_title", 
	"version" => "undefined", 
	"method" => "string hw_api_object-&#62;title ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-object-title.html" 
),
"hwapi_object_value" => array( 
	"methodname" => "hwapi_object_value", 
	"version" => "undefined", 
	"method" => "string hw_api_object-&#62;value ( string name )", 
	"snippet" => "( \${1:\$name} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-object-value.html" 
),
"hwapi_object" => array( 
	"methodname" => "hwapi_object", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;object ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-object.html" 
),
"hwapi_objectbyanchor" => array( 
	"methodname" => "hwapi_objectbyanchor", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;objectbyanchor ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-objectbyanchor.html" 
),
"hwapi_parents" => array( 
	"methodname" => "hwapi_parents", 
	"version" => "undefined", 
	"method" => "array hw_api-&#62;parents ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-parents.html" 
),
"hwapi_reason_description" => array( 
	"methodname" => "hwapi_reason_description", 
	"version" => "undefined", 
	"method" => "string hw_api_reason-&#62;description ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.hwapi-reason-description.html" 
),
"hwapi_reason_type" => array( 
	"methodname" => "hwapi_reason_type", 
	"version" => "undefined", 
	"method" => "HW_API_Reason hw_api_reason-&#62;type ( void  )", 
	"snippet" => "(  )", 
	"desc" => "", 
	"docurl" => "function.hwapi-reason-type.html" 
),
"hwapi_remove" => array( 
	"methodname" => "hwapi_remove", 
	"version" => "undefined", 
	"method" => "bool hw_api-&#62;remove ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-remove.html" 
),
"hwapi_replace" => array( 
	"methodname" => "hwapi_replace", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;replace ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-replace.html" 
),
"hwapi_setcommittedversion" => array( 
	"methodname" => "hwapi_setcommittedversion", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;setcommittedversion ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-setcommittedversion.html" 
),
"hwapi_srcanchors" => array( 
	"methodname" => "hwapi_srcanchors", 
	"version" => "undefined", 
	"method" => "array hw_api-&#62;srcanchors ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-srcanchors.html" 
),
"hwapi_srcsofdst" => array( 
	"methodname" => "hwapi_srcsofdst", 
	"version" => "undefined", 
	"method" => "array hw_api-&#62;srcsofdst ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-srcsofdst.html" 
),
"hwapi_unlock" => array( 
	"methodname" => "hwapi_unlock", 
	"version" => "undefined", 
	"method" => "bool hw_api-&#62;unlock ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-unlock.html" 
),
"hwapi_user" => array( 
	"methodname" => "hwapi_user", 
	"version" => "undefined", 
	"method" => "hw_api_object hw_api-&#62;user ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-user.html" 
),
"hwapi_userlist" => array( 
	"methodname" => "hwapi_userlist", 
	"version" => "undefined", 
	"method" => "array hw_api-&#62;userlist ( array parameter )", 
	"snippet" => "( \${1:\$parameter} )", 
	"desc" => "", 
	"docurl" => "function.hwapi-userlist.html" 
),
"hypot" => array( 
	"methodname" => "hypot", 
	"version" => "PHP4 >= 4.1.0, PHP5", 
	"method" => "float hypot ( float x, float y )", 
	"snippet" => "( \${1:\$x}, \${2:\$y} )", 
	"desc" => "Calculate the length of the hypotenuse of a right-angle triangle", 
	"docurl" => "function.hypot.html" 
),
); # end of main array
?>